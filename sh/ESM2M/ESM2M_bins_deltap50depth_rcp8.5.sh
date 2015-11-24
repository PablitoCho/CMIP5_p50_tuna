#!/bin/sh
rm deltabins.jnl
rm /Data/Projects/CMIP5_p50/ESM2M/delta_p50depthav_bins.txt

while IFS=, read -r species p50 deltaH
do

  mkdir /Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins

  echo "SET DATA \"/Data/Projects/CMIP5_p50/WOA/${species}/p50depth/woa.p50depth.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth/esm2m.deltap50depth.${species}.nc\"" > deltabins.jnl

  echo "Let deltap50depthav = deltap50depth[d=2, l=@ave]" >> deltabins.jnl

  echo "Let p50depthav = p50depth[d=1, l=@ave]" >> deltabins.jnl

  echo "Let depth0to100 = if p50depthav lt 100 then p50depthav" >> deltabins.jnl

  echo "Let depth100to200 = if p50depthav ge 100 and p50depthav lt 200 then p50depthav" >> deltabins.jnl

  echo "Let depth200to300 = if p50depthav ge 200 and p50depthav lt 300 then p50depthav" >> deltabins.jnl

  echo "Let depth300to400 = if p50depthav ge 300 and p50depthav lt 400 then p50depthav" >> deltabins.jnl

  echo "Let depth400to500 = if p50depthav ge 400 and p50depthav lt 500 then p50depthav" >> deltabins.jnl

  echo "Let depth500to600 = if p50depthav ge 500 and p50depthav lt 600 then p50depthav" >> deltabins.jnl

  echo "Let depth600to700 = if p50depthav ge 600 and p50depthav lt 700 then p50depthav" >> deltabins.jnl

  echo "Let depth700to800 = if p50depthav ge 700 and p50depthav lt 800 then p50depthav" >> deltabins.jnl

  echo "Let depth800to900 = if p50depthav ge 800 and p50depthav lt 900 then p50depthav" >> deltabins.jnl

  echo "Let depth900to1000 = if p50depthav ge 900 and p50depthav lt 1000 then p50depthav" >> deltabins.jnl

  echo "Let delta0to100 = (depth0to100*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta100to200 = (depth100to200*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta200to300 = (depth200to300*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta300to400 = (depth300to400*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta400to500 = (depth400to500*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta500to600 = (depth500to600*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta600to700 = (depth600to700*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta700to800 = (depth700to800*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta800to900 = (depth800to900*0+1)*deltap50depthav" >> deltabins.jnl

  echo "Let delta900to1000 = (depth900to1000*0+1)*deltap50depthav" >> deltabins.jnl

  echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/ESM2M/deltap50depth_bins.txt\"/format=tab/append  \"mean\", \"${species}\", ${p50}, ${deltaH}, delta0to100[x=@ave, y=@ave], delta100to200[x=@ave, y=@ave], delta200to300[x=@ave, y=@ave], delta300to400[x=@ave, y=@ave], delta400to500[x=@ave, y=@ave], delta500to600[x=@ave, y=@ave], delta600to700[x=@ave, y=@ave], delta700to800[x=@ave, y=@ave], delta800to900[x=@ave, y=@ave], delta900to1000[x=@ave, y=@ave]" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0000.0100.${species}.nc\" delta0to100" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0100.0200.${species}.nc\" delta100to200" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0200.0300.${species}.nc\" delta200to300" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0300.0400.${species}.nc\" delta300to400" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0400.0500.${species}.nc\" delta400to500" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0500.0600.${species}.nc\" delta500to600" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0600.0700.${species}.nc\" delta600to700" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0700.0800.${species}.nc\" delta700to800" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0800.0900.${species}.nc\" delta800to900" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/deltap50depth_bins/ESM2M.rcp85.deltap50depth.0900.1000.${species}.nc\" delta900to1000" >> deltabins.jnl

  echo "quit" >> deltabins.jnl

  ferret < deltabins.jnl > test_output.txt

  rm ferret.jnl*

done
