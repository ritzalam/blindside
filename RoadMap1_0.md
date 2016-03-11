# Introduction #

BigBlueButton has been in development for over four years now.  We've delivered nine releases since BigBlueButton 0.4 was release on June 12, 2009.  We're currently working on BigBlueButton 0.8.

We've come a long way since the first release.  We're often asked now "When are you going to release 1.0?"

The document outlines the DRAFT list of requirements we believe are necessary to complete for for the release of BigBlueButton 1.0.   For many, the version number is arbitrary.  With each release of BigBlueButton the project delievers a more solid, more stable, system and many universities and companies have deployed BigBlueButton to their students and incorporated it into their product.  This grow really encourages us to make a 1.0 as stellar as possible.

For many, the version number is not arbitrary.  It represents a level of completes, a real product that has completely implement features, documentation, specifications, and test cases.

There are a number of important requirements for 1.0, and we'll group them as follows: usability, stability, API, and modularity.


  * **Usability** - The hallmark of BigBlueButton is its ease of use.  Nothing drives the initial positive impression of BigBlueButton more than a presenter or user able to quickly use the interface without needing a training course.

  * **Stability** - Once past the initial positive experience, the stability of the product ensures long-term acceptance.   While BigBlueButton is fairly stable (our demo server runs for many days without reboot), there are a number of areas for improvement discussed below.

  * **APIs** - We started with very simple APIs, and we need to expand those APIs to enable pre-uploading of slides, management recorded content, and server and client control of individual components.

  * **Modular Architecture** - BigBlueButton started as a self-contained product.  Everything comes pre-assembled, ready to go.  That was great for adoption, but BigBlueButton needs to eveolve to a modular platform (like eclipse) to enable other developers add/remove their own components.  Getting this right will not be easy, and will likely take a few iterations.

All of the above areas have specific requirements for 1.0 which will be outlined below.  In many cases, where there is an associated issue, we'll give a brief outline of the requirement and link to the specific issue for more details.

Our vision is to make BigBlueButton the leading open source web conferencing system -- weather you use it for education, commercial, personal use.  This document outlines our plans to reach that goal.  When BigBlueButton 1.0 is released, it will be in substance, not in name.

## Usability ##

### Pre-flight checklist ###

When a user has an improperly configured microphone or webcam, Flash has difficulty picking the right audio or video source.  In other cases, there might be a software conflict that is preventing Flash from accessing either device.  This causes the presenter to have to debug a user's problem at the stat of a meeting.

Add a pre-flight checklist (issue [122](http://code.google.com/p/bigbluebutton/issues/detail?id=122)).

### Unify the Users and Listeners ###
When there are 25 users (or more), some usability issues with the current two window layout emerge.  For example, when a student raises her hand, in the users window, it takes too much effort to find the associated user in the listeners window to unmute (issue xxx).

### Accessibility ###
BigBlueButton must support [Section 508](http://www.section508.gov/) requirements for access by users with disability (see [85](http://code.google.com/p/bigbluebutton/issues/detail?id=85)).

### Localization ###
Support right-left languages (see [686](http://code.google.com/p/bigbluebutton/issues/detail?id=686)).

### Component requirements ###
The following section looks at the requirements for each individual component.

> #### Voice ####
> Currently, the built-in VoIP (clicking the headset icon) in BigBlueButton has a 2-4 second delay.  This is perceptable when running in a LAN environment.

> For 1.0, BigBlueButton must have **no** perceptial voice delay for 50 users running within a LAN environment (see [740](http://code.google.com/p/bigbluebutton/issues/detail?id=740)).

> A description of the resons for the current delay are given in this [FAQ](http://code.google.com/p/bigbluebutton/wiki/FAQ#Why_is_there_a_delay_in_the_audio_when_I_use_VoIP?).

> There is work underway to explore the best solutions. The current Flash client does not allow UDP connections, and the current handling of VoIP packets are transcoded through red5 (see [post](http://groups.google.com/group/bigbluebutton-dev/browse_thread/thread/212cab1b0c8bdee4#)).

> #### Video ####
> Since we are using the built-in video from Flash, we're not planning on bypassing the built-in video with a custom solution.  Instead, we watching closely to see what Adobe does to improve the bult-in Flash video in version 11.

> #### Chat ####
> XXX

> #### Presentation ####
> When a presenter uploads a portrait A4 document, the text is not readable.

> Support dispalying presentations in both fit-to-page (current mode) and fit-to-width.  The addition of fit-to-width will make it possible to use the full width of the presentation window for portait documents. (see [579](http://code.google.com/p/bigbluebutton/issues/detail?id=579))

> Support full screen mode, similar to hitting F5 in power point.  (see [872](http://code.google.com/p/bigbluebutton/issues/detail?id=872))

> Support collaboration mode which enables viewers to "unlock" from the presenter's view and freely move around the current presentation.  (see [604](http://code.google.com/p/bigbluebutton/issues/detail?id=604)).

> #### Whiteboard ####
> Support keyboard input of text. (see [591](http://code.google.com/p/bigbluebutton/issues/detail?id=591))

> #### Desktop sharing ####
> When the presenter shares their desktop, many times the upates for viewers are too slow, especially if there are 32-bit graphics on the presenter's screen.

> Modify algorithm so it sends the smallest (size) changed regions first, this will increase the perceived update speed.  Center the chat window and make show it as original size if there is sufficent room to display it within the user's monitor (see xxx).

## Areas for investigation ##
These are areas for considering for 1.0.

### Layout management ###
The window approach for BigBlueButton's UI is very flexible, sometime too flexible as it requires the user to manage their windows.  For younger users, such as K12, locking down the windows, providing better layout managememt, or moving from a windowed layout to a fixed layout are all options.

### Additional Modules ###
Add the following additional modules to BigBlueButton.

#### Polling module ####
See xxx.

#### Breakout module ####
See issues tagged [breakout](http://code.google.com/p/bigbluebutton/issues/list?can=2&q=breakout).

#### Shared notes module ####
See [875](http://code.google.com/p/bigbluebutton/issues/detail?id=875).


## For the Developer ##
As an open source project, we continually strive to make it easier for others to extend and build on BigBlueButton.  The following are the 1.0 requirements for the developers.

### Development Environment ###
XXX

### Documentation ###
When looking through the source for the Java (server) and Action Script (client) all classes in BigBlueButton should have sufficent document to understand their role relative to others.

The classes that implement the APIs should be throughly documented.

The build process for BigBlueButton should automatically create Java docs for server-based applications.

Provide documentation on how to configure external dial-in numbers.

### Testing ###
All major components of BigBlueButton should have the framework for unit tests.  The development environment should enable developers to run the unit tests.

The API should have a complete test suite that can be used for both unit testing and stress testing

### API Examples ###
All the APIs in BigBlueButton should have API examples that demonstrate applications of using the API.

Add additional API examples:
  1. Embedding BigBlueButton in an iFrame.
  1. Using oAuth to log into a meeting
  1. Using sibbolith integration

## API ##
The API

Add/remove a module at configuration

> Add/remove modules at run-time
> For those modules that are marked as avaialble, allow the presenter to add/remove the modules.

### Pre-upload slides to a presentation ###
See [356](http://code.google.com/p/bigbluebutton/issues/detail?id=356).


### Manage the recorded meetings ###
As of BigBlueButton 0.8, the server will now store recorded sessions.

Provide a recording API to query meetings for a given meetingID.  The meetingID can be a prefix string, so meetings with the id `math101-001`, `math101-002`, and `math101-003`, can be returned with the query `math101`. (see XXX).

Provide a recording API to publish/unpublish meetings and delete a meeting.


### Inject messages into the chat ###

Eanble API calls for sending messages into the chat window.  This would enable tigher integration, such as enabling a 3rd party application to notify users that the meeting is about it end.  Clicking on a link could extend the meeting another 1 hour (and bill for it).  (see XXX)

### Modularity ###
When looking at BigBlueButton, we want the developer to see a platform, not a closed application.  The platform should provide well-defined modular architecture for adding/removing existing components, installing third-party components, and creating their own componte.

Eclipse is a very good example of achieving a modular architecture.  There is the Eclipse platform which ships with a number of core modules.

In the BigBlueButto ecosystem, there would be three types of modules:

  1. core - enabled by default
  1. stelth - modules are not of sufficent quality to become core, but are included in BigBlueButton to enable broader testing or make it easier for the administrator to add them to the setup
  1. contrib modules are available for download and install from other sites.

To support the above, BigBlueButton must provide the following capabilities (listed below).

#### Architecture ####
The BigBlueButton architecture must provide the internal APIs to provide developers the means to interact with other components of the platform, both within the server and client.

Specifically

# BigBlueButton server (bbb-apps) must provide well-defined API for a module to interact and be added/removed

# BigBlueButton client (bbb-client) must provide well-defined ways for a module to interact and be added/removed


#### Structure of a module ####
A module must have a well-defined directory structure that includes both its server and client components, along with an manifest.xml file that describes the components and dependencies.

#### Server Configuration ####
There be command-line tools that enable the administrator to list, install, remove modules, and enable/disable modules.

An installed but disabled module is a stelth module.

#### Module API ####
The developer would have an API to dynamically enable/disable modules when creating a session.  The API would enable passing of configuration parameters to the enabled modules.

A good example of this API would be to start BigBlueButton with only a single or few modules enabled, such as

  1. Chat only
  1. Two-way web-cam
  1. Desktop sharing session
  1. Click to call

The last example would be enabling developers to use BigBlueButton to enable a click-to-call type applications.

#### Moderator Control of modules ####
Some modules me be active, but only visible to the moderator.  A polling module is a good example: it should be avaialble to the moderator or presenter, but no to the viewers.

The BigBlueButton UI should eanble the presenter to launch an avaialble module during a session.

## Areas for investigation ##
The following modules could be added to BigBlueButton as core or stelth.

  1. Breakout module
  1. Polling module
  1. Shared notes module

## For the Administrator ##

### Security ###
There are no plans to add security for 1.0.  Secure connections to a BigBlueButton can be achieved via VPN.

### Troubleshooting ###
Add capbility to bbb-conf to change the logging levels of all applications, making it easier to spot errors.

### Configuration ###
Add more checks to bbb-conf to continue to trouble shoot any problems with the installation.  Once the error messages have been removed, any error message would be a real error.

### Installation and upgrade ###
Continue to support Ubuntu 10.04 32-bit or 64-bit.  Add support for CentOS only if there is sufficent demand (and support) from commerical companies.

### IMS Basic LTI integration ###
Enable products such as Desire2Learn to launch BigBlueButton meetings without having to create a custom module.



## Beyond 1.0 ##
Probably what's also important is to cover some of the items that we are not planning for 1.0.  In some ways, there area all ares under development, but if we tried to do too much for 1.0.

  1. Full HTML5 client
  1. Full Android, Rim, iPhone client
  1. Integrate with H.232 video conferencing systems
  1. Integrate with Jabber for instant messaging