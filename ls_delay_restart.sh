#!/bin/bash

#Simple script to delay and restart a stream for future recording

#The MIT License (MIT)

#Copyright (c) 2015 Daniel Bunyard

#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

#I can be contacted through my email, danodemano@gmail.com, with any questions.

#NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#This script requires livestreamer be installed on your system
#You can find instructions here: http://livestreamer.readthedocs.org/en/latest/install.html

#The date when you want the stream to start
start_date='11/29/2014 07:45'

#The URL of the stream to record
#See here for list of acceptable sources: https://livestreamer.readthedocs.org/en/latest/plugin_matrix.html#plugin-matrix
stream_url='http://www.twitch.tv/dreamleague'

#The base filename to use for the saved MP4
#an _ counter and .mp4 will be added to the end
base_filename='/home/dan/dl_playoffs_20141129'

#The stream quality, best is always prefered if you have the bandwidth
#Options vary by source but are typically low, medium, and best
stream_quality='best'

#The number of seconds to sleep before trying to re-start the stream on failure
#This should be left at 5 unless you know your Internet connection has problems
#in which case you may want to up it.
fail_sleep_duration=5

#################################################################################
#################################################################################
#UNLESS YOU KNOW WHAT YOU ARE DOING DON'T EDIT BELOW THIS LINE
#################################################################################
#################################################################################

#Get the current epoch and the target epoch
#The sleep seconds is the target minus the current epoc
current_epoch=$(date +%s)
target_epoch=$(date -d "$start_date" +%s)
sleep_seconds=$(( $target_epoch - $current_epoch ))

#Echo out the number of seconds and sleep
echo "Sleeping for: $sleep_seconds"
sleep $sleep_seconds

#Now we need to loop forever restarting the stream as needed
counter_variable=1
while :
do
	#This has to be killed manually
	echo "Press [CTRL+C]x2 to stop..."
	#Start the stream being sure to use the counter as part of the filename
	echo "Command: livestreamer $stream_url $stream_quality -o $base_filename"_"$counter_variable.mp4"
	livestreamer "$stream_url" "$stream_quality" -o "$base_filename"_"$counter_variable".mp4
	#Sleep for a time definied by the fail_sleep_duration variable
	#The hope here is that whatever disrupted the stream is resolved after the delay
	echo "Sleeping for $fail_sleep_duration seconds then trying to restart stream"
	sleep "$fail_sleep_duration"
	#Increment the counter variable
	((counter_variable++))
done
