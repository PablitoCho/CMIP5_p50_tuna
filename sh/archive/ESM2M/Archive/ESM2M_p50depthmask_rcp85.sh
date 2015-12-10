#!/bin/sh
rm p50depthmask.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/CMIP5/ESM2M/processed/rcp8.5/ocean.rcp85.2081-2100.temp.nc\", \"/Data/CMIP5/ESM2M/processed/rcp8.5/esm2m.rcp85.2081-2100.po2.nc\"" > p50depthmask.jnl

  echo "Let p50_critter = ${p50}" >> p50depthmask.jnl #kPa

  echo "Let deltaH_critter = ${deltaH}" >> p50depthmask.jnl  #kJ mol^-1

  echo "Let R =  0.008314" >> p50depthmask.jnl  #kJ mol^-1 K^-1 universal gas constant

  echo "Let tempK = temp[d=1]" >> p50depthmask.jnl #Convert to Kelvin

  echo "Let tempK_ml = temp[d=1, z=10]" >> p50depthmask.jnl #Convert to Kelvin

  echo "Let tempshift_p50 = (deltaH_critter*((1/tempK)-(1/tempK_ml))/(2.303*R))" >> p50depthmask.jnl #Van't Hoff Equation

  echo "Let p50 = 10^(log(p50_critter) + tempshift_p50)" >> p50depthmask.jnl

  echo "Let p50_diff = po2[d=2]-p50" >> p50depthmask.jnl

  echo "Let p50depth = p50_diff[z=@loc:0]" >> p50depthmask.jnl

  echo "Let p50av = p50[l=@ave]" >> p50depthmask.jnl

  echo "Let p50av_diff = po2[d=2,l=@ave]-p50av" >> p50depthmask.jnl

  echo "Let p50depthav = p50av_diff[z=@loc:0]" >> p50depthmask.jnl

  echo "Let p50depthmask = p50depthav*0+1" >> p50depthmask.jnl

  echo "Set memory/size=200" >> p50depthmask.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/p50depthmask/esm2m.rcp85.2081-2100.p50depthmask.${species}.nc\" p50depthmask" >> p50depthmask.jnl

  echo "quit" >> p50depthmask.jnl

  ferret < p50depthmask.jnl > test_output.txt

  rm ferret.jnl*

done
