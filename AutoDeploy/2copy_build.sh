#!/bin/sh
#######################
#分别将web应用包；
#数据库文件；
#mds和aess文件
#copy到服务器,增加openfire sql和jar包
#######################

#tomcat服务器地址
Web_Server=123.57.155.12

#数据库服务器地址
DB_Server=123.57.56.121

#数据库服务器数据库版本文件存放目录
DB_path=/home/hydt/BCM_release

#tomcat服务器tomcat的目录
Apache_path=/BCM/apache-tomcat-7.0.63

#tomcat服务器MDS的目录
MDS_path=/BCM/MDS/bcm-mds/

#tomcat服务器AESS的目录
AESS_path=/BCM/MDS/bcm-aess/

#22服务器编辑打包路径
Build_path=/home/hydt/BCM/bcm-csss-V0.0.18

#openfrie 插件路径
Openfire_path='/opt/openfire/plugins'

echo '[INFO]切换到打包目录'
cd  $Build_path

echo '[INFO]开始复制数据库文件'
scp -r activiti/ root@$DB_Server:$DB_path
scp bcm_* root@$DB_Server:$DB_path
cd $Build_path/openfire
scp *.sql root@$DB_Server:$DB_path

echo '[INFO]开始复制web应用文件'
cd bcmp_build/out/
scp *.war root@$Web_Server:$Apache_path
scp bcm_tomcat* root@$Web_Server:$Apache_path/bin/
scp bcm-aess*.tar root@$Web_Server:$AESS_path
scp bcm-mds*.tar root@$Web_Server:$MDS_path

echo '[INFO]开始复制openfire 插件'
scp $Build_path/openfire/plugins/* root@$Web_Server:$Openfire_path

echo '[INFO] Copy Build files is finished!'