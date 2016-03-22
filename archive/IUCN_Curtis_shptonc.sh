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

ncrename -vz,mask Birds/nc/*.nc



gmt grdmask -Rglobal_land_tmp.nc?atmat -f0x -f1y -NNaN/1/1 Birds/gmt/Acrocephalus_arundinaceus_22714745.gmt -GBirds/nc/Acrocephalus_arundinaceus_22714745.nc




ncrename -vz,mask ${folder}species.nc
cp ${folder}species.nc "${folder}IUCN_${filename}.nc"
done


ogr2ogr -f "GMT" -dim 3 gmt/Zosterops_xanthochroa_22714246.gmt shp/Zosterops_xanthochroa_22714246.shp

gmt grdmask -R-179.5/179.5/-89.5/89.5 -I1 -f0x -f1y -NNaN/1/1 gmt/Zosterops_xanthochroa_22714246.gmt -Gnc/^^_22714246.nc

ncrename -vz,mask Zosterops_xanthochroa_22714246.nc


ogrinfo -al shp/Zosterops_xanthochroa_22714246.shp