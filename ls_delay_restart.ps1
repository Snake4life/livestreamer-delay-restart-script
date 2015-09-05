#Simple script to delay and restart a stream for future recording
#Copyright (C) 2014 Dan Bunyard

#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

#I can be contacted through my email, danodemano@gmail.com, with any questions.

#NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#This script requires livestreamer be installed on your system
#You can find instructions here: http://livestreamer.readthedocs.org/en/latest/install.html

#The date when you want the stream to start
$start_date = [datetime]"09/05/2015 14:41"

#The URL of the stream to record
#See here for list of acceptable sources: https://livestreamer.readthedocs.org/en/latest/plugin_matrix.html#plugin-matrix
$stream_url = 'http://www.twitch.tv/esl_joindotared'

#The base filename to use for the saved MP4
#an _ counter and .mp4 will be added to the end
$base_filename = "$env:userprofile\esl_playoffs_20150805"

#The stream quality, best is always prefered if you have the bandwidth
#Options vary by source but are typically low, medium, and best
$stream_quality = 'best'

#The number of seconds to sleep before trying to re-start the stream on failure
#This should be left at 5 unless you know your Internet connection has problems
#in which case you may want to up it.
$fail_sleep_duration = 5

#################################################################################
#################################################################################
#UNLESS YOU KNOW WHAT YOU ARE DOING DON'T EDIT BELOW THIS LINE
#################################################################################
#################################################################################

#The sleep seconds is the target minus the current
$sleep_time = NEW-TIMESPAN -End $start_date

#Echo out the number of seconds and sleep
if ($sleep_time.TotalSeconds > 0) {
	Write-Host "Sleeping for: $sleep_time"
	sleep $sleep_time.TotalSeconds
}

#Now we need to loop forever restarting the stream as needed
$counter_variable = 1
while($true) {
	#This has to be killed manually
	Write-Host "Press [CTRL+C]x2 to stop..."
	#Build the command and display it
	$command = "livestreamer "
	$command += "$stream_url $stream_quality -o '$base_filename"
	$command += "_"
	$command += "$counter_variable.mp4'"
	Write-Host "Command: $command"
	#Start the stream using the command created above
	invoke-expression $command
	#Sleep for a time definied by the fail_sleep_duration variable
	#The hope here is that whatever disrupted the stream is resolved after the delay
	Write-Host "Sleeping for $fail_sleep_duration seconds then trying to restart stream"
	sleep $fail_sleep_duration
	#Increment the counter variable
	$counter_variable++
}
