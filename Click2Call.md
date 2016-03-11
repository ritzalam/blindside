# NOTE #
| **We have changed the name of the project to BigBlueButton and moved to http://code.google.com/p/bigbluebutton.** |
|:------------------------------------------------------------------------------------------------------------------|


# Add click-2-call to your webpage #

We demonstrate how you can add a click-2-call functionality on your webpages.

This is done by wrapping the open source [JIAXClient](http://www.hem.za.org/jiaxclient) with javascript and flex/actionscript. The jiaxclient applet is hidden by setting its width and height to zero. Javascript functions are implemented to access Java methods in the Applet.

To see see examples, go to the [demo page](http://present.sce.carleton.ca:8080/webphone/demo.html). Please make sure that you accept the certificate so the applet will run properly.

## Issues ##
  * Works only on one page at a time. If you have the applet running on one page and you open another page (on another tab/window or browser), it won't work.
  * When the using the flex client, it takes a little longer to start.
  * Need to install jiaxc library on users drive. If user does not have admin privilege on the PC, it won't work.