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
package org.bigbluebutton.modules.video.model.vo
{
	import org.bigbluebutton.modules.video.VideoFacade;
	import org.bigbluebutton.modules.video.model.business.MediaType;
	import org.bigbluebutton.modules.video.model.business.PublisherModel;
	import org.bigbluebutton.modules.video.model.services.BroadcastStreamDelegate;
	
	/**
	 * Holds the various settings of the broadcast stream, as well as the stream itself
	 * @author 
	 * 
	 */	
	[Bindable]
	public class BroadcastMedia implements IMedia
	{
		private var model:PublisherModel= VideoFacade.getInstance().retrieveProxy(PublisherModel.NAME) as PublisherModel;
		
		private static const _type : MediaType = MediaType.BROADCAST;
		
		public var streamName : String;
		public var uri : String;

		public var deviceStarted : Boolean = false;
		public var broadcasting : Boolean = false;
		
		public var connected : Boolean = model.connected;
		
		public var audio : AudioStream;
		public var video : VideoStream;
		public var broadcastMode : BroadcastMode = BroadcastMode.LIVE;
		public var broadcastStreamDelegate:BroadcastStreamDelegate;
		
		public function BroadcastMedia(streamName : String)
		{
			this.streamName = streamName;
			audio = new AudioStream();
			video = new VideoStream();
		}		
		
		public function get type():MediaType
		{
			return _type;
		}
	}
}