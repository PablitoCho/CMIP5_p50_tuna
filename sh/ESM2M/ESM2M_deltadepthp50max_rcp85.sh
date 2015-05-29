#!/bin/sh
rm rcp85_deltadepthp50max.jnl 

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50av/esm2m.0281-0300.p50av.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50av/esm2m.0381-0400.p50av.${species}.nc\"",  \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50av/esm2m.1981-2000.p50av.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50av/esm2m.rcp85.2081-2100.p50av.${species}.nc\" > rcp85_deltadepthp50max.jnl

  echo "Let c281max = p50av[d=1, z=@max]" >> rcp85_deltadepthp50max.jnl  
  echo "Let c281zero = p50av[d=1] - c281max" >> rcp85_deltadepthp50max.jnl 
  echo "Let c281maxdepth = c281zero[z=@loc:0]" >> rcp85_deltadepthp50max.jnl 


  echo "Let c381max = p50av[d=2, z=@max]" >> rcp85_deltadepthp50max.jnl 
  echo "Let c381zero = p50av[d=2] - c381max" >> rcp85_deltadepthp50max.jnl 
  echo "Let c381maxdepth = c381zero[z=@loc:0]" >> rcp85_deltadepthp50max.jnl 


  echo "Let histmax = p50av[d=3, z=@max]" >> rcp85_deltadepthp50max.jnl  
  echo "Let histzero = p50av[d=3] - histmax" >> rcp85_deltadepthp50max.jnl 
  echo "Let histmaxdepth = histzero[z=@loc:0]" >> rcp85_deltadepthp50max.jnl 


  echo "Let rcp85max = p50av[d=4, z=@max]" >> rcp85_deltadepthp50max.jnl  
  echo "Let rcp85zero = p50av[d=4] - rcp85max" >> rcp85_deltadepthp50max.jnl 
  echo "Let rcp85maxdepth = rcp85zero[z=@loc:0]" >> rcp85_deltadepthp50max.jnl 


  echo "Let hist_diff = histmaxdepth - c281maxdepth" >> rcp85_deltadepthp50max.jnl 
  echo "Let rcp85_diff = rcp85maxdepth - c381maxdepth" >> rcp85_deltadepthp50max.jnl 
  echo "Let delta_depthp50max = hist_diff-rcp85_diff" >> rcp85_deltadepthp50max.jnl #in future, shallower is positive


  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthp50max/esm2m.0281-0300.depthp50max.${species}.nc\" c281maxdepth" >> rcp85_deltadepthp50max.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthp50max/esm2m.0381-0400.depthp50max.${species}.nc\" c381maxdepth" >> rcp85_deltadepthp50max.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthp50max/esm2m.1981-2000.depthp50max.${species}.nc\" histmaxdepth" >> rcp85_deltadepthp50max.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthp50max/esm2m.rcp85.2081-2100.depthp50max.${species}.nc\" rcp85maxdepth" >> rcp85_deltadepthp50max.jnl

  echo "list/nohead/file=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/deltadepthp50max/ESM2M.rcp85.deltadepthp50max.geostats.txt\"/format=tab/append \"${species}\", ${p50}, ${deltaH}, delta_depthp50max[x=@ave, y=@ave], delta_depthp50max[x=@var, y=@var]^0.5" >> rcp85_deltadepthp50max.jnl

  echo "SAVE/CLOBBER/FILE=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/deltadepthp50max/ESM2M.rcp85.deltadepthp50max.${species}.nc\" delta_depthp50max" >> rcp85_deltadepthp50max.jnl

  echo "quit" >> rcp85_deltadepthp50max.jnl

  ferret < rcp85_deltadepthp50max.jnl > test_output.txt
	
  rm ferret.jnl*
	
done