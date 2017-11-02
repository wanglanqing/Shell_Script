#/bin/sh
#1.部署aess
#2.部署mds
#3.部署pess、appgw、csss

tomcat_path='/BCM/apache-tomcat-7.0.63'
mds_path='/BCM/MDS/bcm-mds'
aess_path='/BCM/MDS/bcm-aess'
openfire_path='/opt/openfire/plugins'


#deploy aess
echo '[INFO] Deploy AESS!'
cd $aess_path

#解压aess安装包
aess_name=`ls *.tar`
tar -xvf $aess_name
aess_jarname=`ls *.jar`
echo ''

#启动aess服务
echo '[INFO] Start AESS!'
sh bcm-aess.sh start

#查aess的进程个数
aess_ac=`ps -ef|grep bcm-aess|grep -v 'grep'|wc -l`
if [ $aess_ac -eq 0 ]; then
        echo 'start aess failed!'
    else
        echo 'start aess successed!'
fi

#delpoy mds
echo '---------------------------'
echo '[INFO] Deploy mds'
cd $mds_path
#解压mds安装包
mds_name=`ls *.tar`
tar -xvf $mds_name
mds_jarname=`ls *.jar`
echo ''
echo '[INFO] Start mds!'

sh bcm-mds.sh start

#查aess的进程个数
mds_ac=`ps -ef|grep bcm-mds|grep -v 'grep'|wc -l`
if [ $mds_ac -eq 0 ]; then
        echo 'start mds failed!'
    else
        echo 'start mdss successed!'
fi


#delpoy web applications

echo '---------------------------'
echo '[INFO] Deploy pess/appgw/csss'
#获得各应用的版本号
cd $tomcat_path
pess_version=`ls BCM-PESS-*.war|sed 's/BCM-PESS-//'|sed 's/\.war//'`
appgw_version=`ls BCM-APPGW-*.war|sed 's/BCM-APPGW-//'|sed 's/\.war//'`
csss_version=`ls BCM-CSSS-*.war|sed 's/BCM-CSSS-//'|sed 's/\.war//'`

chmod +x ./bin/bcm_tomcat*.sh

sed -i '/^tail -f/'d ./bin/bcm_tomcat_appgw_deploy.sh 
#sed -i '/^tail -f/'d ./bin/bcm_tomcat_pess_deploy.sh 
#sed -i '/^tail -f/'d ./bin/bcm_tomcat_csss_deploy.sh

./bin/bcm_tomcat_appgw_deploy.sh $appgw_version

kill -9 `ps -ef|grep tomcat|grep -v 'grep'|awk '{print $2}'`
./bin/bcm_tomcat_csss_deploy.sh $csss_version

kill -9 `ps -ef|grep tomcat|grep -v 'grep'|awk '{print $2}'`
./bin/bcm_tomcat_pess_deploy.sh $pess_version

#检查有是否备份成功
DATE=`date +%Y%m%d`
bak_ac=`ls -l $tomcat_path/bak/|grep $DATE|wc -l`
if [ $bak_ac -eq 3 ]; then
        echo '共有【'$bak_ac'】个备份文件，部署成功'
else
        echo '共有【'$bak_ac'】个文件部署失败，请进行检查'
fi


#启动openfire
#将  <setup>true</setup>中的true，修改为false。
sed -i 's/''>'true'<''/''>'false'<''/g' /opt/openfire/conf/openfire.xml
#cat /opt/openfire/conf/openfire.xml
service openfire start