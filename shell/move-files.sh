#!/bin/bash

#use today's date and time
day=$(date +%Y-%m-%d)

#change to log directory
cd /var/log/qradar

#move and add time date to file name
mv qradar.log qradar$day.log

#load file into variable
#copy file from local to hdfs cluster

if [ -f qradar$day.log ]

then
    file=qradar$day.log
    hadoop dfs -put /var/log/qradar/$file /user/qradar
else
    echo "failed to rename and move the file into the cluster" >> /var/log/messages

fi
