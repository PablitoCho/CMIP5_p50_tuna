#!/bin/sh
rm p50depth.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/CMIP5/ESM2M/processed/controls/ocean.0281-0300.temp.nc\", \"/Data/CMIP5/ESM2M/processed/controls/esm2m.0281-0300.po2.nc\"" > p50depth.jnl

  echo "Let p50_critter = ${p50}" >> p50depth.jnl #kPa

  echo "Let deltaH_critter = ${deltaH}" >> p50depth.jnl  #kJ mol^-1 

  echo "Let R =  0.008314" >> p50depth.jnl  #kJ mol^-1 K^-1 universal gas constant

  echo "Let tempK = temp[d=1]" >> p50depth.jnl #Convert to Kelvin

  echo "Let tempK_ml = temp[d=1, z=10]" >> p50depth.jnl #Convert to Kelvin

  echo "Let tempshift_p50 = (deltaH_critter*((1/tempK)-(1/tempK_ml))/(2.303*R))" >> p50depth.jnl #Van't Hoff Equation 

  echo "Let p50 = 10^(log(p50_critter) + tempshift_p50)" >> p50depth.jnl

  echo "Let p50_diff = po2[d=2]-p50" >> p50depth.jnl

  echo "Let p50depth = p50_diff[z=@loc:0]" >> p50depth.jnl

  echo "Let p50av = p50[l=@ave]" >> p50depth.jnl

  echo "Let p50av_diff = po2[d=2,l=@ave]-p50av" >> p50depth.jnl

  echo "Let p50depthav = p50av_diff[z=@loc:0]" >> p50depth.jnl

  echo "define att p50.long_name = \"50% Blood Oxygenation\"" >> p50depth.jnl

  echo "define att p50.units = \"kPa\"" >> p50depth.jnl

  echo "define att p50.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50.species_deltaH = \"${deltaH}\"" >> p50depth.jnl

  echo "define att p50depth.long_name = \"Depth of P50 Threshold\"" >> p50depth.jnl

  echo "define att p50depth.units = \"m\"" >> p50depth.jnl

  echo "define att p50depth.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50depth.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50depth.species_deltaH = \"${deltaH}\"" >> p50depth.jnl

  echo "define att p50av.long_name = \"50% Blood Oxygenation\"" >> p50depth.jnl

  echo "define att p50av.units = \"kPa\"" >> p50depth.jnl

  echo "define att p50av.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50av.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50av.species_deltaH = \"${deltaH}\"" >> p50depth.jnl
	
  echo "define att p50depthav.long_name = \"50% Blood Oxygenation\"" >> p50depth.jnl

  echo "define att p50depthav.units = \"kPa\"" >> p50depth.jnl

  echo "define att p50depthav.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50depthav.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50depthav.species_deltaH = \"${deltaH}\"" >> p50depth.jnl

  echo "Set memory/size=200" >> p50depth.jnl	

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/BloodOxygenBinding/ESM2M_Blood/${species}/p50/esm2m.0281-0300.p50.${species}.nc\"/LLIMITS=1:20/L=1 p50" >> p50depth.jnl

  echo "repeat/L=2:20 (SAVE/APPEND/FILE=\"/Data/Projects/BloodOxygenBinding/ESM2M_Blood/${species}/p50/esm2m.0281-0300.p50.${species}.nc\"/L=\`l\` p50)" >> p50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/BloodOxygenBinding/ESM2M_Blood/${species}/p50depth/esm2m.0281-0300.p50depth.${species}.nc\"/LLIMITS=1:20/L=1 p50depth" >> p50depth.jnl

  echo "repeat/L=2:20 (SAVE/APPEND/FILE=\"/Data/Projects/BloodOxygenBinding/ESM2M_Blood/${species}/p50depth/esm2m.0281-0300.p50depth.${species}.nc\"/L=\`l\` p50depth)" >> p50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/BloodOxygenBinding/ESM2M_Blood/${species}/p50av/esm2m.0281-0300.p50av.${species}.nc\" p50av" >> p50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/BloodOxygenBinding/ESM2M_Blood/${species}/p50depthav/esm2m.0281-0300.p50depthav.${species}.nc\" p50depthav" >> p50depth.jnl

  echo "quit" >> p50depth.jnl

  ferret < p50depth.jnl > test_output.txt
	
  rm ferret.jnl*
	
done