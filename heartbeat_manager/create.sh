ln -s /etc/ha.d
ln -s /var/lib/heartbeat/crm/
ln -s /var/log/ha-debug
ln -s /var/log/ha-log
ln -s /usr/share/ocf/resource.d
ln -s /usr/lib/ocf/resource.d ./resource.d.pace 

touch ./hb_start.sh
echo "/sbin/service heartbeat start" | tee -a ./hb_start.sh

touch ./hb_stop.sh
echo "/sbin/service heartbeat stop" | tee -a ./hb_stop.sh
    
touch ./make_xml_conf.sh
rm /var/lib/heartbeat/crm/*
echo "python /usr/lib/heartbeat/haresources2cib.py /etc/ha.d/haresources" | tee -a ./make_xml_conf.sh
    
touch ./rm_log.sh
echo "rm /var/log/ha-debug" | tee -a ./rm_log.sh
echo "rm /var/log/ha-log" | tee -a ./rm_log.sh

chmod 766 *.sh
