#!/bin/sh

while IFS=, read -r species p50 deltaH
do

ncks -F -v MASK_5DEG /Data/Projects/CMIP5_p50/IUCN/nc_5deg/IUCN_5deg_${species}.nc | awk '$3 ~ /=1/' > /Data/Projects/CMIP5_p50/IUCN/csv_5deg/IUCN_5deg_${species}.txt

awk -F'[ =]' '{print $2 "," $4}' /Data/Projects/CMIP5_p50/IUCN/csv_5deg/IUCN_5deg_${species}.txt > /Data/Projects/CMIP5_p50/IUCN/csv_5deg/IUCN_5deg_${species}.csv

rm /Data/Projects/CMIP5_p50/IUCN/csv_5deg/IUCN_5deg_${species}.txt

done
