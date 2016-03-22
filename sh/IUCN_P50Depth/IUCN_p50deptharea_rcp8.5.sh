#!/bin/sh
rm geostats.jnl
rm /Data/Projects/CMIP5_p50/IUCN_models/cesm1/IUCN_cesm1_p50depthav_area_rcp8.5.txt
rm /Data/Projects/CMIP5_p50/IUCN_models/esm2g/IUCN_esm2g_p50depthav_area_rcp8.5.txt
rm /Data/Projects/CMIP5_p50/IUCN_models/esm2m/IUCN_esm2m_p50depthav_area_rcp8.5.txt
rm /Data/Projects/CMIP5_p50/IUCN_models/hadgem2/IUCN_hadgem2_p50depthav_area_rcp8.5.txt
rm /Data/Projects/CMIP5_p50/IUCN_models/ipsl/IUCN_ipsl_p50depthav_area_rcp8.5.txt
rm /Data/Projects/CMIP5_p50/IUCN_models/mpi/IUCN_mpi_p50depthav_area_rcp8.5.txt

while IFS=, read -r species p50 deltaH
do

for model in cesm1 esm2g esm2m hadgem2 ipsl mpi
do

      echo "SET DATA \"/Data/Projects/CMIP5_p50/IUCN_models/${model}/IUCN.${model}.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/IUCN/nc/IUCN_${species}.nc\", \"/Data/CMIP5/climdiff/WOA_modeldiff_rcp8.5/${model}_rcp8.5_temp.nc\"" > geostats.jnl

      echo "Let p50deptharea = geogP50depth[d=1]*0+1" >> geostats.jnl

      echo "Let habitatarea = mask[d=2]*0+1" >> geostats.jnl

      echo "Let ocean = temp_rcp[d=3, l=@ave]*0+1" >> geostats.jnl

      echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/IUCN_models/IUCN_${model}_p50depthav_area_rcp8.5.txt\"/format=tab/append \"rcp8.5\", \"${species}\", ${p50}, ${deltaH}, ocean[x=@din, y=@din, k=1], habitatarea[x=@din, y=@din], p50deptharea[x=@din, y=@din], geogP50depth[d=1, x=@ave, y=@ave], geogP50depth[d=1, x=@var, y=@var], geogP50depth[d=1, x=@ngd, y=@ngd]" >> geostats.jnl

      echo "quit" >> geostats.jnl

      ferret <  geostats.jnl > ferret_out.txt

      rm ferret.jnl*

done
done