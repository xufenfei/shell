#!/bin/bash
cd /home/tomcat/webapps/
rm -rf abc.war abc

rsync -ave ssh abc.war /home/tomcat/webapps/ >/dev/null

ps -ef | grep -v tomcat7 | grep tomcat | grep -v grep | awk '{print $2}' | xargs kill -9

sleep 30

sh /home/tomcat/bin/startup.sh  > /dev/null

sleep 30

RET=`curl -o /dev/null -s -w %{http_code} http://abc.cctv.com/abc/login`

[[ $RET == 200 ]] && echo "Test500: Update abc.war: OK;  Website: Running." | mail -s "Test500 OK." abc@cctv.com || echo "test500 update abc.war/Website Failed" | mail -s "Test500 update Failed" abc@cctv.com
