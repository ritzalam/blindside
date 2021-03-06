package org.blindsideproject.core.apps.presentation.business
{
	import mx.rpc.IResponder;
	import flash.net.SharedObject;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.SyncEvent;
	import mx.collections.ArrayCollection;
	import mx.rpc.events.AbstractEvent;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;
		
	import org.blindsideproject.core.apps.presentation.model.PresentationModelLocator;
	import org.blindsideproject.core.apps.presentation.model.PresentationModel;
	import org.blindsideproject.core.apps.presentation.controller.events.ClearEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.ViewEvent;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerModelLocator;
	import mx.states.SetProperty;
	import flexunit.utils.ArrayList;
	import org.blindsideproject.core.apps.presentation.vo.SlidesDeck;
	import org.blindsideproject.core.apps.presentation.controller.events.ExtractProgressEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.ConvertProgressEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.UpdateProgressEvent;
	import org.blindsideproject.core.apps.presentation.controller.events.ConvertSuccessEvent;
					
	public class PresentationDelegate
	{
		public static const ID : String = "PresentationDelegate";
		
		private static const SHAREDOBJECT : String = "presentationSO";
		private static const PRESENTER : String = "presenter";
		private static const SHARING : String = "sharing";
		private static const UPDATE_MESSAGE : String = "updateMessage";
		
		private static const UPDATE_RC : String = "UPDATE";
		private static const SUCCESS_RC : String = "SUCCESS";
		private static const FAILED_RC : String = "FAILED";
		private static const EXTRACT_RC : String = "EXTRACT";
		private static const CONVERT_RC : String = "CONVERT";
		
		private var model : PresentationModelLocator = PresentationModelLocator.getInstance();
		private var log : ILogger = LoggerModelLocator.getInstance().log;

		private var dispatcher : CairngormEventDispatcher = model.dispatcher;
		
		public var presentation : PresentationModel = model.presentation;
		
		private var presentationSO : SharedObject;
		private var connDelegate : NetConnectionDelegate;
				
		public function PresentationDelegate()
		{
			connDelegate = new NetConnectionDelegate(this);
		}		
				
		public function connectionSuccess() : void
		{
			presentation.isConnected = true;
			
			sendConnectedEvent();
			
			joinConference();
		}
			
		public function connectionFailed(message : String) : void 
		{
			if (presentationSO != null) presentationSO.close();
			
			presentation.isConnected = false;
			
			sendDisconnectedEvent(message);
		}		
		
		public function join(userid: Number, host : String, room : String) : void
		{			
			presentation.userid = userid;
			presentation.host = host;
			presentation.room = room;
						
			connDelegate.connect(host, room);
		}
		
		public function leave() : void
		{
			presentationSO.close();
			connDelegate.disconnect();
		}
		
		public function gotoPage(page : Number) : void
		{
			presentationSO.send("newPageNumber", page);
		}
		
		public function newPageNumber(page : Number) : void
		{
			presentation.decks.selected = page;
		}
		
		public function clear() : void
		{
			presentationSO.send("clearPresentation");			
		}
		
		public function clearPresentation() : void
		{
			presentationSO.setProperty(SHARING, false);
			var event : ClearEvent = new ClearEvent();
			event.dispatch();
		}
		
		public function givePresenterControl(userid : Number, name : String) : void
		{
			// Force unshare of presentation
			share(false);
			
			log.debug("Assign presenter control to [" + name + "]");
			presentationSO.setProperty(PRESENTER, {userid : userid, name : name});
		}
		
		public function stopSharing() : void
		{
			presentationSO.setProperty(SHARING, false);
		}
		
		public function share(sharing : Boolean) : void
		{
			if (sharing) {
				/**
				 * We have to explicitly copy the data into a new Object, otherwise, the
			 	 * ShareObject won't sync.
			 	 */			
				var name : String = presentation.decks.name;
				var title : String = presentation.decks.title;
				var curPage : Number = presentation.decks.selected;
				
				var slides : Array = new Array();			
				for (var i : uint = 0; i < presentation.decks.slides.source.length; i++)
				{
					slides.push(presentation.decks.slides.source[i]);
				}

				presentationSO.setProperty(SHARING, {share : sharing, 
						presentation : {id : name, description : title, page : curPage, slide : slides}});			
			} else {
				presentationSO.setProperty(SHARING, {share : sharing});
			}
		}
				
		private function joinConference() : void
		{
			presentationSO = SharedObject.getRemote(SHAREDOBJECT, connDelegate.connUri, false);
			
			presentationSO.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			presentationSO.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			presentationSO.addEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
			
			presentationSO.client = this;

			presentationSO.connect(connDelegate.getConnection());
		}

		private function removeListeners() : void
		{
			presentationSO.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			presentationSO.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			presentationSO.removeEventListener(SyncEvent.SYNC, sharedObjectSyncHandler);
		}		
								
		private function sharedObjectSyncHandler( event : SyncEvent) : void
		{
			log.debug( "Presentation::sharedObjectSyncHandler " + event.changeList.length);
			
			for (var i : uint = 0; i < event.changeList.length; i++) 
			{
				log.debug( "Presentation::handlingChanges[" + event.changeList[i].name + "][" + i + "]");
				handleChangesToSharedObject(event.changeList[i].code, 
						event.changeList[i].name, event.changeList[i].oldValue);
			}
		}
		
		/**
		 * See flash.events.SyncEvent
		 */
		private function handleChangesToSharedObject(code : String, name : String, oldValue : Object) : void
		{
			switch (name)
			{
				case UPDATE_MESSAGE:
					if (presentation.isPresenter) {
						log.debug( UPDATE_MESSAGE + " =[" + presentationSO.data.updateMessage.returnCode + "]");
						processUpdateMessage(presentationSO.data.updateMessage.returnCode);
					}
					
					break;
										
				case PRESENTER :
					log.debug("Giving presenter control to [" + presentationSO.data.presenter.name + "]");
					presentation.isSharing = false;
					presentation.presentationLoaded = false;
					presentation.decks = null;
												
					if (presentation.userid == presentationSO.data.presenter.userid) {
						// The user has been given presenter role
						presentation.isPresenter = true;						
					} else {
						if (presentation.isPresenter) {
							// Someone else has become the presenter
							presentation.isPresenter = false;	
						}
					}
					presentation.presenterName = presentationSO.data.presenter.name;
					break;
					
				case SHARING :
					presentation.isSharing = presentationSO.data.sharing.share;
				
					if (presentationSO.data.sharing.share) {
						log.debug( "SHARING true =[" + presentationSO.data.sharing.presentation.slide.length  + "]");
										
						processSharedPresentation(presentationSO.data.sharing.presentation);
						
						var viewEvent : ViewEvent = new ViewEvent();
						viewEvent.dispatch();
					} else {
						log.debug( "SHARING =[" + presentationSO.data.sharing.share + "]");
						// Should send a stop sharing event. This will allow UIs to do what they want 
						// (e.g. clear the screen).
						if (! presentation.isPresenter) {
							presentation.decks = null;
						}
						var event : ClearEvent = new ClearEvent();
						event.dispatch();
					}
					break
					
				default:
					log.debug( "default =[" + code + "," + name + "," + oldValue + "]");				 
					break;
			}
		}
		
		private function processSharedPresentation(pres : Object) : void
		{
			var deck : SlidesDeck = new SlidesDeck(pres);
			
			presentation.newDeckOfSlides(deck);		
			presentation.decks.selected = pres.page;	
		}
		
		private function processUpdateMessage(returnCode : String) : void
		{
			var totalSlides : Number;
			var completedSlides : Number;
			var message : String;
			
			switch (returnCode)
			{
				case SUCCESS_RC:
					message = presentationSO.data.updateMessage.message;
					
					var successEvt : ConvertSuccessEvent = new ConvertSuccessEvent(message);
					successEvt.dispatch();
								
					break;
					
				case UPDATE_RC:
					message = presentationSO.data.updateMessage.message;
					
					var updProgEvt : UpdateProgressEvent = new UpdateProgressEvent(message);
					updProgEvt.dispatch();
					
					break;
										
				case FAILED_RC:
			
					break;
				case EXTRACT_RC:
					totalSlides = presentationSO.data.updateMessage.totalSlides;
					completedSlides = presentationSO.data.updateMessage.completedSlides;
					log.debug( "EXTRACTING = [" + completedSlides + " of " + totalSlides + "]");
					
					var extractEvt : ExtractProgressEvent = new ExtractProgressEvent(totalSlides, completedSlides);
					extractEvt.dispatch();
					
					break;
				case CONVERT_RC:
					totalSlides = presentationSO.data.updateMessage.totalSlides;
					completedSlides = presentationSO.data.updateMessage.completedSlides;
					log.debug( "CONVERTING = [" + completedSlides + " of " + totalSlides + "]");
					
					var convertEvt : ConvertProgressEvent = new ConvertProgressEvent(totalSlides, completedSlides);
					convertEvt.dispatch();								
					break;			
				default:
			
					break;	
			}															
		}
		
		private function netStatusHandler ( event : NetStatusEvent ) : void
		{
			log.debug( "netStatusHandler " + event.info.code );
		}
		
		private function asyncErrorHandler ( event : AsyncErrorEvent ) : void
		{
			log.debug( "asyncErrorHandler " + event.error);
		}
		
			
		public function sendConnectedEvent() : void
		{
//			var event : ConnectedEvent = new ConnectedEvent(ConferenceEvents.CONNECTED_EVENT);
//			event.dispatch();
		}
//
		public function sendDisconnectedEvent(message : String):void
		{
//			var event : DisconnectedEvent = new DisconnectedEvent(ConferenceEvents.DISCONNECTED_EVENT,
//												message);
//			dispatcher.dispatchEvent(event);
		}
	}
}