printf "关闭并屏蔽服务firewalld."
systemctl stop firewalld > /dev/null 2>&1
systemctl mask firewalld > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "安装zabbix3.4.2源......."
yum -y install http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "安装zabbix-agent........"
yum -y install zabbix-agent > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "更改zabbix-agent配置文件"
sed  -i "s/Server=127.0.0.1/Server=192.168.1.120/g" /etc/zabbix/zabbix_agentd.conf
sed  -i "s/ServerActive=127.0.0.1/ServerActive=192.168.1.120/g" /etc/zabbix/zabbix_agentd.conf
sed  -i "s/# HostMetadataItem=/HostMetadataItem=system.uname/g" /etc/zabbix/zabbix_agentd.conf
sed  -i "s/# HostnameItem=system.hostname/HostnameItem=system.hostname/g" /etc/zabbix/zabbix_agentd.conf
sed  -i "s/Hostname=Zabbix server/# Hostname=Zabbix server/g" /etc/zabbix/zabbix_agentd.conf
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "设置zabbix-agent自启动.."
systemctl enable zabbix-agent > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]"

printf "启动zabbix-agent服务...."
systemctl restart zabbix-agent > /dev/null 2>&1
printf "\033[32;1m%20s\033[0m\n" "[ OK ]" 