#!/bin/bash
DIR="/home/moodle2/moodle_backup"
mkdir -p $DIR

TIMENAME=`date +%d.%m.%Y-%H.%M.%S`
LOG=./moodle_backup/logs/moodle_$TIMENAME.log
LOG_ERR=./moodle_backup/logs/moodle_$TIMENAME.err.log

{
    echo "backup has been started at $TIMENAME"
    #service mysql stop
    mysqldump -umoodle -pmoodle moodle --lock-tables | gzip -c > "$DIR/moodle-$TIMENAME-db.dump.gz"
    #service mysql start
    echo "backup has been finished at $TIMENAME"
} > $LOG 2> $LOG_ERR
