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
package org.bigbluebutton.modules.viewers.model.business
{
	import mx.collections.ArrayCollection;
	
	import org.bigbluebutton.modules.viewers.model.vo.User;
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * 
	 * @author
	 * 
	 */	
	public class Conference extends Mediator implements IMediator
	{
		public static const NAME:String = "Conference";
		
		private var _myUserid : Number;
		
		[Bindable] public var me:User = null;		
		[Bindable] public var users : ArrayCollection = null;				
		[Bindable] public var connected : Boolean = false;
		
		public var connectFailReason : String;		
		public var host : String;
		public var room : String;
		
		/**
		 * The default constructor. Creates a new Conference object 
		 * 
		 */		
		public function Conference() : void
		{
			super(NAME);
			me = new User();
			users = new ArrayCollection();
		}

		/**
		 * Adds a user to this conference 
		 * @param newuser
		 * 
		 */		
		public function addUser(newuser : User) : void
		{				
			if (! hasParticipant(newuser.userid)) {						
				users.addItem(newuser);
				sort();
			}					
		}

		/**
		 * Check if the user with the specified id exists 
		 * @param id
		 * @return 
		 * 
		 */		
		public function hasParticipant(id : Number) : Boolean
		{
			var index : int = getParticipantIndex(id);
			
			if (index > -1) {
				return true;
			}
						
			return false;		
		}
		
		/**
		 * Get the user with the specific id 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getParticipant(id : Number) : User
		{
			var index : int = getParticipantIndex(id);
			
			if (index > -1) {
				return users.getItemAt(index) as User;
			}
						
			return null;				
		}
		
		/**
		 * Remove participant with the specified id number 
		 * @param userid
		 * 
		 */		
		public function removeParticipant(userid : Number) : void
		{
			var index : int = getParticipantIndex(userid);
			
			//log.debug( "removing user[" + userid + " at index=" + index + "]")
			
			if (index > -1) {
				//log.debug( "remove user[" + userid + " at index=" + index + "]");
				
				users.removeItemAt(index);
				sort();
			}							
		}
		
		/**
		 * Get the index number of the participant with the specific userid 
		 * @param userid
		 * @return -1 if participant not found
		 * 
		 */		
		private function getParticipantIndex(userid : Number) : int
		{
			var aUser : User;
			
			for (var i:int = 0; i < users.length; i++)
			{
				aUser = users.getItemAt(i) as User;
				
				if (aUser.userid == userid) {
					return i;
				}
			}				
			
			// Participant not found.
			return -1;
		}

		/**
		 * Removes all the participants from the conference 
		 * 
		 */		
		public function removeAllParticipants() : void
		{
			users.removeAll();
		}		

		/**
		 * Change the status of the user 
		 * @param id
		 * @param newStatus
		 * 
		 */		
		public function newUserStatus(id : Number, newStatus : String) : void
		{
			var aUser : User = getParticipant(id);
			
			if (aUser != null) {
				aUser.status = newStatus;
			}	
			
			sort();		
		}
		
		/**
		 * Sorts the users by name 
		 * 
		 */		
		private function sort() : void
		{
			users.source.sortOn("name", Array.CASEINSENSITIVE);	
			users.refresh();				
		}				
	}
}