#!/bin/sh
rm IUCN_num.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"data/IUCN/nc/IUCN_${species}.nc\"" > IUCN_num.jnl

  echo "Let mask_5deg = mask[d=1, gx=t_mn[d=2], gy=t_mn[d=2]]" >> IUCN_num.jnl

  echo "SAVE/CLOBBER/FILE=\"data/nc_5deg/IUCN_5deg_${species}.nc\" mask_5deg" >> IUCN_num.jnl

  echo "quit" >> IUCN_num.jnl

  ferret < IUCN_num.jnl 
	
  rm ferret.jnl*
  rm IUCN_num.jnl	

done