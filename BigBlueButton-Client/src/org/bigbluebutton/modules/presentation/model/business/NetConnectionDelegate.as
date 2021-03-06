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
package org.bigbluebutton.modules.presentation.model.business
{
	import flash.events.*;
	import flash.net.NetConnection;
	
	import org.bigbluebutton.modules.presentation.PresentationFacade;

	/**
	 * The NetConnectionDelegate is a class that connects and listens to the server on behalf of
	 * the presentation module
	 * @author dev_team@bigbluebutton.org
	 * 
	 */	
	public class NetConnectionDelegate
	{
		public static const ID : String = "Presentation.NetConnectionDelegate";
		
		private var model:PresentationFacade = PresentationFacade.getInstance();
		
		private var _delegate : PresentationDelegate;
				
		private var netConnection : NetConnection;	
		private var _connUri : String;
		private var connectionId : Number;
		private var connected : Boolean = false;
					
		/**
		 * The default constructor 
		 * @param delegate - a PresentationDelegate class
		 * 
		 */					
		public function NetConnectionDelegate(delegate : PresentationDelegate) : void
		{
			_delegate = delegate;
		}
		
		public function setNetConnection(nc:NetConnection):void{
			this.netConnection = nc;
		}

		/**
		 * Connects to a server 
		 * @param host - the URL of the server
		 * @param room - the specific room we want to connect to
		 * 
		 */
		public function connect(host : String , room : String) : void
		{					
			netConnection.client = this;
			
			netConnection.addEventListener( NetStatusEvent.NET_STATUS, netStatus );
			netConnection.addEventListener( AsyncErrorEvent.ASYNC_ERROR, netASyncError );
			netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, netSecurityError );
			netConnection.addEventListener( IOErrorEvent.IO_ERROR, netIOError );
			
			try {
				_connUri = host + "/presentation/" + room;
				
				netConnection.connect(_connUri );
				
			} catch( e : ArgumentError ) {
				// Invalid parameters.
				switch ( e.errorID ) 
				{
					case 2004 :						
						//log.error( "Invalid server location: <b>" + _connUri + "</b>");											   
						break;						
					default :
					   break;
				}
			}	
		}
		
		/**
		 *  
		 * @return - the URI of the host
		 * 
		 */		
		public function get connUri() : String
		{
			return _connUri;
		}	
		
		/**
		 * Disconnects from the server 
		 * 
		 */		
		public function disconnect() : void
		{
			netConnection.close();
		}
					
		/**
		 * Method called when a NetStatusEvent is generated by the connection 
		 * @param event
		 * 
		 */					
		protected function netStatus( event : NetStatusEvent ) : void 
		{
			handleResult( event );
		}
		
		/**
		 * Handles a result received from the server 
		 * @param event
		 * 
		 */		
		public function handleResult(  event : Object  ) : void {
			var info : Object = event.info;
			var statusCode : String = info.code;
			
			switch ( statusCode ) 
			{
				case "NetConnection.Connect.Success" :
					_delegate.connectionSuccess();
					
					// find out if it's a secure (HTTPS/TLS) connection
					if ( event.target.connectedProxyType == "HTTPS" || event.target.usingTLS ) {
						//log.info( 	"Connected to secure server");
					} else {
						//log.info(	"Connected to server");
					}
					break;
			
				case "NetConnection.Connect.Failed" :
					
					_delegate.connectionFailed(event.info.application);
					
					_delegate.connectionFailed("Connection to server failed.");
					
					//log.info("Connection to server failed");
					break;
					
				case "NetConnection.Connect.Closed" :					
					_delegate.connectionFailed("Connection to server closed.");					
					//log.info("Connection to server closed");
					break;
					
				case "NetConnection.Connect.InvalidApp" :				
					_delegate.connectionFailed("Application not found on server")
					//log.info("Application not found on server");
					break;
					
				case "NetConnection.Connect.AppShutDown" :
				
					_delegate.connectionFailed("Application has been shutdown");
					//log.info("Application has been shutdown");
					break;
					
				case "NetConnection.Connect.Rejected" :
					_delegate.connectionFailed(event.info.application);
					//log.info("No permissions to connect to the application" );
					break;
					
				default :
				   // statements
				   break;
			}
		}
		
			
		/**
		 * Method is called when a NetSecurityError is received 
		 * @param event - a NetSecurityError event
		 * 
		 */			
		protected function netSecurityError( event : SecurityErrorEvent ) : void 
		{
		    handleFault( new SecurityErrorEvent ( SecurityErrorEvent.SECURITY_ERROR, false, true,
		    										  "Security error - " + event.text ) );
		}
		
		/**
		 * Method is called when a NetIOError is received 
		 * @param event - a NetIOError event
		 * 
		 */		
		protected function netIOError( event : IOErrorEvent ) : void 
		{
			handleFault( new IOErrorEvent ( IOErrorEvent.IO_ERROR, false, true, 
							 "Input/output error - " + event.text ) );
		}
			
		/**
		 * Method is called whe a NetAsyncError is received 
		 * @param event - a NetAsyncEvent
		 * 
		 */			
		protected function netASyncError( event : AsyncErrorEvent ) : void 
		{
			handleFault( new AsyncErrorEvent ( AsyncErrorEvent.ASYNC_ERROR, false, true,
							 "Asynchronous code error - <i>" + event.error + "</i>" ) );
		}
	
		/**
		 * Handles a Fault (server could not respond properly)  
		 * @param event
		 * 
		 */	
		public function handleFault(  event : Object  ) : void 
		{			
			_delegate.connectionFailed(event.text);
		}
		
		/**
		 *  
		 * @return - The server connection object
		 * 
		 */		
		public function getConnection() : NetConnection
		{
			return netConnection;
		}
	}
}