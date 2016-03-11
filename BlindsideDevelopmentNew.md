# NOTE #
| **We have changed the name of the project to BigBlueButton and moved to http://code.google.com/p/bigbluebutton.** |
|:------------------------------------------------------------------------------------------------------------------|


## Setting up your IDEs ##
### Eclipse ###
**To start, you will need to download Eclipse. You can get it [here](http://www.eclipse.org/).**Once done, you will need to install the subversion plug-in for eclipse called [subclipse](http://subclipse.tigris.org/). To install it, in Eclipse go to Help>Software Updates>Find and Install. Select 'Search for new Features to Install', then click on 'New Remote Site'. In the site URL enter 'http://subclipse.tigris.org/update_1.2.x' then click next. If you get an error on the following screen make sure to uncheck Mylyn Integration. You don't need it.

### Flex Builder ###
Flex Builder is the Adobe IDE for the Flex platform. It's built on top of Eclipse, so if you want you can download it as an Eclipse plug-in. I prefer the standalone version. You can download Flex3 from [here](http://www.adobe.com/products/flex/). It has a 60 day free trial, but if you're a student or academia you can get a free copy from [here](http://www.flexregistration.com/). Once you've installed Flex, repeat the process of installing Subclipse in Flex.

## Checking out the Code ##
### Server-side ###
To check out the server code, open the SVN perspective in Eclipse and make a new repository location. The address is available if you click on the source tab here on google code.
Once you've opened the repository, check out the project named 'sumilon'
When the download is complete, open the command prompt and navigate to the root directory of sumilon. Run the command 'ant retrieve' (you will need [ant](http://ant.apache.org/) installed. This will download all the dependencies that sumilon needs to compile properly. If you now go to Eclipse and refresh the workspace, Eclipse should not report any errors. Finally, to run the server, in Eclipse find the file called build.xml under the sumilon root folder. Right click on the file and go to Run>Ant Build. After a somewhat lenghty startup procedure the server should start.
If the server doesn't start make sure you don't have any other instances of Tomcat or Red5 running on your machine, and make sure you have the latest Java JDK installed - the server will likely not compile properly with just a JRE.

### Client ###
In Flex, open the SVN perspective and create a new repository. The address is the same as for the server code. Check out the project called blindside-client.
Once all the files finish downloading, run the blindside-client inside of Eclipse. Blindside should then start. Provided you have the server running on the same machine, you can try logging in to the default room #85115, with password 'modpass' for the moderator or 'viewpass' for the viewer. Your name can be whatever you want.

## The Presentation Module ##
### Checking out the Servlet ###
Now that you have Blindside running, there are a couple of extra things to do. If you've tried to upload a presentation inside the client, you will have gotten an I/O error. This is because the file uploading currently works independently of the sumilon server package. To get the file uploading to work, you will have to go to Eclipse and check out the blindside-servlet project. The full instructions on how to do this are in the original howto on this wiki.