3deploy_web.sh


#!/bin/sh

##############################
#远程调用数据库服务器脚本文件#
##############################

#web应用服务器地址
Web_Server = 123.57.155.xx

echo '[INFO] Deploy web service , PE/APPGW/CSSS/MDS/AE.'
ssh root@$Web_Server "deploy.sh"

echo '[INFO] Deploy web service is finished!'
