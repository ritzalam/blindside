# Overview #
BigBlueButton is developed by a dedicated core team of developers and a broad community that work together on all aspects of development: design, development, testing, documentation, localization, editing wikis, and, most importantly, supporting others in the use of BigBlueButton.

This document describes how you can setup a development environment on a BigblueButton server to make changes to your own setup and contribute improvements back to the community.

BigBlueButton has a lot of components: bbb-web, bbb-client, bbb-apps, desktop sharing, and so on.  You don't need to understand everything to contribute to the project.  For example, if you are interested in improving the client, you need only setup the development for bigbluebutton-client.  At a minimum, you need to understand the overall architecture (see ArchitectureOverview).

BigBlueButton comes with a configuration script `bbb-conf`, which can do most of the steps to setup a working development environment (as described below).  While it's good to let the script do most the work, as you become more familiar with BigBlueButton, you should take a look at the source code in `bbb-conf`

```
/usr/local/bin/bbb-conf
```

to understand what it is doing.  The more you know about BigBlueButton, the easier it is to make your own changes and contribute to the project.

In BigBlueButton 0.8-beta-4 (and later), we've generalized these instructions so you can use any unix account on a BigBlueButton server.



The source for BigBlueButton is on [GitHub](https://github.com/bigbluebutton/bigbluebutton).  If you're not familiar with git, a good place to start is [free book](http://progit.org/book/) and http://help.github.com/ GitHub Help pages].  If you don't know what the terms **_clone_**, **_branch_**, and **_commit_** mean in git, make sure you do before working with the BigBlueButton source.


## Prerequisites ##

This guide is written for BigBlueButton 0.8-beta-4 or later.  If you are using an earlier version of BigBlueButton, you'll need to update you server (see 08InstallationUbuntu).

### The Basics ###
Before setting up a development environment, you should have already

  * An understanding of the BigBlueButton ArchitectureOverview
  * An understand of how git works

### A Working BigBlueButton Server ###

You need to have a working BigBlueButton server 0.8-beta-4 (or later) to setup a development environment.

While it may seem obvious, we emphasize your BigBlueButton server should be working **before** you start setting up the development environment.  That way, if you do run a modified version of the BigBlueButton client and something isn't working, you can switch back to the built-in client to check that your environment is working correctly.


### Developing on Windows ###
If you are on Windows, we recommend you download the 08BigBlueButtonVM and use it for compiling and testing your changes.  That's how we (the core developers) develop BigBlueButton.

### You'll need sudo abilities ###
> setup the BigBlueButton development environment, yo To verify, you should be able to

```
  sudo ls
```

and get back a list of files in the current directory.


# Setup a Development Environment #

## Setting up the development tools ##

On a BigBlueButton server, you can install all the necessary development tools with the following command:

```
   bbb-conf --setup-dev tools
```

When you run this script asked to enter your password to sudo into root.  This script will:

  1. Download and setup groovy, grails, and gradle
  1. Download and install FlexBuilder
  1. Install OpenJDK
  1. Install git
  1. Add the necessary environment variables in your ~/.profile


After the initial setup is complete, you'll need to reload your `.profile` to use the new environment variables for groovy, grails, and gradle.  To do this, run

```
source ~/.profile
```

You need only do this once.  When you next login to your account, you'll have the environment variables in place.

Again, you can use any account on a BigBlueButton server that has sudo rights.  For the rest of this document we'll use the account `firstuser` for the examples.

The `bbb-conf` script create for you a `dev` directory in your account.

```
/home/firstuser/dev
```

It's in this directory that you'll place the source for BigBlueButton.

## Hard Core Forking ##

We recommend you use GitHub to fork BigBlueButton.  This will make it easy for to work on your own copy of BigBlueButton's source, store updates to GitHub, and [contribute](Contributing_to_BigBlueButton.md) back to the project by sending us pull requests.

To checkout the source:

  1. Setup an account on [GitHub](https://github.com/plans) if you don't already have one (it's free!)
  1. Setup your [ssh keys](http://help.github.com/linux-set-up-git/). Skip to the "Set Up SSH Keys" section.
  1. [Fork](http://help.github.com/fork-a-repo/) the BigBlueButton repository into your GitHub account
  1. Clone your repository into your `~/dev` folder


After cloning, you'll have the following directory
```
/home/firstuser/dev/bigbluebutton
```

Confirm that you are working on the master branch.

```
cd ~/dev/bigbluebutton
git status
```

You should see

```
# On branch master
nothing to commit (working directory clean)
```


A few suggestions when using git.  It is good practice to develop on a branch and merge the changes to master when you are done.
Let's say you are trying to fix [Issue 100](https://code.google.com/p/blindside/issues/detail?id=100).

```
git checkout -b fixing-issue-100
```

You should see

```
Switched to a new branch 'fixing-issue-100'
```

Do

```
git status
```

The output should be

```
# On branch fixing-issue-100
nothing to commit (working directory clean)
```

## Client Development ##
With the development environment checked out and the code cloned, we're ready to start developing!

This section will walk you through making a change to the BigBlueButton client.

### Setting up the environment ###
To setup the client for development for the client, do the following

```
bbb-conf --setup-dev client
```

This command modifies the nginx settings for BigBlueButton so that HTTP request for loading the BigBlueButton client are now serviced by

```
~/dev/bigbluebutton/bigbluebutton-client
```

instead of

```
/var/www/bigbluebutton
```

### Build the client ###
Let's now build the client  Note we're not making any changes yet -- we're going to build the client to ensure it works.


```
cd ~/dev/bigbluebutton/bigbluebutton-client
```


First, we'll build the locales (language translation files).  If your not modifying the locales, you need only do this once.


```
cd ~/dev/bigbluebutton/bigbluebutton-client
ant locales
```

This will take about 10 minutes (depending on the speed of your system).

Next, let's build the client
```
ant
```

After that, point your browser to your BigBlueButton server and login ot the demo page.  The client should start properly.

### Making a change ###

> Before we build the BigBlueButton client, let's make a small visible change to the interface.

```
  vi ~/dev/bigbluebutton/bigbluebutton-client/src/org/bigbluebutton/main/views/MainApplicationShell.mxml
```

You can use any editor you want, but real Unix developers all use `vi`.  At line 311, you'll see the line

```
<mx:Label text="{ResourceUtil.getInstance().getString('bbb.mainshell.copyrightLabel2',[appVersion])}" id="copyrightLabel2"/>
```

Insert the text ' -- BigBlueButton Rocks!!' as shown below.

```
 <mx:Label text="{ResourceUtil.getInstance().getString('bbb.mainshell.copyrightLabel2',[appVersion]) + ' -- BigBlueButton Rocks!'}" id="copyrightLabel2"/>
```


Now, rebuild the BigBlueButton client again.

```
cd ~/dev/bigbluebutton/bigbluebutton-client
ant
```

When done, join the demo meeting using the client. You should be able to see your changes.


To switch to using the built-in version of BigBlueButton, do

```
  sudo ln -s -f /etc/bigbluebutton/nginx/client /etc/bigbluebutton/nginx/client.nginx
  sudo /etc/init.d/nginx restart
```

To switch back to your development setup, do

```
  sudo ln -s -f /etc/bigbluebutton/nginx/client_dev /etc/bigbluebutton/nginx/client.nginx
  sudo /etc/init.d/nginx restart
```


### Developing BBB-Web ###
```
bbb-conf --setup-dev web
```

Now let's start grails webapp.
```
cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-web/
```

Tell grails to listen on port 8888
```
grails -Dserver.port=8888 run-app
```

If you get an error ` "Could not resolve placeholder 'apiVersion'"`., just run `grails -Dserver.port=8888 run-app` again. The error is grails not picking up the "bigbluebutton.properties" the first time.

Now test again if you can join the demo meeting.

## Developing the Red5 Applications ##

Make red5/webapps writeable. Otherwise, you will get permission error when you try to deploy into Red5.

```
  sudo chmod -R o+w /usr/share/red5/webapps
```



### Developing BBB-Apps ###
Run the setup script. This will remove the bbb-apps package from red5/webapps.

```
bbb-cong --setup-dev apps
```

Stop red5
```
    sudo /etc/init.d/red5 stop
```

Compile and deploy bbb-apps
```
cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-apps
gradle resolveDeps
gradle clean war deploy

```

Start Red5
```
cd /usr/share/red5/
sudo -u red5 ./red5.sh
```

### Developing BBB-Voice ###
```
# Stop red5
    sudo /etc/init.d/red5 stop

cd /home/firstuser/dev/bigbluebutton/bbb-voice
gradle resolveDeps

# Compile and deploy bbb-voice
gradle war deploy

# On another terminal window, start Red5
cd /usr/share/red5/
sudo -u red5 ./red5.sh

```

### Developing Deskshare ###
```
cd /home/firstuser/dev/bigbluebutton/deskshare
gradle resolveDeps
```

**Building the applet.**
```
cd applet
gradle jar
```

Now we need to create a key to sign the applet. Enter a password when prompted for one. Make sure it is at least 6 chars long.
```
ant create-signing-key
```

Sign the jar file. Enter the password you created from the previous step when prompted.
```
ant sign-jar
```

The signed jar file is located in `/home/firstuser/dev/bigbluebutton/deskshare/applet/build/libs/bbb-deskshare-applet-0.71.jar`

We need to copy it to where nginx is loading the client.

If you are developing also the bbb-client, then
```
cp /home/firstuser/dev/bigbluebutton/deskshare/applet/build/libs/bbb-deskshare-applet-0.71.jar /home/firstuser/dev/bigbluebutton/bigbluebutton-client/client
```

If you are not developing the client, therefore, nginx will serve the client from the default location. Therefore,
```
cp /home/firstuser/dev/bigbluebutton/deskshare/applet/build/libs/bbb-deskshare-applet-0.71.jar /var/www/bigbluebutton/client/
```

**Building the server side component.**
```

cd /home/firstuser/dev/bigbluebutton/deskshare/app
# Compile
gradle war
# Copy over to Red5
gradle deploy

# Stop red5
    sudo /etc/init.d/red5 stop

cd /home/firstuser/dev/bigbluebutton/bigbluebutton-apps
# Compile and deploy bbb-apps
gradle war deploy

# On another terminal window, start Red5
cd /usr/share/red5/
sudo -u red5 ./red5.sh
```

## Troubleshooting ##

If you get the "Welcome to Nginx" page. Check if bigbluebutton is enabled in nginx. You should see **bigbluebutton** in `/etc/nginx/sites-enabled`.

If not, enable it.

```
sudo ln -s /etc/nginx/sites-available/bigbluebutton /etc/nginx/sites-enabled/bigbluebutton

sudo /etc/init.d/nginx restart
```

If you get a "Old Translation" warning when starting the client, in `/var/www/bigbluebutton/client/conf/config.xml` change

```
<localeversion suppressWarning="false">0.71</localeversion>
```

to

```
<localeversion suppressWarning="false">0.8-beta2</localeversion>
```