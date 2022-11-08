#!/bin/sh
date=`date +%B-%d-%Y`

tar -cvf ~/Documents/github/github_shell/backup/backup_github_$date.rar ~/Documents/github/ 2>/dev/null
exit 0
