#!/bin/bash

kill -9 `ps -ef|grep bcm-aess|grep -v 'grep'|awk '{print $2}'`
kill -9 `ps -ef|grep bcm-mds|grep -v 'grep'|awk '{print $2}'`
kill -9 `ps -ef|grep tomcat|grep -v 'grep'|awk '{print $2}'`
service openfire stop
