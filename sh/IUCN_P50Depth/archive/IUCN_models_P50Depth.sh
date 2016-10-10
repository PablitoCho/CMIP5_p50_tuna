#!/bin/sh
rm IUCNmodels.jnl

while IFS=, read -r species p50 deltaH
do

for model in cesm1 esm2g esm2m hadgem2 ipsl mpi
do

  mkdir /Data/Projects/CMIP5_p50/IUCN_models/${model}

  echo "SET DATA \"/Data/Projects/CMIP5_p50/IUCN/nc/IUCN_${species}.nc\", \"/Data/Projects/CMIP5_p50/${model}/${species}/p50depth/${model}.rcp85.p50depthav.${species}.nc\""  > IUCNmodels.jnl

  echo "Let geogP50depth = mask[d=1] * P50DEPTHAV[d=2]" >> IUCNmodels.jnl

  echo "define att geogP50depth.long_name = \"Delta P50 Depth in the Species Range\"">> IUCNmodels.jnl
 
  echo "define att geogP50depth.units = \"m\"" >> IUCNmodels.jnl 

  echo "define att geogP50depth.species = \"${species}\"" >> IUCNmodels.jnl 

  echo "define att geogP50depth.species_p50 = \"${p50}\"" >> IUCNmodels.jnl 

  echo "define att geogP50depth.species_deltaH = \"${deltaH}\"" >> IUCNmodels.jnl 

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/IUCN_models/${model}/IUCN.${model}.p50depthav.${species}.nc\" geogP50depth" >> IUCNmodels.jnl

  echo "quit" >> IUCNmodels.jnl 

  ferret < IUCNmodels.jnl > test_output.txt
	
  rm ferret.jnl*

done

done