

# Overview #
This document outlines the API that is available for integrating BigBlueButton with other applications. The changes between releases will be described in the document. Features which are not currently implemented will be clearly marked as such.

The API is implemented with the end-user in mind. To call the API, you simply make an HTTP request to a URL with the query parameters supplying the information needed for the call. The API returns an XML response.

The current API implementation lies on the bigbluebutton-web component, which has been written using the Grails framework.

# API Changes in Releases #

## Version 0.64 ##
Added new API calls:
  * **isMeetingRunning**
  * **end**
  * **getMeetingInfo**
  * **getMeetings**

## Version 0.7 ##
In 0.70, we made a couple of changes that will force you to update your API integrations.  These changes were necessary to improve the security of the API and our ability to add features in future releases.  We apologize for any inconvenience this may have caused.

Added new API calls:
  * **api version returned on index**

Fixes:
  * **Fixed**<a href='http://code.google.com/p/bigbluebutton/issues/detail?id=487'><a href='https://code.google.com/p/blindside/issues/detail?id=487'>Issue 487</a></a> **- Add the action name to the checksum calculation.
  *** Fixed <a href='http://code.google.com/p/bigbluebutton/issues/detail?id=473'><a href='https://code.google.com/p/blindside/issues/detail?id=473'>Issue 473</a></a> **- Remove "meetingToken" from the API.
  *** Fixed <a href='http://code.google.com/p/bigbluebutton/issues/detail?id=394'><a href='https://code.google.com/p/blindside/issues/detail?id=394'>Issue 394</a></a> **- Need endMeeting API call implemented.
  *** Fixed <a href='http://code.google.com/p/bigbluebutton/issues/detail?id=247'><a href='https://code.google.com/p/blindside/issues/detail?id=247'>Issue 247</a></a> **- DynamicConferenceService never cleans out ended conferences.
  *** Fixed <a href='http://code.google.com/p/bigbluebutton/issues/detail?id=393'><a href='https://code.google.com/p/blindside/issues/detail?id=393'>Issue 393</a></a> **- Need getMeetingInfo API call implemented.**

## Version 0.8 ##
Added new API calls:
  * **getRecordings**
  * **publishRecordings**
  * **deleteRecordings**

Updates:
  * **create** - Now supports pre-uploading slides
  * **create** - Added new parameters duration and record
  * **join** - Added createTime parameter
  * **getMeetingInfo** - Added recording indicator to the response

For a detail of the updates in the api 0.8 check the following <a href='http://groups.google.com/group/bigbluebutton-dev/browse_thread/thread/c214cbe9bdb2268a'>link</a>

## Version Master Branch ##
No changes yet.

<br />
# API Security Model #
The API provides a way to be secured so that third-party apps may make calls to it, but not allow other people (end users) to make similar calls to create their own meetings, etc.
For instance, a third party application that is integrated with the API may embed a JavaScript URL that calls to the BBB API to create a meeting. An end user will be able to see this URL in their browser and should not be allowed to modify a parameter (for example, the meeting ID) and create their own meeting. By doing so, they could create meetings that were not tracked by the third-party app, which could present a billing problem, etcetera. They should also not be able to modify any parameter (for instance the maximum attendees) to modify the meeting that is being created by the third party app.
Those examples are clearly abuses of the system, and therefore must be protected against. The API must provide a way of enabling this protection.

## _Configuration_ ##
The securitySalt is set in

```
   /var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties 
```

Look for the parameter

```
   beans.dynamicConferenceService.securitySalt=<your_salt>
```


<p><font color='#FF0000'><b>IMPORTANT: DO NOT ALLOW END USERS TO KNOW YOUR SECURITY SALT OR ELSE YOUR SECURITY WILL BE COMPROMISED.</b></font></p>

## _Usage_ ##
<p>The implementation of this security model lies in ApiController.groovy. It entails creating a checksum out of the combination of the entire HTTP query string and a server-configured security token.</p>
<p>To use the security model, you must be able to create an SHA-1 checksum out of the call name <i>plus</i> the query string <i>plus</i> the security salt that you configured on your server. To do so, follow these steps:</p>
  1. Create the entire query string for your API call without the checksum parameter.
    * Example for create meeting API call: "name=Test+Meeting&meetingID=abc123&attendeePW=111222&moderatorPW=333444"
  1. Prepend the call name to your string
    * Example for above query string:
      * call name is "create"
      * String becomes: "createname=Test+Meeting&meetingID=abc123&attendeePW=111222&moderatorPW=333444"
  1. Now, append the security salt to your string
    * Example for above query string:
      * security salt is "639259d4-9dd8-4b25-bf01-95f9567eaf4b"
      * String becomes: "createname=Test+Meeting&meetingID=abc123&attendeePW=111222&moderatorPW=333444639259d4-9dd8-4b25-bf01-95f9567eaf4b"
  1. Now, find the SHA-1 sum for that string (implementation varies based on programming language).
    * he SHA-1 sum for the above string is: "1fcbb0c4fc1f039f73aa6d697d2db9ba7f803f17"
  1. Add a checksum parameter to your query string that contains this checksum.
    * Above example becomes: "name=Test+Meeting&meetingID=abc123&attendeePW=111222&moderatorPW=333444&checksum=1fcbb0c4fc1f039f73aa6d697d2db9ba7f803f17"
<p>If you configured a security salt on your server, you <b>MUST</b> send this checksum with <b>EVERY</b> API call. Since end users do not know your security salt, they can not fake calls to the server, and they can not modify your calls – since changing a single parameter name or value by only one character will completely change the checksum required to validate the call.</p>
<p>Implementations of the SHA-1 functionality exist in nearly all programming languages. Here are example methods or links to example implementations for various languages:</p>
  * JavaScript (describes MD5 also): <a href='http://pajhome.org.uk/crypt/md5/'><a href='http://pajhome.org.uk/crypt/md5/'>http://pajhome.org.uk/crypt/md5/</a></a>
  * Java: <a href='http://commons.apache.org/codec/'><a href='http://commons.apache.org/codec/'>http://commons.apache.org/codec/</a></a>
    * You can use org.apache.commons.codec.digest.DigestUtilsandcall DigestUtils.shaHex(string + salt)
  * PHP: simply call sha(string + salt)
    * See <a href='http://php.net/manual/en/function.sha1.php'><a href='http://php.net/manual/en/function.sha1.php'>http://php.net/manual/en/function.sha1.php</a></a>

## _Error handling_ ##
  * All API calls make a best-effort attempt to return a properly formatted document that contains enough information for the user to be able to determine what the error is.
  * Errors are returned with a "returncode" value of "FAILED" and a "message" and "messageKey" value.  We will try very hard to keep the messageKey stable (unchanging) throughout the life of the API.  However, the "message" value is a plain text (english) value that may change with time.  You can use the messageKey to determine the type of error and look up internationalized text within your own system if needed.
  * i.e. - An invalid request may return an error message of "No conference with that meeting ID exists", but the messageKey is simple "invalidMeetingIdentifier".

<br /><br />

# API Resources #
## Administration ##
In the following section is described the administration calls
| Resource | Description |
|:---------|:------------|
| create   | Creates a new meeting. |
| join     | Join a new user to an existing meeting. |
| end      | Ends meeting. |

## Monitoring ##
In the following section is described the monitoring calls
| Resource | Description |
|:---------|:------------|
| isMeetingRunning | Checks whether if an specified meeting is running. |
| getMeetings | Get a list of the Meetings. |
| getMeetingInfo | Get the details of a Meeting. |

## Recording ##
| Resource | Description |
|:---------|:------------|
| getRecordings | Get a list of recordings. |
| publishRecordings | Enables to publish or unpublish a recording. |
| deleteRecordings | Deletes a existing Recording |

<br /><br />
# API Calls #
<p><font color='#FF0000'><b>NOTE:</b></font> Parameters marked with <font color='#FF0000'>(NFS)</font> are not yet fully supported. You can pass them in to the controller, but they may not have any actual effect on the conference. This is more a limitation based on support by the actual BBB application more than the API itself.</p>

## Standard parameters and responses ##
<p> The following response parameters are standard to every call and may be returned from any call. </p>
<p><b>Parameters:</b></p>
| **Param Name** | **Required / Optional** | **Type** | **Description** |
|:---------------|:------------------------|:---------|:----------------|
| checksum       | Varies                  | String   | <p>See the <b>Security</b> section for more details on the usage for this parameter.</p> <p>This is basically an SHA-1 hash of callName + queryString + securitySalt. The security salt will be configured into the application at deploy time. If a security salt is present, all calls to the API must include the checksum parameter.</p> |

<p><b>Response:</b></p>
| **Param Name** | **When Returned** | **Type** | **Description** |
|:---------------|:------------------|:---------|:----------------|
| returncode     | Always            | String   | <p>Indicates whether the intended function was successful or not. Always one of two values:</p> <p>FAILED – there was an error of some sort – look for the message and messageKey for more information. Note that if the returncode is FAILED, the call-specific response parameters marked as “always returned” will not be returned. They are only returned as part of successful responses.</p> <p>SUCCESS – the call succeeded – the other parameters that are normally associated with this call will be returned.</p>|
| message        | Sometimes         | String   | <p>A message that gives additional information about the status of the call. A message parameter will always be returned if the returncode was FAILED. A message may also be returned in some cases where returncode was SUCCESS if additional information would be helpful.</p> |
| messageKey     | Sometimes         | String   | <p>Provides similar functionality to the message and follows the same rules. However, a message key will be much shorter and will generally remain the same for the life of the API whereas a message may change over time. If your third party application would like to internationalize or otherwise change the standard messages returned, you can look up your own custom messages based on this messageKey.</p> |


<br><br>
<h2>Create Meeting</h2>
<p>Creates a bigbluebutton meeting, according to the parameters passed.</p>

<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/create?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/create?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required / Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> name              </td><td> Required                   </td><td> String      </td><td> <p>A name for the meeting.</p> </td></tr>
<tr><td> meetingID         </td><td> Required                   </td><td> String      </td><td> <p>A meeting ID that can be used to identify this meeting by the third party application.  This must be unique to the server that you are calling.  If you supply a non-unique meeting ID, you will still have a successful call, but will receive a warning message in the response. If you intend to use the recording feature, the meetingID shouldn't contain commas.</p> </td></tr>
<tr><td> attendeePW        </td><td> Optional                   </td><td> String      </td><td> <p>The password that will be required for attendees to join the meeting. This is optional, and if not supplied, BBB will assign a random password.</p> </td></tr>
<tr><td> moderatorPW       </td><td> Optional                   </td><td> String      </td><td> <p>The password that will be required for moderators to join the meeting or for certain administrative actions (i.e. ending a meeting). This is optional, and if not supplied, BBB will assign a random password.</p> </td></tr>
<tr><td> welcome           </td><td> Optional                   </td><td> String      </td><td> <p>A welcome message that gets displayed on the chat window when the participant joins. You can include keywords (<code>%%CONFNAME%%</code>, <code>%%DIALNUM%%</code>, <code>%%CONFNUM%%</code>) which will be substituted automatically. You can set a default welcome message on <a href='http://code.google.com/p/bigbluebutton/source/browse/trunk/bigbluebutton-web/grails-app/conf/bigbluebutton.properties'>bigbluebutton.properties</a></p> </td></tr>
<tr><td> dialNumber        </td><td> Optional                   </td><td> String      </td><td> <p>The dial access number that participants can call in using regular phone. You can set a default dial number on <a href='http://code.google.com/p/bigbluebutton/source/browse/trunk/bigbluebutton-web/grails-app/conf/bigbluebutton.properties'>bigbluebutton.properties</a></p> </td></tr>
<tr><td> voiceBridge       </td><td> Optional                   </td><td> String      </td><td> <p>Voice conference number that participants enter to join the voice conference. The default pattern for this is a 5-digit number, because in the default Asterisk configuration, this is the PIN that a dial-in user must enter to join the conference.  If you want to change this pattern, you have to edit /etc/asterisk/bbb_extensions.conf.  When using the default setup, we recommend you always pass a 5 digit voiceBridge parameter -- and have it begin with the digit '7' if you are using the default FreeSWITCH setup (see <a href='http://code.google.com/p/bigbluebutton/wiki/FAQ#Why_did_my_voice_conference_number_worked_in_0.7_but_not_in_0.71'>FAQ entry</a>). Finally, if you don't pass a value for voiceBridge, then users will not be able to join a voice conference for the session. </p> </td></tr>
<tr><td> webVoice          </td><td> Optional                   </td><td> String      </td><td> <p>Voice conference alphanumberic that participants enter to join the voice conference.</p> </td></tr>
<tr><td> logoutURL         </td><td> Optional                   </td><td> String      </td><td> <p>The URL that the BigBlueButton client will go to after users click the OK button on the 'You have been logged out message'.  This overrides, the value for <code>bigbluebutton.web.loggedOutURL</code> if defined in <a href='http://code.google.com/p/bigbluebutton/source/browse/trunk/bigbluebutton-web/grails-app/conf/bigbluebutton.properties'>bigbluebutton.properties</a></p> <p><font color='#FF0000'>.</font></p> </td></tr>
<tr><td> maxParticipants   </td><td> Optional <font color='#FF0000'>(NFS)</font> </td><td> Number      </td><td> <p>The maximum number of participants to allow into the meeting (including moderators). After this number of participants have joined, BBB will return an appropriate error for other users trying to join the meeting. A negative number indicates that an unlimited number of participants should be allowed (this is the default setting).</p> <p><font color='#FF0000'>TODO: This can be supplied to the API currently, but BBB does not actually restrict access yet once the room is full.</font></p> </td></tr>
<tr><td> record            </td><td> Optional                   </td><td> String      </td><td> <p>Setting ‘record=true’ instructs the BigBlueButton server to record the media and events in the session for later playback. Available values are true or false. Default value is false. </p> </td></tr>
<tr><td> duration          </td><td> Optional                   </td><td> Number      </td><td> <p>The duration parameter allows to specify the number of minutes for the meeting's length. When the length of the meeting reaches the duration, BigBlueButton automatically ends the meeting. The default is 0, which means the meeting continues until the last person leaves or an end API calls is made with the associated meetingID.</p> </td></tr>
<tr><td> meta<b></td><td> Optional</b></td><td> String      </td><td> <p>You can pass one or more metadata values for create a meeting. These will be stored by BigBlueButton and later retrievable via the getMeetingInfo call and getRecordings. Examples of meta parameters are meta_Presenter, meta_category, meta_LABEL, etc.  All parameters are converted to lower case, so meta_Presenter would be the same as meta_PRESENTER. </p> </td></tr></tbody></table>


<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/create?name=Test&meetingID=test01&checksum=1234'>http://yourserver.com/bigbluebutton/api/create?name=Test&amp;meetingID=test01&amp;checksum=1234</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/create?name=Test&meetingID=test01&moderatorPW=mp&attendeePW=ap&checksum=wxyz'>http://yourserver.com/bigbluebutton/api/create?name=Test&amp;meetingID=test01&amp;moderatorPW=mp&amp;attendeePW=ap&amp;checksum=wxyz</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/create?name=Test&meetingID=test01&moderatorPW=mp&attendeePW=ap&meta_presenter=joe&meta_category=education&checksum=abcd'>http://yourserver.com/bigbluebutton/api/create?name=Test&amp;meetingID=test01&amp;moderatorPW=mp&amp;attendeePW=ap&amp;meta_presenter=joe&amp;meta_category=education&amp;checksum=abcd</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt; <br>
	&lt;returncode&gt;SUCCESS&lt;/returncode&gt; <br>
    &lt;meeting&gt; <br>
        &lt;meetingID&gt;Test&lt;/meetingID&gt; <br>
        &lt;createTime&gt;1308591802&lt;/createTime&gt; <br>
        &lt;attendeePW&gt;ap&lt;/attendeePW&gt; <br>
        &lt;moderatorPW&gt;mp&lt;/moderatorPW&gt; <br>
        &lt;hasBeenForciblyEnded&gt;false&lt;/hasBeenForciblyEnded&gt; <br>
        &lt;messageKey&gt;createSuccess&lt;/messageKey&gt; <br>
        &lt;message&gt;Meeting has been create&lt;/message&gt; <br>
    &lt;/meeting&gt; <br>
&lt;/response&gt; <br>
</code></pre>

<h3>Preupload Slides</h3>
Now, it's possible to preupload slides within the create call. You can specify an URL for BigBlueButton to download and process the slides or you can upload the slides in base64 form. For use the preupload slides part, you have to do it in the following way:<br>
<br>
<ul><li>You have to send a HTTP POST request.<br>
</li><li>The URL Resource has to be the same as the previously described.<br>
</li><li>In the body part, you would append a simple XML like the following with the presentation to upload:<br>
<pre><code>&lt;?xml version="1.0" encoding="UTF-8"?&gt; <br>
&lt;modules&gt; <br>
    &lt;module name="presentation"&gt; <br>
        &lt;document url="http://www.samplepdf.com/sample.pdf" /&gt; <br>
        &lt;document name="sample-presentation.pdf"&gt;JVBERi0xLjQKJ....<br>
          [clipped here]<br>
          ....0CiUlRU9GCg==<br>
        &lt;/document&gt; <br>
    &lt;/module&gt; <br>
&lt;/modules&gt; <br>
</code></pre></li></ul>

And that's all!<br>
<br>
For more information about the preupload slides check the following <a href='http://groups.google.com/group/bigbluebutton-dev/browse_thread/thread/d36ba6ff53e4aa79'>link</a>. For a complete example of the preupload slides check the following demos: <a href='https://github.com/bigbluebutton/bigbluebutton/blob/master/bbb-api-demo/src/main/webapp/demo7.jsp'>demo7</a> and <a href='https://github.com/bigbluebutton/bigbluebutton/blob/master/bbb-api-demo/src/main/webapp/demo8.jsp'>demo8</a>.<br>
<br>
<br><br>

<h2>Join Meeting</h2>
<p>Joins automatically a user to the meeting specified in the meetingID parameter.</p>

<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/join?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/join?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required/Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> fullName          </td><td> Required                 </td><td> String      </td><td> <p>The full name that is to be used to identify this user to other conference attendees.</p> </td></tr>
<tr><td> meetingID         </td><td> Required                 </td><td> String      </td><td> <p>The meeting ID that identifies the meeting you are attempting to join.</p> </td></tr>
<tr><td> password          </td><td> Required                 </td><td> String      </td><td> <p>The password that this attendee is using. If the moderator password is supplied, he will be given moderator status (and the same for attendee password, etc)</p> </td></tr>
<tr><td> createTime        </td><td> Optional                 </td><td> String      </td><td> <p>Third-party apps using the API can now pass createTime parameter (which was created in the create call), BigBlueButton will ensure it matches the ‘createTime’ for the session.  If they differ, BigBlueButton will not proceed with the join request. This prevents a user from reusing their join URL for a subsequent session with the same meetingID.</p> </td></tr>
<tr><td> userID            </td><td> Optional                 </td><td> String      </td><td> <p>NEW in 0.7</p><p>An identifier for this user that will help your application to identify which person this is.  This user ID will be returned for this user in the getMeetingInfo API call so that you can check </p> </td></tr>
<tr><td> webVoiceConf      </td><td> Optional                 </td><td> String      </td><td> <p>If you want to pass in a custom voice-extension when a user joins the voice conference using voip. This is useful if you want to collect more info in you Call Detail Records about the user joining the conference. You need to modify your /etc/asterisk/bbb-extensions.conf to handle this new extensions. </p> </td></tr></tbody></table>

<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/join?meetingID=test01&password=mp&fullName=John&checksum=1234'>http://yourserver.com/bigbluebutton/api/join?meetingID=test01&amp;password=mp&amp;fullName=John&amp;checksum=1234</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/join?meetingID=test01&password=ap&fullName=Mark&checksum=wxyz'>http://yourserver.com/bigbluebutton/api/join?meetingID=test01&amp;password=ap&amp;fullName=Mark&amp;checksum=wxyz</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/join?meetingID=test01&password=ap&fullName=Chris&createTime=273648&checksum=abcd'>http://yourserver.com/bigbluebutton/api/join?meetingID=test01&amp;password=ap&amp;fullName=Chris&amp;createTime=273648&amp;checksum=abcd</a></a></li></ul>

<p><b>Example Response:</b></p>
There is no XML response for this call if it is properly formatted.  You should simply redirect the user to the call URL, and they will be entered into the meeting.<br>
<br>
<p><font color='#FF0000'>NOTE: there is the possibility that a user is sent to a join URL that is invalid right now.  For instance, if the client application forms the URL incorrectly, or sends the user to join a meeting that hasn't been created, then the user will end up seeing the XML that would be returned as an error.  We need to figure out a better way of handling this.</font></p>

<br /><br />

<h2>Is Meeting Running</h2>
<p>This call enables you to simply check on whether or not a meeting is running by looking it up with your meeting ID.</p>

<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/isMeetingRunning?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/isMeetingRunning?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required/Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> meetingID         </td><td> Required                 </td><td> String      </td><td> <p>The meeting ID that identifies the meeting you are attempting to check on.</p> </td></tr></tbody></table>

<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/isMeetingRunning?meetingID=test01&checksum=1234'>http://yourserver.com/bigbluebutton/api/isMeetingRunning?meetingID=test01&amp;checksum=1234</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt;<br>
   &lt;returncode&gt;SUCCESS&lt;/returncode&gt;<br>
   &lt;running&gt;true&lt;/running&gt;<br>
&lt;/response&gt;<br>
</code></pre>

<p>running can be “true” or “false” that signals whether a meeting with this ID is currently running.</p>

<br /><br />

<h2>End Meeting</h2>
<p>Use this to forcibly end a meeting and kick all participants out of the meeting.</p>

<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/end?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/end?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required/Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> meetingID         </td><td> Required                 </td><td> String      </td><td> <p>The meeting ID that identifies the meeting you are attempting to end.</p> </td></tr>
<tr><td> password          </td><td> Required                 </td><td> String      </td><td> <p>The moderator password for this meeting. You can not end a meeting using the attendee password.</p></td></tr></tbody></table>

<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/end?meetingID=1234567890&password=mp&checksum=1234'>http://yourserver.com/bigbluebutton/api/end?meetingID=1234567890&amp;password=mp&amp;checksum=1234</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt;<br>
   &lt;returncode&gt;SUCCESS&lt;/returncode&gt;<br>
   &lt;messageKey&gt;sentEndMeetingRequest&lt;/messageKey&gt;<br>
   &lt;message&gt;<br>
   A request to end the meeting was sent. Please wait a few seconds, and then use the getMeetingInfo or isMeetingRunning API calls to verify that   it was ended.<br>
   &lt;/message&gt;<br>
&lt;/response&gt;<br>
</code></pre>

<font color='#FF0000'>IMPORTANT NOTE:</font>  You should note that when you call end meeting, it is simply sending a request to the backend (Red5) server that is handling all the conference traffic.  That backend server will immediately attempt to send every connected client a logout event, kicking them from the meeting.  It will then disconnect them, and the meeting will be ended.  However, this may take several seconds, depending on network conditions.  Therefore, the end meeting call will return a success as soon as the request is sent.  But to be sure that it completed, you should then check back a few seconds later by using the getMeetingInfo or isMeetingRunning calls to verify that all participants have left the meeting and that it successfully ended.<br>
<br>
<font color='#FF0000'>TODO: In future iterations, this call will also mark a meeting that has ended so that it can not be immediately restarted with the same join meeting URLs that initially dropped users into the meeting.  This will protect against devious users restarting a meeting that you just kicked them from.</font>

<br /><br />

<h2>Get Meeting Info</h2>
<p>This call will return all of a meeting's information, including the list of attendees as well as start and end times.</p>

<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/getMeetingInfo?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/getMeetingInfo?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required/Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> meetingID         </td><td> Required                 </td><td> String      </td><td> <p>The meeting ID that identifies the meeting you are attempting to check on.</p> </td></tr>
<tr><td> password          </td><td> Required                 </td><td> String      </td><td> <p>The moderator password for this meeting. You can not get the meeting information using the attendee password.</p></td></tr></tbody></table>

<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/getMeetingInfo?meetingID=test01&password=mp&checksum=1234'>http://yourserver.com/bigbluebutton/api/getMeetingInfo?meetingID=test01&amp;password=mp&amp;checksum=1234</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt;<br>
   &lt;returncode&gt;SUCCESS&lt;/returncode&gt;<br>
   &lt;meetingName&gt;Test&lt;/meetingName&gt;<br>
   &lt;meetingID&gt;test01&lt;/meetingID&gt;<br>
   &lt;createTime&gt;1315254777880&lt;/createTime&gt;<br>
   &lt;attendeePW&gt;ap&lt;/attendeePW&gt;<br>
   &lt;moderatorPW&gt;mp&lt;/moderatorPW&gt;<br>
   &lt;running&gt;true&lt;/running&gt;<br>
   &lt;recording&gt;false&lt;/recording&gt;<br>
   &lt;hasBeenForciblyEnded&gt;false&lt;/hasBeenForciblyEnded&gt;<br>
   &lt;startTime&gt;1315254785069&lt;/startTime&gt;<br>
   &lt;endTime&gt;0&lt;/endTime&gt;<br>
   &lt;participantCount&gt;1&lt;/participantCount&gt;<br>
   &lt;maxUsers&gt;20&lt;/maxUsers&gt;<br>
   &lt;moderatorCount&gt;1&lt;/moderatorCount&gt;<br>
   &lt;attendees&gt;<br>
      &lt;attendee&gt;<br>
         &lt;userID&gt;1&lt;/userID&gt;<br>
         &lt;fullName&gt;John Doe&lt;/fullName&gt;<br>
         &lt;role&gt;MODERATOR&lt;/role&gt;<br>
      &lt;/attendee&gt;<br>
   &lt;/attendees&gt;<br>
   &lt;metadata/&gt;<br>
   &lt;messageKey/&gt;<br>
   &lt;message/&gt;<br>
&lt;/response&gt;<br>
</code></pre>

<p>
<font color='#FF0000'>TODO: add participant join / disconnect times to each attendee node.</font>
</p>

<br /><br />

<h2>Get Meetings</h2>
<p>This call will return a list of all the meetings found on this server.</p>

<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/getMeetings?checksum=[checksum'>http://yourserver.com/bigbluebutton/api/getMeetings?checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
Now, In BigBlueButton 0.8 is not required to pass any parameter for this call.<br>
<br>
<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/getMeetings?checksum=1234'>http://yourserver.com/bigbluebutton/api/getMeetings?checksum=1234</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt;<br>
   &lt;returncode&gt;SUCCESS&lt;/returncode&gt;<br>
   &lt;meetings&gt;<br>
      &lt;meeting&gt;<br>
         &lt;meetingID&gt;test01&lt;/meetingID&gt;<br>
         &lt;meetingName&gt;Test&lt;/meetingName&gt;<br>
         &lt;createTime&gt;1315254777880&lt;/createTime&gt;<br>
         &lt;attendeePW&gt;ap&lt;/attendeePW&gt;<br>
         &lt;moderatorPW&gt;mp&lt;/moderatorPW&gt;<br>
         &lt;hasBeenForciblyEnded&gt;false&lt;/hasBeenForciblyEnded&gt;<br>
         &lt;running&gt;true&lt;/running&gt;<br>
      &lt;/meeting&gt;<br>
   &lt;/meetings&gt;<br>
&lt;/response&gt;<br>
</code></pre>

<br /><br />

<h2>Get Recordings</h2>
<p>Retrieves the recordings that are available for playback for a given<br>
meetingID (or set of meeting IDs).</p>
<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/getRecordings?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/getRecordings?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required / Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> meetingID         </td><td> Optional                   </td><td> String      </td><td> <p>A meeting ID for get the recordings. It can be a set of meetingIDs separate by commas. If the meeting ID is not specified, it will get ALL the recordings.</p> </td></tr></tbody></table>

<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/getRecordings?checksum=1234'>http://yourserver.com/bigbluebutton/api/getRecordings?checksum=1234</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/getRecordings?meetingID=CS101&checksum=abcd'>http://yourserver.com/bigbluebutton/api/getRecordings?meetingID=CS101&amp;checksum=abcd</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/getRecordings?meetingID=CS101,CS102&checksum=wxyz'>http://yourserver.com/bigbluebutton/api/getRecordings?meetingID=CS101,CS102&amp;checksum=wxyz</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt;<br>
   &lt;returncode&gt;SUCCESS&lt;/returncode&gt; <br>
   &lt;recordings&gt;<br>
      &lt;recording&gt; <br>
         &lt;recordID&gt;183f0bf3a0982a127bdb8161-1308597520&lt;/recordID&gt; <br>
         &lt;meetingID&gt;CS101&lt;/meetingID&gt; <br>
         &lt;name&gt;&lt;![CDATA[On-line session for CS 101]]&gt;&lt;/name&gt; <br>
         &lt;published&gt;false&lt;/published&gt; <br>
         &lt;startTime&gt;Thu Mar 04 14:05:56 UTC 2010&lt;/startTime&gt; <br>
         &lt;endTime&gt;Thu Mar 04 15:01:01 UTC 2010&lt;/endTime&gt; <br>
         &lt;metadata&gt; <br>
            &lt;title&gt;&lt;![CDATA[Test Recording]]&gt;&lt;/title&gt; <br>
            &lt;subject&gt;&lt;![CDATA[English 232 session]]&gt;&lt;/subject&gt; <br>
            &lt;description&gt;&lt;![CDATA[First Class]]&gt;&lt;/description&gt; <br>
            &lt;creator&gt;&lt;![CDATA[Fred Dixon]]&gt;&lt;/creator&gt; <br>
            &lt;contributor&gt;&lt;![CDATA[Richard Alam]]&gt;&lt;/contributor&gt; <br>
            &lt;language&gt;&lt;![CDATA[en_US]]&gt;&lt;/language&gt; <br>
         &lt;/metadata&gt; <br>
         &lt;playback&gt; <br>
            &lt;format&gt; <br>
               &lt;type&gt;simple&lt;/type&gt; <br>
               &lt;url&gt;http://server.com/simple/playback?recordID=183f0bf3a0982a127bdb8161-1...&lt;/url&gt; <br>
               &lt;length&gt;62&lt;/length&gt; <br>
            &lt;/format&gt; <br>
         &lt;/playback&gt;<br>
      &lt;/recording&gt; <br>
      &lt;recording&gt; <br>
         &lt;recordID&gt;183f0bf3a0982a127bdb8161-13085974450&lt;/recordID&gt; <br>
         &lt;meetingID&gt;CS102&lt;/meetingID&gt; <br>
         ... <br>
      &lt;/recording&gt; <br>
   &lt;/recordings&gt; <br>
   &lt;messageKey/&gt; <br>
   &lt;message/&gt; <br>
&lt;/response&gt;<br>
</code></pre>



<br><br>

<h2>Publish Recordings</h2>
<p>Publish and unpublish recordings for a given recordID (or set of record IDs).</p>
<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/publishRecordings?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/publishRecordings?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required / Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> recordID          </td><td> Required                   </td><td> String      </td><td> <p>A record ID for specify the recordings to apply the publish action. It can be a set of meetingIDs separate by commas. </p> </td></tr>
<tr><td> publish           </td><td> Required                   </td><td> String      </td><td> <p>The value for publish or unpublish the recording(s). Available values: true or false. </p> </td></tr></tbody></table>

<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/publishRecordings?recordID=record123&publish=true&checksum=1234'>http://yourserver.com/bigbluebutton/api/publishRecordings?recordID=record123&amp;publish=true&amp;checksum=1234</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/publishRecordings?recordID=record123,recordABC&publish=true&checksum=wxyz'>http://yourserver.com/bigbluebutton/api/publishRecordings?recordID=record123,recordABC&amp;publish=true&amp;checksum=wxyz</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt;<br>
    &lt;returncode&gt;SUCCESS&lt;/returncode&gt;<br>
    &lt;published&gt;true&lt;/published&gt;<br>
&lt;/response&gt;<br>
</code></pre>



<br><br>

<h2>Delete Recordings</h2>
<p>Delete one or more recordings for a given recordID (or set of record IDs).</p>
<p><b>Resource URL:</b></p>
<a href='#'><a href='http://yourserver.com/bigbluebutton/api/deleteRecordings?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/deleteRecordings?[parameters]&amp;checksum=[checksum</a>]</a>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required / Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> recordID          </td><td> Required                   </td><td> String      </td><td> <p>A record ID for specify the recordings to delete. It can be a set of meetingIDs separate by commas. </p> </td></tr></tbody></table>

<p><b>Example Requests:</b></p>
<ul><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/deleteRecordings?recordID=record123&checksum=1234'>http://yourserver.com/bigbluebutton/api/deleteRecordings?recordID=record123&amp;checksum=1234</a></a>
</li><li><a href='#'><a href='http://yourserver.com/bigbluebutton/api/deleteRecordings?recordID=record123,recordABC&checksum=wxyz'>http://yourserver.com/bigbluebutton/api/deleteRecordings?recordID=record123,recordABC&amp;checksum=wxyz</a></a></li></ul>

<p><b>Example Response:</b></p>
<pre><code>&lt;response&gt;<br>
    &lt;returncode&gt;SUCCESS&lt;/returncode&gt;<br>
    &lt;deleted&gt;true&lt;/deleted&gt;<br>
&lt;/response&gt;<br>
</code></pre>



<br><br>

<h1>API Sample Code</h1>
<h2>Overview</h2>
BigBlueButton provides API Sample Codes so you can integrated easily with your application. Feel free to contribute and post your implementation of the API in other language code in the bigbluebutton-dev mailing list.<br>
<br>
<h2>Language code</h2>
<h3>JSP</h3>
It is updated with the latest API version: <a href='https://github.com/bigbluebutton/bigbluebutton/tree/master/bbb-api-demo'><a href='https://github.com/bigbluebutton/bigbluebutton/tree/master/bbb-api-demo'>https://github.com/bigbluebutton/bigbluebutton/tree/master/bbb-api-demo</a></a>

<h3>PHP</h3>
Needs to be updated, however you can find it useful: <a href='https://github.com/bigbluebutton/bigbluebutton/tree/master/labs/bbb-api-php'>https://github.com/bigbluebutton/bigbluebutton/tree/master/labs/bbb-api-php</a>

You need to enable the "allow_url_fopen" to "On" in your php.ini file so this example can work. Simply add/replace to your php.ini file :<br>
<br>
<code>allow_url_fopen = On</code>

<h3>Ruby</h3>
Needs to be updated, however you can find it useful:<br>
<a href='https://github.com/mconf/bigbluebutton-api-ruby'>https://github.com/mconf/bigbluebutton-api-ruby</a>

<h3>Javascript</h3>
See the Chrome extension that allows for API testing. Obviously implementing your entire integration in JavaScript is risky because you must expose your security salt.  <b>This is not recommended</b>. Also note that if you integrate using Javascript and you are calling the API on a different domain than the one that your JavaScript is being served from, you will have cross-site scripting issues. Also, needs to be updated: <a href='http://github.com/jthomerson/BigBlueButton-api-chrome-extension'>http://github.com/jthomerson/BigBlueButton-api-chrome-extension</a>


<h1>API Testing Tools</h1>
If you are developing in bigbluebutton, most of the time you will need to make many API calls. You can use the following tools that will help you for your tests.<br>
<br>
<h2>BBB API Buddy</h2>
This application will help you to automatically generate the most commons URL's of the bigbluebutton API. You just need to fill the fields and test!<br>
<a href='http://www.omarshammas.com/bbbapibuddy'>http://www.omarshammas.com/bbbapibuddy</a>

you can check the code in:<br>
<a href='https://github.com/omarshammas/bigbluebutton-API-Buddy'>https://github.com/omarshammas/bigbluebutton-API-Buddy</a>

<h2>Chrome extension</h2>
There is a Chrome extension that allows for quickly testing the API functionality. It's currently working with the 0.7 API.  You can also use it to help you understand usage of the API.<br>
<br>
The extension can be found at: <a href='https://chrome.google.com/extensions/detail/ncbonhmhjnamefpmmjdpbohnkbeliehb'>https://chrome.google.com/extensions/detail/ncbonhmhjnamefpmmjdpbohnkbeliehb</a>

The code for the extension can be found at: <a href='http://github.com/jthomerson/BigBlueButton-api-chrome-extension'>http://github.com/jthomerson/BigBlueButton-api-chrome-extension</a>

<br><br>

<h1>Desired Future Features</h1>

<h2>Support for JSON/JSONP</h2>
<ul><li>It would be very nice to optionally allow JSON responses, and to support JSONP. This might allow for simpler integrations, even within static or almost-static webpages using JavaScript as the primary integration language. It should not be assumed that all users will be running custom software on a server and be able to process XML responses, etc.<br>
<ul><li>This being said, even within JavaScript there are simple ways to make the API call and process the returned XML (using jQuery and $.xml2json, for example)<br>
<h2>Meeting event callbacks</h2>
<p>This may actually even be called a “reverse API” - where we define an interface that the third- party application can implement to be notified of events. This would not be necessary for the first version of the API, but would be a nice feature for future enhancements. More details:</p>
</li></ul></li><li>When major events happen within meetings, it would be very helpful to provide a way for third-party applications to be notified of these events. For instance, when a user joins a conference, they will presumably be joining through the third-party app. However, when they leave the conference, the app may have certain auditing that it needs to do to record their disconnect time, etc. If BBB could make some callback to the application, this would assist in such scenarios.<br>
</li><li>For example, the application may be able to register a URL that BBB would call with status updates. BBB would define an API that such an app would be required to implement at that URL.<br>
<ul><li>i.e. -BBB could call:<br>
</li><li><a href='http://third-party-app/bbb-integ.php?event=meetingEnded&meetingID=abcd'>http://third-party-app/bbb-integ.php?event=meetingEnded&amp;meetingID=abcd</a>
<ul><li><b><a href='http://third-party-app/bbb-integ.php?event=userLeft&userID=1234'>http://third-party-app/bbb-integ.php?event=userLeft&amp;userID=1234</a>
</li><li></b> <a href='http://third-party-app/bbb-integ.php?event=meetingEnded&meetingID=abcd'>http://third-party-app/bbb-integ.php?event=meetingEnded&amp;meetingID=abcd</a>
</li></ul></li></ul></li><li>We are already announcing events such as this within BBB through ActiveMQ to communicate between the Red5 apps where these events originate and the API. It would probably not be very difficult to register additional listeners through the Spring Integration configuration that will make these HTTP calls for us for each event.</li></ul>

<br><br>