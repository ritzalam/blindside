package org.blindsideproject.core.apps.presentation.model
{
	import org.blindsideproject.core.IApplication;
	import mx.collections.ArrayCollection;

	import org.blindsideproject.core.apps.presentation.business.PresentationDelegate;
	import org.blindsideproject.core.apps.presentation.vo.SlidesDeck;
	
	public class PresentationModel implements IApplication
	{
		/**
		 * The userid of this participant.
		 */
		public var userid : Number;
		
		// If connected to the presentation server or not
		[Bindable] public var isConnected : Boolean = false;				
		
		// The host of the presentation server application.
		public var host : String;
		
		public var room : String;
		
		// Is this user the presenter?
		[Bindable] public var isPresenter : Boolean = false;
		[Bindable] public var presenterName : String = "No presenter";
		
		// Has this presenter loaded a presentation
		[Bindable] public var presentationLoaded : Boolean = false;
		
		/**
		 * If a presentation is being shared or not.
		 */
		[Bindable] public var isSharing : Boolean = false;
		
		/**
		 * The presentation slides being shared.
		 */
		[Bindable] public var decks : SlidesDeck;
		
		public function PresentationModel() : void {}
				
		public function displayDefaultSlide() : void
		{
			decks.displayDefaultSlide();
		}
		
		public function newDeckOfSlides(deck : SlidesDeck) : void
		{
		    if (decks == null) {
		    	decks = deck;
		    } else {
		        decks.name = deck.name;	        
		        decks.selected = deck.selected;
		        decks.title = deck.title;
		        decks.slides.removeAll();
		        decks.slides = new ArrayCollection(deck.slides.source);
		    }		
		    
			presentationLoaded = true;	
		}
		
		public function open(userid:Number):void
		{
			this.userid = userid;
		}
		
		public function getApplicationId():String
		{
			return null;
		}
		
		public function close():void
		{
			isConnected = false;
		}
		
	}
}