# NOTE #
| **We have changed the name of the project to BigBlueButton and moved to http://code.google.com/p/bigbluebutton.** |
|:------------------------------------------------------------------------------------------------------------------|


# Slideshow #
  * http://meyerweb.com/eric/tools/s5/

# FSM #
http://smc.sourceforge.net/SmcHome.htm
http://unimod.sourceforge.net/intro.html

# Flash Player #
  * http://www.jeroenwijering.com/?item=JW_FLV_Media_Player

  * http://www.flashinsider.com/2006/07/26/how-to-create-your-own-youtube-site/
  * http://www.howforge.com/open-source-youtube
  * http://pandastream.com/
  * http://phpmotion.com/
  * http://corp.kaltura.com/
  * http://www.moviemasher.com/
  * http://www.metavid.org

# Papervision #
  * http://papervision2.com/tutorial-list/
  * http://pv3d.org/
  * http://www.madvertices.com/2008/01/papervision-3d-training-videos.html
  * http://papervision3d-fr.com/
  * http://www.dehash.com/?p=152
  * http://blog.tartiflop.com/
  * http://blog.tartiflop.com/2008/09/first-steps-in-papervision3d-part-8-movie-materials/
  * http://dev.papervision3d.org/
  * http://www.blender.org/

# Amazon EC2 #
  * http://www.techexperiment.com/2008/09/24/how-amazon-s3-and-ec2-can-cut-your-hosting-bills-in-half/
  * http://scottpenberthy.com/2008/09/24/amazon-aws-vs-rackspace-and-akamai/
  * http://www.mikebrittain.com/blog/2008/07/19/web-hosting-on-ec2/
  * http://ronaldlewis.com/asterisk-pbx-on-amazon-ec2-how-to-guide-almost-complete/
  * http://www.scribd.com/doc/3905321/PREVIEW-CloudCrunch-Howto-Asterisk-PBX-and-Amazon-EC2
  * http://www.donaldflood.com/2007/07/21/installing-asterisk-on-amazon-ec2/
  * http://www.causecaller.com/wiki/Asterisk_on_EC2

# MySQL Replication and Clustering #

Some notes on mysql replication and clustering.

  * [How to: Move / Copy a live MySQL database (and what not to do)](http://www.softwareprojects.com/resources/programming/t-how-to-move-copy-a-live-mysql-database-1257.html)
  * [MySQL Failover Strategy using State Management](http://dev.mysql.com/tech-resources/articles/failover-strategy-part1.html)
  * [MySQL Cluster Carrier Grade Edition](http://www.mysql.com/industry/telecom/)
  * [High Availability and Scalability](http://dev.mysql.com/doc/refman/5.0/en/ha-overview.html)
  * [An introduction to replication](http://www.databasejournal.com/features/mysql/article.php/3355201)
  * [Restoring lost data from the Binary Update Log](http://www.databasejournal.com/features/mysql/article.php/3326351)
  * [Live Backups of MySQL Using Replication](http://www.onlamp.com/pub/a/onlamp/2005/06/16/MySQLian.html)

## Tcpdump ##
```
> tcpdump -s 0 -i eth0 src 10.98.10.14 -vvv -ttt -e w feb7-8.49am.pbx2.pcap
```

## CPAN ##
http://sial.org/howto/perl/life-with-cpan/
http://www.perlmonks.org/?node_id=394737

# Links on how to create live CDs #
Investigate creating ISO images for releases.

  * http://www-128.ibm.com/developerworks/linux/library/l-fedora-livecd/index.html
  * http://fedoraproject.org/wiki/FedoraLiveCD
  * http://fedoraproject.org/wiki/FedoraLiveCD/LiveCDHowTo
  * http://www.byteclub.net/wiki/CentOS_Live
  * https://projects.centos.org/trac/livecd/wiki
  * https://webapps.saugus.k12.ca.us/community/jklein/weblog/450.html
  * http://sipx-wiki.calivia.com/index.php/A_Kickstart_CD_for_sipX_on_CentOS
  * http://www.linux-live.org/
  * http://www.techonthenet.com/linux/centos4_update.php

# Virtualization #

Some notes on virtualization.

  * [Using Xen for High Availability Clusters](http://www.onlamp.com/pub/a/onlamp/2008/02/05/using-xen-for-high-availabilty-clusters.html)
  * [Building A Virtual Cluster with Xen (Part One)](http://www.clustermonkey.net//content/view/139/33/)
  * [ztxen a zaptel timer for XEN virtual domains](http://lists.digium.com/pipermail/asterisk-dev/2007-May/027470.html)
  * [Example PCI hiding in dom0 and direct access in domU](http://lists.xensource.com/archives/html/xen-users/2005-11/msg00656.html)
  * [loading ztdummy in xen creates an rtc problem](http://bugs.digium.com/view.php?id=9592)
  * [Build your own Asterisk@Home Xen domU](http://code.blitzaffe.com/pages/home/entry/11_build_your_own_asterisk_home)
  * [Fedora Core 6, Xen and Asterisk](http://www.crc.id.au/fedora-core-6-xen-and-asterisk/)

## Fax ##
  * [Faxterisk](http://www.attractel.com/t38.html)
  * [Receiving and sending faxes with asterisk 1.4, NVFaxDetect, iaxmodem and hylafax](http://blogtech.oc9.com/index.php?option=com_content&view=article&catid=4:asterisk&id=77:20071121ast&Itemid=6)
  * [T.38](http://www.voip-info.org/wiki/view/T.38)
  * [T.38 Fax Support, Hype or Reality?](http://blog.tmcnet.com/blog/tom-keating/voip/t38-fax-support-hype-or-reality.asp)
  * [AsterFax - Asterisk Fax](http://asterfax.sourceforge.net/)
  * [HylaFax and IAXmodem Installatioin](http://aussievoip.com.au/wiki/HylaFax+and+IAXmodem+Installatioin)
  * [IAXmodem](http://iaxmodem.sourceforge.net/)
  * [NVFaxDetect](http://www.voip-info.org/wiki-NVFaxDetect)
  * [What is AvantFAX?](http://www.avantfax.com/)
  * [Build A HylaFax Server With AvantFax Frontend Using Debian Etch](http://www.howtoforge.com/build-a-hylafax-server-with-avantfax-on-debian-etch)
  * [Fax Services with Hylafax](http://www.linux.org/lessons/advanced/x833.html)
  * [How to build a Hylafax server (i.e. Hylamonster)](http://howtoforge.com/linux_hylafax_server)
  * [How To Set Up A Debian Linux Fax Server](http://www.aboutdebian.com/fax.htm)
  * [Winprint HylaFAX](http://winprinthylafax.sourceforge.net/)
  * [Asterisk and fax calls](http://www.voip-info.org/wiki-Asterisk+fax)
  * [Faxing with Asterisk](http://scottstuff.net/blog/articles/2004/03/28/faxing-with-asterisk)
  * [T.38 Passthrough](http://www.voip-info.org/tiki-index.php?page=Asterisk%20T.38)
  * [Avantfax](http://www.avantfax.com/)
  * [Callweaver](http://www.callweaver.org/blog?category=t.38)
  * [Fax Gateway](http://bugs.digium.com/view.php?id=13405)

## FreeSWITCH ##
  * http://www.voiceovergurl.com/
  * [PBX prompts](http://www.pbxprompts.com/)
  * http://www.gmvoices.com/
  * http://lists.freeswitch.org/pipermail/freeswitch-users/2008-January/001932.html
  * http://lists.freeswitch.org/pipermail/freeswitch-users/2008-July/004178.html
  * http://wiki.freeswitch.org/wiki/FreeSwitch_Scheduler_API
  * http://wiki.freeswitch.org/index.php?title=Misc._Dialplan_Tools_sched_hangup

## Grails ##
  * [Grails services and Google Maps](http://www.ibm.com/developerworks/java/library/j-grails05208/index.html)
  * [Masterisk Grails](http://www.ibm.com/developerworks/views/java/libraryview.jsp?search_by=mastering+grails)
  * http://fbflex.wordpress.com/2008/05/15/rest-service-xml-output-in-grails-via-content-negotiation/
  * [Grails, REST and JSecurity](http://www.grassr.com/wordpress/?p=18)
  * http://henyoonline.blogspot.com/2008/07/rest-with-grails.html

## Tools ##
### Diffs and Merging ###
  * [Meld](http://meld.sourceforge.net/index.html)
  * [Winmerge](http://www.winmerge.org/index.php)
  * [Tortoise Merge](http://tortoisesvn.tigris.org/TortoiseMerge.html)
  * [Beyond Compare](http://www.scootersoftware.com/)
  * http://www.hanselman.com/blog/ScottHanselmans2007UltimateDeveloperAndPowerUsersToolListForWindows.aspx
  * http://opensourceresources.wikispaces.com/

# Email/ Newsletter #
  * [Marketing](http://www.openemm.org/)
  * http://www.phplist.com/

# PDF #
  * http://www.primopdf.com/