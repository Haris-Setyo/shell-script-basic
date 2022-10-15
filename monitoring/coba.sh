#!/bin/sh

temp=temp0.log
tempdata=tempd.log
list=inventory.txt
date=`date +%Y-%m-%d`

lines=`cat $list | wc -l`

kop(){
echo "======================================================"
echo "============== jumlah server = $lines ================"
echo "======================================================"

echo `date +%B-%d-%Y-%H:%M`
echo "Server" "IP" "hostname" "Version" "Ram(|)" "Disk(|)" "Product" | awk '{printf "%-15s %-15s %-14s %-16s %-14s %-18s %-6s\n",$1,$2,$3,$4,$5,$6,$7}' 
echo "--------" "------------" "-----------" "----------" "------------" "---------" "-------------------------" | awk '{printf "%-10s %-18s %-15s %-15s %-15s %-12s %-6s\n",$1,$2,$3,$4,$5,$6,$7}'
}
kop;
kop >> log/checkserver$date.log


while read line
do
    echo $line > $temp
    ansible -i temp0.log -m setup -a 'filter=ansible_product_name' all > log/pro.log
    ansible -i temp0.log -m setup -a 'filter=ansible_distribution' all > log/dis.log
    ansible -i temp0.log -m setup -a 'filter=ansible_distribution_version' all > log/ver.log
    ansible -i temp0.log -m setup -a 'filter=ansible_memory_mb' all > log/mem.log
    ansible -i temp0.log -m shell -a 'df -h' all > log/df.log

    ser=`cat $temp | awk '{print $1}'`
    ips=`cat $temp |  awk '{print $2}' | tr -d "ansible_host="`
    host1=`cat temp0.log |  awk '{print $3}' | sed 's/ansible_user=//g'`
    pro=`cat log/pro.log | grep ansible_product_name | awk '{print $2"-"$3"-"$4}' | tr -d '"|,'`
    dis=`cat log/dis.log | grep ansible_distribution | awk '{print $2}' | tr -d '"|,'`
    ver=`cat log/ver.log | grep ansible_distribution_version | awk '{print $2}' | tr -d '"|,'`
    mem1=`cat log/mem.log| sed '10!D' | awk '{print $2 "MB"}' | tr -d ','`
    mem2=`cat log/mem.log | sed '11!D' | awk '{print $2 "MB"S}' | tr -d ','`
    disk=`cat log/df.log | grep -w "/" | awk '{print $2"|"$5}'`

    echo $ser"   "$ips"     "$host1"    "$dis"_"$ver "   "$mem1"|"$mem2 "  "$disk"   "$pro"    " > $tempdata

	wait

        sed -i '/^[[:space:]]*$/d' $tempdata
	#echo  $name" "$ip" "$host" "$mem > $tempdata
	#cat $tempdata 
	awk '{printf "%-10s %-20s %-13s %-15s %-16s %-12s %-6s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9}' $tempdata
        awk '{printf "%-10s %-20s %-13s %-15s %-16s %-12s %-6s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9}' $tempdata >> log/checkserver$date.log


>$temp
>$tempdata

done <$list
