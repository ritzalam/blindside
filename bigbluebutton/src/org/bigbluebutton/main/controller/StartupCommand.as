package org.bigbluebutton.main.controller
{
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	import org.puremvc.as3.multicore.interfaces.INotification;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		public function StartupCommand()
		{
			super();
		}
		
		public function execute(notification:INotification):void
		{
		}
		
		public function sendNotification(notificationName:String, body:Object=null, type:String=null):void
		{
		}
		
		public function initializeNotifier(key:String):void
		{
		}
		
	}
}