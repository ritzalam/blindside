package org.bigbluebutton.main
{
	import org.bigbluebutton.core.Constants;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class MainApplicationFacade extends Facade implements IFacade
	{
		private var ENV : String = Constants.DEV_ENV;
		
		public function MainApplicationFacade(key:String)
		{
			super(key);
		}
		
		public function registerProxy(proxy:IProxy):void
		{
		}
		
		public function retrieveProxy(proxyName:String):IProxy
		{
			return null;
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
		}
		
		public function removeProxy(proxyName:String):IProxy
		{
			return null;
		}
		
		public function initializeNotifier(key:String):void
		{
		}
		
		public function hasProxy(proxyName:String):Boolean
		{
			return false;
		}
		
		public function registerCommand(noteName:String, commandClassRef:Class):void
		{
		}
		
		public function removeCommand(notificationName:String):void
		{
		}
		
		public function hasCommand(notificationName:String):Boolean
		{
			return false;
		}
		
		public function registerMediator(mediator:IMediator):void
		{
		}
		
		public function retrieveMediator(mediatorName:String):IMediator
		{
			return null;
		}
		
		public function removeMediator(mediatorName:String):IMediator
		{
			return null;
		}
		
		public function hasMediator(mediatorName:String):Boolean
		{
			return false;
		}
		
		public function notifyObservers(notification:INotification):void
		{
		}
		
		public function removeCore(key:String):void
		{
		}
		
		public function get runtimeEnvironment() : String
		{
			return ENV;
		}
		
		public function set runtimeEnvironment(env : String)
		{
			ENV = env;
		}
	}
}