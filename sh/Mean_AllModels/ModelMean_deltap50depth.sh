#!/bin/sh
rm modelmean.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/cesm1/${species}/deltap50depth/cesm1.deltap50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/esm2g/${species}/deltap50depth/esm2g.deltap50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/esm2m/${species}/deltap50depth/esm2m.deltap50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/hadgem2/${species}/deltap50depth/hadgem2.deltap50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ipsl/${species}/deltap50depth/ipsl.deltap50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/mpi/${species}/deltap50depth/mpi.deltap50depthav.${species}.nc\", \"/Data/WOA/WOA_temp/temperature_monthly_5deg.nc\"" > modelmean.jnl

  echo "Let modelmean = (DELTAP50DEPTHAV[d=1] + DELTAP50DEPTHAV[d=2] + DELTAP50DEPTHAV[d=3] + DELTAP50DEPTHAV[d=4] + DELTAP50DEPTHAV[d=5] + DELTAP50DEPTHAV[d=6])/6" >> modelmean.jnl  


  echo "Let mask1 = DELTAP50DEPTHAV[d=1]*0" >> modelmean.jnl 
  
  echo "Let possign1 = if DELTAP50DEPTHAV[d=1] GT 0 then (1) else 0" >> modelmean.jnl 
  
  echo "Let negsign1 = if DELTAP50DEPTHAV[d=1] LT 0 then (-1) else 0" >> modelmean.jnl  
  
  echo "Let sign1 = mask1+possign1+negsign1" >> modelmean.jnl 


  echo "Let mask2 = DELTAP50DEPTHAV[d=2]*0" >> modelmean.jnl 

  echo "Let possign2 = if DELTAP50DEPTHAV[d=2] GT 0 then (1) else 0" >> modelmean.jnl 

  echo "Let negsign2 = if DELTAP50DEPTHAV[d=2] LT 0 then (-1) else 0" >> modelmean.jnl 
 
  echo "Let sign2 = mask2+possign2+negsign2" >> modelmean.jnl 


  echo "Let mask3 = DELTAP50DEPTHAV[d=3]*0" >> modelmean.jnl 

  echo "Let possign3 = if DELTAP50DEPTHAV[d=3] GT 0 then (1) else 0" >> modelmean.jnl 

  echo "Let negsign3 = if DELTAP50DEPTHAV[d=3] LT 0 then (-1) else 0" >> modelmean.jnl 
 
  echo "Let sign3 = mask3+possign3+negsign3" >> modelmean.jnl 


  echo "Let mask4 = DELTAP50DEPTHAV[d=4]*0" >> modelmean.jnl 

  echo "Let possign4 = if DELTAP50DEPTHAV[d=4] GT 0 then (1) else 0" >> modelmean.jnl 

  echo "Let negsign4 = if DELTAP50DEPTHAV[d=3] LT 0 then (-1) else 0" >> modelmean.jnl 
 
  echo "Let sign4 = mask3+possign4+negsign4" >> modelmean.jnl 


  echo "Let mask5 = DELTAP50DEPTHAV[d=5]*0" >> modelmean.jnl 

  echo "Let possign5 = if DELTAP50DEPTHAV[d=5] GT 0 then (1) else 0" >> modelmean.jnl 

  echo "Let negsign5 = if DELTAP50DEPTHAV[d=5] LT 0 then (-1) else 0" >> modelmean.jnl 
 
  echo "Let sign5 = mask5+possign5+negsign5" >> modelmean.jnl 


  echo "Let mask6 = DELTAP50DEPTHAV[d=6]*0" >> modelmean.jnl 

  echo "Let possign6 = if DELTAP50DEPTHAV[d=6] GT 0 then (1) else 0" >> modelmean.jnl 

  echo "Let negsign6 = if DELTAP50DEPTHAV[d=6] LT 0 then (-1) else 0" >> modelmean.jnl 
 
  echo "Let sign6 = mask6+possign6+negsign6" >> modelmean.jnl 


  echo "Let signsum = sign1 + sign2 + sign3 + sign4 + sign5 + sign6" >> modelmean.jnl 

  echo "Let signfind = if (signsum ne (6) AND signsum ne (-6)) then 0 else 1" >> modelmean.jnl 

  echo "Let signfind2 = signsum*signfind" >> modelmean.jnl 

  echo "Let signfind3 = ignore0(signfind2)" >> modelmean.jnl 

  echo "Let signagree = signfind3*0+1" >> modelmean.jnl 

  echo "Let signagree_5deg = signagree[gx=t_mn[d=7], gy=t_mn[d=7]]" >> modelmean.jnl


  echo "define att modelmean.long_name = \"Model Mean Delta P50 Depth\"">> modelmean.jnl
 
  echo "define att modelmean.units = \"m\"" >> modelmean.jnl 

  echo "define att modelmean.species = \"${species}\"" >> modelmean.jnl 

  echo "define att modelmean.species_p50 = \"${p50}\"" >> modelmean.jnl 

  echo "define att modelmean.species_deltaH = \"${deltaH}\"" >> modelmean.jnl 

  echo "define att signagree.long_name = \"Mask for Gridpoints with Sign Agreement\"" >> modelmean.jnl 

  echo "define att signagree.species = \"${species}\"" >> modelmean.jnl
 
  echo "define att signagree.species_p50 = \"${p50}\"" >> modelmean.jnl 

  echo "define att signagree.species_deltaH = \"${deltaH}\"" >> modelmean.jnl 


  echo "define att signagree_5deg.species = \"${species}\"" >> modelmean.jnl
 
  echo "define att signagree_5deg.species_p50 = \"${p50}\"" >> modelmean.jnl 

  echo "define att signagree_5deg.species_deltaH = \"${deltaH}\"" >> modelmean.jnl 


  echo "Set memory/size=200" >> modelmean.jnl 

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/modelmean/modelmean.deltap50depth.${species}.nc\" modelmean, signagree" >> modelmean.jnl 


  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/modelmean/signagree.5deg.deltap50depth.${species}.nc\" signagree_5deg" >> modelmean.jnl 

  echo "quit" >> modelmean.jnl 

  ferret < modelmean.jnl > test_output.txt
	
  rm ferret.jnl*
	
done

