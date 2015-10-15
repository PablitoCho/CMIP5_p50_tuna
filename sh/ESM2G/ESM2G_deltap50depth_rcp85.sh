	#!/bin/sh
rm deltap50depth.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/ESM2G/${species}/p50depthav/esm2g.0281-0300.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2G/${species}/p50depthav/esm2g.0381-0400.p50depthav.${species}.nc\",  \"/Data/Projects/CMIP5_p50/ESM2G/${species}/p50depthav/esm2g.1981-2000.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2G/${species}/p50depthav/esm2g.rcp85.2081-2100.p50depthav.${species}.nc\"" > deltap50depth.jnl

  echo "Let hist_diff = p50depthav[d=3]-p50depthav[d=1]" >> deltap50depth.jnl

  echo "Let rcp85_diff = p50depthav[d=4]-p50depthav[d=2]" >> deltap50depth.jnl

  echo "Let delta_p50depth = hist_diff-rcp85_diff" >> deltap50depth.jnl  #in future, shallower is positive

#  echo "Let mask1 = p50depthav[d=1]*0+1" >> deltap50depth.jnl

#  echo "Let mask2 = p50depthav[d=2]*0+1" >> deltap50depth.jnl

#  echo "Let mask3 = p50depthav[d=3]*0+1" >> deltap50depth.jnl

#  echo "Let mask4 = p50depthav[d=4]*0+1" >> deltap50depth.jnl

#  echo "list/nohead/file=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2G/ESM2G.rcp85.p50depthav.geostats.txt\"/format=tab/append \"${species}\", ${p50}, ${deltaH}, mask1[d=1, x=@din, y=@din], mask2[d=2, x=@din, y=@din], mask3[d=3, x=@din, y=@din], mask4[d=4, x=@din, y=@din], delta_p50depth[x=@ave, y=@ave], delta_p50depth[x=@var, y=@var]^0.5" >> deltap50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2G/${species}/ESM2G.rcp85.deltap50depth.${species}.nc\" delta_p50depth" >> deltap50depth.jnl

  echo "quit" >> deltap50depth.jnl

  ferret < deltap50depth.jnl > test_output.txt

  rm ferret.jnl*

done
