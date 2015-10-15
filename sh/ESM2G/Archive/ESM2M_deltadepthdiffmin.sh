#!/bin/sh
rm deltadepthdiffmin.jnl

while IFS=, read -r species p50 deltaH
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/diffmin/esm2m.0281-0300.diffmin.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/diffmin/esm2m.0381-0400.diffmin.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/diffmin/esm2m.1981-2000.diffmin.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/diffmin/esm2m.rcp85.2081-2100.diffmin.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthdiffmin/esm2m.0281-0300.depthdiffmin.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthdiffmin/esm2m.0381-0400.depthdiffmin.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthdiffmin/esm2m.1981-2000.depthdiffmin.${species}.nc\", \"/Data/Projects/CMIP5_p50/ESM2M_Blood/${species}/depthdiffmin/esm2m.rcp85.2081-2100.depthdiffmin.${species}.nc\"" > deltadepthdiffmin.jnl

  echo "Let select5 = if(depthdiffmin[d=5] GE 2000) then 0 else depthdiffmin[d=5]" >> deltadepthdiffmin.jnl
  echo "Let ig5 = ignore0(select5)" >> deltadepthdiffmin.jnl
  echo "Let mask5 = ig5*0+1" >> deltadepthdiffmin.jnl

  echo "Let select6 = if(depthdiffmin[d=6] GE 2000) then 0 else depthdiffmin[d=6]" >> deltadepthdiffmin.jnl
  echo "Let ig6 = ignore0(select6)" >> deltadepthdiffmin.jnl
  echo "Let mask6 = ig6*0+1" >> deltadepthdiffmin.jnl

  echo "Let select7 = if(depthdiffmin[d=7] GE 2000) then 0 else depthdiffmin[d=7]" >> deltadepthdiffmin.jnl
  echo "Let ig7 = ignore0(select7)" >> deltadepthdiffmin.jnl
  echo "Let mask7 = ig7*0+1" >> deltadepthdiffmin.jnl

  echo "Let select8 = if(depthdiffmin[d=8] GE 2000) then 0 else depthdiffmin[d=8]" >> deltadepthdiffmin.jnl
  echo "Let ig8 = ignore0(select8)" >> deltadepthdiffmin.jnl
  echo "Let mask8 = ig8*0+1" >> deltadepthdiffmin.jnl

  echo "Let hist_diffmin = (diffmin[d=3]*mask7)-(diffmin[d=1]*mask5)" >> deltadepthdiffmin.jnl
  echo "Let rcp85_diffmin = (diffmin[d=4]*mask8)-(diffmin[d=2]*mask6)" >> deltadepthdiffmin.jnl
  echo "Let deltadiffmin = hist_diffmin-rcp85_diffmin" >> deltadepthdiffmin.jnl

  echo "Let hist_depthdiffmin = (depthdiffmin[d=7]*mask7)-(depthdiffmin[d=5]*mask5)" >> deltadepthdiffmin.jnl
  echo "Let rcp85_depthdiffmin = (depthdiffmin[d=8]*mask8)-(depthdiffmin[d=6]*mask6)" >> deltadepthdiffmin.jnl
  echo "Let deltadepthdiffmin = hist_depthdiffmin-rcp85_depthdiffmin" >> deltadepthdiffmin.jnl

  echo "Let delta_diffmin_av = deltadiffmin[x=@ave, y=@ave]" >> deltadepthdiffmin.jnl
  echo "Let delta_depthdiffmin_av = deltadepthdiffmin[x=@ave, y=@ave]" >> deltadepthdiffmin.jnl
  echo "Let delta_diffmin_sd = deltadiffmin[x=@var, y=@var]^0.5" >> deltadepthdiffmin.jnl
  echo "Let delta_depthdiffmin_sd = deltadepthdiffmin[x=@var, y=@var]^0.5" >> deltadepthdiffmin.jnl

  echo "Let abs_delta_diffmin = abs(deltadiffmin)" >> deltadepthdiffmin.jnl
  echo "Let abs_delta_depthdiffmin = abs(deltadepthdiffmin)" >> deltadepthdiffmin.jnl
  echo "Let abs_delta_diffmin_av = abs_delta_diffmin[x=@ave, y=@ave]" >> deltadepthdiffmin.jnl
  echo "Let abs_delta_depthdiffmin_av = abs_delta_depthdiffmin[x=@ave, y=@ave]" >> deltadepthdiffmin.jnl
  echo "Let abs_delta_diffmin_sd = abs_delta_diffmin[x=@var, y=@var]^0.5" >> deltadepthdiffmin.jnl
  echo "Let abs_delta_depthdiffmin_sd = abs_delta_depthdiffmin[x=@var, y=@var]^0.5" >> deltadepthdiffmin.jnl


echo "define att deltadiffmin.long_name = \"Change in the Minimum Difference in Oxygen Pressure Between Blood and Environment\"" >> deltadepthdiffmin.jnl
  echo "define att deltadiffmin.units = \"kPa\"" >> deltadepthdiffmin.jnl
  echo "define att deltadiffmin.scenario = \"RCP 8.5\"" >> deltadepthdiffmin.jnl
  echo "define att deltadiffmin.species = \"${species}\"" >> deltadepthdiffmin.jnl
  echo "define att deltadiffmin.species_p50 = \"${p50}\"" >> deltadepthdiffmin.jnl
  echo "define att deltadiffmin.species_deltaH = \"${deltaH}\"" >> deltadepthdiffmin.jnl

echo "define att deltadepthdiffmin.long_name = \"Change in the Depth of the Minimum Difference in Oxygen Pressure Between Blood and Environment\"" >> deltadepthdiffmin.jnl
  echo "define att deltadepthdiffmin.units = \"kPa\"" >> deltadepthdiffmin.jnl
  echo "define att deltadepthdiffmin.scenario = \"RCP 8.5\"" >> deltadepthdiffmin.jnl
  echo "define att deltadepthdiffmin.species = \"${species}\"" >> deltadepthdiffmin.jnl
  echo "define att deltadepthdiffmin.species_p50 = \"${p50}\"" >> deltadepthdiffmin.jnl
  echo "define att deltadepthdiffmin.species_deltaH = \"${deltaH}\"" >> deltadepthdiffmin.jnl

  echo "list/nohead/file=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/ESM2M.rcp85.diffmin.geostats.txt\"/format=tab/append \"${species}\", ${p50}, ${deltaH}, delta_diffmin_av, delta_diffmin_sd, delta_depthdiffmin_av, delta_depthdiffmin_sd, abs_delta_diffmin_av, abs_delta_diffmin_sd, abs_delta_depthdiffmin_av, abs_delta_depthdiffmin_sd" >> deltadepthdiffmin.jnl
 	
  echo "SAVE/CLOBBER/FILE=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/deltadiffmin/ESM2M.rcp85.deltadiffmin.${species}.nc\" deltadiffmin" >> deltadepthdiffmin.jnl

  echo "SAVE/CLOBBER/FILE=\"/Users/kasmith/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/deltadepthdiffmin/ESM2M.rcp85.deltadepthdiffmin.${species}.nc\" deltadepthdiffmin" >> deltadepthdiffmin.jnl

  echo "quit" >> deltadepthdiffmin.jnl

  ferret < deltadepthdiffmin.jnl > test_output.txt
	
  rm ferret.jnl*
	
done