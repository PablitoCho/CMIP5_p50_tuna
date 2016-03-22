#!/bin/sh
rm maskP50depthav.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/IUCN/nc/IUCN_${species}.nc\", \"/Data/Projects/CMIP5_p50/WOA/${species}/p50depth/woa.p50depthav.${species}.nc\""  > maskP50depthav.jnl

  echo "Let geogP50Zav = mask[d=1] * p50depthav[d=2]" >> maskP50depthav.jnl

  echo "define att geogP50Zav.long_name = \"P50 Depth in the Species Range\"">> maskP50depthav.jnl
 
  echo "define att geogP50Zav.units = \"m\"" >> maskP50depthav.jnl 

  echo "define att geogP50Zav.species = \"${species}\"" >> maskP50depthav.jnl 

  echo "define att geogP50Zav.species_p50 = \"${p50}\"" >> maskP50depthav.jnl 

  echo "define att geogP50Zav.species_deltaH = \"${deltaH}\"" >> maskP50depthav.jnl 

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN.WOA.p50depthav.${species}.nc\" geogP50Zav" >> maskP50depthav.jnl

  echo "quit" >> maskP50depthav.jnl 

  ferret < maskP50depthav.jnl > test_output.txt
	
  rm ferret.jnl*


done