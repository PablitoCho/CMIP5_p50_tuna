#!/bin/sh
rm binstats.jnl

while IFS=, read -r species p50 deltaH
do

      echo "SET DATA \"/Data/Projects/CMIP5_p50/WOA/${species}/p50depth/woa.p50depth.${species}.nc\", \"/Data/CMIP5/climdiff/WOA_modeldiff_rcp8.5/ESM2M_rcp8.5_temp.nc\"" > binstats.jnl

      echo "Let p50depthav = p50depth[d=1, l=@ave]" >> binstats.jnl

      echo "Let ocean = temp_rcp[d=2]*0+1" >> binstats.jnl

      echo "Let p50depth_area = p50depthav*0+1" >> binstats.jnl

      echo "Let depth0to100 = if p50depthav lt 100 then p50depthav" >> binstats.jnl

      echo "Let depth100to200 = if p50depthav ge 100 and p50depthav lt 200 then p50depthav" >> binstats.jnl

      echo "Let depth200to300 = if p50depthav ge 200 and p50depthav lt 300 then p50depthav" >> binstats.jnl

      echo "Let depth300to400 = if p50depthav ge 300 and p50depthav lt 400 then p50depthav" >> binstats.jnl

      echo "Let depth400to500 = if p50depthav ge 400 and p50depthav lt 500 then p50depthav" >> binstats.jnl

      echo "Let depth500to600 = if p50depthav ge 500 and p50depthav lt 600 then p50depthav" >> binstats.jnl

      echo "Let depth600to700 = if p50depthav ge 600 and p50depthav lt 700 then p50depthav" >> binstats.jnl

      echo "Let depth700to800 = if p50depthav ge 700 and p50depthav lt 800 then p50depthav" >> binstats.jnl

      echo "Let depth800to900 = if p50depthav ge 800 and p50depthav lt 900 then p50depthav" >> binstats.jnl

      echo "Let depth900to1000 = if p50depthav ge 900 and p50depthav lt 1000 then p50depthav" >> binstats.jnl

      echo "Let depth0to100_area = depth0to100*0+1" >> binstats.jnl

      echo "Let depth100to200_area = depth100to200*0+1" >> binstats.jnl

      echo "Let depth200to300_area = depth200to300*0+1" >> binstats.jnl

      echo "Let depth300to400_area = depth300to400*0+1" >> binstats.jnl

      echo "Let depth400to500_area = depth400to500*0+1" >> binstats.jnl

      echo "Let depth500to600_area = depth500to600*0+1" >> binstats.jnl

      echo "Let depth600to700_area = depth600to700*0+1" >> binstats.jnl

      echo "Let depth700to800_area = depth700to800*0+1" >> binstats.jnl

      echo "Let depth800to900_area = depth800to900*0+1" >> binstats.jnl

      echo "Let depth900to1000_area = depth900to1000*0+1" >> binstats.jnl

      echo "list/clobber/nohead/file=\"/Data/Projects/CMIP5_p50/WOA/p50depthav_bins.txt\"/format=tab/append \"rcp8.5\", \"${species}\", ${p50}, ${deltaH}, depth0to100_area[x=@din, y=@din], depth100to200_area[x=@din, y=@din], depth200to300_area[x=@din, y=@din], depth300to400_area[x=@din, y=@din], depth400to500_area[x=@din, y=@din], depth500to600_area[x=@din, y=@din], depth600to700_area[x=@din, y=@din], depth700to800_area[x=@din, y=@din], depth800to900_area[x=@din, y=@din], depth900to1000_area[x=@din, y=@din]" >> binstats.jnl

      echo "quit" >> binstats.jnl

      ferret <  binstats.jnl > ferret_out.txt

      rm ferret.jnl*

done
