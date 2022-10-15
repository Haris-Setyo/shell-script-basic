#!/bin/bash

date=`date +%B-%d-%Y-%H:%M`
logfile=/home/haris/Documents/belajar-shell-script/shell_haris/shell-mysql/log/mysql$date.csv


mysql --defaults-extra-file=/path/to/my.cnf <<EOF > $logfile
USE ig_clone
source /home/haris/Documents/latihan-mysql/instagram/coba1.sql
quit
EOF
