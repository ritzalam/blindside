Not for beginners. This is a rough set of guidelines on how to set up the bbb dev environment on Unix system.

We recommend installing on Ubuntu 10.04 32-bit system. You'll need to have a BigBlueButton VM running to copy some of the files.

## Installing BigBlueButton ##
Install Ubuntu 10.04 32-bit on your server.

If you don't have a user called **`firstuser`**, create a user called **`firstuser`**. We will run commands using **`firstuser`** user.
```
sudo useradd -d /home/firstuser -m firstuser
sudo passwd firstuser
```

Update the system
```
   sudo apt-get update
   sudo apt-get dist-upgrade
```

Copy to following in a file named `install.sh`
```
#!/bin/bash
set -x
set -e

wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | sudo apt-key add -

#
# 32-bit URL
#
echo "deb http://ubuntu.bigbluebutton.org/bbb_0.8.0.1/ bigbluebutton-lucid main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list

#
# 64-bit URL
#
#echo "deb http://ubuntu.bigbluebutton.org/bbb0_8-64/ bigbluebutton-lucid main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list

sudo apt-get update
sudo apt-get install build-essential ruby rdoc libopenssl-ruby ruby-dev wget

wget http://production.cf.rubygems.org/rubygems/rubygems-1.6.0.tgz
tar zxvf rubygems-1.6.0.tgz
cd rubygems-1.6.0
sudo ruby setup.rb
sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
sudo gem update --system 1.7.2

# Install builder gem
sudo gem install builder bundler god

# Install needed packages for nokogiri
sudo apt-get install libreadline-ruby libopenssl-ruby libxslt-dev libxml2-dev curl libcurl3 libcurl3-dev

sudo apt-get install bbb-freeswitch-config
sudo apt-get install bigbluebutton
sudo apt-get install bbb-demo

sudo bbb-conf --clean
sudo bbb-conf --check

```

Make the script executable.When prompted for mysql password, just hit enter. Accept the Java license agreement by hitting Tab or left arrow.
```
  chmod +x install.sh
  sudo ./install.sh
```

When finished, you should be able to join the demo conference.

Test the demo recording by clicking on "View API Examples" and then "Join a Course (Recorded)".

## Install FFMPEG ##

**Note** You can skip this step as ffmpeg is only needed for the Matterhorn integration.

Install FFMPEG 0.8.1 from instruction here
http://ubuntuforums.org/showpost.php?p=9868359&postcount=1289

Copy the following into a file called `install-ffmpeg.sh`
```
#!/bin/bash
set -x
set -e

sudo apt-get remove ffmpeg x264 libx264-dev
sudo apt-get update

# install dependencies
sudo apt-get install build-essential git-core checkinstall yasm texi2html libfaac-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev libvorbis-dev libx11-dev libxfixes-dev libxvidcore-dev zlib1g-dev

# Install x264
cd /usr/local/src
sudo git clone git://git.videolan.org/x264
cd /usr/local/src/x264
# Build from a certain commit so installs are consistent
sudo git checkout 392e762151d1657abc8ae5d345c144c3ef280819
sudo git checkout -b 392e762151d1657abc8ae5d345c144c3ef280819
sudo ./configure --enable-static
sudo make
sudo checkinstall --pkgname=x264 --default --pkgversion="3:$(./version.sh | awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --backup=no --deldoc=yes

# Install LAME (optional)
sudo apt-get remove libmp3lame-dev
sudo apt-get install nasm
cd /usr/local/src
sudo wget http://downloads.sourceforge.net/project/lame/lame/3.98.4/lame-3.98.4.tar.gz
sudo tar xzvf lame-3.98.4.tar.gz
cd /usr/local/src/lame-3.98.4
sudo ./configure --enable-nasm --disable-shared
sudo make
sudo checkinstall --pkgname=lame-ffmpeg --pkgversion="3.98.4" --backup=no --default --deldoc=yes

# Install libvpx (optional)
cd /usr/local/src
sudo git clone git://review.webmproject.org/libvpx
cd /usr/local/src/libvpx
sudo git checkout v0.9.6
sudo git checkout -b v0.9.6
sudo ./configure
sudo make
sudo checkinstall --pkgname=libvpx --pkgversion="$(date +%Y%m%d%H%M)-git" --backup=no --default --deldoc=yes


# Install FFMPEG
cd /usr/local/src
sudo git clone git://git.videolan.org/ffmpeg
cd /usr/local/src/ffmpeg
sudo git checkout n0.8.1
sudo git checkout -b n0.8.1
sudo ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-postproc  --enable-libfaac --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid --enable-x11grab --enable-libvpx --enable-libmp3lame
sudo make
sudo checkinstall --pkgname=ffmpeg --pkgversion="5:$(./version.sh)" --backup=no --deldoc=yes --default

hash x264 ffmpeg ffplay ffprobe
sudo make tools/qt-faststart
sudo checkinstall --pkgname=qt-faststart --pkgversion="$(./version.sh)" --backup=no --deldoc=yes --default install -D -m 755 /usr/local/src/ffmpeg/tools/qt-faststart /usr/local/bin/qt-faststart

```

Make the file executable
```
  chmod +x install-ffmpeg.sh
  sudo ./install-ffmpeg.sh
```

## Setup Development Environment ##
Install Java and Ant
```
sudo apt-get install openjdk-6-jdk
sudo apt-get install ant
```

SSH into your BigBlueButton VM.
```
cd /home/firstuser/dev/tools
tar zcvf gradle-0.8.tar.gz gradle-0.8
tar zcvf grails-1.1.1.tar.gz grails-1.1.1
tar zcvf groovy-1.6.5.tar.gz groovy-1.6.5
```

Now, transfer the tar.gz files to your new dev env.
```
scp gradle-0.8.tar.gz <your server's ip>:~/dev/tools
scp grails-1.1.1.tar.gz <your server's ip>:~/dev/tools/
scp groovy-1.6.5.tar.gz <your server's ip>:~/dev/tools/
```

In you dev env. Extract the files you just transferred.
```
cd /home/firstuser/dev/tools
tar zxvf gradle-0.8.tar.gz 
tar zxvf grails-1.1.1.tar.gz 
tar zxvf groovy-1.6.5.tar.gz 
```

Update your environment by editing `~/.profile`
```
 vi ~/.profile
```

Append the following to the `~/.profile`
```
#
# BigBlueButton: Setup development environment

export GROOVY_HOME=/home/firstuser/dev/tools/groovy-1.6.5
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk

export GRAILS_HOME=/home/firstuser/dev/tools/grails-1.1.1
export PATH=$PATH:$GRAILS_HOME/bin

export FLEX_HOME=/home/firstuser/dev/tools/flex
export PATH=$PATH:$FLEX_HOME/bin

export GRADLE_HOME=/home/firstuser/dev/tools/gradle-0.8
export PATH=$PATH:$GRADLE_HOME/bin

export ANT_OPTS="-Xmx512m -XX:MaxPermSize=512m"
```

Refresh your environment.
```
    source ~/.profile
    env
```

Clone BigBlueButton
```
mkdir /home/firstuser/dev/source
cd /home/firstuser/dev/source
sudo apt-get install git-core
git clone git://github.com/bigbluebutton/bigbluebutton.git
```

### Client Development ###
```
mkdir -p /home/firstuser/dev/tools/flex-4.5.0.20967
cd /home/firstuser/dev/tools
ln -s flex-4.5.0.20967 flex
```

Install Flex SDK.

Download the Open Source Flex SDK 4.5.0.20967 from
http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+4.5

```
wget http://fpdownload.adobe.com/pub/flex/sdk/builds/flex4.5/flex_sdk_4.5.0.20967_mpl.zip
unzip flex_sdk_4.5.0.20967_mpl.zip
```

Install `playerglobal.swc`

```
cd
mkdir dev/tools/flex-4.5.0.20967/frameworks/libs/player/10.3
cd dev/tools/flex-4.5.0.20967/frameworks/libs/player/10.3
wget http://fpdownload.macromedia.com/pub/flashplayer/updaters/10/playerglobal10_3.swc
mv playerglobal10_3.swc playerglobal.swc
```


Setup the client for development.
```
bbb-conf --setup-dev client
```


---

**NOTE:** If you don't want to run [`bbb-conf --setup-dev client`] but want to instead setup manually, do the following: (the steps below essentially is what [`bbb-conf --setup-dev client`} executes.
```
cd dev/source/bigbluebutton/bigbluebutton-client
mkdir -p bin/conf
ln -s bin client
```


Edit `/etc/nginx/sites-enabled/bigbluebutton` and change root entry in /client to point to your dev client.
```
        # BigBlueButton Flash client.
        location /client {
                root    /home/firstuser/dev/source/bigbluebutton/bigbluebutton-client;
                index  index.html index.htm;
        }
```

Restart Nginx
```
/etc/init.d/nginx/restart
```

Copy the installed `config.xml` into the client dev directory.
```
cp /var/www/bigbluebutton/client/conf/config.xml bigbluebutton-client/src/conf/config.xml
```

---


Now compile the client.
```
cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-client
ant
```

Restart the servers.
```
sudo bbb-conf --clean
```

Test by joining the demo meeting. The dev client should be the one that get's loaded. You can check `/var/log/nginx/access.log` to confirm. Or make some simple changes in the UI to see that it is the one being loaded.

### Developing BBB-Web ###
```

# Copy bigbluebutton.properites in /var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties 
cp /var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties /home/firstuser/dev/source/bigbluebutton/bigbluebutton-web/grails-app/conf/

# Enabling firstuser to write to /var/bigbluebutton to upload slides
sudo chmod -R ugo+rwx /var/bigbluebutton

# Enable firstuser to write to /var/log/bigbluebutton to write log files
sudo chmod -R ugo+rwx /var/log/bigbluebutton
```

We need to have grails serve the web-app instead of Tomcat. However, we can't stop tomcat because it is serving up the demo app. So we just instead tell nginx to forward the calls to grails by changing the port from 8080 (Tomcat's listening port) to 8888 (we tell grails to listen on this port).
```
sudo vi /etc/nginx/sites-enabled/bigbluebutton

# Change the proxy_pass to point to 8888

       location /bigbluebutton {
           proxy_pass         http://127.0.0.1:8888;
           proxy_redirect     default;

# Restart nginx
sudo /etc/init.d/nginx restart
```

Now let's start grails webapp.
```
cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-web/
# Tell grails to listen on port 8888
grails -Dserver.port=8888 run-app
```

If you get an error ` "Could not resolve placeholder 'apiVersion'"`., just run "ant" again. It's grails not picking up the "bigbluebutton.properties" the first time.

Now test again if you can join the demo meeting.

### Developing BBB-Apps ###

```
cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-apps
gradle resolveDeps


# Make red5/webapps writeable by firstuser
sudo chmod -R o+w /usr/share/red5/webapps

# Copy values from /usr/share/red5/webapps/bigbluebutton/WEB-INF/bigbluebutton.properties to
# /home/firstuser/dev/source/bigbluebutton/bigbluebutton-apps/src/main/webapp/WEB-INF/bigbluebutton.properties.

# Remove the existing bbb-apps
sudo apt-get purge --yes bbb-apps

# Stop red5
    sudo /etc/init.d/red5 stop

cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-apps
# Compile and deploy bbb-apps
gradle war deploy

# On another terminal window, start Red5
cd /usr/share/red5/
sudo -u red5 ./red5.sh

```

### Developing BBB-Voice ###
```
cd /home/firstuser/dev/source/bigbluebutton/bbb-voice
gradle resolveDeps

# Copy values from /usr/share/red5/webapps/sip/WEB-INF/bigbluebutton-sip.properties to /home/firstuser/dev/source/bigbluebutton/bbb-voice/src/main/webapp/WEB-INF/bigbluebutton-sip.properties

# Stop red5
    sudo /etc/init.d/red5 stop

cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-apps
# Compile and deploy bbb-apps
gradle war deploy

# On another terminal window, start Red5
cd /usr/share/red5/
sudo -u red5 ./red5.sh

```

### Developing Deskshare ###
```
cd /home/firstuser/dev/source/bigbluebutton/deskshare
gradle resolveDeps
```

**Building the applet.**
```
cd applet
gradle jar

# Now we need to create a key to sign the applet. Enter a password when prompted for one. Make sure it is at least 6 chars long.
ant create-signing-key

# Sign the jar file. Enter the password you created from the previous step when prompted.
ant sign-jar

# The signed jar file is located in  /home/firstuser/dev/source/bigbluebutton/deskshare/applet/build/libs/bbb-deskshare-applet-0.71.jar

# We need to copy it to where nginx is loading the client.

# If you are developing also the bbb-client, then

cp /home/firstuser/dev/source/bigbluebutton/deskshare/applet/build/libs/bbb-deskshare-applet-0.71.jar /home/firstuser/dev/source/bigbluebutton/bigbluebutton-client/client

# If you are not developing the client, therefore, nginx will serve the client from the default location. Therefore, 

cp /home/firstuser/dev/source/bigbluebutton/deskshare/applet/build/libs/bbb-deskshare-applet-0.71.jar /var/www/bigbluebutton/client/

```

**Building the server side component.**
```

cd /home/firstuser/dev/source/bigbluebutton/deskshare/app
# Compile
gradle war
# Copy over to Red5
gradle deploy

# Stop red5
    sudo /etc/init.d/red5 stop

cd /home/firstuser/dev/source/bigbluebutton/bigbluebutton-apps
# Compile and deploy bbb-apps
gradle war deploy

# On another terminal window, start Red5
cd /usr/share/red5/
sudo -u red5 ./red5.sh
```