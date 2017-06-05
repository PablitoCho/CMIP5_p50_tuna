#!/bin/sh
rm IUCN_5deg.jnl

mkdir data/IUCN/nc_5deg

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"data/IUCN/nc/IUCN_${species}.nc\", \"data/WOA/temperature_monthly_5deg.nc\"" > IUCN_5deg.jnl

  echo "Let mask_5deg = mask[d=1, gx=t_mn[d=2], gy=t_mn[d=2]]" >> IUCN_5deg.jnl

  echo "SAVE/CLOBBER/FILE=\"data/IUCN/nc_5deg/IUCN_5deg_${species}.nc\" mask_5deg" >> IUCN_5deg.jnl 

  echo "quit" >> IUCN_5deg.jnl 

  ferret < IUCN_5deg.jnl 
	
  rm ferret.jnl*
  rm IUCN_5deg.jnl
	

done