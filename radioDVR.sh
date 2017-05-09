#!/bin/bash

DATE=$(date +%A)

####################################################
YESTERDAY=$(date -v-1d +%A)

if [ $YESTERDAY == "Sunday" ]; then YESTERDAY="Friday"; fi

sed -i -e "s/$YESTERDAY/$DATE/g" ftpscripts.txt 
#################################################

curl -o /Library/WebServer/Documents/radio/redeye/$DATE.mp3 -m 11000 "http://65.19.131.138/foxnewsradio-foxnewsaac-ibc2?session-id=f059e82414ebec860341fb1ad68c3b60-72717670336c67316c73683134633869&source=v6player&sbmd=1&user-id=f059e82414ebec860341fb1ad68c3b60"

#Run FTP commands from text file
#ftp -n < ~/Desktop/ftpscripts.txt

#This removes the mail that is sent when cron job is finished from previous day (not needed)
rm -r /var/mail/
