#!/bin/sh
rm p50depth.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50depthav/esm2m.0281-0300.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50depthav/esm2m.0381-0400.p50depthav.${species}.nc\"",  \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50depthav/esm2m.1981-2000.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50depthav/esm2m.rcp85.2081-2100.p50depthav.${species}.nc\" > rcp85_p50depthav.jnl

  echo "Let hist_diff = p50depthav[d=3]-p50depthav[d=1]" >> rcp85_p50depthav.jnl 

  echo "Let rcp85_diff = p50depthav[d=4]-p50depthav[d=2]" >> rcp85_p50depthav.jnl 

  echo "Let delta_p50depth = hist_diff-rcp85_diff" >> rcp85_p50depthav.jnl  #in future, shallower is positive
  
  echo "Let mask1 = p50depthav[d=1]*0+1" >> rcp85_p50depthav.jnl

  echo "Let mask2 = p50depthav[d=2]*0+1" >> rcp85_p50depthav.jnl

  echo "Let mask3 = p50depthav[d=3]*0+1" >> rcp85_p50depthav.jnl

  echo "Let mask4 = p50depthav[d=4]*0+1" >> rcp85_p50depthav.jnl

  echo "list/nohead/file=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/ESM2M.rcp85.p50depthav.geostats.txt\"/format=tab/append \"${species}\", ${p50}, ${deltaH}, mask1[d=1, x=@din, y=@din], mask2[d=2, x=@din, y=@din], mask3[d=3, x=@din, y=@din], mask4[d=4, x=@din, y=@din], delta_p50depth[x=@ave, y=@ave], delta_p50depth[x=@var, y=@var]^0.5" >> rcp85_p50depthav.jnl

  echo "SAVE/CLOBBER/FILE=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/ESM2M.rcp85.deltap50depth.${species}.nc\" delta_p50depth" >> rcp85_p50depthav.jnl

  echo "quit" >> rcp85_p50depthav.jnl

  ferret < rcp85_p50depthav.jnl > test_output.txt
	
  rm ferret.jnl*
	
done