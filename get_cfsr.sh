#!/bin/bash

hour=$(awk '{if ($1 == "NL%ITIME1") print substr($3, 1, 2)}' IN-CFSR)
day=$(awk '{if ($1 == "NL%IDATE1") print $3}' IN-CFSR)
year=$(awk '{if ($1 == "NL%IYEAR1") print $3}' IN-CFSR)
moth=$(awk '{if ($1 == "NL%IMONTH1") print $3}' IN-CFSR)
nday=$(awk '{if ($1 == "NL%TIMMAX") print substr($3, 1, 1)}' IN-CFSR)

echo $year$moth$day$hour $nday

hours=0
for i in $(seq 1 $((4*$nday+1)))
do
date1=$(date --date="$moth/$day/$year $hour" +'%s')
date1=$(($date1+$hours)) # (date --date="$moth/$day/$year $hour" +'%s')
#date2=$(date -d @$date1 +"%Y%m%d%H")
hours=$(($hours+21600))
#echo $date2 $(date -d @$date1 +"%Y%m")

wget -c  http://nomads.ncdc.noaa.gov/modeldata/cmd_pgbh/$(date -d @$date1 +"%Y")/$(date -d @$date1 +"%Y%m")/$(date -d @$date1 +"%Y%m%d")/pgbh00.gdas.$(date -d @$date1 +"%Y%m%d%H").grb2
done
