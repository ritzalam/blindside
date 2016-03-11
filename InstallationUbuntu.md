

# Installing BigBlueButton using Ubuntu Packages #

**NOTE:** As of BigBlueButton 0.70, we support installation from packages on **Ubuntu 10.04 32-bit** and **Ubuntu 10.04 64-bit**.  If you are attempting to install on a variation of Ubuntu, these packages might work, but we recommend that you

  1. Search through [bigbluebutton-dev](http://groups.google.com/group/bigbluebutton-dev/topics?gvc=2) for your variation of Ubuntu.
  1. Post any new questions to [bigbluebutton-setup](http://groups.google.com/group/bigbluebutton-setup/topics?gvc=2).

## Prerequisites ##

You'll need root access to your desktop or server.

Also,  BigBlueButton uses nginx, which listens on port 80 for http access and tunneling, so if you have apache running, you'll need to configure apache to listen to a different port by editing `/etc/apache2/ports.conf` and changing the entry for 80 to another number, such as 8081.  Avoid using 8080 in apache as BigBlueButton uses tomcat6 which binds to that port.

## There are five commands to setup your own BigBlueButton Server ##

There are just five commands you need to setup BigBlueButton.  Cut and paste the following commands into a terminal window.
```
   wget http://archive.bigbluebutton.org/bigbluebutton.asc 
   sudo apt-key add bigbluebutton.asc 
   echo "deb http://archive.bigbluebutton.org/ bigbluebutton main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list
   sudo apt-get update 
   sudo apt-get install bigbluebutton 

```

The first four commands download the BigBlueButton repository key, add the key to apt-get's keyring, add the BigBlueButton repository URL to apt-get's list of sources, and then instruct apt-get to update the list of available packages.

The last command is where all the magic happens.  This one command will install **all** of BigBlueButton (except for desktop sharing, see below) along with all its dependencies.  Here's a screen shot of the packages it will install.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/install_ubuntu/add_packages.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/install_ubuntu/add_packages.png)

Enter 'Y'.  Then sit back.

After a few moments, if you don't have mysql installed, the mysql setup script will ask to specify a password for the mysql 'root' user.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/install_ubuntu/setup_mysql.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/install_ubuntu/setup_mysql.png)

Enter a password for mysql's 'root' user (you'll need to enter it twice).  Almost immediately, the setup script for bbb-web will then ask you for that mysql root password; bbb-web needs to access the mysql to create the database for BigBlueButton.  Give the the same password your did a moment ago.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/install_ubuntu/setup_bbb-web.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/install_ubuntu/setup_bbb-web.png)

## Trying out your server ( 8:42 minutes later) ##

After a few moments, everything will be installed --- including the voice conference server using Asterisk.  You've got a full BigBlueButton server up and running that you can use.  Open a web browser to the URL provided using the IP address of the VM.


![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-join.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-join.png)


You are now running the same server as you'll find on-line at http://demo.bigbluebutton.org/.  (We setup our demo server using these packages.).  To start using your BigBlueButton server, enter your and then click Join.  You'll join the default meeting.


![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-bbb-running.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-bbb-running.png)

# Troubleshooting #

## Wait!  It didn't work! ##
We've built in a BigBlueButton configuration utility, called `bbb-conf`, to help you configure your BigBlueButton server and trouble shoot your setup if something doesn't work right.

If you think something isn't working correctly, the first step is enter the following command.

```
   bbb-conf --check
```

The `--check` will check your setup to ensure the correct processes are running, the BigBlueButton components have correctly started, and look for common configuration problems that might prevent BigBlueButton from working properly.  For example, here's the output on our demo server

```
Current Configuration:

/var/www/bigbluebutton/client/conf/config.xml (bbb-client)
                 IP for tunnel check: demo.bigbluebutton.org
                  IP for rtmp (red5): demo.bigbluebutton.org
          host for bbb-web interface: demo.bigbluebutton.org

/etc/nginx/sites-available/bigbluebutton (configuration file nginx)
                         server_name: demo.bigbluebutton.org
                                port: 80
                client document root: /var/www/bigbluebutton

/var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties (bbb-web)
                                host: demo.bigbluebutton.org

/var/lib/tomcat6/webapps/bigbluebutton/demo/bbb_api_conf.jsp (API demos)
                                host: demo.bigbluebutton.org

/etc/asterisk/bbb_extensions.conf (asterisk)
                   conference module: konference
```

One common problem is that not all the processes are running.  You can do a clean restart of BigBluebutton with the command.

```
   bbb-conf --clean
```


If you are accessing the server via an IP address, then another common problem is the IP address in BigBlueButton's configuration files is different than the IP address of the host server.  To change all of BigBlueButton's configuration files to use a different IP address, enter

If you need to change your IP address for BigBlueButton, the following command will update all the configuration files and restart the needed processes.

```
   bbb-conf --setip <ip_address>
```


## Keeping your server up-to-date with a new release ##

Want to keep your BigBlueButton server up-to-date with the latest BigBlueButton release?  No problem, just enter

```
  sudo apt-get update
  sudo apt-get dist-upgrade
```

and apt-get will download and install the released BigBlueButton.  Don't you just love the power of Ubuntu/Debian packages.

## How to install desktop sharing ##
Desktop sharing is now a separate component.  Don't worry, you can install it with a single apt-get command. Please see [how to install desktop sharing](http://code.google.com/p/bigbluebutton/wiki/InstallingDesktopSharing) and why doing so changes the licensing of BigBlueButton.