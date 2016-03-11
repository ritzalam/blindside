The following instructions will guide you to install BigBlueButton on CentOS. So far the instructions have been tested on **CentOS 5.4 32-bit**. In most cases, you'll want to install from [packages](RPMPackaging.md), but if you want to really understand how BigBlueButton is setup, go through the step-by-step instructions below and you'll become familiar with each component.

## Instructions ##
**NOTE: If your 'hostname' command does not return the proper (working) IP or domain, you need to run `hostname <your-correct-hostname-or-ip>` to make these instructions work.**

```
# we'll work mostly from the /tmp/ directory:
cd /tmp

# we'll need wget
yum install wget -y

# install MySQL server
yum install -y mysql-server
service mysqld start
chkconfig mysqld on

# install tomcat6
yum install -y tomcat6

# start tomcat and configure it to automatically start on boot:
service tomcat6 start
chkconfig tomcat6 on

# install openoffice
yum -y groupinstall 'Office/Productivity'

# download openoffice server initializing script
wget http://bigbluebutton.org/downloads/0.64/centos-install/bbb-openoffice-headless
mv bbb-openoffice-headless /etc/init.d/

# start the openoffice server
chmod +x /etc/init.d/bbb-openoffice-headless
chkconfig --add bbb-openoffice-headless
chkconfig bbb-openoffice-headless on
service bbb-openoffice-headless start

# for compiling your own packages, you will need some development tools
yum -y install gcc gcc-c++ compat-gcc-32 compat-gcc-32-c++

# some more requirements for packages that we will soon install:
yum -y install -y zlib zlib-devel freetype freetype-devel libjpeg libjpeg-devel

# install swftools:
wget http://www.swftools.org/swftools-0.8.1.tar.gz
tar xzf swftools-0.8.1.tar.gz 
cd swftools-0.8.1
./configure 
make
make install
cd ..

# install ghostscript
yum install -y ghostscript

# install ImageMagick
yum install -y ImageMagick

# now install nginx:
yum install -y nginx

# install activemq from source:
useradd activemq
wget http://apache.mirror.rafal.ca/activemq/apache-activemq/5.2.0/apache-activemq-5.2.0-bin.tar.gz
tar xzf apache-activemq-5.2.0-bin.tar.gz 
mv apache-activemq-5.2.0 /usr/share/
ln -s /usr/share/apache-activemq-5.2.0 /usr/share/activemq
chown -R activemq.activemq /usr/share/apache-activemq-5.2.0
chown -R activemq.activemq /usr/share/activemq

# Now get the init.d file that we created for you
wget http://bigbluebutton.org/downloads/0.64/centos-install/activemq
mv activemq /etc/init.d/

# now make that file executable, start the service and configure it to auto-start
chmod a+x /etc/init.d/activemq
service activemq start
chkconfig activemq on

# now we will install Red5 from source
useradd red5
wget http://bigbluebutton.org/downloads/0.64/red5-0.9.1.tar.gz
tar xvf red5-0.9.1.tar.gz
mv red5-0.9.1 /usr/share/red5
chown -R red5.red5 /usr/share/red5

# now get the init.d file that we created for you
wget http://bigbluebutton.org/downloads/0.64/centos-install/red5
mv red5 /etc/init.d/

# now chmod the file, start and config auto-start:
chmod a+x /etc/init.d/red5
service red5 start
chkconfig red5 on

# now prepare for Asterisk build: 
yum install -y kernel-devel

# On Xen VM you need:
# yum install -y kernel-xen-devel

yum install -y ncurses-devel openssl-devel newt-devel zlib-devel bison

# install asterisk
wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-1.4.25.tar.gz
tar zxvf asterisk-1.4.25.tar.gz
cd asterisk-1.4.25
./configure
make 
make install
make samples
make config
cd ..

# configure asterisk
wget http://bigbluebutton.org/downloads/0.64/bbb_extensions.conf
mv bbb_extensions.conf /etc/asterisk/
echo "#include \"bbb_extensions.conf\"" >> /etc/asterisk/extensions.conf

wget http://bigbluebutton.org/downloads/0.64/bbb_sip.conf
mv bbb_sip.conf /etc/asterisk/bbb_sip.conf
echo "#include \"bbb_sip.conf\"" >> /etc/asterisk/sip.conf


wget http://bigbluebutton.org/downloads/0.64/app_konference.so
mv app_konference.so /usr/lib/asterisk/modules/
chmod 755 /usr/lib/asterisk/modules/app_konference.so
# set autoload module BigBlueButton conference
echo "load => app_konference.so" >> /etc/asterisk/modules.conf

wget http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/centos-install-files/asterisk-create-sip-accounts.sh
chmod a+x asterisk-create-sip-accounts.sh
./asterisk-create-sip-accounts.sh

# set enabled to yes in manager.conf
cat /etc/asterisk/manager.conf | sed 's/^enabled = no/enabled = yes/' > /tmp/manager.conf
mv -f /tmp/manager.conf /etc/asterisk/

# add account to manager.conf
echo "

; BigBlueButton: Enable Red5 to connect
[bbb]
secret = secret
permit = 0.0.0.0/0.0.0.0
read = system,call,log,verbose,command,agent,user
write = system,call,log,verbose,command,agent,user
" >> /etc/asterisk/manager.conf


# configure nginx
mkdir -p /etc/nginx/sites-available
mkdir -p /etc/nginx/sites-enabled

wget http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/centos-install-files/nginx-bigbluebutton.conf
wget http://bigbluebutton.googlecode.com/svn/trunk/bbb-images/centos-install-files/nginx.conf
mv -f nginx.conf /etc/nginx/
cat nginx-bigbluebutton.conf  | sed "s/192.168.0.136/`hostname`/" > /etc/nginx/sites-available/bigbluebutton
rm -f nginx-bigbluebutton.conf
ln -s /etc/nginx/sites-available/bigbluebutton /etc/nginx/sites-enabled/bigbluebutton
service nginx start
chkconfig nginx on

# download BBB apps
cd /tmp/
mkdir bbb-install
cd bbb-install
wget http://bigbluebutton.org/downloads/0.64/packages/bbb-default.tar.gz
wget http://bigbluebutton.org/downloads/0.64/packages/bigbluebutton.war
wget http://bigbluebutton.org/downloads/0.64/packages/video.tar.gz
wget http://bigbluebutton.org/downloads/0.64/packages/bigbluebutton-apps.tar.gz
wget http://bigbluebutton.org/downloads/0.64/packages/client.tar.gz
wget http://bigbluebutton.org/downloads/0.64/packages/sip.tar.gz

# configure MySQL database
echo "create database bigbluebutton_dev;" | mysql -u root
echo "grant all on bigbluebutton_dev.* to 'bbb'@'localhost' identified by 'secret';" | mysql -u root
echo "commit;" | mysql -u root

# now install the webapp
cp /tmp/bbb-install/bigbluebutton.war /var/lib/tomcat6/webapps/bigbluebutton.war

setsebool -P allow_execstack 1
service tomcat6 restart

# download blank slide and thumbnail dummies
mkdir -p /var/bigbluebutton/blank
cd /var/bigbluebutton/blank
wget http://bigbluebutton.org/downloads/0.64/blank/blank-slide.swf
wget http://bigbluebutton.org/downloads/0.64/blank/blank-thumb.png
```

**Generate a GUID (manual step)**

For security, you need to generate a GUID. You can use an online GUID generator, such as [this one](http://www.somacon.com/p113.php). Keep this GUID handy as we will need it shortly.

Determine PDF2SWF, CONVERT and GS applications (manual step)
```
      # Make a note of where pdf2swf is installed
      which pdf2swf
       
      # You should see something like
      # /usr/local/bin/pdf2swf
        
      # Make a note of where the convert application is installed
      which convert

      # You shoud see something like.
      # /usr/bin/convert

      # Note where GhostScript is installed
      which gs

      # You should see something like.
      # /usr/bin/gs
```
Edit bbb-web properties
```
vi /var/lib/tomcat6/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties

# Change the following:
#  - swfToolsDir to the directory where pdf2swf is located (in this example, it is /usr/local/bin)
#  - imageMagickDir to the directory where convert is located (in this example, it is /usr/bin)
#  - ghostScriptExec to point to the gs application (in this example, it is /usr/bin/gs)
#  - change bigbluebutton.web.serverURL=http://<YOUR HOSTNAME>
#  - set beans.dynamicConferenceService.securitySalt to be equal to the guid we just generated (i.e. beans.dynamicConferenceService.securitySalt=<YOUR-GUID>)
```
Back to the automated tasks:
```
# create nopdfworkaround file
mkdir /etc/bigbluebutton
echo '%!
/pdfmark {cleartomark} bind def' > /etc/bigbluebutton/nopdfmark.ps

# restart tomcat
service tomcat6 restart

# make sure that your database was created:
echo "show tables" | mysql -u root bigbluebutton_dev
echo "select * from user" | mysql -u root bigbluebutton_dev

# setup the slide upload folder
mkdir /var/bigbluebutton
chown -R tomcat:adm /var/bigbluebutton
chmod -R 777 /var/bigbluebutton

# setup the red5 apps
cd /tmp/bbb-install
tar xvf bigbluebutton-apps.tar.gz
mv bigbluebutton /usr/share/red5/webapps/

# install video app
tar xvf video.tar.gz
mv video /usr/share/red5/webapps/

# install voice app
tar xvf sip.tar.gz
mv sip /usr/share/red5/webapps/

# install bbb-client:
mkdir -p /var/www/bigbluebutton
tar xvf client.tar.gz
mv bin /var/www/bigbluebutton/client

cat /var/www/bigbluebutton/client/conf/config.xml | sed "s/192.168.0.120/`hostname`/" | sed "s|conf/join-mock.xml|http://`hostname`/bigbluebutton/conference-session/enter|" > /tmp/config.xml
mv -f /tmp/config.xml /var/www/bigbluebutton/client/conf/config.xml

# install bbb-default pages
tar xvf bbb-default.tar.gz
mv web /var/www/bigbluebutton-default
```

Now we need to create bbb\_api\_conf.jsp, which will hold our GUID and the BigBlueButtonURL. Be sure to replace < YOUR-GUID > with the GUID we generated earlier.
```
echo "<%!
// This is the security salt that must match the value set in the BigBlueButton server
String salt = \"<YOUR-GUID>\";

// This is the URL for the BigBlueButton server
String BigBlueButtonURL = \"http://`hostname`/bigbluebutton/\";
%>" > /var/lib/tomcat6/webapps/bigbluebutton/demo/bbb_api_conf.jsp

```

Installing Desktop Sharing (optional)
```
# download deskshare app
wget http://bigbluebutton.org/downloads/0.64/packages/deskshare.tar.gz

# install deskshare app
#
# Desktop sharing uses Xuggler.  Before you install desktop sharing in BigBlueButton
# please read how this changes the licensing of BigBlueButton from LGPL to AGPL.
#
#     http://code.google.com/p/bigbluebutton/wiki/InstallingDesktopSharing 
#

tar xvf deskshare.tar.gz
mv deskshare /usr/share/red5/webapps/
```

Desktop sharing is disabled by default. To enable it, edit "/var/www/bigbluebutton/client/conf/config.xml" and uncomment the DeskShareModule. You will find the DeskshareModule commented as follows:
```
 <!-- module name="DeskShareModule" url="DeskShareModule.swf" uri="rtmp://192.168.0.132/deskShare" onUserJoinedEvent="START" onUserLogoutEvent="STOP" loadNextModule="PhoneModule" /-->
```
In the same file, for the ListenersModule change the property loadNextModule="PhoneModule" to loadNextModule="DeskShareModule"

Finish the installation
```
# create directory for log files
mkdir /var/log/bigbluebutton

# create an empty log file
touch /var/log/bigbluebutton/bbb-web.log
chmod 777 /var/log/bigbluebutton/bbb-web.log

# restart things:
service activemq restart
service asterisk restart
service red5 restart
service tomcat6 restart
```