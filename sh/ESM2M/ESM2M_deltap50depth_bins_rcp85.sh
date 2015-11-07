#!/bin/sh
rm deltabins.jnl
rm /Data/Projects/CMIP5_p50/ESM2M/delta_p50depthav_bins.txt

while IFS=, read -r species p50 deltaH
do

  mkdir /Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins

  echo "SET DATA \"/Data/Projects/CMIP5_p50/ESM2M/${species}/p50depthav/esm2m.0281-0300.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M/${species}/p50depthav/esm2m.0381-0400.p50depthav.${species}.nc\",  \"/Data/Projects/CMIP5_p50/ESM2M/${species}/p50depthav/esm2m.1981-2000.p50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M/${species}/p50depthav/esm2m.rcp85.2081-2100.p50depthav.${species}.nc\"" > deltabins.jnl

  echo "Let control_diff = p50depthav[d=1]-p50depthav[d=2]" >> deltabins.jnl

  echo "Let rcp85_diff = p50depthav[d=3]-p50depthav[d=4]" >> deltabins.jnl

  echo "Let delta_p50depth = rcp85_diff-control_diff" >> deltabins.jnl  #in future, shallower is positive

  echo "Let depth0to100 = if p50depthav[d=3] lt 100 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth100to200 = if p50depthav[d=3] ge 100 and p50depthav[d=3] lt 200 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth200to300 = if p50depthav[d=3] ge 200 and p50depthav[d=3] lt 300 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth300to400 = if p50depthav[d=3] ge 300 and p50depthav[d=3] lt 400 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth400to500 = if p50depthav[d=3] ge 400 and p50depthav[d=3] lt 500 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth500to600 = if p50depthav[d=3] ge 500 and p50depthav[d=3] lt 600 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth600to700 = if p50depthav[d=3] ge 600 and p50depthav[d=3] lt 700 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth700to800 = if p50depthav[d=3] ge 700 and p50depthav[d=3] lt 800 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth800to900 = if p50depthav[d=3] ge 800 and p50depthav[d=3] lt 900 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let depth900to1000 = if p50depthav[d=3] ge 900 and p50depthav[d=3] lt 1000 then p50depthav[d=3]" >> deltabins.jnl

  echo "Let delta0to100 = (depth0to100*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta100to200 = (depth100to200*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta200to300 = (depth200to300*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta300to400 = (depth300to400*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta400to500 = (depth400to500*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta500to600 = (depth500to600*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta600to700 = (depth600to700*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta700to800 = (depth700to800*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta800to900 = (depth800to900*0+1)*delta_p50depth" >> deltabins.jnl

  echo "Let delta900to1000 = (depth900to1000*0+1)*delta_p50depth" >> deltabins.jnl

  echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/ESM2M/delta_p50depthav_bins.txt\"/format=tab/append  \"mean\", \"${species}\", ${p50}, ${deltaH}, delta0to100[x=@ave, y=@ave], delta100to200[x=@ave, y=@ave], delta200to300[x=@ave, y=@ave], delta300to400[x=@ave, y=@ave], delta400to500[x=@ave, y=@ave], delta500to600[x=@ave, y=@ave], delta600to700[x=@ave, y=@ave], delta700to800[x=@ave, y=@ave], delta800to900[x=@ave, y=@ave], delta900to1000[x=@ave, y=@ave]" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0000.0100.${species}.nc\" delta0to100" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0100.0200.${species}.nc\" delta100to200" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0200.0300.${species}.nc\" delta200to300" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0300.0400.${species}.nc\" delta300to400" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0400.0500.${species}.nc\" delta400to500" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0500.0600.${species}.nc\" delta500to600" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0600.0700.${species}.nc\" delta600to700" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0700.0800.${species}.nc\" delta700to800" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0800.0900.${species}.nc\" delta800to900" >> deltabins.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M/${species}/delta_p50depthav_bins/ESM2M.rcp85.deltap50depth.0900.1000.${species}.nc\" delta900to1000" >> deltabins.jnl

#  echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/ESM2M/delta_p50depthav_bins.txt\"/format=tab/append  \"max\", \"${species}\", ${p50}, ${deltaH}, delta0to100[x=@max, y=@max], delta100to200[x=@max, y=@max], delta200to300[x=@max, y=@max], delta300to400[x=@max, y=@max], delta400to500[x=@max, y=@max], delta500to600[x=@max, y=@max], delta600to700[x=@max, y=@max], delta700to800[x=@max, y=@max], delta800to900[x=@max, y=@max], delta900to1000[x=@max, y=@max]" >> deltabins.jnl

#  echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/ESM2M/delta_p50depthav_bins.txt\"/format=tab/append  \"min\", \"${species}\", ${p50}, ${deltaH}, delta0to100[x=@min, y=@min], delta100to200[x=@min, y=@min], delta200to300[x=@min, y=@min], delta300to400[x=@min, y=@min], delta400to500[x=@min, y=@min], delta500to600[x=@min, y=@min], delta600to700[x=@min, y=@min], delta700to800[x=@min, y=@min], delta800to900[x=@min, y=@min], delta900to1000[x=@min, y=@min]" >> deltabins.jnl

  echo "quit" >> deltabins.jnl

  ferret < deltabins.jnl > test_output.txt

  rm ferret.jnl*

done
