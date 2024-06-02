#!/bin/sh
i=1
while [ $i -lt 157 ]
do
  /usr/bin/curl -k -sS -f --connect-timeout 3 --max-time 10 https://ic.glafir.ru/weathers/weather_grub
  if [ "$?" -eq "0" ]
  then
    i=`expr $i + 1`
    continue
  else
    sleep 1
  fi
done
