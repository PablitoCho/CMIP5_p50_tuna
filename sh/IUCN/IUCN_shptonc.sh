#!/bin/sh

mkdir data/IUCN/nc

for folder in data/IUCN/species_*/
do
echo "$folder"
ogr2ogr -f "GMT" -dim 3 ${folder}species.gmt ${folder}*.shp
filename="$(awk -F "\"" 'FNR==9 {print$2}' ${folder}species.gmt | sed -e 's/ /_/g')"
gmt grdmask -R-179.5/179.5/-89.5/89.5 -I1 -f0x -f1y -NNaN/1/1 ${folder}species.gmt -G${folder}species.nc
ncrename -vz,mask ${folder}species.nc
cp ${folder}species.nc "data/IUCN/nc/IUCN_${filename}.nc"
done