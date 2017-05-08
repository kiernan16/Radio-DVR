#!/bin/bash

DATE=$(date +%A)

curl -o /Library/WebServer/Documents/radio/redeye/$DATE.mp3 -m 11000 "http://65.19.131.138/foxnewsradio-foxnewsaac-ibc2?session-id=f059e82414ebec860341fb1ad68c3b60-72717670336c67316c73683134633869&source=v6player&sbmd=1&user-id=f059e82414ebec860341fb1ad68c3b60"


#This removes the mail that is sent when cron job is finished from previous day (not needed)
rm -r /var/mail/
