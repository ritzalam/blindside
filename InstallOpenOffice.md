# NOTE #
| **We have changed the name of the project to BigBlueButton and moved to http://code.google.com/p/bigbluebutton.** |
|:------------------------------------------------------------------------------------------------------------------|


## Installing OpenOffice ##
  1. Install OpenOffice at `c:\tools\ooo-2.2\`.
  1. Open the following file in your favourite text editor (e.g. vi or notepad):
> > `c:\tools\ooo-2.2\share\registry\data\org\openoffice\Office\Common.xcu`

You should see:
```
   <oor:component-data oor:name="Common" oor:package="org.openoffice.Office"
     xmlns:install="http://openoffice.org/2004/installation"
     xmlns:oor="http://openoffice.org/2001/registry"
     xmlns:xs="http://www.w3.org/2001/XMLSchema"
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
       ...
       <node oor:name="Help">
        <node oor:name="Registration">
            <prop oor:name="URL">
                <value>http://www.openoffice.org/welcome/registration20.html</value>
            </prop>
        </node>
       </node>
       ...
   </oor:component-data>

```

Remove the URL value to disable the registration process, e.g.:

```
        <node oor:name="Registration">
            <prop oor:name="URL">
                <value></value>
            </prop>
        </node>
```

**Links:**
http://wiki.alfresco.com/wiki/Running_OpenOffice_From_Terminal

## Running OpenOffice as headless ##
How to run OpenOffice in headless/invisible mode?
http://wiki.alfresco.com/wiki/Running_OpenOffice_From_Terminal

If having problems running in headless mode in Linux, perhaps the registration screen
is still popping up. Use VNC to dispaly screen and go through registration
process.

####  ####

SSH to your box normally
Enter this: vncserver -geometry 1280x1024 :1 &

which should open the display for the screen
resolution 1280x1024 (when you do this for the
first time – it’ll prompt you for the password)
Exit the putty.


I believe you saved the session to the box in putty.

  1. Then select category:  Connection / SSH / Tunnels
  1. At the “Source port” enter 5901
  1. At the “Destination”   e.g. where.you.openoffice.server.is:5901
  1. Click “Add” button and save your session.

ssh to the box with putty as usual.

Now open vnc viewer  and connect to localhost:5901.
Enter the password that you’ve entered when started the vncserver.

http://www.rhic.bnl.gov/RCF/UserInfo/Software/VNC/vnc.html

###  ###
To check if OpenOffice is listening for connection:

> > netstat -antp