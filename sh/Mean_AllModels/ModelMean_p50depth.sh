#!/bin/sh
rm modelmean.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/cesm1/${species}/p50depth/cesm1.rcp85.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/esm2g/${species}/p50depth/esm2g.rcp85.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/esm2m/${species}/p50depth/esm2m.rcp85.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/hadgem2/${species}/p50depth/hadgem2.rcp85.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ipsl/${species}/p50depth/ipsl.rcp85.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/mpi/${species}/p50depth/mpi.rcp85.p50depthav.${species}.nc\"" > modelmean.jnl

  echo "Let modelmean = (P50DEPTHAV[d=1] + P50DEPTHAV[d=2] + P50DEPTHAV[d=3] + P50DEPTHAV[d=4] + P50DEPTHAV[d=5] + P50DEPTHAV[d=6])/6" >> modelmean.jnl  


  echo "define att modelmean.long_name = \"Model Mean P50 Depth\"">> modelmean.jnl
 
  echo "define att modelmean.units = \"m\"" >> modelmean.jnl 

  echo "define att modelmean.species = \"${species}\"" >> modelmean.jnl 

  echo "define att modelmean.species_p50 = \"${p50}\"" >> modelmean.jnl 

  echo "define att modelmean.species_deltaH = \"${deltaH}\"" >> modelmean.jnl 

  echo "Set memory/size=200" >> modelmean.jnl 

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/modelmean/modelmean.p50depth.${species}.nc\" modelmean" >> modelmean.jnl 

  echo "quit" >> modelmean.jnl 

  ferret < modelmean.jnl > test_output.txt
	
  rm ferret.jnl*
	
done

