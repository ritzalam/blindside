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
package org.bigbluebutton.modules.voiceconference.view
{
	import mx.containers.Box;
	import org.blindsideproject.meetme.model.MeetMeFacade;
	import org.blindsideproject.meetme.model.MeetMeRoom;
	import org.blindsideproject.meetme.business.NetConnectionDelegate;
	import org.blindsideproject.meetme.events.*;

	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import org.blindsideproject.core.util.log.ILogger;
	import org.blindsideproject.core.util.log.LoggerFacade;
    import superpanel.nl.wv.extenders.panel.SuperPanel;
	import mx.controls.TileList;

	/**
	 * This is a convinience class for the MeetMeUserTileList GUI component. It holds some variables
	 * @author dev_team@bigbluebutton.org
	 * 
	 */	
	public class MeetMeUserListClass extends SuperPanel
	{
		private var model : MeetMeFacade = MeetMeFacade.getInstance();
		private var dispatcher : CairngormEventDispatcher = model.getDispatcher();
		private var log : ILogger = LoggerFacade.getInstance().log;
		
		
		[Bindable]
		public var meetMeRoom : MeetMeRoom = model.meetMeRoom;;
		
		[Bindable] 
		public var participantsList:TileList; 
		
		[Bindable]
		public var userRole : uint;
	}  	
}