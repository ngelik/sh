# shows where you are
# ls -lrt -d -1 $PWD/*

# **********************************************************************************
# Only for RHEL 5.9 x64
# **********************************************************************************

#rm [!rabbit_manager.sh]*

function cp_rabbit_help_files {
    cp /home/rabbit/mycommands_rabbit/RabbitMq_*.sh /home/rabbit/
}

function get_info {
    echo "********************************************************"
    echo `cat /etc/redhat-release`
    echo `rpm -q redhat-release`
    echo "`uname -a`"
    echo `erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell`
    echo "********************************************************"
}

function cp_cookie {
    local d=`date +"%y%m%d_%T"`
    ./RabbitMq_stop.sh
    mv /var/lib/rabbitmq/.erlang.cookie /var/lib/rabbitmq/.erlang.cookie."${d//:/}".bak
    cp ./.erlang.cookie /var/lib/rabbitmq/
    chown rabbitmq /var/lib/rabbitmq/.erlang.cookie
    ./RabbitMq_start.sh

    rabbitmqctl cluster_status
}

function remove_from_claster {
    rabbitmqctl stop_app
    rabbitmqctl reset
    rabbitmqctl start_app

    rabbitmqctl cluster_status
}

function add_to_cluster {
    cp_cookie

    rabbitmqctl stop_app
    rabbitmqctl join_cluster $1
    rabbitmqctl start_app

    rabbitmqctl cluster_status
}

function add_users_man {
    #add monitor user
    rabbitmqctl add_vhost monitor
    rabbitmqctl add_user monitor_user monitor_pwd
    rabbitmqctl set_permissions -p monitor monitor_user ".*" ".*" ".*"
    rabbitmqctl set_user_tags monitor_user monitoring

    #add admin user
    rabbitmqctl add_vhost admin
    rabbitmqctl add_user admin  admin
    rabbitmqctl set_permissions -p admin admin ".*" ".*" ".*"
    rabbitmqctl set_user_tags admin  administrator

    #add mangm user
    rabbitmqctl add_vhost user
    rabbitmqctl add_user user user
    rabbitmqctl set_permissions -p user user ".*" ".*" ".*"
    rabbitmqctl set_user_tags user management
}

#use: add_user_app vhost user pwd
function add_user_app {
    rabbitmqctl add_vhost $1
    rabbitmqctl add_user $2 $3
    rabbitmqctl set_permissions -p $1 $2 ".*" ".*" ".*"
    rabbitmqctl set_user_tags $2 app
}

# *********************************************************************************

#get_info
#cp_rabbit_help_files
#cp_cookie
#add_to_cluster rabbit@vm-rabbitmq-n1
#remove_from_claster

#add_users_man
#add_user_app Usp-PC-PCentre.dev usp_mqp_entry usp_mqp_entry
