

# How to setup your own BigBlueButton Server in a few minutes #

Many universities and colleges have told us they want to run their own version  BigBlueButton behind their firewall.  In addition, developers have asked how to setup a development environment to enhance and extend BigBlueButton.

In response to these requests, we've created a Ubuntu-based virtual machine (VM) that makes it easy for anyone to download and run a BigBlueButton server.  The VM runs under VMWare Player, which is available on Unix, Windows, or Mac.  We've also pre-configured the VM so it can serve as a full [development environment](DevelopingBBB.md).  We've added scripts (using `bbb-conf`) to make it easy for a developer to checkout BigBlueButton's source from Google Code repository, make local changes, and, with a few commands, re-compile various components of BigBlueButton for development and testing.

Prerequisites:
  1. VMWare Player (or VMWare Workstation) for Windows or Unix, or VM Fusion for Mac
  1. Alternatively you can use VirtualBox.
  1. A DHCP Server for the VM to acquire an IP address on boot

The second point is key: the VM must be able to connect to the internet to update from packages.  If it does not acquire an IP address, it won't be able to finish the setup of BigBlueButton.

<a href='http://www.youtube.com/watch?feature=player_embedded&v=--yC6LpeFqA' target='_blank'><img src='http://img.youtube.com/vi/--yC6LpeFqA/0.jpg' width='853' height=505 /></a>

## Installing BigBlueButton VM ##

  1. Download and uncompress the [BigBlueButton 0.70 VM](http://bigbluebutton.org/downloads/bigbluebutton-vm-actual_date_here.zip).  MD5SUM for this file is below.

```
8d594c6f30b7af0786d259ca70392dc2  bigbluebutton-vm-2010-04-02.zip
```

> 2.  Open the enclosed **ubuntu-vmw6** folder.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm_icons.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm_icons.png)

> 3.  Double-click on the bigbluebutton-vm.vmx icon.

This will start VMWare Player (or VMWare Workstation) and boot the VM. Note: In VMWare, make sure the networking is set to **Bridged**, not NAT.

The BigBlueButton VM takes about 10 minutes to first initialize.  Sit back, relax, go watch some youtube videos.  During this time, the BigBlueButton VM goes through its initial startup script that

  * Sets up the networking (acquire an IP address from a DHCP server)
  * Installs the  BigBlueButton packages
  * Configures  BigBlueButton to use the VM's current IP address
  * Installs OpenSSH

When it's done, you'll see a welcome message that asks you to login and change the password.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm_boot.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm_boot.png)

The VM is setup to have a default account called **firstuser** with password **default**.  To secure your server, take a moment to login and change this password.

To change the password, login as firstuser and provide the default password.  You'll immediately be asked to enter the password again, then to provide a new password.  Again, do this now as it will secure your server.

After resetting the default password, you'll get the following welcome message (this appears each time you login as firstuser).

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-welcome.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-welcome.png)

Note: Due to an upgrade to OpenOffice 3.2, you'll need to restart the VM after this first boot sequence to have OpenOffice properly running for document conversation.  The next time the VM starts everything will be working properly.

## Installing the BigBlueButton VM using VirtualBox ##

See [Running BigBlueButton VM in Virtual Box](BigBlueButtonVMVirtualBox.md).

## Running the BigBlueButton VM ##

At this point, you've got a full BigBlueButton server up and running.  Open a web browser to the URL provided using the IP address of the VM.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-join.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-join.png)

Enter whatever name you like and then click Join.  You'll join the default meeting.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-bbb-running.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-bbb-running.png)

## Developing BigBlueButton ##

We've included all the development tools in this VM to compile and deploy the source for bigbluebutton-client, bigbluebutton-web, and bigbluebutton-apps. See [developing BigBlueButton](http://code.google.com/p/bigbluebutton/wiki/DevelopingBBB) for more information.


## How to install desktop sharing ##
Desktop sharing is now a separate component.  Don't worry, you can install it with a single apt-get command. Please see [how to install desktop sharing](http://code.google.com/p/bigbluebutton/wiki/InstallingDesktopSharing) and why doing so changes the licensing of BigBlueButton.


# Upgrading the BigBlueButton VM #



## How to upgrade to the next release ##

This is where packages make life easy.

The BigBlueButton components are installed as Ubuntu packages.  The VM already has apt configure to check the repository http://archive.bigbluebutton.org for updates.  This means, when we ship BigBlueButton 0.70 (for example), you'll be able to upgrade your server with two commands.

```
  # sudo apt-get update
  # sudo apt-get dist-upgrade
```

When you run these commands, you'll see BigBlueButton download a packages for the new release.  You may be prompted to update an existing configuration file.

**Note**: Best to always check the [release notes](http://code.google.com/p/bigbluebutton/wiki/ReleaseNotes) for specific instructions to upgrade to a new release.

When updating, you'll see the upgrade messages.

![http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-apt-get-upgrade.png](http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/vm/vm-apt-get-upgrade.png)

## Updating the BigBlueButton VM to packages on trunk (aka Living on the Edge) ##

We upgrade the repository http://archive.bigbluebutton.org with every release.  In addition, during each iteration of BigBlueButton, we have our [continuous integration server Hudson](http://bigbluebutton.org/hudson) automatically updating packages off of the SVN tree in Google Code.

These packages are used to update our [devbuild server](http://devbuild.bigbluebutton.org), so you can always try out the latest version.  Keep in mind that trunk isn't always going to be stable, so devbuild will be as stable as trunk.

However, if you want to live on the edge and use the latest packages built by our from the trunk of the BigBlueButton Google Code repository, then edit `/etc/apt/sources.list.d/bigbluebutton.list` and change

```
#
# Repository for BigBlueButton
#
deb http://archive.bigbluebutton.org/ bigbluebutton main
```

to
```
#
# Repository for BigBlueButton
#
deb http://archive.bigbluebutton.org/dev bigbluebutton main
```

Do an `apt-get update/apt-get dist-upgrade` and you'll be running the latest builds, which are not guaranteed to be stable, but you can see what's happing in the current itteration.




# Troubleshooting #

## The console gives an error when booting ##

When the VM first boots, it acquires an IP address and runs a setup script to finish the installation of BigBlueButton.   The script:
  1. updating the packages
  1. installs BigBlueButton

The update step ensures that any updates to packages issued after the release of the BigBlueButton VM will be automatically downloaded before installation proceeded.

The most common error that prevents update and installation is occurs when the BigBlueButton VM failed to acquire an IP address.  When this occurs, you'll see errors in the console when booting.

You can manually finish the installation process, but you first need to ensure the VM has (1) acquired an IP address and (2) the IP address is accessible by the host computer.

First, check in VMWare Player that has networking set to **bridged**.  Next, type

```
    ping google.com
```

You should get some ping results

```
   PING google.com (72.14.204.99) 56(84) bytes of data.
   64 bytes from iad04s01-in-f99.1e100.net (72.14.204.99): icmp_seq=1 ttl=54 time=4.54 ms
   64 bytes from iad04s01-in-f99.1e100.net (72.14.204.99): icmp_seq=2 ttl=54 time=4.42 ms
```

If not, it means that the VM is unable to acquire an IP address from a DHCP server on the network.  If there is a DHCP serer, you can try

```
    sudo /etc/init.d/networking restart
```

Try the ping command again.  If you are unable to acquire an IP address, check out this resource [Ubuntu Networking](https://help.ubuntu.com/10.04/internet/C/index.html).

Next, you can manually finish the setup to BigBlueButton with the following commands:

```
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install bigbluebutton
```

There should be no errors when you type the above three commands.

Next, you'll need to ensure that BigBlueButton is listening to the IP address of your VM.  To check your current environment for possible problems that might prevent BigBlueButton from running, type the following command:

```

   bbb-conf -c

```

You should see output such as

```
root@bbb-vm-20100102:/etc/asterisk# bbb-conf -c
Current Configuration:

/var/www/bigbluebutton/client/conf/config.xml (bbb-client)
                 IP for tunnel check: 192.168.0.163
                  IP for rtmp (red5): 192.168.0.163
          host for bbb-web interface: 192.168.0.163

/etc/nginx/sites-available/bigbluebutton (configuration file nginx)
                         server_name: 192.168.0.163
                                port: 80
                client document root: /var/www/bigbluebutton

/var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties (bbb-web)
                                host: 192.168.0.163

/var/lib/tomcat6/webapps/bigbluebutton/demo/bbb_api_conf.jsp (API demos)
                                host: 192.168.0.163

/etc/asterisk/bbb_extensions.conf (asterisk)
                   conference module: konference

```

If there are any problems (i.e. if bbb-conf detects that red5 isn't running), you'll see a warning message at the bottom.

The output from above showed that BigBlueButton's configuration files were listening to IP address 192.168.0.163.  When you type the command, if the IP address shown for your output differs from the IP address of your VM, you can change the IP address that BigBlueButton is using `bbb-conf`.

For example, if the output from `ifconfig` shows your VM is listening to IP address 192.168.0.125, then issue the following command

```

  sudo bbb-conf --setip 192.168.0.125

```


If you need to restart BigBlueButton, do the command

```

   bbb-conf --clean

```

and this will do a clean restart.


## I'm still having problems ##

If you've tried both the above commands and your BigBlueButton server is not working, please post to our [forums](http://groups.google.com/group/bigbluebutton-setup/topics?gvc=2).