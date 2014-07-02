d=`date +"%y%m%d_%T"`
#log_path=/var/log/rabbitmq
log_path=/opt/log/rabbitmq

sudo /usr/sbin/rabbitmqctl rotate_logs ."${d//:/}"_old.log

mv ${log_path}/shutdown_err ${log_path}/shutdown_err."${d//:/}"_old.log
mv ${log_path}/shutdown_log ${log_path}/shutdown_log."${d//:/}"_old.log
mv ${log_path}/startup_err ${log_path}/startup_err."${d//:/}"_old.log
mv ${log_path}/startup_log ${log_path}/startup_log."${d//:/}"_old.log

sudo mv ${log_path}/*_old.log ${log_path}/old
sudo mv ${log_path}/*.log.* ${log_path}/old

sudo /sbin/service rabbitmq-server stop

#tail -f --lines=40 /var/log/rabbitmq/startup_log
#tail -f --lines=40 /var/log/rabbitmq/rabbit@`hostname`.log
