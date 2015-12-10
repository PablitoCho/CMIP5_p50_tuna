#!/bin/sh
rm rcp85_depthdiffmin.jnl 

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/CMIP5/ESM2M/processed/rcp8.5/esm2m.rcp85.2081-2100.po2.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50av/esm2m.rcp85.2081-2100.p50av.${species}.nc\"" > rcp85_depthdiffmin.jnl

  echo "Let po2av = PO2[d=1, l=@ave]" >> rcp85_depthdiffmin.jnl
 
  echo "Let diff = po2av - p50av" >>  rcp85_depthdiffmin.jnl

#  only upper 2000 m of the ocean
#  echo "Let diff2000 = diff[z=0:2000]" >>  rcp85_depthdiffmin.jnl 
#  echo "Let diffmin = diff2000[k=@min]" >>  rcp85_depthdiffmin.jnl	
#  echo "Let depthfind = diff2000 - diffmin" >>  rcp85_depthdiffmin.jnl	

#  entire water column of the ocean
  echo "Let diffmin = diff[k=@min]" >>  rcp85_depthdiffmin.jnl	
  echo "Let depthfind = diff - diffmin" >>  rcp85_depthdiffmin.jnl	


  echo "Let depthdiffmin = depthfind[z=@loc:0]" >>  rcp85_depthdiffmin.jnl

  echo "define att diffmin.long_name = \"Minimum Difference in Oxygen Pressure Between Blood and Environment\"" >> rcp85_depthdiffmin.jnl

  echo "define att diffmin.units = \"kPa\"" >> rcp85_depthdiffmin.jnl

  echo "define att diffmin.species = \"${species}\"" >> rcp85_depthdiffmin.jnl

  echo "define att diffmin.species_p50 = \"${p50}\"" >> rcp85_depthdiffmin.jnl

  echo "define att diffmin.species_deltaH = \"${deltaH}\"" >> rcp85_depthdiffmin.jnl

echo "define att depthdiffmin.long_name = \"Depth of the Minimum Difference in Oxygen Pressure Between Blood and Environment\"" >> rcp85_depthdiffmin.jnl

  echo "define att depthdiffmin.units = \"kPa\"" >> rcp85_depthdiffmin.jnl

  echo "define att depthdiffmin.species = \"${species}\"" >> rcp85_depthdiffmin.jnl

  echo "define att depthdiffmin.species_p50 = \"${p50}\"" >> rcp85_depthdiffmin.jnl

  echo "define att depthdiffmin.species_deltaH = \"${deltaH}\"" >> rcp85_depthdiffmin.jnl

	
  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/diffmin/esm2m.rcp85.2081-2100.diffmin.${species}.nc\" diffmin" >> rcp85_depthdiffmin.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthdiffmin/esm2m.rcp85.2081-2100.depthdiffmin.${species}.nc\" depthdiffmin" >> rcp85_depthdiffmin.jnl

  echo "quit" >> rcp85_depthdiffmin.jnl

  ferret < rcp85_depthdiffmin.jnl > test_output.txt
	
  rm ferret.jnl*
	
done