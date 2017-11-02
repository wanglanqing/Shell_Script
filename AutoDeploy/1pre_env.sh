#!/bin/sh
#######################
#1.停止tomcat、ae、mds服务；
#2.删除旧文件；
#######################

#tomcat服务器地址
Web_Server=123.57.155.12

#数据库服务器地址
DB_Server=123.57.56.121

echo '[INFO] Shutdown tomcat/mds/aess/openfire Services.'
ssh root@$Web_Server "stop services.sh"

echo '[INFO] Delete last WEB_build message.'
ssh root@$Web_Server "del_old_webfiles.sh"

echo '[INFO] Delete drop existent databases.'
ssh root@$DB_Server "del_old_DBfiles.sh"

echo '[INFO] Prepare env is finished! Pls excute 1copy_bulid.sh !'