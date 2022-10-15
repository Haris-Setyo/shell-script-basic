#!/bin/sh

temp0=log/sctemp.log
date=`date +%B-%d-%Y`
ip=192.168.100.29
user=flylxy
#read -p "enter server ip address: " ip

#read -p "enter server user: " user

./src/service.expect $ip $user | egrep -v 'Welcome|spawn|@|Super|apt|https' >> $temp0


j1=`cat $temp0 | grep '\[ + \]'| wc -l` 
j2=`cat $temp0 | grep '\[ - \]'| wc -l` 
j3=`cat $temp0 | grep '\[ ? \]'| wc -l`
t1=`expr $j1 + $j2 + $j3`

h1=`cat $temp0 | grep '\[ + \]'` 
h2=`cat $temp0 | grep '\[ - \]'` 
h3=`cat $temp0 | grep '\[ ? \]'`

simp(){
echo "==============================================="
echo "=== Total Service at $ip : $t1 ===="
echo "==============================================="
echo "number of service status is running $j1 "
echo "==============================================="
echo "$h1"
echo "==============================================="
echo "number of service status not running $j2 "
echo "==============================================="
echo "$h2"
echo "==============================================="
echo "number of service state cannot be determined $j3 "
echo "==============================================="
echo "$h3"
echo "==============================================="
}
simp;
simp > log/Checkservice$date.log

rm -f $temp0
