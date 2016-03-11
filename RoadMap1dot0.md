

# Introduction #
As the popularity of BigBlueButton increases, we are increasingly asked "when are you going to release BigBlueButton 1.0?"

We first released BigBlueButton version 0.4 on June 12, 2009 (see [project history](http://en.wikipedia.org/wiki/BigBlueButton#History)).  Since then, first we've had nine subsequent releases: 0.5, 0.6, 0.61, 0.62, 0.63, 0.64, 0.7, 0.71, and 0.71a – each improving on the previous, each reflecting a strong desire by the core development team to build a solid product.

This document outlines the **DRAFT** requirements for 1.0.

For many interested in this project, the version number is arbitrary -- it's a marketing name.  Whether its 0.71a, 1.2, 4.5 or some other number, we see more universities, colleges, and K12 institutions using BigBlueButton in their classes, and more companies integrating BigBlueButton into their products.

For others -- including the core developers -- the version number is **not** arbitrary.  It represents a level of quality, stability, and completeness in BigBlueButton we want to achieve before calling it 1.0.  When BigBlueButton 1.0 is released, it will be in substance, not name.

The requirements for BigBlueButton 1.0 are driven by our target market: distance education. We are often asked "why are you focusing on one target market -- don’t you realize that BigBlueButton would be great for market X, Y, and Z?"  We realize this, but we also realize that the core features of BigBlueButton -- shared chat, presentation, voice, video, and desktop -- are the same core features for many markets (including distance education).  Our belief is when we deliver a world-class open source solution for distance education, then we will, in essence, deliver a world class solution for other markets as well.

What are the requirements for distance education?  At the highest level, we state the goal of BigBlueButton is to enable universities and colleges to provide remote students a high-quality learning experience.  Going into more detail, we can refine the requirements using the following user stories:

  * As a teacher, I want to start my on-line class within five minutes so I can focus my energies on teaching students.

  * As a remote student, I want to effortlessly interact with the teacher and other students so I can focus my energies on learning.

  * As an administrator, I want to install BigBlueButton in under fifteen minutes so I can experiment with its capabilities within my organization.

  * As a developer, I want to integrate BigBlueButton into my product in less than four hours so I can demonstrate integrated real-time collaboration.

From the above user stories there are four distinct roles: teacher, student, administrator, and developer.  Each user has a job to accomplish.  We want the interface of BigBlueButton to fade into the background and enable each user to get that job done efficiently.

In drafting this document, there are a few key goals not related to any specific feature; rather, they underlie all of the requirements.  These key goals are usability, stability, and APIs.

  * **Usability** - If we’ve learned anything in the past nine releases, it’s that if we can make BigBlueButton simpler in a release, we’re headed in the right direction.  Whenever a first time teacher or student is able to quickly get started with BigBlueButton, the product establishes a very positive initial first impression.  Usability touches all human-facing aspect of the product, including the quality of audio and video.

  * **Stability** - Translating that initial positive impression into long-term adoption requires rock-solid stability.  We run our demo server for days without reboot, but we want to have some formal metrics for determining 1.0.  These metrics need to be based on proper coverage for unit, integration, and stress testing.

  * **APIs** - BigBlueButton's API is very simple, and simple is good.  It's helped create a [growing list](http://bigbluebutton.org/support) of 3rd party integrations with other open source products.  As we work towards 1.0, we need to keep the APIs simple but also expand them to enable pre-uploading of slides, dynamic configuration of the client, and access recorded content.

There's lots of detail in this document.  To avoid duplication, many times we'll link a requirement to its associated issue.  Parts of this document are titled "Areas under investigation", which list those requirements that are under consideration for BigBlueButton 1.0, but not committed to that release.  Obviously, if we tried to add every feature in our issue tracker to 1.0, we’d never finish; therefore, there is section at the end of this document for those items planned for post 1.0.

We welcome your feedback on this roadmap to 1.0.

# The DRAFT Requirements for BigBlueButton 1.0 #

## Core Features ##
This section covers the enhancement and additions we want to make to BigBlueButton’s core features.

### Record and Playback ###
This feature is currently in development for BigBlueButton 0.8.  See [Record and Playback specifications](http://code.google.com/p/bigbluebutton/wiki/RecordPlaybackSpecification).

Release 0.8 will focus on record and playback of slides + audio in an HTML5 interface.   Support an video playback of the slides + audio ([900](http://code.google.com/p/bigbluebutton/issues/list?thanks=900)).

### Pre-flight checklist ###
Sometimes Flash has difficulty picking the right microphone, speaker, or webcam for the user’s setup.  Other times the presenter can’t start their desktop sharing because Java is not properly installed.  These problems can delay the start of a session.

The pre-flight checklist is in development for 0.8 ([122](http://code.google.com/p/bigbluebutton/issues/detail?id=122)).

### Unify the Users and Listeners window ###
When there are 25 (or more) users in a session, having a separate Users window (those logged in from the web) and Listeners window (those who have joined the voice conference) starts to cause usability problems for the presenter.  For example, when a student raises her hand in the Users window, the moderator must scroll and hunt for the associated user in the Listeners window to unmute the student ([901](http://code.google.com/p/bigbluebutton/issues/detail?id=901)).


### Accessibility for users with disabilities ###
BigBlueButton must support students with disabilities.  Specifically, it must support the necessary [Section 508](http://www.section508.gov/) requirements to enable access by users with disabilities ([85](http://code.google.com/p/bigbluebutton/issues/detail?id=85)).


### Voice ###
The built-in VoIP (clicking the headset icon) in BigBlueButton has an average 2-4 second delay.  This is perceptible even when running in a LAN environment, where the network latency and packet loss are negligible.  A description of the reasons for the delay are in [FAQ](http://code.google.com/p/bigbluebutton/wiki/FAQ#Why_is_there_a_delay_in_the_audio_when_I_use_VoIP?).

BigBlueButton must have **no** perceptual voice delay for 50 users running within a LAN environment ([740](http://code.google.com/p/bigbluebutton/issues/detail?id=740)).

Note: We've made some progress towards this goal in a recent [forum post](http://groups.google.com/group/bigbluebutton-dev/browse_thread/thread/a36d61df9b9fc45b).

### Video ###
BigBlueButton uses the built-in video from Flash.   Currently, we're not planning any improvements to video for 1.0.  Instead, we watching closely to see what Adobe does to improve the built-in video in upcoming versions of Flash.

### Chat ###
There are no major enhancements planned for chat for 1.0.

### Presentation ###
When a presenter uploads a portrait A4 document, the text is not readable on most screens as BigBlueButton displays the entire document at once (fit-to-page).

Support displaying presentations in both fit-to-page (good for landscape documents) and fit-to-width (good for portrait documents).  The addition of fit-to-width will make it possible for the presenter to use more width and scroll up and down in a portrait document ([579](http://code.google.com/p/bigbluebutton/issues/detail?id=579)).

Support full screen mode, similar to hitting F5 in power point.  Full screen mode should have optional notifications of new chat messages or join/leave events ([872](http://code.google.com/p/bigbluebutton/issues/detail?id=872)).

Support collaboration mode which enables viewers to "unlock" from the presenter's view and freely move around the current presentation.  ([604](http://code.google.com/p/bigbluebutton/issues/detail?id=604)).

### Whiteboard ###
Support keyboard input of text and symbols ([591](http://code.google.com/p/bigbluebutton/issues/detail?id=591)).

### Desktop sharing ###
Currently, BigBlueButton uses a Java applet to capture and display the presenter’s screen to remote clients.  However, the screen updates can be slow, especially if there are 32-bit graphics on the presenter's screen.  For detailed explanation, see [FAQ entry](http://code.google.com/p/bigbluebutton/wiki/FAQ#How_can_I_make_desktop_sharing_faster?).

We need to increase the efficiency of the screen sharing as measured by the speed at which the remote screen updates for the users.  Two possible approaches

  * Reduce the bit depth of the changed regions from 32-bit to 16-bit before compression and sending
  * Reorder the sending of change regions to always send the smallest first (giving the remote user a perception of faster screen updates).

See [902](http://code.google.com/p/bigbluebutton/issues/detail?id=902).


Reduce the effort by viewers to view the screen sharing by automatically centering the screen sharing window and make it show original size if there is sufficient on the viewer’s monitor ([903](http://code.google.com/p/bigbluebutton/issues/detail?id=903)).


### Areas for investigation ###
We are reviewing these requirements for inclusion in 1.0.

#### Layout management ####

BigBlueButton's window-based UI is very flexible, sometime too flexible as it requires the user to manage their windows.  For younger users, such as students in K12, too much flexibility can hinder the learning.

Investigate locking down the windows, providing better layout managememt, or moving from a windowed layout to a fixed layout ([904](http://code.google.com/p/bigbluebutton/issues/detail?id=904)).

#### Additional Modules ####
Include the following additional modules.

  * Polling module ([831](http://code.google.com/p/bigbluebutton/issues/detail?id=831))
  * Breakout module (see [issues related to breakout module](http://code.google.com/p/bigbluebutton/issues/list?can=2&q=breakout))
  * Shared notes module ([875](http://code.google.com/p/bigbluebutton/issues/detail?id=875))


## Developer Requirements ##
This section looks at ways to make it easier for other developers to participate in the BigBlueButton project.

### Development Environment ###
Analyze whether we can reduce the number of steps necessary to setup your own development environment.

It should be possible to setup a development environment on a non-BigBlueButton VM in under 30 minutes.

### Documentation ###
Ensure all classes in BigBlueButton, both on the server (Java) and client (ActionScript) -- have sufficient javadoc documentation for a developer to understand their role relative to others.

Ensure all classes that implement the APIs are throughly documented.  The development environment (i.e ant scripts) should automatically compile the Java docs.

### API Examples ###
All the APIs in BigBlueButton should have API examples that demonstrate applications of using the API.

Add additional API examples:

  * Embedding BigBlueButton in an iFrame
  * Using oAuth to log into a meeting
  * Using sibbolith to log into a meeting


## Stability and Testing ##

### No Open Stability Issues ###
All [stability issues](http://code.google.com/p/bigbluebutton/issues/list?can=2&q=label:Stability&colspec=ID+Type+Status+Priority+Milestone+Owner+Component+Summary&x=priority&y=component&mode=grid&cells=tiles) are closed.

### Unit Testing ###
All the core client modules (voice, video, chat, presentation, and desktop sharing) have unit tests to verify their functionality.

All the core server modules have unit tests to verify their functionality.

The development environment should enable developers to run the unit tests to verify conformance.

### Integration Testing ###
The API should have a complete test suite to verify stability and conformance to documentation.  The test suite should help us find this API bug: [672](http://code.google.com/p/bigbluebutton/issues/detail?id=672).


### Stress Testing ###
Verify that the a BigBlueButton server can run with large number of users load for 48 hours without any errors on the client or the server.

The term "large number of users" will need to be calibrated according to the server capacity (memory and CPU).  The stress test should repeatedly start, stop, and generate user activity  in multiple simultaneous classrooms.   The traffic should cover using all of the core elements of voice, video, chat, presentations, and desktop sharing.

The term "without any errors" means the there were no freezes on the client, nor are there any exceptions in the server logs, nor were there any memory leaks throughout the tests.

## API ##
This section covers the extensions needed to the BigBlueButton 1.0 API.

### Pre-upload slides to a presentation ###
This feature is currently in development for BigBlueButton 0.8   ([356](http://code.google.com/p/bigbluebutton/issues/detail?id=356)).

### Access to recorded sessions ###
The addition of record and plabyack to BigBlueButton 0.8 means the server will now store recorded sessions.

Extend the API to enable 3rd party applications to query for all recorded meetings (_getRecordedMeetings_).  This query can pass an option meetingID to filter the meetings that match that ID.  For example, a meetingID of “math101-%” would match the meetings with ID math101-001`, `math101-002`, and `math101-003`.

Enable the API to get detailed information on a specific meetingID
_getRecordedMeetingInfo( meetingID )_.

Enable the API to delete a recorded meeting _deleteRecordedMeeting( meetingID )_.

Create an test suite to validate the APIs are all implemented correctly.

### Inject messages into the chat ###
Enable API calls for sending messages into the chat window (see [905](http://code.google.com/p/bigbluebutton/issues/detail?id=905)).

This would enable tighter integration, such as enabling a 3rd party application to notify users that the meeting is about it end.  Clicking on a link could extend the meeting another 1 hour (and bill for it).

### Modularity ###
When looking at BigBlueButton 1.0, we want the developer to see a platform, not a closed application.

There are a spectrum of modularity we can achieve.

For existing components:
  1. Configure the components within the server (implemented in XXX)
  1. Dynamically enable/disable components at time of creating a meeting
  1. Dynamically enable/disable components after the meeting has started

By creating modularity, a developer could start a BigBlueButton session specific with only the modules needed for her specific application.  For example

  1. Chat only
  1. Two-way web-cam
  1. Desktop sharing session
  1. Click to call

See [294](http://code.google.com/p/bigbluebutton/issues/detail?id=294).

The next step is to create a full plug-in architecture with well-defined APIs (see post 1.0).


## Administrator Requirements ##

### Security ###
There are no plans to add security for 1.0.  Secure connections to a BigBlueButton can be achieved via VPN.

### Installation and Upgrade of BigBlueButton ###
Continue to support Ubuntu 10.04 32-bit or 64-bit.  Add support for CentOS only if there is sufficient demand (and support) from commerical companies.

### Troubleshooting tools ###
Add more capabilities to bbb-conf to change the logging levels of all applications, making it easier to spot errors ([906](http://code.google.com/p/bigbluebutton/issues/detail?id=906)).

Add more checks to bbb-conf to continue to trouble shoot any problems with the installation.  Once the error messages have been removed, any error message would be a real error.

### IMS Basic LTI integration ###
Enable products such as Desire2Learn to launch BigBlueButton meetings without having to create a custom module (http://code.google.com/p/bigbluebutton/issues/detail?id=907).



# Beyond 1.0 #

There are a number of capabilities that we want to add (soon) after 1.0 is released.

  * **Plug-in Architecture** - Currently, BigBlueButton is self-contained product.  Everything comes pre-assembled, ready to go.  That is great for initial adoption, but we want BigBlueButton to become modular platform (like eclipse) to enable other developers to easily create an integrate their own modules.

  * **Full mobile support** - This includes a Android, Rim, iPhone client.

  * **HTML 5 client** - While the absence of an ability to access the microphone and web cam would prevent an HTML 5 client from becoming a first-class client, an HTML 5 client could receive a stream of the current video and audio, and it could participate in other areas, such as real-time chat.

  * **Integration with H.263** - This would enable BigBlueButton to integrate with other commercial conferencing systems.

  * **Support for Jabber** - This would enable us to integrate with other popular IM systems.

  * **Support right-left languages** - See [686](http://code.google.com/p/bigbluebutton/issues/detail?id=686).

