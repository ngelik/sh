#!/bin/bash

#nc, netcat, ncat, pnetcat
#Хост, который хотим мониторить
#host1=10.19.1.19
monitoring=('10.1.5.39:22' '10.1.3.220:21,20080' '10.1.2.221:21,22,33080') 

#Порты, которые хотим мониторить на хосте
ports1="22 21 33444 33080"

#Путь к лог файлу
port_cheker_log="./port_cheker.log"

#Имя клиента, которого мониторим
client="Test1"
#Интервал мониторинга
interval="1"
#Единица интервала мониторинга - s, m, h, d
interval_unit="m"
#Число писем, что будет отправлено, если связь потеряна
#Время между отправкой писем расчитывается так:
# (${interval}${interval_unit})*#номер попытки проверки
#Пример: interval=5s, тогда письма придут так (номер проверки - интревал) 1 - 5s, 2 - 10s, 3 - 15s,...
message_count=5

#Шлем ли вообще письмо либо просто пишем в лог (debug-режим) true | false
sendme_mail="true"
#Кому шлем ругательства (пользователи через пробел)
mail_list="example1@example.ru example2@example.com"
#Тема пиьсма
msg_subj="${client} Мониторинг."
#Шаблон содержимого первого письма
msg_first_body="Мониторинг ${client}  запущен: ${monitoring[@]}	. Интервал - ${interval}${interval_unit}"


#Шаблон содержимого письма-уведомления
msg_body="Звонить президенту!"


#**********************************************************************************
# Выполняем мониторинг
. port_checker_main "${monitoring}" "${ports1}" "${interval}" "${interval_unit}" "${client}" ${message_count} "${mail_list}" "${msg_subj}" "${msg_first_body}" "${msg_body}" "${port_cheker_log}" "${sendme_mail}"