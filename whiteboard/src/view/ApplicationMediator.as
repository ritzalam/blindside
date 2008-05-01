package view
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * The Application Mediator is the main mediator class of the Whiteboard application
	 * <p>
	 * This class extends the Mediator class of the PureMVC framework 
	 * @author dzgonjan
	 * 
	 */	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		/**
		 * The default constructor for the class. It calls the super() constructor, and also creates and
		 * registers the BoardMediator with the application  
		 * @param viewComponent
		 * 
		 */		
		public function ApplicationMediator(viewComponent:whiteboard)
		{
			viewComponent.txtDebug.text += "\n ApplicationMediator";
			super(NAME, viewComponent);
			facade.registerMediator(new BoardMediator(viewComponent.board));
		}
		
		/**
		 * Returns the application component (whiteboard.mxml) 
		 * @return 
		 * 
		 */		
		protected function get app():whiteboard
		{
            return viewComponent as whiteboard;
        }

	}
}