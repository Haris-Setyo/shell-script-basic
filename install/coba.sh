#!/bin/sh

log=log/listinstall.log
ins=log/temp.txt
p=log/0temp.log
h=log/hasil.log
h1=log/jumlah.log
m=log/cek.log
date=`date +%B-%d-%Y-%H:%M`
t=log/hasil$date.log

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

read -p "What your choise installing? " packet

case $packet in

    "1")
    cat src/1.txt > $ins
    ;;

    "2")
    cat src/2.txt > $ins
    ;;
    * ) echo "Please answer 1 or 2, when you dont know packed contact your admin"
    exit;;
esac



while read line
do
    echo $line > $p
    pi=`cat $p | awk '{print $1}'`
    
    sudo apt-get install $pi -y | grep -A1 NEW >> $h
    
    perl -p -i -e "s/\r//g" $h

    cat $h | sed '2!D' >>$log

    
    
    

> $h
> $p

done < $ins

clear



echo "---------List Install------------"
echo "already install"
cat $log
echo "---------------------------------"


while true
do
    read -p "do you check packed? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

kop(){
echo "=================================================================================="
echo `date +%B-%d-%Y-%H:%M`
echo "=================================================================================="
echo "list-package" 
echo "=================================================================================="
}
kop; 
kop >> $t

while read line
do
    apt list | awk '/'$line'.*installed/' > $m

    perl -p -i -e "s/\r//g" $m

    isi(){
    echo "$line" 
    echo "----------------------------------------------------------------------------------"
    cat $m 
    echo "=================================================================================="
    }
    isi;
    isi >> $t


done <$log


clear 
cat $t



