cat > /etc/logrotate.d/rabbitmq-server << EOF
/var/log/rabbitmq/*.log {
	# ежедневная ротация
	daily
	# отсутствие файла не является ошибкой
	missingok
	# хранится история за 30 дней
	rotate 30
	# ротируемые файлы сжимаются
	compress
	# ротируемый файл не сжимается, остальные - сжимаются
	delaycompress
	# не обрабатывать пустые файлы
	notifempty
	# prerotate/postrotate выполняются только 1 раз
	sharedscripts
	postrotate
		/sbin/service rabbitmq-server rotate-logs > /dev/null
	endscript
}	                
EOF