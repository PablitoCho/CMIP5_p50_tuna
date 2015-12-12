#!/bin/sh
rm geostats.jnl
rm /Data/Projects/CMIP5_p50/CESM1/cesm1_p50depthav_area_rcp8.5.txt

while IFS=, read -r species p50 deltaH
do

for model in cesm1 esm2g esm2m hadgem2 ipsl mpi
do

      echo "SET DATA \"/Data/Projects/CMIP5_p50/${model}/${species}/p50depth/${model}.rcp85.p50depth.${species}.nc\", \"/Data/CMIP5/climdiff/WOA_modeldiff_rcp8.5/${model}_rcp8.5_temp.nc\"" > geostats.jnl

      echo "Let p50depthav = p50depth[d=1, l=@ave]" >> geostats.jnl

      echo "Let p50deptharea = p50depthav*0+1" >> geostats.jnl

      echo "Let p50depthav_deltaH0 = p50depth_deltaH0[d=1, l=@ave]" >> geostats.jnl

      echo "Let p50deptharea_deltaH0 = p50depthav_deltaH0*0+1" >> geostats.jnl

      echo "Let ocean = temp_rcp[d=2, l=@ave]*0+1" >> geostats.jnl

      echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/${model}/${model}_p50depthav_area_rcp8.5.txt\"/format=tab/append \"rcp8.5\", \"${species}\", ${p50}, ${deltaH}, ocean[x=@din, y=@din, k=1], p50deptharea[x=@din, y=@din], p50deptharea_deltaH0[x=@din, y=@din], p50depthav[x=@ave, y=@ave], p50depthav[x=@var, y=@var], p50depthav[x=@ngd, y=@ngd]" >> geostats.jnl

      echo "quit" >> geostats.jnl

      ferret <  geostats.jnl > ferret_out.txt

      rm ferret.jnl*

done
done