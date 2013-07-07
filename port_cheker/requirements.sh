source ./port_checker_common
mymail="example@example.ru"

whatis `get_net_cat_name` | mailx -s "Port_checker requirements" $mymail
