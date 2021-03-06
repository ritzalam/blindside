/**
* BigBlueButton open source conferencing system - http://www.bigbluebutton.org/
*
* Copyright (c) 2008 by respective authors (see below).
*
* This program is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free Software
* Foundation; either version 2.1 of the License, or (at your option) any later
* version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT ANY
* WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
* PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
* 
*/
package org.bigbluebutton.modules.chat
{
	import org.bigbluebutton.modules.chat.controller.StartupCommand;
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	/**
	 * 
	 * Class ChatFacade
	 * 
	 */	
	public class ChatFacade extends Facade implements IFacade
	{
		
		public static const NAME:String = "ChatFacade";
		public static const STARTUP:String          = "startup";
		public static const NEW_MESSAGE:String      = "newMessage";
		public static const CLOSE_CHAT:String       = "closeChat";
		
		
		public function ChatFacade()
		{
			super(NAME);
		}
		
		/**
		 * 
		 * @returns the instance of ChatFacade
		 * 
		 */
		public static function getInstance():ChatFacade{
			if (instanceMap[NAME] == null) instanceMap[NAME] = new ChatFacade();
			return instanceMap[NAME] as ChatFacade;
		
		}
		
		/**
		 * initializes the controller and registers the required commands with it 
		 * 
		 */
		override protected function initializeController():void{
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
			
		}
		/**
		 * 
		 * @param app:ChatModule
		 * 
		 */		
		public function startup(app:ChatModule):void {
			sendNotification(ChatFacade.STARTUP, app);
		}
		
		
		
	}
}