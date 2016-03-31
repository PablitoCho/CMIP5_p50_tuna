#!/bin/sh
rm geostats.jnl
rm /Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area_200_tropics.txt

while IFS=, read -r species p50 deltaH
do

      echo "SET DATA \"/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN.WOA.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/IUCN/nc/IUCN_${species}.nc\", \"/Data/WOA/WOA_temp/temperature_monthly_1deg.nc\", \"/Data/Projects/CMIP5_p50/WOA/${species}/p50depth/woa.p50depth.${species}.nc\"" > geostats.jnl

      echo "Let globalocean = t_an[d=3, l=@ave, k=1]" >> geostats.jnl

      echo "Let yy = y[gy=globalocean]" >> geostats.jnl

      echo "Let idlats = if (yy ge -30 and yy le 30) then 1 else 0" >> geostats.jnl

      echo "Let tropics = ignore0(idlats)" >> geostats.jnl
 
      echo "Let p50deptharea = GEOGP50ZAV[d=1]*0+1" >> geostats.jnl

      echo "Let habitatarea = mask[d=2]*0+1" >> geostats.jnl

      echo "Let ocean = t_an[d=3, l=@ave, k=1]*0+1" >> geostats.jnl

      echo "Let p50depth_200 = if p50depth[d=4] lt 200 then p50depth" >> geostats.jnl

      echo "Let p50deptharea_200 = p50depth_200[l=@ave]*0+1" >> geostats.jnl

      echo "Let HA_200 = p50deptharea_200*habitatarea" >> geostats.jnl

      echo "Let p50deptharea_t = p50deptharea*tropics" >> geostats.jnl

      echo "Let habitatarea_t = habitatarea*tropics" >> geostats.jnl

      echo "Let ocean_t = ocean*tropics" >> geostats.jnl

      echo "Let p50deptharea_200_t = p50deptharea_200*tropics" >> geostats.jnl

      echo "Let HA_200_t = HA_200*tropics" >> geostats.jnl

      echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area_200_tropics.txt\"/format=tab/append \"WOA\", \"${species}\", ${p50}, ${deltaH}, ocean_t[x=@din, y=@din], habitatarea_t[x=@din, y=@din], p50deptharea_t[x=@din, y=@din], p50deptharea_200_t[x=@din, y=@din], HA_200_t[x=@din, y=@din], GEOGP50ZAV[d=1, x=@ave, y=@ave], GEOGP50ZAV[d=1, x=@var, y=@var], GEOGP50ZAV[d=1, x=@ngd, y=@ngd]" >> geostats.jnl

      echo "quit" >> geostats.jnl

      ferret <  geostats.jnl > ferret_out.txt

      rm ferret.jnl*

done
