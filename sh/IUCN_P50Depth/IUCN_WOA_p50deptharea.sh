#!/bin/sh
rm geostats.jnl
rm /Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area.txt

while IFS=, read -r species p50 deltaH
do

      echo "SET DATA \"/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN.WOA.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/IUCN/nc/IUCN_${species}.nc\", \"/Data/WOA/WOA_temp/temperature_monthly_1deg.nc\"" > geostats.jnl

      echo "Let p50deptharea = GEOGP50ZAV[d=1]*0+1" >> geostats.jnl

      echo "Let habitatarea = mask[d=2]*0+1" >> geostats.jnl

      echo "Let ocean = t_an[d=3, l=@ave]*0+1" >> geostats.jnl

      echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area.txt\"/format=tab/append \"WOA\", \"${species}\", ${p50}, ${deltaH}, ocean[x=@din, y=@din, k=1], habitatarea[x=@din, y=@din], p50deptharea[x=@din, y=@din], GEOGP50ZAV[d=1, x=@ave, y=@ave], GEOGP50ZAV[d=1, x=@var, y=@var], GEOGP50ZAV[d=1, x=@ngd, y=@ngd]" >> geostats.jnl

      echo "quit" >> geostats.jnl

      ferret <  geostats.jnl > ferret_out.txt

      rm ferret.jnl*

done
