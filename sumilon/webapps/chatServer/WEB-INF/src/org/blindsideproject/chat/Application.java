
package org.blindsideproject.chat;


 

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCapableConnection;
import org.red5.server.api.so.ISharedObject;
import org.blindsideproject.chat.listener.ChatSharedObjectListener;

/**
 * This is the base class of chat server application. It overwrites the methods of ApplicationAdapter class. 
 * [See ApplicationAdapter description in Conference Application section.]
 * 
 * Chat server uses SharedObjectListener to listen to the chat messages passed between clients using ChatSO SharedObject. It stores all the chat history.
 * When a new client join the group chat, server send the chat history to the client.
 * 
 * 
 */
public class Application extends ApplicationAdapter 
				implements IPendingServiceCallback
{

	/**
	 * listener object for chatSO SharedObject. Used by chat clients for communication.
	 */
	ChatSharedObjectListener chatListener = null;
		
	boolean debugMode = true;
	
	  /** 
	   * This method is called once on scope start. overrides MultiThreadedApplicationAdapter.appStart(IScope).
	   * Since this is the Application start handler method, all the initialization tasks that the server application needs, have to go here.
	   *  
	   * @param app the Application scope
	   * @return true if Application can be started, or esle false
	   * 
	   * 
	   * @see org.red5.server.adapter.MultiThreadedApplicationAdapter#appStart(org.red5.server.api.IScope)
	   */
	  public boolean appStart (IScope app)
	  {
		  if (!super.appStart(app))
	    		return false;
		  
	      return true;
	  }
	  
	  /**
	   * This method is automatically called when chat Server application is stopped. 
	   * The tasks that are needed to be done before exiting the server, have to go here.
	   * 
	   */
	  public void appStop ()
	  {
		 
	  }
	  /** 
	   * Called once on room scope start (when first client connects to the scope). overrides MultiThreadedApplicationAdapter.roomStart(IScope).
	   * This function makes sure that chatSO SharedObject is created. It also registers a listener to the SharedObject. 
	   *  
	   * @param room the Room scope
	   * @return true if Room can be started and the sharedObject is created, or esle false
	   * 
	   * 
	   * @see org.red5.server.adapter.MultiThreadedApplicationAdapter#roomStart(org.red5.server.api.IScope)
	   */
	  public boolean roomStart(IScope room) {
		  // create a sharedobject with the name chatSO
		  
		  if (!super.roomStart(room))
	    		return false;
		  
		  if(!hasSharedObject(room, "chatSO")){
			  if(!createSharedObject(room, "chatSO", true))
				  System.out.println("Sharedobject::chatSO could not be created");
		  }
	      ISharedObject so = getSharedObject(room, "chatSO", true);
	      
	      if(so == null){
	    	  System.out.println("SharedObject was not created");
	    	  return false;
	      }
	      
	      // create a SharedObject listener and register it to listen on chatSO
	      chatListener = new ChatSharedObjectListener();
	      so.addSharedObjectListener(chatListener);
	      

	      return true;            
	  }
	  /**
	   * This method is called every time client leaves room scope. Developer can add tasks here that are needed to be executed when a client disconnects from the server.
	   * @param client chat client
	   * @param room room scope
	   * @return
	   * 
	   * 
	   * @see org.red5.server.adapter.MultiThreadedApplicationAdapter#roomLeave(org.red5.server.api.IClient, org.red5.server.api.IScope)
	   */
	  public void roomLeave(IClient client, IScope room) {

	  }
	  /**
	   * Called every time client joins room scope
	   * @param client chat client
	   * @param room Room scope
	   * 
	   */ 
	  public boolean roomJoin(IClient client, IScope room) {
	     	
		  System.out.println("\n\n CLIENT ID IS: " + client.getId());
	  	
		  return true;
	  } 
	  /**
	   * This method is called every time new client connects to the application. NetConnection.connect() call from client side, call this function in server side.
	   * It also takes parameters from the client. This method is a powerful handler method which allows developers to add tasks here that needs to be done every time a new client connects to the server. 
	   * In this method, server invokes setChatLog() method remotely to send chat history to the new client
	   * @param conn the connection between server and client
	   * 
	   * @param params parameter array passed from client
	   * @return true
	   * 
	   */
	  public boolean roomConnect(IConnection conn, Object[] params) {

		  if (conn instanceof IServiceCapableConnection) {
			  IServiceCapableConnection sc = (IServiceCapableConnection) conn;
			  String chatLog = chatListener.getChatLog();
			  // call client method remotely to send chat Log
			  sc.invoke("setChatLog", new Object[]{chatLog});
		  }
		  

	  	  return true;
	  }
	    /**
	     * Called when the result comes from remote method invokation
	     * @param call IPendingServiceCall 
	     * 
	     */
	  public void resultReceived(IPendingServiceCall call) {
//			log.info("Received result " + call.getResult() + " for "
//					+ call.getServiceMethodName());		
		}
	  
}