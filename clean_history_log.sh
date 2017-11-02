#/bin/bash

#定义各日志的工作目录
aess_logpath="/BCM/bcm-aess/logs/bcm-aess"
mds_logpath="/BCM/bcm-mds/logs/bcm-mds"
tomcat_path="/BCM/apache-tomcat-7.0.68/logs"
gw_path="/BCM/apache-tomcat-7.0.68/logs/bcm-appgw"
csss_path="/BCM/apache-tomcat-7.0.68/logs/bcm-csss"
pe_path="/BCM/apache-tomcat-7.0.68/logs/bcm-pess"

#获取服务器时间，确定要删除日志的月份
current_year=`date +"%Y"`
current_month=`date +"%m"`
last_month=$[$current_month-1]
last_year=$[$current_year-1]
curren_time=`date`

#定义logfile
logfile="/home/hydt/clean_historylog.log"

if [ ! -f "$logfile" ]; then 
#if [ ! -x "$myPath"]; then 
	touch $logfile
fi

echo "========== 本次清理时间为：$curren_time ==========" >>$logfile
echo "当前为$current_month月，将清除$last_month的历史日志" >>$logfile
echo "清除前的磁盘使用情况如下：">>$logfile
df -h >>$logfile

#删除AE的日志文件
cd $aess_logpath
if [ $current_month -eq 01 ]; then
	aess_count=`find ./ -name "*$last_year*"|wc -l `
	echo " ">>$logfile
	echo "1. 将要删除aess应用$last_year,即去年的日志文件,共计$aess_count个文件" >>$logfile
	rm -rf *$last_year*
	aess_count=`find ./ -name "*$last_year*"|wc -l ` >>$logfile	
fi
if [[ $current_month -gt 01  &&  $current_month -lt 11 ]]; then
	aess_count=`find ./ -name "*$current_year-0$last_month*"|wc -l `
	echo " ">>$logfile
	echo "1. 将要删除aess应用$current_year-0$last_month月份的日志文件,共计$aess_count个文件" >>$logfile
	rm -rf *$current_year-0$last_month*
	aess_count=`find ./ -name "*$current_year-0$last_month*"|wc -l ` >>$logfile	
else
	aess_count=`find ./ -name "*$current_year-$last_month*"|wc -l `
	echo " ">>$logfile
	echo "1. 将要删除aess应用$current_year-$last_month月份的日志文件,共计$aess_count个文件" >>$logfile
	rm -rf *$current_year-$last_month*
	aess_count=`find ./ -name "*$current_year-$last_month*"|wc -l ` >>$logfile			
fi	

if [ $aess_count -eq 0 ]; then
	echo "AE清理完毕" >>$logfile
else
	echo "请确认AE删除结果" >>$logfile
fi

#删除MDS的日志文件
cd $mds_logpath
if [ $current_month -eq 01 ]; then
	mds_count=`find ./ -name "*$last_year*"|wc -l `
	echo " ">>$logfile
	echo "2. 将要删除mds应用$last_year的日志文件,共计$mds_count个文件" >>$logfile
	rm -rf *$last_year*
	mds_count=`find ./ -name "*$last_year*"|wc -l ` >>$logfile	
fi
if [[ $current_month -gt 01 && $current_month -lt 11 ]]; then
	mds_count=`find ./ -name "*$current_year-0$last_month*"|wc -l `
	echo " ">>$logfile
	echo "2. 将要删除mds应用$current_year-0$last_month月份的日志文件,共计$mds_count个文件" >>$logfile
	rm -rf *$current_year-0$last_month*
	mds_count=`find ./ -name "*$current_year-0$last_month*"|wc -l ` >>$logfile		
else
	mds_count=`find ./ -name "*$current_year-$last_month*"|wc -l `
	echo " ">>$logfile
	echo "2. 将要删除mds应用$current_year-$last_month月份的日志文件,共计$mds_count个文件" >>$logfile
	rm -rf *$current_year-$last_month*
	mds_count=`find ./ -name "*$current_year-$last_month*"|wc -l ` >>$logfile		
fi	

if [ $mds_count -eq 0 ]; then
	echo "MDS清理完毕" >>$logfile
else
	echo "请确认MDS删除结果" >>$logfile
fi

#删除tomcat的日志文件
cd $tomcat_path
#find ./ -name "*-*$last_month-*"|xargs rm -rf

if [ $current_month -eq 01 ]; then
	tomcat_count=`find ./ -name "*$last_year*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除tomcat应用$last_year的日志文件,共计$tomcat_count个文件" >>$logfile
	rm -rf *$last_year*
	tomcat_count=`find ./ -name "*$last_year*"|wc -l ` >>$logfile	
fi
if [[ $current_month -gt 01 && $current_month -lt 11 ]]; then
	tomcat_count=`find ./ -name "*$current_year-0$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除tomcat应用$current_year-0$last_month月份的日志文件,共计$tomcat_count个文件" >>$logfile
	rm -rf *$current_year-0$last_month*
	tomcat_count=`find ./ -name "*$current_year-0$last_month*"|wc -l ` >>$logfile	
else
	tomcat_count=`find ./ -name "*$current_year-$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除tomcat应用$current_year-$last_month月份的日志文件,共计$tomcat_count个文件" >>$logfile
	echo "rm -rf *$current_year-$last_month*">>$logfile
	rm -rf *$current_year-$last_month*
	tomcat_count=`find ./ -name "*$current_year-$last_month*"|wc -l ` >>$logfile		
fi	

if [ $tomcat_count -eq 0 ]; then
	echo "Tomcat清理完毕" >>$logfile
else
	echo "请确认Tomcat删除结果" >>$logfile
fi

#删除bcm-gw的日志文件
cd $gw_path
#find ./ -name "*-*$last_month-*"|xargs rm -rf
if [ $current_month -eq 01 ]; then
	gw_count=`find ./ -name "*$last_year*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除gw应用$last_year的日志文件,共计$gw_count个文件" >>$logfile
#	rm -rf *-*$last_year*
	find ./ -name "*$last_year*"|xargs rm -rf
	gw_count=`find ./ -name "*$last_year*"|wc -l ` >>$logfile	
fi
if [[ $current_month -gt 01 && $current_month -lt 11 ]]; then
	gw_count=`find ./ -name "*$current_year-0$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除gw应用$current_year-0$last_month月份的日志文件,共计$gw_count个文件" >>$logfile
	rm -rf *$current_year-0$last_month*
	gw_count=`find ./ -name "*$current_year-0$last_month*"|wc -l ` >>$logfile		#statements
else
	gw_count=`find ./ -name "*$current_year-$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除gw应用$current_year-$last_month月份的日志文件,共计$gw_count个文件" >>$logfile
	rm -rf *$current_year-$last_month*
	gw_count=`find ./ -name "*$current_year-$last_month*"|wc -l ` >>$logfile		
fi	

if [ $gw_count -eq 0 ]; then
	echo "bcm-gw清理完毕" >>$logfile
else
	echo "请确认bcm-gw删除结果" >>$logfile
fi

#删除bcm-csss的日志文件
cd $csss_path
#find ./ -name "*-*$last_month-*"|xargs rm -rf
if [ $current_month -eq 01 ]; then
	csss_count=`find ./ -name "*$last_year*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除csss应用$last_year的日志文件,共计$csss_count个文件" >>$logfile
	rm -rf *$last_year*
	csss_count=`find ./ -name "*$last_year*"|wc -l ` >>$logfile	
fi
if [[ $current_month -gt 01 && $current_month -lt 11 ]]; then
	csss_count=`find ./ -name "*$current_year-0$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除csss应用$current_year-0$last_month月份的日志文件,共计$csss_count个文件" >>$logfile
	rm -rf *$current_year-0$last_month*
	csss_count=`find ./ -name "*$current_year-0$last_month*"|wc -l ` >>$logfile	
else
	csss_count=`find ./ -name "*$current_year-$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除csss应用$current_year-$last_month月份的日志文件,共计$csss_count个文件" >>$logfile
	rm -rf *$current_year-$last_month*
	csss_count=`find ./ -name "*$current_year-$last_month*"|wc -l ` >>$logfile		
fi	

if [ $csss_count -eq 0 ]; then
	echo "bcm-csss清理完毕" >>$logfile
else
	echo "请确认bcm-csss删除结果" >>$logfile
fi

#删除bcm-csss的日志文件
cd $pe_path
#find ./ -name "*-*$last_month-*"|xargs rm -rf
if [ $current_month -eq 01 ]; then
	pe_count=`find ./ -name "*$last_year*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除pess应用$last_year的日志文件,共计$pe_count个文件" >>$logfile
	rm -rf *$last_year*
	pe_count=`find ./ -name "*$last_year*"|wc -l ` >>$logfile	
fi
if [[ $current_month -gt 01 && $current_month -lt 11 ]]; then
	pe_count=`find ./ -name "*$current_year-0$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除pess应用$current_year-0$last_month月份的日志文件,共计$pe_count个文件" >>$logfile
	rm -rf *$current_year-0$last_month*
	pe_count=`find ./ -name "*$current_year-0$last_month*"|wc -l ` >>$logfile	
	#statements
else
	pe_count=`find ./ -name "*$current_year-$last_month*"|wc -l `
	echo " ">>$logfile
	echo "3. 将要删除pess应用$current_year-$last_month月份的日志文件,共计$pe_count个文件" >>$logfile
	rm -rf *$current_year-$last_month*
	pe_count=`find ./ -name "*$current_year-$last_month*"|wc -l ` >>$logfile		
fi	

if [ $pe_count -eq 0 ]; then
	echo "bcm-pess清理完毕" >>$logfile
else
	echo "请确认bcm-pess删除结果" >>$logfile
fi

echo " ">>$logfile
echo "清除后的磁盘使用情况如下：">>$logfile
df -h >>$logfile

echo "========== 本次清除完毕！========== ">>$logfile
echo " ">>$logfile
echo " ">>$logfile
