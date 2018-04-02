#!/bin/sh
i=0
while [ $i -lt 138 ]
do
  i=`expr $i + 1`
  /usr/bin/curl https://ic.glafir.ru/weathers/weather_grub
done
