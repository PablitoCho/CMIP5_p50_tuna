#!/bin/sh
rm p50depth.jnl

while IFS=, read -r species p50 deltaH
do
  
  mkdir results/WOA
  mkdir results/WOA/${species}
  mkdir results/WOA/${species}/p50
  mkdir results/WOA/${species}/p50depth

  echo "SET DATA \"data/WOA/WOA_po2_monthly_1deg.nc\", \"data/WOA/temperature_monthly_1deg.nc\"" >p50depth.jnl

  echo "Let p50_critter = ${p50}" >> p50depth.jnl #kPa

  echo "Let deltaH_critter = ${deltaH}" >> p50depth.jnl  #kJ mol^-1 

  echo "Let R =  0.008314" >> p50depth.jnl  #kJ mol^-1 K^-1 universal gas constant

  echo "Let tempK = t_an[d=2] + 273.15" >> p50depth.jnl

  echo "Let tempK_ml = tempK[z=10]" >> p50depth.jnl

  echo "Let tempshift_p50 = (deltaH_critter*((1/tempK)-(1/tempK_ml))/(2.303*R))" >> p50depth.jnl #Van't Hoff Equation 

  echo "Let p50 = 10^(log(p50_critter) + tempshift_p50)" >> p50depth.jnl

  echo "Let p50_diff = po2[d=1]-p50" >> p50depth.jnl

  echo "Let p50depth = p50_diff[z=@loc:0]" >> p50depth.jnl

  echo "Let p50_diff_deltaH0 = po2[d=1]-p50_critter" >> p50depth.jnl

  echo "Let p50depth_deltaH0 = p50_diff_deltaH0[z=@loc:0]" >> p50depth.jnl

  echo "Let p50av = p50[l=@ave]" >> p50depth.jnl

  echo "Let p50depthav = p50depth[l=@ave]" >> p50depth.jnl

  echo "Let p50depthav_deltaH0 = p50depth_deltaH0[l=@ave]" >> p50depth.jnl


  echo "define att p50.long_name = \"50% Blood Oxygenation\"" >> p50depth.jnl

  echo "define att p50.units = \"kPa\"" >> p50depth.jnl

  echo "define att p50.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50.species_deltaH = \"${deltaH}\"" >> p50depth.jnl


  echo "define att p50depth_deltaH0.long_name = \"Depth of P50 Threshold when deltaH=0\"" >> p50depth.jnl

  echo "define att p50depth_deltaH0.units = \"m\"" >> p50depth.jnl

  echo "define att p50depth_deltaH0.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50depth_deltaH0.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50depth_deltaH0.species_deltaH = \"0\"" >> p50depth.jnl


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


  echo "define att p50depthav.long_name = \"Depth of P50 Threshold\"" >> p50depth.jnl

  echo "define att p50depthav.units = \"m\"" >> p50depth.jnl

  echo "define att p50depthav.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50depthav.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50depthav.species_deltaH = \"${deltaH}\"" >> p50depth.jnl


  echo "define att p50depthav_deltaH0.long_name = \"Depth of P50 Threshold when deltaH=0\"" >> p50depth.jnl

  echo "define att p50depthav_deltaH0.units = \"m\"" >> p50depth.jnl

  echo "define att p50depthav_deltaH0.species = \"${species}\"" >> p50depth.jnl

  echo "define att p50depthav_deltaH0.species_p50 = \"${p50}\"" >> p50depth.jnl

  echo "define att p50depthav_deltaH0.species_deltaH = \"0\"" >> p50depth.jnl


  echo "Set memory/size=200" >> p50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"results/WOA/${species}/p50/woa.p50.${species}.nc\"/LLIMITS=1:12/L=1 p50" >> p50depth.jnl

  echo "repeat/L=2:12 (SAVE/APPEND/FILE=\"results/WOA/${species}/p50/woa.p50.${species}.nc\"/L=\`l\` p50)" >> p50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"results/WOA/${species}/p50depth/woa.p50depth.${species}.nc\"/LLIMITS=1:12/L=1 p50depth, p50depth_deltaH0" >> p50depth.jnl

  echo "repeat/L=2:12 (SAVE/APPEND/FILE=\"results/WOA/${species}/p50depth/woa.p50depth.${species}.nc\"/L=\`l\` p50depth, p50depth_deltaH0)" >> p50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"results/WOA/${species}/p50/woa.p50av.${species}.nc\" p50av" >> p50depth.jnl

  echo "SAVE/CLOBBER/FILE=\"results/WOA/${species}/p50depth/woa.p50depthav.${species}.nc\" p50depthav, p50depthav_deltaH0" >> p50depth.jnl

  echo "quit" >> p50depth.jnl

  ferret < p50depth.jnl 
	
  rm ferret.jnl*
  rm p50depth.jnl 
	
done

