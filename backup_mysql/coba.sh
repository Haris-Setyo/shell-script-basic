#!/bin/sh

date=`date +%B-%d-%Y-%H:%M`

mysqldump join_us --user root --password=(passmyql) --result-file=/home/haris/Documents/belajar-shell-script/shell_haris/backupmysql/backup/joinus$date.sql

#join_us is my db
