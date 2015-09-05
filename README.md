Livestreamer Delay and Restart Script
=================================

THIS SCRIPT DEPENDS ON LIVESTREAMER WHICH CAN BE OBTAINED FROM HERE: http://livestreamer.readthedocs.org/en/latest/install.html

This simple script can be used to schedule a stream recording and will also automatically restart it on failure.  The user-controlled variables are documented near the top of the script and will need to be edited with start date, stream URL, etc.

##Windows Version

Once you have filled in the variable right-click the script and choose "Run with PowerShell" to execute.  You will see the output indicating how long it's going to sleep.  Once this time has been reached it will start recording the stream and restart if interrupted.

##Linux Version

Once you have filled in the variables from a terminal simply execute ./ls_delay_restart.sh and you will see an output of sleeping for x seconds.  Once this time has been reached it will start recording the stream and restart if interrupted.  
Make sure you chmod +x the script before you attempt to execute it.  


####Any issues please let me know!
