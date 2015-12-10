#!/bin/sh
rm deltap50depth.jnl

while IFS=, read -r species p50 deltaH
do
  mkdir /Data/Projects/CMIP5_p50/ESM2G/${species}/temp_deltaH0/deltap50depth

  echo "SET DATA \"/Data/Projects/CMIP5_p50/WOA/${species}/temp_deltaH0/p50depth/woa.p50depth.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2G/${species}/temp_deltaH0/p50depth/esm2g.rcp85.p50depth.${species}.nc\"" > deltap50depth.jnl

  echo "Let deltap50depth = p50depth[d=1]-p50depth[d=2]" >> deltap50depth.jnl #kPa

  echo "Let deltap50depthav = deltap50depth[l=@ave]" >> deltap50depth.jnl #kPa

  echo "define att deltap50depth.long_name = \"Delta Depth of P50 Threshold\"" >> deltap50depth.jnl

  echo "define att deltap50depth.units = \"m\"" >> deltap50depth.jnl

  echo "define att deltap50depth.species = \"${species}\"" >> deltap50depth.jnl

  echo "define att deltap50depth.species_p50 = \"${p50}\"" >> deltap50depth.jnl

  echo "define att deltap50depth.species_deltaH = \"${deltaH}\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.long_name = \"Delta Depth of P50 Threshold\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.units = \"m\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.species = \"${species}\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.species_p50 = \"${p50}\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.species_deltaH = \"${deltaH}\"" >> deltap50depth.jnl

  echo "Set memory/size=200" >> deltap50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2G/${species}/temp_deltaH0/deltap50depth/esm2g.deltap50depth.${species}.nc\"/LLIMITS=1:12/L=1 deltap50depth" >> deltap50depth.jnl

  echo "repeat/L=2:12 (SAVE/APPEND/FILE=\"/Data/Projects/CMIP5_p50/ESM2G/${species}/temp_deltaH0/deltap50depth/esm2g.deltap50depth.${species}.nc\"/L=\`l\` deltap50depth)" >> deltap50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2G/${species}/temp_deltaH0/deltap50depth/esm2g.deltap50depthav.${species}.nc\" deltap50depthav" >> deltap50depth.jnl

  echo "quit" >> deltap50depth.jnl

  ferret < deltap50depth.jnl > test_output.txt
	
  rm ferret.jnl*
	
done

