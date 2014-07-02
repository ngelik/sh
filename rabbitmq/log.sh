log_path=/opt/log/rabbitmq

tail -f --lines=40 ${log_path}/rabbit@mpay05.log

#tail -f --lines=40 ${log_path}/startup_log
#tail -f --lines=40 ${log_path}/rabbit@mpay05.log
#tail -f --lines=40 ${log_path}/startup_err
