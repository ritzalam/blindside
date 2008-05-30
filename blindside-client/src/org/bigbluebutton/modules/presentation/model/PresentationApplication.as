package org.bigbluebutton.modules.presentation.model
{
				
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.rpc.IResponder;
	import mx.utils.ArrayUtil;
	
	import org.bigbluebutton.modules.presentation.PresentationFacade;
	import org.bigbluebutton.modules.presentation.model.business.PresentationDelegate;
	import org.bigbluebutton.modules.presentation.model.services.FileUploadService;
	import org.bigbluebutton.modules.presentation.model.services.PresentationService;
	import org.bigbluebutton.modules.presentation.model.vo.SlidesDeck;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
			
	/**
	 * The PresentationApplication class is the ApplicationMediator class of the Presentation Module
	 * <p>
	 * This class extends the Proxy class of the pureMVC framework
	 * <p>
	 * This class implements the IResponder interface 
	 * @author dzgonjan
	 * 
	 */						
	public class PresentationApplication extends Mediator implements IMediator, IResponder
	{
		public var model:PresentationModel; 
		public static const NAME:String = "PresentationApplication";

		private var _url : String;
		private var _userid : Number;
		private var _room : String;
		private var _docServiceAddress : String = "http://localhost:8080";
		
		/**
		 * The default constructor 
		 * @param userid - the clients userid
		 * @param room - the room the presentation module is connected to
		 * @param url - the url of the presentation server
		 * @param docServiceAddress
		 * 
		 */		
		public function PresentationApplication(userid : Number, room : String, 
				url : String, docServiceAddress : String) : void 
		{
			super(NAME);
			_url = url;
			_userid = userid;
			_room = room;
			_docServiceAddress = docServiceAddress;
			
			// Initialize the model
			model = PresentationFacade.getInstance().presentation;
		}
		
		/**
		 * Call the proxy to send out a join request to the server 
		 * 
		 */		
		public function join() : void
		{	
			presentationProxy.join(_userid, _url, _room);		
		}
		
		/**
		 * returns the Presentation Proxy class, which it retrieves from the facade 
		 * @return 
		 * 
		 */		
		public function get presentationProxy():PresentationDelegate{
			return facade.retrieveProxy(PresentationDelegate.ID) as PresentationDelegate;
		}
		
		/**
		 * Sends a request to the proxy to leave the presentation and disconnect from the server 
		 * 
		 */		
		public function leave() : void
		{
			presentationProxy.leave();
		}
		
		/**
		 * Upload a presentation to the server 
		 * @param fileToUpload - A FileReference class of the file we wish to upload
		 * 
		 */		
		public function uploadPresentation(fileToUpload : FileReference) : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/upload";
						
			var service:FileUploadService = new FileUploadService(fullUri, _room);
			facade.registerProxy(service);
			service.upload(fileToUpload);
		}
		
		/**
		 * Loads a presentation from the server. creates a new PresentationService class 
		 * 
		 */		
		public function loadPresentation() : void
		{
			var fullUri : String = _docServiceAddress + "/blindside/file/xmlslides?room=" + _room;	
			model.presentationLoaded = false;
			
			var service:PresentationService = new PresentationService(fullUri, this);
		}
		
		/**
		 * Share the presentation with the rest of the room 
		 * @param share
		 * 
		 */		
		public function sharePresentation(share : Boolean) : void
		{
			if (share) {	
				presentationProxy.share(true);		
			} else {
				presentationProxy.share(false);					
			}		
		}
		
		/**
		 * Assign a presented to the presentation 
		 * @param userid
		 * @param name
		 * 
		 */		
		public function assignPresenter(userid : Number, name : String) : void
		{
			presentationProxy.givePresenterControl(userid, name);		
		}
		
		/**
		 * This is the response event. It is called when the PresentationService class sends a request to
		 * the server. This class then responds with this event 
		 * @param event
		 * 
		 */		
		public function result(event : Object):void
		{
			//log.debug("Got result [" + event.result.toString() + "]");
		
			if (event.result.presentations == null)	return;
			
		    var result:ArrayCollection = event.result.presentations.presentation is ArrayCollection
		        ? event.result.presentations.presentation as ArrayCollection
		        : new ArrayCollection(ArrayUtil.toArray(event.result.presentations.presentation));
		    
		    var temp:ArrayCollection = new ArrayCollection();
		    var cursor:IViewCursor = result.createCursor();
		    
		    while (!cursor.afterLast)
		    {
		    	var deck:SlidesDeck = new SlidesDeck(cursor.current);
		    	//log.debug("Got gallery [" + deck.title + "]");
				model.newDeckOfSlides(deck);
		        cursor.moveNext();
		    }
		}

		/**
		 * Event is called in case the call the to server wasn't successful. This method then gets called
		 * instead of the result() method above 
		 * @param event
		 * 
		 */
		public function fault(event : Object):void
		{
			//log.debug("Got fault [" + event.fault.toString() + "]");		
		}		
	}
}