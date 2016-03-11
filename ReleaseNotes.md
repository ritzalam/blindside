<a href='Hidden comment: 
= Release 0.70: _Add_Code_Name_Here =

Released: Date Here!

* * 64-bit support starting at Ubuntu 10.04

* * Added a whiteboard for modifying the slides in the presentation window as a presenter

* * Modifications in the Graphical User Interface layout

* * Added the API calls and added some extra security to the API calls.

* * Added a PHP API class for easy integration into third-party solutions.

== Fixed Issues ==

See [http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone%3DRelease0.7&colspec=ID+Type+Status+Priority+Milestone+Owner+Component+Summary&cells=tiles]
'></a>

# Release 0.64: Lickety-split #

_Code named for the reduced bandwidth and speed improvements to desktop sharing_

Released: April 3, 2010

  * **Faster desktop sharing** - We refactored the desktop sharing applet so it now uses less CPU on the presenter's computer.  We also refactored the desktop sharing server component (bbb-apps-deskshare) so it runs faster and only sends a keyframe when new users join, which results in much less bandwidth usage during a session.

  * **Fine-grain listener management** - To make it easier for the moderator to manage listeners, such as "mute everyone except the presenter", the moderator can now "lock" a participant's mute/unmuted state in the Listener's window.  When locked, a listener is unaffected by the global mute all/unmute all buttons in the lower left-hand corner of the Listener window.  This lets the moderator lock the presenter as unmuted, then click the global mute all button to mute everyone else.  In addition, after clicking the mute all button, new listeners join as muted (this is good when a class has started and you don't want latecomers to disturb the lecture).

  * **API Additions** - Jeremy Thomerson has added three new API calls: getMeetings (returns an XML file listing all the active meetings), getMeetingInfo (get information on a specific meeting), and end (end a specific meeting).  In particular, getMeetingInfo enables external applications to query the list of users in a conference. See this [api example](http://demo.bigbluebutton.org/bigbluebutton/demo/demo4.jsp) that uses getMeetingInfo.

  * **Show number of participants** - When there are more than five participants in either the Users or Listeners window, the title of the window will show a count (i.e. Users: 7, Listeners: 9).

  * **New method for slide selection** - The presenter can now jump to a particular slide by clicking the page number button (located between the left and right arrows) and clicking on the slide from the film strip of thumbnails.

  * **Localization** - Thanks to members of the mailing list -- and to DJP for checking in language contributions -- there are now [sixteen localizations](LocalizationOfBBB.md) for BigBlueButton.

  * **RPM packages for CentOS 5.4** - We now provide [RPM packages](RPMPackaging.md) for installation on CentOS 5.4 (32-bit and 64-bit).

## Fixed Issues ##

  * See [issues fixed in BigBlueButton 0.64](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.64&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary)

## Known Issues ##

  * [Issue 419](http://code.google.com/p/bigbluebutton/issues/detail?id=419&sort=priority&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary) Viewers are unable to mute/unmute themselves
  * [Issue 357](http://code.google.com/p/bigbluebutton/issues/detail?id=357&sort=priority&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary) Uploading a presentation overwrites a previous presentation with the same name
  * [Issue 467](http://code.google.com/p/bigbluebutton/issues/detail?id=467&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary) Creating a meeting with a blank meetingID overrides any previous meetings with blank meetingIDs


# Release 0.63: Red Dot #

_Code named for the red dot that's now visible in the presentation module_

Released: January 25, 2010

## New Features ##

  * **API for Third-Party Integration** - Thanks to Jeremy Thomerson, we now have a [BigBlueButton API](http://code.google.com/p/bigbluebutton/wiki/API) that makes it easy to create and join meetings, and integrate BigBlueButton with third-party applications.

  * **Localization Support** - Another big contribution to this release is work done by Xie Yan Qing and Chen Guangtao from China, who made [localization of the BBB Client](LocalizationOfBBB.md) possible.

  * **Support for other file formats** - Jean-Philippe Guiot, a contributor from France, submitted a patch months ago that allows uploading of different file formats for the presentation module.  Now, we've finally integrated his work into BBB, so from version 0.63 you will be able to upload not only .pdf, but also .ppt, doc, txt, and other file formats!

  * **Improved Presentation Module** - The presentation module has been refactored to use the Mate Framework for Flex. It is now more robust, and has several new features, such as the ability for the viewers in a conference to see where the presenter is pointing his mouse of the current slide (the red dot!). The stability of the file upload and conversion process has also been improved.

  * **VoIP stability** - VoIP is now more stable, with fewer dropped calls than ever, and better voice quality. And no system-access fee either!

  * **Distribution** - You now longer need to compile a kernel module for VoIP.  This means that you can now [install BigBlueButton](InstallationUbuntu.md) 0.63 on any Ubuntu 9.04 32-bit (server or desktop) with just five commands.

  * **Updated Install instructions** - If you want to install BigBlueButton's components, we've provided step-by-step instructions for [Ubuntu 9.04](InstallingBigBlueButton.md), [CentOS 5.03](InstallingBigBlueButtonCentOS.md), and [Fedora 12](InstallingBigBlueButtonFedora.md).

## Fixed Issues ##
  * [See Issues Fixed in BigBlueButton 0.63](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.63%20status=Fixed&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary)

## Known Issues ##
  * [Issue 324](http://code.google.com/p/bigbluebutton/issues/detail?id=324) List of uploaded presentation doesn't get transferred when changing presenters
  * [Issue 322](http://code.google.com/p/bigbluebutton/issues/detail?id=322) Odd issue with presentation getting out of sync



# Release 0.62: Nebula NGC604 #

_Code named in honor of Nubula NGC604_

Released: November 11, 2009

## New Features ##

  * **Better Desktop Sharing!** - We've made our Desktop Sharing much better by reverse engineering the Adobe Screen Codec from specs.  The result is much faster, platform independent implementation for desktop sharing.   To share their desktop, the presenter must have Java (1.6) installed to run a Java applet.   There is no changes required for the viewers to view the presenter's desktop.  We've also simplified the user interface for both presenter and viewer

  * **Full built-in development environment** - The BigBlueButton VM makes it easier to modify and build your own versions of BigBlueButton.  See [developing in BigBlueButton](http://code.google.com/p/bigbluebutton/wiki/Developing_BigBlueButton).

  * **Updated command-line tools** - The command-line tools `bbb-setip` and `bbb-setupdev` have been consolidated into a single script `bbb-conf`. If you modify your setup, typing `bbb-conf --check` will perform some checks on your setup to look for common configuration problems with running BigBlueButton

## To upgrade your BigBlueButton 0.61 installation to 0.62 ##

If you are running  BigBlueButton VM 0.61 -- either from VM or from [apt-get packages](InstallationUbuntu.md) -- you can upgrade your installation to BigBlueButton 0.62 with with three commands.

```
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get dist-upgrade
```

**Note**: Be sure to do `sudo apt-get update` _before_ `sudo apt-get dist-upgrade`.  We've moved out a lot of configuration files into a new package called `bbb-common`.  If you skip doing an `upgrade` and go directly to `dist-upgrade`, the package manager will complain that `bbb-common` is trying to overwrite files owned by another package.

**Note**: If you had desktop sharing installed, you can upgrade the apt-get install command described in InstallingDesktopSharing.


## Fixed Issues ##
  * [Issue 11](http://code.google.com/p/bigbluebutton/issues/detail?id=11)   	 Listeners window not getting updates
  * [Issue 110](http://code.google.com/p/bigbluebutton/issues/detail?id=110) Deskshare works only when tunneling on Mac OS X
  * [Issue 150](http://code.google.com/p/bigbluebutton/issues/detail?id=150) Deskshare applet should test port to check if it should tunnel
  * [Issue 168](http://code.google.com/p/bigbluebutton/issues/detail?id=168) One one deskshare usage per session
  * [Issue 170](http://code.google.com/p/bigbluebutton/issues/detail?id=170) Switching presenter while screensharing results in old presenter seeing screenshare viewer window
  * [Issue 177](http://code.google.com/p/bigbluebutton/issues/detail?id=177) When selecting a slide from the fisheye control, the cursor becomes an i-beam
  * [Issue 179](http://code.google.com/p/bigbluebutton/issues/detail?id=179) Zooming can cause a slide to disapper when clicking next
  * [Issue 180](http://code.google.com/p/bigbluebutton/issues/detail?id=180) Deskshare can leave a stream open
  * [Issue 187](http://code.google.com/p/bigbluebutton/issues/detail?id=187) Improve slide navigation from keyboard
  * [Issue 189](http://code.google.com/p/bigbluebutton/issues/detail?id=189) Improve speed of Desktop Sharing
  * [Issue 200](http://code.google.com/p/bigbluebutton/issues/detail?id=200) Update build.sh scripts with Virtual Machine
  * [Issue 201](http://code.google.com/p/bigbluebutton/issues/detail?id=201) Update desktop sharing video
  * [Issue 203](http://code.google.com/p/bigbluebutton/issues/detail?id=203) Create wiki on how to setup development environment
  * [Issue 204](http://code.google.com/p/bigbluebutton/issues/detail?id=204) Update Installing BBB from source wiki
  * [Issue 208](http://code.google.com/p/bigbluebutton/issues/detail?id=208) Port 9123 could still be in use on restart of red5
  * [Issue 220](http://code.google.com/p/bigbluebutton/issues/detail?id=220) Not all viewers automatically seeing the shared desktop
  * [Issue 221](http://code.google.com/p/bigbluebutton/issues/detail?id=221) Tooltips for all icons
  * [Issue 226](http://code.google.com/p/bigbluebutton/issues/detail?id=226) Desktop sharing window remains open when sharer closes connection / crashes
  * [Issue 229](http://code.google.com/p/bigbluebutton/issues/detail?id=229) Last frame of desktop sharing is visible to viewers
  * [Issue 230](http://code.google.com/p/bigbluebutton/issues/detail?id=230) Flash debug client shows messages

## Known Issues ##
  * [Issue 233](http://code.google.com/p/bigbluebutton/issues/detail?id=233) 	java.io.IOException: Too many open files
  * [Issue 227](http://code.google.com/p/bigbluebutton/issues/detail?id=227) BBB apps (Red5) should reconnect to ActiveMQ when connection drops
  * [Issue 214](http://code.google.com/p/bigbluebutton/issues/detail?id=214) VoIP stops working
  * [Issue 198](http://code.google.com/p/bigbluebutton/issues/detail?id=198) Mozilla crashes uploading PDF

# Release 0.61: Titan #

Released: September 15, 2009

_Code named in honor of Saturn's largest moon_

## New Features ##

In preparation for schools and universities that are using BigBlueButton for the fall term, this month saw a lot of bug fixes, hardening, and a few new features.  Our goal was (and continues to be) to make the BigBlueButton code base as solid as possible.  Notable additions to this release include:

  * **Support for High Res Web Cameras** - As presenter, if you have the bandwidth, it's now possible to share video using your webcam at 640x480 high resolution or 320x240 standard resolution.  We've refactored the video module itself so the code is much cleaner and better organized.

  * **Simplified Desktop Sharing User Interface** - We've simplified the user experiences for initiating desktop sharing.  It now shares the entire desktop by default.  We've also refactored the desktop sharing module.

  * **Refactored slide conversion** - We went deep into the slide conversion process and fixed a number of bugs.

  * **Desktop Sharing and Xuggler** - The sharing capture applet now divides the presenter's screen into distinct tiles and only sends to the server the tiles that have changed since the last frame.  The desktop sharing also uses Xuggler re-assemble the tiles and compress the images into a flash video stream.  Because desktop sharing incorporates Xuggler, which is licensed under the AGPL, we've had to make desktop sharing a separate module (don't worry, you can install it with a single command).
However, if you choose to incorporate desktop sharing into BigBlueButton, you must accept the AGPL license for BigBlueButton. This has similar implications for any web application that, in turn, incorporates BigBlueButton.
For information on installing desktop sharing in BigBlueButton and how it changes the licensing, please see [how to install desktop sharing](http://code.google.com/p/bigbluebutton/wiki/InstallingDesktopSharing).


## To upgrade your installation ##

If you are running a BigBlueButton VM or had installed BigBlueButton using packages, you can upgrade to this release with the following two commands

```
  sudo apt-get update
  sudo apt-get upgrade
```

**Note:** If you get an error during upgrade, just run `sudo apt-get upgrade` again.  We refactored the install scripts and a previous install script and new install scrip both reference the same configuration file.  Running the upgrade command a second time will solve the problem as the first time upgrades all the install script.

## Fixed Issues ##
  * [Issue 25](http://code.google.com/p/bigbluebutton/issues/detail?id=25) Windows can get hidden or off-screen
  * [Issue 52](http://code.google.com/p/bigbluebutton/issues/detail?id=52) First moderator should become default presenter
  * [Issue 66](http://code.google.com/p/bigbluebutton/issues/detail?id=66) Progress should include generating thumbnails
  * [Issue 71](http://code.google.com/p/bigbluebutton/issues/detail?id=71) Reload after login doesn't load the person back into the session
  * [Issue 90](http://code.google.com/p/bigbluebutton/issues/detail?id=90) deskshare-app blocks red5 from restarting
  * [Issue 72](http://code.google.com/p/bigbluebutton/issues/detail?id=72) Upon uploading a presentation the first slide does not show
  * [Issue 115](http://code.google.com/p/bigbluebutton/issues/detail?id=115) Windows respond very poorly when maximized
  * [Issue 128](http://code.google.com/p/bigbluebutton/issues/detail?id=128) Unable to drag desktop sharing window while sharing fullscreen
  * [Issue 129](http://code.google.com/p/bigbluebutton/issues/detail?id=129) BigBlueButton client will hang for ~ 1 minute while it waits for direct connection to 1935 to timeout
  * [Issue 146](http://code.google.com/p/bigbluebutton/issues/detail?id=146) User can log in without entering a username
  * [Issue 149](http://code.google.com/p/bigbluebutton/issues/detail?id=149) Session not invalidated after logout
  * [Issue 157](http://code.google.com/p/bigbluebutton/issues/detail?id=157) Red5 ip is lost after upgrading
  * [Issue 161](http://code.google.com/p/bigbluebutton/issues/detail?id=161) Red5 logs are erased on restart
  * [Issue 163](http://code.google.com/p/bigbluebutton/issues/detail?id=163) Sharing full screen may cause red5 server to halt
  * [Issue 166](http://code.google.com/p/bigbluebutton/issues/detail?id=166) Video screen not resized according to the window resize
  * [Issue 168](http://code.google.com/p/bigbluebutton/issues/detail?id=168) One one deskshare usage per session
  * [Issue 169](http://code.google.com/p/bigbluebutton/issues/detail?id=169) Make "USB Video Class Video" default choice for Mac
  * [Issue 175](http://code.google.com/p/bigbluebutton/issues/detail?id=175) Maximize deskshare window when in full screen causes hang
  * [Issue 176](http://code.google.com/p/bigbluebutton/issues/detail?id=176) Share web cam icon allows multiple clicks
  * [Issue 178](http://code.google.com/p/bigbluebutton/issues/detail?id=178) Reset layout should reset sizes of windows

## Known Issues ##
  * [Issue 181](http://code.google.com/p/bigbluebutton/issues/detail?id=181) Stopping deskshare crashes Safari
  * ~~[Issue 180](http://code.google.com/p/bigbluebutton/issues/detail?id=180) Deskshare can leave a stream open~~
  * ~~[Issue 179](http://code.google.com/p/bigbluebutton/issues/detail?id=179) Zooming can cause a slide to disapper when clicking next~~
  * ~~[Issue 170](http://code.google.com/p/bigbluebutton/issues/detail?id=170) Switching presenter while screensharing results in old presenter seeing screenshare viewer window~~
  * [Issue 153](http://code.google.com/p/bigbluebutton/issues/detail?id=153)  The Show button on the Upload Window doesn't work

# 0.6 Release: Mir Space Station. August 12 2009 #


### New Features ###
**Integrated VOIP**

Participants can now use their headset to join a voice conference using voice over IP (VoIP).  For sites that setup BigBlueButton to connect to the phone system, both VoIP and dial-in participants can share the same voice conference.

The VoIP capability is based on the [Red5Phone](http://code.google.com/p/red5phone) project to connect Asterisk and Red5.

### Fixed Issues ###
Here are the list of issues we fixed on this release:
  * [Issue 67](http://code.google.com/p/bigbluebutton/issues/detail?id=67) Red5 Phone Module
  * [Issue 69](http://code.google.com/p/bigbluebutton/issues/detail?id=69) Users do not see slides from presenter
  * [Issue 98](http://code.google.com/p/bigbluebutton/issues/detail?id=98) Left and Right arrow keys not working
  * [Issue 99](http://code.google.com/p/bigbluebutton/issues/detail?id=99) Update Reset Zoom icon
  * [Issue 104](http://code.google.com/p/bigbluebutton/issues/detail?id=104) Add Desktop Sharing to BigBlueButton
  * [Issue 106](http://code.google.com/p/bigbluebutton/issues/detail?id=106) Unable to start desktop sharing
  * [Issue 108](http://code.google.com/p/bigbluebutton/issues/detail?id=108) Client does not provide proper feedback when logging out
  * [Issue 114](http://code.google.com/p/bigbluebutton/issues/detail?id=114) Client trying to load history.js and history.htm
  * [Issue 117](http://code.google.com/p/bigbluebutton/issues/detail?id=117) Log window is hard to read
  * [Issue 118](http://code.google.com/p/bigbluebutton/issues/detail?id=118) Limitation of conference session does not work.
  * [Issue 121](http://code.google.com/p/bigbluebutton/issues/detail?id=121) Can't input chat text in full screen mode
  * [Issue 125](http://code.google.com/p/bigbluebutton/issues/detail?id=125) Build bbb-apps from VM
  * [Issue 130](http://code.google.com/p/bigbluebutton/issues/detail?id=130) Hearing voices after logging out
  * [Issue 135](http://code.google.com/p/bigbluebutton/issues/detail?id=135) Participant entry sound plays when user icon is clicked
  * [Issue 136](http://code.google.com/p/bigbluebutton/issues/detail?id=136) Phone Logout null pointer exception
  * [Issue 138](http://code.google.com/p/bigbluebutton/issues/detail?id=138) Unmute-all icon mis-aligned
  * [Issue 139](http://code.google.com/p/bigbluebutton/issues/detail?id=139) bbb-setip not detecting rtmp port

### Known Issues ###
  * [Issue 141](http://code.google.com/p/bigbluebutton/issues/detail?id=141) Impossible to disconnect from voice-conference w/o logging out
  * ~~[Issue 133](http://code.google.com/p/bigbluebutton/issues/detail?id=133) Webcam window still visible to other participants after logging out~~
  * ~~[Issue 129](http://code.google.com/p/bigbluebutton/issues/detail?id=129) Client takes too long to test port 1935 and start tunneling~~
  * [Issue 127](http://code.google.com/p/bigbluebutton/issues/detail?id=127) Video stream not properly closing in client
  * ~~[Issue 107](http://code.google.com/p/bigbluebutton/issues/detail?id=107) Cut-and-paste url should give a login error~~
  * [Issue 88](http://code.google.com/p/bigbluebutton/issues/detail?id=88) PDF slide with many symbols causing long delay
  * ~~[Issue 72](http://code.google.com/p/bigbluebutton/issues/detail?id=72) Upon uploading a presentation the first slide does not show~~

Released: August 12, 2009

# 0.5 Release: Apollo 11 #

Released: July 21, 2009

_Code named in honor of the 40th anniversary of the moon landing_

### New Features ###
**Desktop Sharing**

Desktop Sharing has been in development for a long time.  We wanted a solution that would work on all three platforms (Mac, Unix, and PC), so we decided to use a Java Applet to grab to send screen updates to the Red5 server.  We then used Xuggler from within Red5 to create a live stream from the incoming images from the applet.

From the presenter's perspective, there is a new screen icon on the top toolbar. Once clicked, the presenter can choose the area of their screen to share.  Clicking on Start Sharing causes this area of their screen to appear on all the clients.  While sharing the presenter can still drag around the window to determine which portion of the screen gets shared.

**Private Chat**

Any participant can now chat privately with anyone else in the room by choosing their name from the drop-down menu in the chat window.

Under the hood, the private chat works in the same way as the public chat, except that each participant has a dedicated shared object on the server to which messages get sent, and to which only they listen to.

### Fixed Issues ###
Here are the list of issues we fixed on this release:
  * [Issue 109](http://code.google.com/p/bigbluebutton/issues/detail?id=109) Cannot upload twice a file
  * [Issue 101](http://code.google.com/p/bigbluebutton/issues/detail?id=101) Red5 video app has significant delay
  * [Issue 96](http://code.google.com/p/bigbluebutton/issues/detail?id=96) Fixed the thumbnail view in presentation module to be more responsive and user friendly
  * [Issue 94](http://code.google.com/p/bigbluebutton/issues/detail?id=94) Change applet certificate
  * [Issue 93](http://code.google.com/p/bigbluebutton/issues/detail?id=93) deskshare-client should tunnel through port 80
  * [Issue 87](http://code.google.com/p/bigbluebutton/issues/detail?id=87) Logout should close the deskshare module
  * [Issue 85](http://code.google.com/p/bigbluebutton/issues/detail?id=85) Added a zoom slide to presentation module, for users without mousewheel
  * [Issue 84](http://code.google.com/p/bigbluebutton/issues/detail?id=84) Only one instance of the upload window can now be opened.
  * [Issue 78](http://code.google.com/p/bigbluebutton/issues/detail?id=78) Added Desktop Sharing. The presenter can now do a screen-cast
  * [Issue 75](http://code.google.com/p/bigbluebutton/issues/detail?id=75) bbb-setupdev -s (setup samba) now gives the correct path
  * [Issue 5](http://code.google.com/p/bigbluebutton/issues/detail?id=5) Added Private Chat. Participants can now chat privately with any other participant in the conference

### Known Issues ###
  * [Issue 112](http://code.google.com/p/bigbluebutton/issues/detail?id=112) Desk share video shows the final frame when presenter logs out
  * ~~[Issue 111](http://code.google.com/p/bigbluebutton/issues/detail?id=111) Desk share video has narrow yellow stripe at the top~~
  * ~~[Issue 110](http://code.google.com/p/bigbluebutton/issues/detail?id=110) Deskshare works only when tunneling on Mac OS X~~
  * [Issue 95](http://code.google.com/p/bigbluebutton/issues/detail?id=95) Deskshare app sometimes crashes
  * ~~[Issue 90](http://code.google.com/p/bigbluebutton/issues/detail?id=90) deskshare-app blocks red5 from restarting~~

# Release 0.4 #

Released: June 12, 2009

Much of the effort in this release was on creating individual packages for the components, creating a [Continuous Integration Server](http://bigbluebutton.org/hudson/) using Hudson, and distributing the entire package as a [downloadable virtual machine](http://code.google.com/p/bigbluebutton/wiki/BigBlueButtonVM).

Other updates include:
  * BigBlueButton client now supports tunneling through a firewall via port 80
  * Uploading of multiple slides

# Release 0.32 #
Added
  * Pan and zoom around the slide with the mouse and mouse-wheel