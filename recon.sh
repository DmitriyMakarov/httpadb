#!/bin/bash


devfile=devices.list
snfile=sn.list
if [ -f $devfile ]; then 
rm $devfile;
fi
if [ -f $snfile ]; then 
rm $snfile;
fi
adb devices >> $devfile
sed '1s/List of devices attached//' $devfile >> rem
sed '1,3s/device//g' rem >> $snfile
rm rem

IFS=$'\r\n' GLOBIGNORE='*' command eval 'snarray=($(cat $snfile))'


# adb -s ${snarray[0]} shell svc data disable
# adb -s ${snarray[1]} shell svc data disable
# sleep 5
# adb -s ${snarray[0]} shell svc data enable
# adb -s ${snarray[1]} shell svc data enable
# 
# if [ -f $devfile ]; then 
# rm $devfile;
# fi
# if [ -f $snfile ]; then 
# rm $snfile;
# fi

for i in ${!snarray[@]}; do
  adb -s ${snarray[$i]} shell svc data disable
  sleep 3
  adb -s ${snarray[$i]} shell svc data enable
done

if [ -f $devfile ]; then 
rm $devfile;
fi
if [ -f $snfile ]; then 
rm $snfile;
fi
