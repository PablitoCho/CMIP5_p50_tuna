#!/bin/sh
rm depthdiffmin.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/CMIP5/ESM2M/processed/controls/esm2m.0381-0400.po2.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50av/esm2m.0381-0400.p50av.${species}.nc\"" > depthdiffmin.jnl

  echo "Let po2av = PO2[d=1, l=@ave]" >> depthdiffmin.jnl
 
  echo "Let diff = po2av - p50av" >>  depthdiffmin.jnl

  echo "Let diff2000 = diff[z=0:2000]" >>  depthdiffmin.jnl  #only upper 2000 m of the ocean

  echo "Let diffmin = diff2000[k=@min]" >>  depthdiffmin.jnl	

  echo "Let depthfind = diff2000 - diffmin" >>  depthdiffmin.jnl	

  echo "Let depthdiffmin = depthfind[z=@loc:0]" >>  depthdiffmin.jnl

  echo "define att diffmin.long_name = \"Minimum Difference in Oxygen Pressure Between Blood and Environment\"" >> depthdiffmin.jnl

  echo "define att diffmin.units = \"kPa\"" >> depthdiffmin.jnl

  echo "define att diffmin.species = \"${species}\"" >> depthdiffmin.jnl

  echo "define att diffmin.species_p50 = \"${p50}\"" >> depthdiffmin.jnl

  echo "define att diffmin.species_deltaH = \"${deltaH}\"" >> depthdiffmin.jnl

echo "define att depthdiffmin.long_name = \"Depth of the Minimum Difference in Oxygen Pressure Between Blood and Environment\"" >> depthdiffmin.jnl

  echo "define att depthdiffmin.units = \"kPa\"" >> depthdiffmin.jnl

  echo "define att depthdiffmin.species = \"${species}\"" >> depthdiffmin.jnl

  echo "define att depthdiffmin.species_p50 = \"${p50}\"" >> depthdiffmin.jnl

  echo "define att depthdiffmin.species_deltaH = \"${deltaH}\"" >> depthdiffmin.jnl

	
  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/diffmin/esm2m.0381-0400.diffmin.${species}.nc\" diffmin" >> depthdiffmin.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthdiffmin/esm2m.0381-0400.depthdiffmin.${species}.nc\" depthdiffmin" >> depthdiffmin.jnl

  echo "quit" >> depthdiffmin.jnl

  ferret < depthdiffmin.jnl > test_output.txt
	
  rm ferret.jnl*
	
done