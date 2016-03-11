# NOTE #
| **We have changed the name of the project to BigBlueButton and moved to http://code.google.com/p/bigbluebutton.** |
|:------------------------------------------------------------------------------------------------------------------|


#summary How to setup your development environment

# Development Environment #
Note: The instructions assumes you are working on a Windows machine. There is no specific requirement on what type of machine or OS is needed. If it has enough processor and memory (at least 512MB), has Java installed, you're good to go.

## Create Directories ##
  1. Create `c:\tools` - will be referred to as `TOOLS_DIR` for the rest of this document
  1. Create `c:\source\client` - will be referred to as `CLIENT_DIR` for the rest of this document
  1. Create `c:\source\server` - will be referred to as `SERVER_DIR` for the rest of this document

## Download and Install Software ##
### Ant ###
  1. Download [Ant](http://ant.apache.org)
  1. Install ant in `TOOLS_DIR` - e.g. `TOOLS_DIR\ant-1.7.0`
  1. Click `Start -> Control Panel -> System -> Advanced tab -> Environment Variables` on your computer
  1. Add `ANT_HOME` in your system variables - e.g `ANT_HOME = TOOLS_DIR\ant-1.7.0`
  1. Add `ANT_HOME\bin` to your PATH
  1. Open a command prompt and run `ant -version`. You should see the ant version displayed.

### Tomcat ###
  1. Download [Tomcat](http://tomcat.apache.org)
  1. Install tomcat in `TOOLS_DIR` - e.g. `TOOLS_DIR\tomcat-5.5.23`
  1. Open a command prompt and cd to `TOOLS_DIR\tomcat-5.5.23`
  1. Run `bin\catalina.bat start`
  1. Open your browser and go to `http://localhost:8080`
  1. You should see the Tomcat page displayed

### ActiveMQ ###
  1. Download [ActiveMQ](http://activemq.apache.org)
  1. Install activeMQ in `TOOLS_DIR` - e.g. `TOOLS_DIR\activemq-4.1.1`
  1. Open a command prompt and cd to `TOOLS_DIR\activemq-4.1.1`
  1. Run `bin\activemq`
  1. Make sure it starts without any problems

### Eclipse ###
  1. Download [Eclipse IDE](http://www.eclipse.org)
  1. Install eclipse in `TOOLS_DIR` - e.g. `TOOLS_DIR\eclipse-3.3`
  1. Start eclipse and set your workspace to the `SERVER_DIR`
  1. Install the [Subclipse plugin](http://subclipse.tigris.org/). Make sure you get the correct version

### Flex Builder 2 ###
  1. Download [Flex Builder 2](http://www.adobe.com/products/flex/)
  1. Install flexbuilder in `TOOLS_DIR` - e.g. `TOOLS_DIR\flex-2`
  1. Start flexbuilder
  1. Install the [Subclipse plugin](http://subclipse.tigris.org/). Make sure you get the correct version. Flex Builder is built on top of Eclipse 3.0/3.1

### OpenOffice (Optional) ###
  1. Follow the instructions on [Installing OpenOffice](InstallOpenOffice.md)
  1. Create a batch file, `TOOLS_DIR\ooo-2.2\start-oo.bat`
  1. Copy this command inside batch file -- `C:\tools\ooo-2.2\program\soffice.exe -headless -accept="socket,port=8100;urp;" `
  1. On a command window, run `start-oo.bat`
  1. Open another command window and run `netstat -a` and verify if your computer is LISTENING on port 8100

### SWF Tools and PDF Toolkit ###
  1. Download [SWF Tools](http://www.swftools.org)
  1. Download [PDF Toolkit](http://www.accesspdf.com/pdftk)
  1. Install in `TOOLS_DIR\swftools`
  1. Add `SWFTOOLS_HOME = TOOLS_DIR\swftools` in you environment variables
  1. Add `SWFTOOLS_HOME` to your PATH

### Asterisk ###
  1. Download and install Asterisk 1.2 from [Asterisk website](http://www.asterisk.org/downloads).
  1. Apply [meetme.c.patch](http://blindside.googlecode.com/svn/trunk/asterisk).
  1. Configure Asterisk using [sample conf](http://blindside.googlecode.com/svn/trunk/asterisk).

## Checkout Blindside Components ##
  1. Checkout blindside-server and blindside-servlet from [code repository](http://blindside.googlecode.com/svn/trunk/) on your Eclipse IDE and put into `SERVER_DIR`.
  1. Checkout blindside-client from [code repository](http://blindside.googlecode.com/svn/trunk/) on your Flex IDE and put into `CLIENT_DIR`.

## Running Blindside ##
  1. Edit `SERVER_DIR\blindside-servlet\war\WEB-INF\blindside.properties`.
    * swftoolLocation=c:/tools/pdf2swf (Edit to point to your pdf2swf executable)
    * pdfExtractor=c:/tools/pdftk (Edit to point to your pdftk executable)
    * presBaseDirectory=c:/temp/upload (directory where uploaded slides are extracted)
    * extractedFolder=extracted

  1. Edit `SERVER_DIR\blindside-server\webapps\astmeetme\WEB-INF\astmeetme.properties` with your Asterisk Management Interface (AMI) values.
    * These properties are for Asterisk Management Interface (AMI)
    * ami.host=192.168.0.101
    * ami.port=5038
    * ami.username=

&lt;username&gt;


    * ami.password=

&lt;password&gt;



  1. Edit `SERVER_DIR\blindside-server\webapps\conference\conferences\conferences.xml` to create conference rooms. Make sure 

&lt;name&gt;

 has an equivalent entry in your Asterisk's `meetme.conf` file.
> 

&lt;conference-room&gt;


> > 

&lt;name&gt;

85101

&lt;/name&gt;


> > 

&lt;mod-password&gt;

modpass

&lt;/mod-password&gt;


> > 

&lt;view-password&gt;

viewpass

&lt;/view-password&gt;



> 

&lt;/conference-room&gt;


  1. Open a command window and start ActiveMQ.
  1. Open another command window and change directory to `SERVER_DIR\blindside-server` and start it by typing `ant server`.
  1. Open another command window and start Tomcat.
  1. Open another command window and change directory to `SERVER_DIR\blindside-servlet` and build it by typing `ant warfile`. This will generate `blindside.war`.
  1. Deploy `blindside.war` to your Tomcat installation.
  1. Open `CLIENT_DIR\blindside-client\html-template\index.template.html` change value of `red5Host` to your blindside-server and `presentationHost` to your tomcat-server.
  1. Run the `blindside-client` from your Flex IDE.
  1. Login using information you provided in `conferences.xml`.
  1. Convert a Powerpoint slide to PDF using OpenOffice or another tool.
  1. Upload the converted PDF slides to share presentation.