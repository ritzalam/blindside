# NOTE #
| **We have changed the name of the project to BigBlueButton and moved to http://code.google.com/p/bigbluebutton.** |
|:------------------------------------------------------------------------------------------------------------------|


## SIPP ##
## SIPP Help ##
```
 > sipp

Usage:

  sipp remote_host[:remote_port] [options]

  Available options:

   -v               : Display version and copyright information.

   -aa              : Enable automatic 200 OK answer for INFO, UPDATE and
                      NOTIFY messages.

   -base_cseq       : Start value of [cseq] for each call.

   -bg              : Launch SIPp in background mode.

   -bind_local      : Bind socket to local IP address, i.e. the local IP
                      address is used as the source IP address.  If SIPp runs
                      in server mode it will only listen on the local IP
                      address instead of all IP addresses.

   -buff_size       : Set the send and receive buffer size.

   -cid_str         : Call ID string (default %u-%p@%s).  %u=call_number,
                      %s=ip_address, %p=process_number, %%=% (in any order).

   -cp              : Set the local control port number. Default is 8888.

   -d               : Controls the length of calls. More precisely, this
                      controls the duration of 'pause' instructions in the
                      scenario, if they do not have a 'milliseconds' section.
                      Default value is 0 and default unit is milliseconds.

   -f               : Set the statistics report frequency on screen. Default is
                      1 and default unit is seconds.

   -fd              : Set the statistics dump log report frequency. Default is
                      60 and default unit is seconds.

   -i               : Set the local IP address for 'Contact:','Via:', and
                      'From:' headers. Default is primary host IP address.


   -inf             : Inject values from an external CSV file during calls into
                      the scenarios.
                      First line of this file say whether the data is to be
                      read in sequence (SEQUENTIAL) or random (RANDOM) order.
                      Each line corresponds to one call and has one or more
                      ';' delimited data fields. Those fields can be referred
                      as [field0], [field1], ... in the xml scenario file.

   -ip_field        : Set which field from the injection file contains the IP
                      address from which the client will send its messages.
                      If this option is omitted and the '-t ui' option is
                      present, then field 0 is assumed.
                      Use this option together with '-t ui'

   -l               : Set the maximum number of simultaneous calls. Once this
                      limit is reached, traffic is decreased until the number
                      of open calls goes down. Default:
                        (3 * call_duration (s) * rate).

   -lost            : Set the number of packets to lose by default (scenario
                      specifications override this value).

   -m               : Stop the test and exit when 'calls' calls are processed

   -mi              : Set the local media IP address

   -master          : 3pcc extended mode: indicates the master number

   -max_recv_loops  : Set the maximum number of messages received read per
                      cycle. Increase this value for high traffic level.  The
                      default value is 1000.

   -max_sched_loops : Set the maximum number of calsl run per event loop.
                      Increase this value for high traffic level.  The default
                      value is 1000.

   -max_reconnect   : Set the the maximum number of reconnection.

   -max_retrans     : Maximum number of UDP retransmissions before call ends on
                      timeout.  Default is 5 for INVITE transactions and 7 for
                      others.

   -max_invite_retrans: Maximum number of UDP retransmissions for invite
                      transactions before call ends on timeout.

   -max_non_invite_retrans: Maximum number of UDP retransmissions for non-invite
                      transactions before call ends on timeout.

   -max_socket      : Set the max number of sockets to open simultaneously.
                      This option is significant if you use one socket per
                      call. Once this limit is reached, traffic is distributed
                      over the sockets already opened. Default value is 50000

   -mb              : Set the RTP echo buffer size (default: 2048).

   -mp              : Set the local RTP echo port number. Default is 6000.

   -nd              : No Default. Disable all default behavior of SIPp which
                      are the following:
                      - On UDP retransmission timeout, abort the call by
                        sending a BYE or a CANCEL
                      - On receive timeout with no ontimeout attribute, abort
                        the call by sending a BYE or a CANCEL
                      - On unexpected BYE send a 200 OK and close the call
                      - On unexpected CANCEL send a 200 OK and close the call
                      - On unexpected PING send a 200 OK and continue the call
                      - On any other unexpected message, abort the call by
                        sending a BYE or a CANCEL


   -nr              : Disable retransmission in UDP mode.

   -p               : Set the local port number.  Default is a random free port
                      chosen by the system.

   -pause_msg_ign   : Ignore the messages received during a pause defined in
                      the scenario

   -r               : Set the call rate (in calls per seconds).  This value can
                      bechanged during test by pressing '+','_','*' or '/'.
                      Default is 10.
                      pressing '+' key to increase call rate by 1,
                      pressing '-' key to decrease call rate by 1,
                      pressing '*' key to increase call rate by 10,
                      pressing '/' key to decrease call rate by 10.
                      If the -rp option is used, the call rate is calculated
                      with the period in ms given by the user.

   -rp              : Specify the rate period for the call rate.  Default is 1
                      second and default unit is milliseconds.  This allows
                      you to have n calls every m milliseconds (by using -r n
                      -rp m).
                      Example: -r 7 -rp 2000 ==> 7 calls every 2 seconds.
                               -r 10 -rp 5s => 10 calls every 5 seconds.

   -rate_increase   : Specify the rate increase every -fd units (default is
                      seconds).  This allows you to increase the load for each
                      independent logging period.
                      Example: -rate_increase 10 -fd 10s
                        ==> increase calls by 10 every 10 seconds.

   -rate_max        : If -rate_increase is set, then quit after the rate
                      reaches this value.
                      Example: -rate_increase 10 -rate_max 100
                        ==> increase calls by 10 until 100 cps is hit.

   -recv_timeout    : Global receive timeout. Default unit is milliseconds. If
                      the expected message is not received, the call times out
                      and is aborted.

   -send_timeout    : Global send timeout. Default unit is milliseconds. If a
                      message is not sent (due to congestion), the call times
                      out and is aborted.

   -reconnect_close : Should calls be closed on reconnect?

   -reconnect_sleep : How long (in milliseconds) to sleep between the close and
                      reconnect?

   -rsa             : Set the remote sending address to host:port for sending
                      the messages.

   -rtp_echo        : Enable RTP echo. RTP/UDP packets received on port defined
                      by -mp are echoed to their sender.
                      RTP/UDP packets coming on this port + 2 are also echoed
                      to their sender (used for sound and video echo).

   -rtt_freq        : freq is mandatory. Dump response times every freq calls
                      in the log file defined by -trace_rtt. Default value is
                      200.

   -s               : Set the username part of the resquest URI. Default is
                      'service'.

   -sd              : Dumps a default scenario (embeded in the sipp executable)

   -sf              : Loads an alternate xml scenario file.  To learn more
                      about XML scenario syntax, use the -sd option to dump
                      embedded scenarios. They contain all the necessary help.

   -slave           : 3pcc extended mode: indicates the slave number

   -slave_cfg       : 3pcc extended mode: indicates the file where the master
                      and slave addresses are stored

   -sn              : Use a default scenario (embedded in the sipp executable).
                      If this option is omitted, the Standard SipStone UAC
                      scenario is loaded.
                      Available values in this version:

                      - 'uac'      : Standard SipStone UAC (default).
                      - 'uas'      : Simple UAS responder.
                      - 'regexp'   : Standard SipStone UAC - with regexp and
                        variables.
                      - 'branchc'  : Branching and conditional branching in
                        scenarios - client.
                      - 'branchs'  : Branching and conditional branching in
                        scenarios - server.

                      Default 3pcc scenarios (see -3pcc option):

                      - '3pcc-C-A' : Controller A side (must be started after
                        all other 3pcc scenarios)
                      - '3pcc-C-B' : Controller B side.
                      - '3pcc-A'   : A side.
                      - '3pcc-B'   : B side.


   -stat_delimiter  : Set the delimiter for the statistics file

   -stf             : Set the file name to use to dump statistics

   -t               : Set the transport mode:
                      - u1: UDP with one socket (default),
                      - un: UDP with one socket per call,
                      - ui: UDP with one socket per IP address The IP
                        addresses must be defined in the injection file.
                      - t1: TCP with one socket,
                      - tn: TCP with one socket per call,
                      - l1: TLS with one socket,
                      - ln: TLS with one socket per call,
                      - c1: u1 + compression (only if compression plugin
                        loaded),
                      - cn: un + compression (only if compression plugin
                        loaded).


   -timeout         : Global timeout. Default unit is seconds.  If this option
                      is set, SIPp quits after nb units (-timeout 20s quits
                      after 20 seconds).

   -timer_resol     : Set the timer resolution. Default unit is milliseconds.
                      This option has an impact on timers precision.Small
                      values allow more precise scheduling but impacts CPU
                      usage.If the compression is on, the value is set to
                      50ms. The default value is 10ms.

   -trace_msg       : Displays sent and received SIP messages in <scenario file
                      name>_<pid>_messages.log

   -trace_shortmsg  : Displays sent and received SIP messages as CSV in
                      <scenario file name>_<pid>_shortmessages.log

   -trace_screen    : Dump statistic screens in the
                      <scenario_name>_<pid>_cenaris.log file when quitting
                      SIPp. Useful to get a final status report in background
                      mode (-bg option).

   -trace_err       : Trace all unexpected messages in <scenario file
                      name>_<pid>_errors.log.

   -trace_stat      : Dumps all statistics in <scenario_name>_<pid>.csv file.
                      Use the '-h stat' option for a detailed description of
                      the statistics file content.

   -trace_rtt       : Allow tracing of all response times in <scenario file
                      name>_<pid>_rtt.csv.

   -trace_logs      : Allow tracing of <log> actions in <scenario file
                      name>_<pid>_logs.log.

   -users           : Instead of starting calls at a fixed rate, begin 'users'
                      calls at startup, and keep the number of calls constant.

   -3pcc            : Launch the tool in 3pcc mode ("Third Party call
                      control"). The passed ip address is depending on the
                      3PCC role.
                      - When the first twin command is 'sendCmd' then this is
                        the address of the remote twin socket.  SIPp will try to
                        connect to this address:port to send the twin command
                        (This instance must be started after all other 3PCC
                        scenarii).
                          Example: 3PCC-C-A scenario.
                      - When the first twin command is 'recvCmd' then this is
                        the address of the local twin socket. SIPp will open
                        this address:port to listen for twin command.
                          Example: 3PCC-C-B scenario.

   -tdmmap          : Generate and handle a table of TDM circuits.
                      A circuit must be available for the call to be placed.
                      Format: -tdmmap {0-3}{99}{5-8}{1-31}

   -key             : keyword value
                      Set the generic parameter named "keyword" to "value".

Signal handling:

   SIPp can be controlled using posix signals. The following signals
   are handled:
   USR1: Similar to press 'q' keyboard key. It triggers a soft exit
         of SIPp. No more new calls are placed and all ongoing calls
         are finished before SIPp exits.
         Example: kill -SIGUSR1 732
   USR2: Triggers a dump of all statistics screens in
         <scenario_name>_<pid>_screens.log file. Especially useful
         in background mode to know what the current status is.
         Example: kill -SIGUSR2 732

Exit code:

   Upon exit (on fatal error or when the number of asked calls (-m
   option) is reached, sipp exits with one of the following exit
   code:
    0: All calls were successful
    1: At least one call failed
   97: exit on internal command. Calls may have been processed
   99: Normal exit without calls processed
   -1: Fatal error


Example:

   Run sipp with embedded server (uas) scenario:
     ./sipp -sn uas
   On the same host, run sipp with embedded client (uac) scenario
     ./sipp -sn uac 127.0.0.1
```