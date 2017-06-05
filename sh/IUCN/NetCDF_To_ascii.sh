#!/bin/sh

mkdir data/IUCN/csv_5deg

while IFS=, read -r species p50 deltaH
do

ncks -F -v MASK_5DEG data/IUCN/nc_5deg/IUCN_5deg_${species}.nc | awk '$3 ~ /=1/' > data/IUCN/csv_5deg/IUCN_5deg_${species}.txt

awk -F'[ =]' '{print $2 "," $4}' data/IUCN/csv_5deg/IUCN_5deg_${species}.txt > data/IUCN/csv_5deg/IUCN_5deg_${species}.csv

rm data/IUCN/csv_5deg/IUCN_5deg_${species}.txt

done
