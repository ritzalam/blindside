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

package org.bigbluebuttonproject.fileupload.document;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


// TODO: Auto-generated Javadoc
/**
 * This class is used for logging in blindside-servlet. Provides a compact way for other classes to log.
 * 
 * @author ritzalam
 */
public class LogProgressListener implements IProgressListener {
	// get the current log for LogProgressListener class
	/** The log. */
	private static Log log = LogFactory.getLog(LogProgressListener.class);
	
	/* (non-Javadoc)
	 * @see org.bigbluebuttonproject.fileupload.document.IProgressListener#update(java.lang.String)
	 */
	public void update(String message) {
		log.info(message);
	}

}
