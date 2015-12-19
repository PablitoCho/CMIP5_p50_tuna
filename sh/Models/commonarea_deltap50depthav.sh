#!/bin/sh
rm commonarea.jnl

while IFS=, read -r species p50 deltaH
do

for model in cesm1 esm2g esm2m hadgem2 ipsl mpi
do

    echo "SET DATA \"/Data/Projects/CMIP5_p50/${model}/${species}/deltap50depth/${model}.deltap50depthav.${species}.nc\", \"/Data/Projects/CMIP5_p50/${model}/${model}.mask.deltap50depthav.nc\"" > commonarea.jnl

    echo "Let deltap50depthav_mask = DELTAP50DEPTHAV[d=1] * maskall[d=2]" >> commonarea.jnl

    echo "Let deltap50depthav_deltaH_mask = DELTAP50DEPTHAV_DELTAH0[d=1] * maskall_H0[d=2]" >> commonarea.jnl

    echo "Set memory/size=200" >> commonarea.jnl

    echo "SAVE/CLOBBER/FILE=\"/Data/Projects/CMIP5_p50/${model}/${species}/deltap50depth/${model}.deltap50depthav.commonarea.${species}.nc\" deltap50depthav_mask, deltap50depthav_deltaH_mask" >> commonarea.jnl

    echo "quit" >> commonarea.jnl

  ferret < commonarea.jnl > test_output.txt

  rm ferret.jnl*

done
done
