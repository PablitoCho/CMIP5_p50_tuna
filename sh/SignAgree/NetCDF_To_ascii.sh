#!/bin/sh
rm /Data/Projects/CMIP5_p50/modelmean/signagree.txt

while IFS=, read -r species p50 deltaH
do

ncks -F -v SIGNAGREE_5DEG /Data/Projects/CMIP5_p50/modelmean/signagree.5deg.deltap50depth.${species}.nc | awk '$3 ~ /=1/' > /Data/Projects/CMIP5_p50/modelmean/signagree.txt

awk -F'[ =]' '{print $2 "," $4}' /Data/Projects/CMIP5_p50/modelmean/signagree.txt > /Data/Projects/CMIP5_p50/modelmean/signagree.${species}.csv

rm /Data/Projects/CMIP5_p50/modelmean/signagree.txt

done
