2deploy_db.sh

#!/bin/sh

##############################
#远程调用数据库服务器脚本文件#
##############################

#数据库服务器地址
DB_Server = 123.57.56.1xx

echo '[INFO] Drop database/tables.'
ssh root@$DB_Server "drop_database.sh"

echo '[INFO] Deploy DB , Create database/tables.'
ssh root@$DB_Server "deploy.sh"

echo '[INFO] Deploy DB is finished!'