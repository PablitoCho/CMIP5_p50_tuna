#!/bin/sh
rm maskP50depthav.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"data/IUCN/nc/IUCN_${species}.nc\", \"results/modelmean/modelmean.p50depth.${species}.nc\""  > maskP50depthav.jnl

  echo "Let geogP50 = mask[d=1] * modelmean[d=2]" >> maskP50depthav.jnl

  echo "define att geogP50.long_name = \"P50 Depth in the Species Range\"">> maskP50depthav.jnl
 
  echo "define att geogP50.units = \"m\"" >> maskP50depthav.jnl 

  echo "define att geogP50.species = \"${species}\"" >> maskP50depthav.jnl 

  echo "define att geogP50.species_p50 = \"${p50}\"" >> maskP50depthav.jnl 

  echo "define att geogP50.species_deltaH = \"${deltaH}\"" >> maskP50depthav.jnl 

  echo "SAVE/CLOBBER/FILE=\"results/IUCN_modelmean/IUCN.modelmean.p50depth.${species}.nc\" geogP50" >> maskP50depthav.jnl

  echo "quit" >> maskP50depthav.jnl 

  ferret < maskP50depthav.jnl 
	
  rm ferret.jnl*
  rm maskP50depthav.jnl	

done