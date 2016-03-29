#!/bin/sh

for SHPfile in Birds/shp/*.shp
do
ogr2ogr -f "GMT" -dim 3 ${SHPfile%.*}.gmt ${SHPfile}
done

mv Birds/shp/*.gmt Birds/gmt

for GMTfile in Birds/gmt/*.gmt
do
gmt grdmask -Rglobal_land_tmp.nc?atmat -f0x -f1y -NNaN/1/1 ${GMTfile} -G${GMTfile%.*}.nc
done

mv Birds/gmt/*.nc Birds/nc

for ncfile in Birds/nc/*.nc
do
ncrename -vz,mask ${ncfile}
done

