
# Overview #
This document outlines the API that is available for integrating BigBlueButton with other applications. It is currently in draft stage as not all features are available. Features which are not currently implemented will be clearly marked as such.

# Overall API Usage #
The API is implemented with the end-user in mind. To call the API, you simply make an HTTP request to a URL with the query parameters supplying the information needed for the call. The API returns an XML response. Here are some example API calls and their responses:

## _Create meeting (with your own meeting ID) example:_ ##
<a href='http://yourserver.com/bigbluebutton/api/create?name=Test+Meeting&meetingID=abcdef&attendeePW=111222&moderatorPW=333444'><a href='http://yourserver.com/bigbluebutton/api/create?name=Test+Meeting&meetingID=abcdef&attendeePW=111222&moderatorPW=333444'>http://yourserver.com/bigbluebutton/api/create?name=Test+Meeting&amp;meetingID=abcdef&amp;attendeePW=111222&amp;moderatorPW=333444</a></a>
```
<response>
    <returncode>SUCCESS</returncode>
    <meetingToken>6db0a605-627f-4f6c-a384-53f745ee372c</meetingToken>
    <meetingID>abcdef</meetingID>
    <attendeePW>111222</attendeePW>
    <moderatorPW>333444</moderatorPW>
    <messageKey/>
<message/>
</response>
```

## _Create meeting (with no meeting ID) example:_ ##
<a href='http://yourserver.com/bigbluebutton/api/create?name=Test+Meeting&meetingID=fedcba'><a href='http://yourserver.com/bigbluebutton/api/create?name=Test+Meeting&meetingID=fedcba'>http://yourserver.com/bigbluebutton/api/create?name=Test+Meeting&amp;meetingID=fedcba</a></a>
```
<response>
    <returncode>SUCCESS</returncode>
    <meetingToken>0752956f-dc4a-46f1-81a7-a1f98014c723</meetingToken>
    <meetingID>fedcba</meetingID>
    <attendeePW>tverwpay</attendeePW>
    <moderatorPW>eqma84wp</moderatorPW>
    <messageKey/>
    <message/>
</response>
```

## _Join meeting example:_ ##
<a href='http://yourserver.com/bigbluebutton/api/join?fullName=Joe+User&meetingID=abcdef&password=333444'><a href='http://yourserver.com/bigbluebutton/api/join?fullName=Joe+User&meetingID=abcdef&password=333444'>http://yourserver.com/bigbluebutton/api/join?fullName=Joe+User&amp;meetingID=abcdef&amp;password=333444</a></a>
<p>This call sends the caller directly into the application. There is no XML response. You should redirect your user to a URL like this when you are done creating the meeting and are ready to direct them into the meeting.</p>

## _Is meeting running example:_ ##
<a href='http://yourserver.com/bigbluebutton/api/isMeetingRunning?meetingID=abcdef'><a href='http://yourserver.com/bigbluebutton/api/isMeetingRunning?meetingID=abcdef'>http://yourserver.com/bigbluebutton/api/isMeetingRunning?meetingID=abcdef</a></a>
```
<response>
    <returncode>SUCCESS</returncode>
    <running>true</running>
</response>
```

More details on these calls can be found in the **API Calls** section below.

<br><br>
<h1>API Security Model</h1>
The API provides a way to be secured so that third-party apps may make calls to it, but not allow other people (end users) to make similar calls to create their own meetings, etc.<br>
For instance, a third party application that is integrated with the API may embed a JavaScript URL that calls to the BBB API to create a meeting. An end user will be able to see this URL in their browser and should not be allowed to modify a parameter (for example, the meeting ID) and create their own meeting. By doing so, they could create meetings that were not tracked by the third-party app, which could present a billing problem, et cetera. They should also not be able to modify any parameter (for instance the maximum attendees) to modify the meeting that is being created by the third party app.<br>
Those examples are clearly abuses of the system, and therefore must be protected against. The API must provide a way of enabling this protection.<br>
<br>
<h2><i>Configuration</i></h2>
<p><b>TODO:</b> the securitySalt is currently set on the ApiController and needs to be able to be configured via bigbluebutton.properties (or similar)</p>
<p><font color='#FF0000'><b>IMPORTANT: DO NOT ALLOW END USERS TO KNOW YOUR SECURITY SALT OR ELSE YOUR SECURITY WILL BE COMPROMISED.</b></font></p>

<h2><i>Usage</i></h2>
<p>The implementation of this security model lies in ApiController.groovy. It entails creating a checksum out of the combination of the entire HTTP query string and a server-configured security token.</p>
<p>To use the security model, you must be able to create an SHA-1 checksum out of the query string <i>plus</i> the security salt that you configured on your server. To do so, follow these steps:</p>
<ol><li>Create the entire query string for your API call without the checksum parameter.<br>
<ul><li>Example for create meeting API call: "name=Test+Meeting&meetingID=abc123&attendeePW=111222&moderatorPW=333444"<br>
</li></ul></li><li>Append the security salt to your string<br>
<ul><li>Example for above query string:<br>
<ul><li>security salt is "639259d4-9dd8-4b25-bf01-95f9567eaf4b"<br>
</li><li>String becomes: "name=Test+Meeting&meetingID=abc123&attendeePW=111222&moderatorPW=333444639259d4-9dd8-4b25-bf01-95f9567eaf4b"<br>
</li></ul></li></ul></li><li>Now, find the SHA-1 sum for that string (implementation varies based on programming language).<br>
<ul><li>he SHA-1 sum for the above string is: "fe1f3f036d420997a5aa6fdadb21eba346a892ad"<br>
</li></ul></li><li>Add a checksum parameter to your query string that contains this checksum.<br>
<ul><li>Above example becomes: "name=Test+Meeting&meetingID=abc123&attendeePW=111222&moderatorPW=33344 4&checksum=fe1f3f036d420997a5aa6fdadb21eba346a892ad"<br>
<p>If you configured a security salt on your server, you <b>MUST</b> send this checksum with <b>EVERY</b> API call. Since end users do not know your security salt, they can not fake calls to the server, and they can not modify your calls – since changing a single parameter name or value by only one character will completely change the checksum required to validate the call.</p>
<p>Implementations of the SHA-1 functionality exist in nearly all programming languages. Here are example methods or links to example implementations for various languages:</p>
</li></ul></li></ol><ul><li>JavaScript (describes MD5 also): <a href='http://pajhome.org.uk/crypt/md5/'><a href='http://pajhome.org.uk/crypt/md5/'>http://pajhome.org.uk/crypt/md5/</a></a>
</li><li>Java: <a href='http://commons.apache.org/codec/'><a href='http://commons.apache.org/codec/'>http://commons.apache.org/codec/</a></a>
<ul><li>You can use org.apache.commons.codec.digest.DigestUtilsandcall DigestUtils.shaHex(string + salt)<br>
</li></ul></li><li>PHP: simply call sha(string + salt)<br>
<ul><li>See <a href='http://php.net/manual/en/function.sha1.php'><a href='http://php.net/manual/en/function.sha1.php'>http://php.net/manual/en/function.sha1.php</a></a></li></ul></li></ul>

<h2><i>Error handling</i></h2>
<ul><li>Any invalid API calls should return a properly formatted document that contains enough information for the user to be able to determine what the error is.<br>
</li><li>It would be good if this returned a reasonable error message as well as a distinct error key for each type of error so that end users could internationalize their applications and provide custom messages based only on the key that we return.<br>
<ul><li>i.e.-aninvalidrequestmayreturnanerrormessageof“Noconferenceexistswiththat token ID” but the error key returned is simply “invalidTokenID”.</li></ul></li></ul>

<br><br>
<h1>Desired Future Features</h1>

<h2><i>Support for JSON/JSONP</i></h2>
<ul><li>It would be very nice to optionally allow JSON responses, and to support JSONP. This might allow for simpler integrations, even within static or almost-static webpages using JavaScript as the primary integration language. It should not be assumed that all users will be running custom software on a server and be able to process XML responses, etc.<br>
<ul><li>This being said, even within JavaScript there are simple ways to make the API call and process the returned XML (using jQuery and $.xml2json, for example)<br>
<h2><i>Meeting event callbacks</i></h2>
<p>This may actually even be called a “reverse API” - where we define an interface that the third- party application can implement to be notified of events. This would not be necessary for the first version of the API, but would be a nice feature for future enhancements. More details:</p>
</li></ul></li><li>When major events happen within meetings, it would be very helpful to provide a way for third-party applications to be notified of these events. For instance, when a user joins a conference, they will presumably be joining through the third-party app. However, when they leave the conference, the app may have certain auditing that it needs to do to record their disconnect time, etc. If BBB could make some callback to the application, this would assist in such scenarios.<br>
</li><li>For example, the application may be able to register a URL that BBB would call with status updates. BBB would define an API that such an app would be required to implement at that URL.<br>
<ul><li>i.e. -BBB could call:<br>
</li><li><a href='http://third-party-app/bbb-integ.php?event=meetingEnded&meetingID=abcd'>http://third-party-app/bbb-integ.php?event=meetingEnded&amp;meetingID=abcd</a>
<ul><li><b><a href='http://third-party-app/bbb-integ.php?event=userLeft&userID=1234'>http://third-party-app/bbb-integ.php?event=userLeft&amp;userID=1234</a>
</li><li></b> <a href='http://third-party-app/bbb-integ.php?event=meetingEnded&meetingID=abcd'>http://third-party-app/bbb-integ.php?event=meetingEnded&amp;meetingID=abcd</a>
</li></ul></li></ul></li><li>We are already announcing events such as this within BBB through ActiveMQ to communicate between the Red5 apps where these events originate and the API. It would probably not be very difficult to register additional listeners through the Spring Integration configuration that will make these HTTP calls for us for each event.</li></ul>

<br><br>
<h1>API Calls</h1>
<h2><i>Standard parameters and responses</i></h2>
<p> The following response parameters are standard to every call and may be returned from any call. </p>
<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required / Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> checksum          </td><td> Varies                     </td><td> String      </td><td> <p>See the <b>Security</b> section for more details on the usage for this parameter.</p> <p>This is basically an SHA-1 hash of queryString + securitySalt. The security salt will be configured into the application at deploy time. If a security salt is present, all calls to the API must include the checksum parameter.</p> </td></tr></tbody></table>

<p><b>Response:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>When Returned</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> returnCode        </td><td> Always               </td><td> String      </td><td> <p>Indicates whether the intended function was successful or not. Always one of two values:</p> <p>FAILED – there was an error of some sort – look for the message and messageKey for more information. Note that if the returnCode is FAILED, the call-specific response parameters marked as “always returned” will not be returned. They are only returned as part of successful responses.</p> <p>SUCCESS – the call succeeded – the other parameters that are normally associated with this call will be returned.</p></td></tr>
<tr><td> message           </td><td> Sometimes            </td><td> String      </td><td> <p>A message that gives additional information about the status of the call. A message parameter will always be returned if the returnCode was FAILED. A message may also be returned in some cases where returnCode was SUCCESS if additional information would be helpful.</p> </td></tr>
<tr><td> messageKey        </td><td> Sometimes            </td><td> String      </td><td> <p>Provides similar functionality to the message and follows the same rules. However, a message key will be much shorter and will generally remain the same for the life of the API whereas a message may change over time. If your third party application would like to internationalize or otherwise change the standard messages returned, you can look up your own custom messages based on this messageKey.</p> </td></tr></tbody></table>

<p></p>
<h2><i>Meeting workflow calls</i></h2>
<p>These calls are the primary calls of the API. They are used for creating and joining meetings.</p>
<p><font color='#FF0000'><b>NOTE:</b></font> Parameters marked with <font color='#FF0000'>(NFS)</font> are not yet fully supported. You can pass them in to the controller, but they may not have any actual effect on the conference. This is more a limitation based on support by the actual BBB application more than the API itself.</p>

<br><br>
<h1>Create Meeting (create)</h1>
<p>Example URL:<a href='http://yourserver.com/bigbluebutton/api/create?[parameters]&checksum=[checksum]'><a href='http://yourserver.com/bigbluebutton/api/create?[parameters]&checksum=[checksum'>http://yourserver.com/bigbluebutton/api/create?[parameters]&amp;checksum=[checksum</a>]</a> </p>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required / Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> name              </td><td> Required                   </td><td> String      </td><td> <p>A name for the meeting.</p> <p><font color='#FF0000'>TODO: Currently there is no way to specify a name for the meeting that is different than the meeting ID / meetme room name. This is a limitation of BBB client and not really the API.</font></p> </td></tr>
<tr><td> meetingID         </td><td> Optional                   </td><td> String      </td><td> <p>A meeting ID that can be used to identify this meeting by the third party application. This is optional, and if not supplied, BBB will generate a meeting token that can be used to identify the meeting.</p> </td></tr>
<tr><td> attendeePW        </td><td> Optional                   </td><td> String      </td><td> <p>The password that will be required for attendees to join the meeting. This is optional, and if not supplied, BBB will assign a random password.</p> </td></tr>
<tr><td> moderatorPW       </td><td> Optional                   </td><td> String      </td><td> <p>The password that will be required for moderators to join the meeting or for certain administrative actions (i.e. ending a meeting). This is optional, and if not supplied, BBB will assign a random password.</p> </td></tr>
<tr><td> maxParticipants   </td><td> Optional <font color='#FF0000'>(NFS)</font> </td><td> Number      </td><td> <p>The maximum number of participants to allow into the meeting (including moderators). After this number of participants have joined, BBB will return an appropriate error for other users trying to join the meeting. A negative number indicates that an unlimited number of participants should be allowed (this is the default setting).</p> <p><font color='#FF0000'>TODO: This can be supplied to the API currently, but BBB does not actually restrict access yet once the room is full.</font></p> </td></tr>
<tr><td> meetmeRoom        </td><td> Optional <font color='#FF0000'>(NFS)</font> </td><td> String      </td><td> <p>The name of the meetme room to use for audio conferencing.</p> </td></tr>
<tr><td> maxParticipants   </td><td> Optional <font color='#FF0000'>(NFS)</font> </td><td> Number      </td><td> <p>The name of the server that will be handling the audio portion of this conference.</p> <p><font color='#FF0000'>TODO: This is not currently supported by BBB at all. It would be very nice to allow this to be configurable and not assume that the Asterisk and BBB servers will have a 1:1 relationship. For example, some applications assign the web and audio portions to independent servers based on current load at the time of meeting creation. WebServerA might have two BBB conferences on it, while PhoneServerA	and	PhoneServerB are handling the actual Asterisk portion of each of those meetings.</font></p> </td></tr></tbody></table>

<p><b>Response:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>When Returned</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> meetingToken      </td><td> Always               </td><td> String      </td><td> <p>The internal meeting token assigned by the API for this meeting. It can be used by subsequent calls for joining or otherwise modifying a meeting's status.</p></td></tr>
<tr><td> meetingID         </td><td> Sometimes            </td><td> String      </td><td> <p>The meeting ID supplied by the third party app, or null if none was supplied. If can be used in conjunction with a password in subsequent calls for joining or otherwise modifying a meeting's status.</p> </td></tr>
<tr><td> attendeePW        </td><td> Always               </td><td> String      </td><td> <p>The password that will be required for attendees to join the meeting. If you did not supply one, BBB will assign a random password.</p> </td></tr>
<tr><td> moderatorPW       </td><td> Always               </td><td> String      </td><td> <p>The password that will be required for moderators to join the meeting or for certain administrative actions (i.e. ending a meeting). If you did not supply one, BBB will assign a random password.</p> </td></tr></tbody></table>

<br><br>
<h1>Join Meeting (join)</h1>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required/Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> fullName          </td><td> Required                 </td><td> String      </td><td> <p>The full name that is to be used to identify this user to other conference attendees.</p> </td></tr>
<tr><td> meetingToken      </td><td> Optional                 </td><td> String      </td><td> <p>The internal meeting token assigned by the API for this meeting when it was created. Note that <i>either</i> the meetingToken or the meetingID along with one of the passwords <i>must</i> be passed into this call in order to determine which meeting to find.</p> </td></tr>
<tr><td> meetingID         </td><td> Optional                 </td><td> String      </td><td> <p>If you specified a meeting ID when calling create, then you can use either the generated meeting token <i>or</i> your specified meeting ID to find meetings. This parameter takes your meeting ID.</p> </td></tr>
<tr><td> password          </td><td> Optional                 </td><td> String      </td><td> <p>The password that this attendee is using. If the moderator password is supplied, he will be given moderator status (and the same for attendee password, etc)</p> </td></tr>
<tr><td> redirectImmediately </td><td> Optional                 </td><td> Boolean     </td><td> <p>If this is passed as true, then BBB will not return a URL for you to redirect the user to, but will instead treat this as an entry URL and will immediately set up the client session and redirect the user into the conference. Values can be either a 1 (one) or a 0 (zero), indicating true or false respectively. Defaults to false.</p> </td></tr></tbody></table>


<p><b>Response:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>When Returned</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> entryURL          </td><td> Always               </td><td> String      </td><td> <p>The URL that the user can be sent to in order to join the meeting. When they go to this URL, BBB will setup their client session and redirect them into the conference.</p></td></tr></tbody></table>

<h2><i>Back-office administration calls</i></h2>
<p>These calls may be used by the back-office applications to handle meeting management, etc.</p>

<h2>Is meeting running (isMeetingRunning)</h2>
<p>This call enables you to simply check on whether or not a meeting is running by looking it up with either the token or your ID.</p>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required/Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> meetingToken      </td><td> Optional                 </td><td> String      </td><td> <p>The internal meeting token assigned by the API for this meeting when it was created.</p> </td></tr>
<tr><td> meetingID         </td><td> Optional                 </td><td> String      </td><td> <p>If you specified a meeting ID when calling create, then you can use <i>either</i> the generated meeting token <i>or</i> your specified meeting ID to find meetings. This parameter takes your meeting ID.</p> </td></tr></tbody></table>

<p><b>Response:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>When Returned</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> running           </td><td> Always               </td><td> String      </td><td> <p>A string of either “true” or “false” that signals whether a meeting with this ID or token is currently running.</p></td></tr></tbody></table>

<h2>End Meeting (endMeeting)</h2>
<p>Use this to forcibly end a meeting and kick all participants out of the meeting.</p>
<p><font color='#FF0000'>TODO: this call is not yet implemented.</font></p>

<p><b>Parameters:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>Required/Optional</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> meetingToken      </td><td> Optional                 </td><td> String      </td><td> <p>The internal meeting token assigned by the API for this meeting when it was created. Note that <i>either</i> the meetingToken or the meetingID along with one of the passwords <i>must</i> be passed into this call in order to determine which meeting to find.</p></td></tr>
<tr><td> meetingID         </td><td> Optional                 </td><td> String      </td><td> <p>If you specified a meeting ID when calling create, then you can use either the generated meeting token <i>or</i> your specified meeting ID to find meetings. This parameter takes your meeting ID.</p></td></tr>
<tr><td> password          </td><td> Required                 </td><td> String      </td><td> <p>The moderator password for this meeting. You can not end a meeting using the attendee password.</p></td></tr></tbody></table>


<p><b>Response:</b></p>
<table><thead><th> <b>Param Name</b> </th><th> <b>When Returned</b> </th><th> <b>Type</b> </th><th> <b>Description</b> </th></thead><tbody>
<tr><td> ended             </td><td> Always               </td><td> String      </td><td> <p>A string of either “true” or “false” that signals whether the meeting was successfully ended.</p></td></tr></tbody></table>


<h2>List Meeting Attendees (listAttendees)</h2>
<p>This call will list all current attendees of a meeting.</p>
<p><font color='#FF0000'>TODO: this call is not yet implemented.</font></p>


<h2>Get Meeting Info (getMeetingInfo)</h2>
<p>This call will return all of a meeting's information, including the list of attendees as well as start and end times.</p>
<p><font color='#FF0000'>TODO: this call is not yet implemented.</font></p>