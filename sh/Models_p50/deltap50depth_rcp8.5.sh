#!/bin/sh
rm deltap50depth.jnl

while IFS=, read -r species p50 deltaH
do

for model in cesm1 esm2g esm2m hadgem2 ipsl-cm5a mpi-esm
do

  mkdir results/${model}/${species}/deltap50depth

  echo "SET DATA \"results/WOA/${species}/p50depth/woa.p50depth.${species}.nc\", \"results/${model}/${species}/p50depth/${model}.rcp85.p50depth.${species}.nc\"" > deltap50depth.jnl

  echo "Let deltap50depth = p50depth[d=1]-p50depth[d=2]" >> deltap50depth.jnl #kPa

  echo "Let deltap50depthav = deltap50depth[l=@ave]" >> deltap50depth.jnl #kPa

  echo "Let deltap50depth_deltaH0 = p50depth_deltaH0[d=1]-p50depth_deltaH0[d=2]" >> deltap50depth.jnl #kPa

  echo "Let deltap50depthav_deltaH0 = deltap50depth_deltaH0[l=@ave]" >> deltap50depth.jnl #kPa


  echo "define att deltap50depth.long_name = \"Delta Depth of P50 Threshold\"" >> deltap50depth.jnl

  echo "define att deltap50depth.units = \"m\"" >> deltap50depth.jnl

  echo "define att deltap50depth.species = \"${species}\"" >> deltap50depth.jnl

  echo "define att deltap50depth.species_p50 = \"${p50}\"" >> deltap50depth.jnl

  echo "define att deltap50depth.species_deltaH = \"${deltaH}\"" >> deltap50depth.jnl


  echo "define att deltap50depth_deltaH0.long_name = \"Delta Depth of P50 Threshold when deltaH=0\"" >> deltap50depth.jnl

  echo "define att deltap50depth_deltaH0.units = \"m\"" >> deltap50depth.jnl

  echo "define att deltap50depth_deltaH0.species = \"${species}\"" >> deltap50depth.jnl

  echo "define att deltap50depth_deltaH0.species_p50 = \"${p50}\"" >> deltap50depth.jnl

  echo "define att deltap50depth_deltaH0.species_deltaH = \"0\"" >> deltap50depth.jnl


  echo "define att deltap50depthav.long_name = \"Delta Depth of P50 Threshold\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.units = \"m\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.species = \"${species}\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.species_p50 = \"${p50}\"" >> deltap50depth.jnl

  echo "define att deltap50depthav.species_deltaH = \"${deltaH}\"" >> deltap50depth.jnl


  echo "define att deltap50depthav_deltaH0.long_name = \"Delta Depth of P50 Threshold when deltaH=0\"" >> deltap50depth.jnl

  echo "define att deltap50depthav_deltaH0.units = \"m\"" >> deltap50depth.jnl

  echo "define att deltap50depthav_deltaH0.species = \"${species}\"" >> deltap50depth.jnl

  echo "define att deltap50depthav_deltaH0.species_p50 = \"${p50}\"" >> deltap50depth.jnl

  echo "define att deltap50depthav_deltaH0.species_deltaH = \"0\"" >> deltap50depth.jnl


  echo "Set memory/size=200" >> deltap50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"results/${model}/${species}/deltap50depth/${model}.deltap50depth.${species}.nc\"/LLIMITS=1:12/L=1 deltap50depth, deltap50depth_deltaH0" >> deltap50depth.jnl

  echo "repeat/L=2:12 (SAVE/APPEND/FILE=\"results/${model}/${species}/deltap50depth/${model}.deltap50depth.${species}.nc\"/L=\`l\` deltap50depth, deltap50depth_deltaH0)" >> deltap50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"results/${model}/${species}/deltap50depth/${model}.deltap50depthav.${species}.nc\" deltap50depthav, deltap50depthav_deltaH0" >> deltap50depth.jnl

  echo "quit" >> deltap50depth.jnl

  ferret < deltap50depth.jnl

  rm ferret.jnl*
  rm deltap50depth.jnl

done
done
