#!/bin/sh
rm geostats.jnl
rm /Data/Projects/CMIP5_p50/ESM2G/esm2g_p50depthav_area_rcp8.5.txt

while IFS=, read -r species p50 deltaH
do

      echo "SET DATA \"/Data/Projects/CMIP5_p50/ESM2G/${species}/p50depth/esm2g.rcp85.p50depth.${species}.nc\", \"/Data/CMIP5/climdiff/WOA_modeldiff_rcp8.5/ESM2G_rcp8.5_temp.nc\"" > geostats.jnl

      echo "Let p50depthav = p50depth[d=1, l=@ave]" >> geostats.jnl

      echo "Let p50deptharea = p50depthav*0+1" >> geostats.jnl

	echo "Let ocean = temp_rcp[d=2, l=@ave]*0+1" >> geostats.jnl

      echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/ESM2G/esm2g_p50depthav_area_rcp8.5.txt\"/format=tab/append \"rcp8.5\", \"${species}\", ${p50}, ${deltaH}, ocean[x=@din, y=@din, k=1], p50deptharea[x=@din, y=@din], p50depthav[x=@ave, y=@ave], p50depthav[x=@var, y=@var], p50depthav[x=@ngd, y=@ngd]" >> geostats.jnl

      echo "quit" >> geostats.jnl

      ferret <  geostats.jnl > ferret_out.txt

      rm ferret.jnl*

done
