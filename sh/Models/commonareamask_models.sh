#!/bin/sh
rm commonmask.jnl

for model in cesm1 esm2g esm2m hadgem2 ipsl mpi
do

  echo "SET DATA \"/Data/Projects/CMIP5_p50/${model}/Katsuwonus_pelamis/deltap50depth/${model}.deltap50depthav.Katsuwonus_pelamis.nc\", \"/Data/Projects/CMIP5_p50/${model}/Thunnus_alalunga/deltap50depth/${model}.deltap50depthav.Thunnus_alalunga.nc\", \"/Data/Projects/CMIP5_p50/${model}/Thunnus_albacares/deltap50depth/${model}.deltap50depthav.Thunnus_albacares.nc\", \"/Data/Projects/CMIP5_p50/${model}/Thunnus_maccoyii/deltap50depth/${model}.deltap50depthav.Thunnus_maccoyii.nc\", \"/Data/Projects/CMIP5_p50/${model}/Thunnus_obesus/deltap50depth/${model}.deltap50depthav.Thunnus_obesus.nc\", \"/Data/Projects/CMIP5_p50/${model}/Thunnus_thynnus/deltap50depth/${model}.deltap50depthav.Thunnus_thynnus.nc\"" > commonmask.jnl

  echo "Let mask1 = DELTAP50DEPTHAV[d=1]*0+1" >> commonmask.jnl
  echo "Let mask2 = DELTAP50DEPTHAV[d=2]*0+1" >> commonmask.jnl
  echo "Let mask3 = DELTAP50DEPTHAV[d=3]*0+1" >> commonmask.jnl
  echo "Let mask4 = DELTAP50DEPTHAV[d=4]*0+1" >> commonmask.jnl
  echo "Let mask5 = DELTAP50DEPTHAV[d=5]*0+1" >> commonmask.jnl
  echo "Let mask6 = DELTAP50DEPTHAV[d=6]*0+1" >> commonmask.jnl

  echo "Let maskall = mask1 * mask2 * mask3 * mask4 * mask5 * mask6" >> commonmask.jnl

  echo "Let mask1_H0 = DELTAP50DEPTHAV_DELTAH0[d=1]*0+1" >> commonmask.jnl
  echo "Let mask2_H0 = DELTAP50DEPTHAV_DELTAH0[d=2]*0+1" >> commonmask.jnl
  echo "Let mask3_H0 = DELTAP50DEPTHAV_DELTAH0[d=3]*0+1" >> commonmask.jnl
  echo "Let mask4_H0 = DELTAP50DEPTHAV_DELTAH0[d=4]*0+1" >> commonmask.jnl
  echo "Let mask5_H0 = DELTAP50DEPTHAV_DELTAH0[d=5]*0+1" >> commonmask.jnl
  echo "Let mask6_H0 = DELTAP50DEPTHAV_DELTAH0[d=6]*0+1" >> commonmask.jnl

  echo "Let maskall_H0 = mask1_H0 * mask2_H0 * mask3_H0 * mask4_H0 * mask5_H0 * mask6_H0" >> commonmask.jnl

  echo "define att maskall.long_name = \"Mask for Common Area, ${model} rcp8.5 deltap50depthav\"" >> commonmask.jnl
  echo "define att maskall_H0.long_name = \"Mask for Common Area, ${model} rcp8.5 deltap50depthav deltaH=0\"" >> commonmask.jnl

  echo "Set memory/size=200" >> commonmask.jnl

  echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/${model}/${model}.mask.deltap50depthav.nc\" maskall, maskall_H0" >> commonmask.jnl

  echo "quit" >> commonmask.jnl

  ferret < commonmask.jnl > test_output.txt

  rm ferret.jnl*

done
