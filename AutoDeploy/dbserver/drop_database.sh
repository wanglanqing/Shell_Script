#/bin/sh

# MySQL
echo 'drop hydt_bcm/hydt_bcm_act/ofdb'

export MYSQL_HOST=$ETH0_IP
export MYSQL_ROOT_PASS=iHYDTxx
export MYSQL_HYDT_BCM_PASS=hydt_xx

#删除pe数据库
actsql='drop database hydt_bcm_act;'
mysql -uhydt_bcm -p${MYSQL_HYDT_BCM_PASS} -h localhost -Dhydt_bcm -e "${actsql}"

#删除bcm数据库
bcmsql='drop database hydt_bcm;'
mysql -uhydt_bcm -p${MYSQL_HYDT_BCM_PASS} -h localhost -Dhydt_bcm -e "${bcmsql}"

#删除openfire数据库
ofdbsql='drop database hydt_ofdb;'
mysql -uhydt_bcm -p${MYSQL_HYDT_BCM_PASS} -h localhost -Dhydt_bcm -e "${ofdbsql}"
