/*
  Modularity - A PureMVC AS3 MultiCore Flex Demo
  Copyright(c) 2008 Cliff Hall <clifford.hall@puremvc.org>
  Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.widgetworks.superwidget.view
{
	import com.widgetworks.superwidget.model.SuperWidgetProxy;
	import com.widgetworks.superwidget.view.components.SuperWidget;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.LinkButton;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;

	public class SuperWidgetMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'SuperWidgetMediator';
		
		public function SuperWidgetMediator(viewComponent:SuperWidget)
		{
			super( NAME, viewComponent );
			superWidget.addEventListener( SuperWidget.POKE, onPoke );
		}
		
		override public function initializeNotifier(key:String):void
		{
			super.initializeNotifier(key);
			superWidgetProxy = facade.retrieveProxy( SuperWidgetProxy.NAME ) as SuperWidgetProxy;
		} 

		protected function onPoke( event:Event ):void
		{
			// add a button to the canvas
			var button:LinkButton = new LinkButton();
			button.label = 'You poked the Super Widget! [ Click to Remove ]';
			button.addEventListener( MouseEvent.CLICK, onComponentClick );
			button.setStyle("color", "red");
			var btnMsg : IPipeMessage = new Message("AddComponent", null, button);			
			superWidget.mbus.outputPipe().write(btnMsg);
			
			// and add some status message text 
			var status:String = "Some data from the SuperWidget Model: [ "+superWidgetProxy.getData().toString()+ " ]";
			var statusMsg : IPipeMessage = new Message("StatusMessage", null, status);
			superWidget.mbus.outputPipe().write(statusMsg);	
		}
		
		
		// Handle clicks to the buttons added to the widget canvas
		protected function onComponentClick( event:MouseEvent ):void
		{
			var component:DisplayObject = event.target as DisplayObject;
			var cmpMsg : IPipeMessage = new Message("RemoveComponent", null, component);			
			superWidget.mbus.outputPipe().write(cmpMsg);
			
			component.removeEventListener( MouseEvent.CLICK, onComponentClick );
			
			// and add some status message text 
			var status:String = "Removed SuperWidget-generated display object from Widget Canvas";
			var statusMsg : IPipeMessage = new Message("StatusMessage", null, status);
			superWidget.mbus.outputPipe().write(statusMsg);	

		}

		protected function get superWidget():SuperWidget
		{
			return viewComponent as SuperWidget;
		}		
		
		protected var superWidgetProxy:SuperWidgetProxy;
		
	}
}