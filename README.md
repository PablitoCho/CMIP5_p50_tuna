### CMIP5 P<sub>50</sub> Analysis  
-----------------------------  




**Please cite the following paper if you use this code:**

Mislan, K. A. S., C. A. Deutsch, R. W. Brill, J. P. Dunne, and J. L. Sarmiento. (2017) Projections of climate driven changes in tuna vertical habitat based on species-specific differences in blood oxygen affinity. Global Change Biology.

---------------------------
#### Software dependencies
---------------------------
**All the required software is open source.**

NOAA Ferret v7:[http://www.ferret.noaa.gov/Ferret/](http://www.ferret.noaa.gov/Ferret/)


Python v2.7.6: [https://www.python.org/](https://www.python.org/)  
Python packages: scipy 0.14.0, basemap 1.0.7, numpy 1.9.2, netCDF4 1.1.8, matplotlib 1.4.3

R v3.2.2: [http://www.r-project.org/](http://www.r-project.org/)  
R packages: ncdf 1.6.8, colorRamps 2.3, fields 8.2-1, caTools 1.17.1
library(RNetCDF)
library(ncdf4)
library(viridis)


**Operating system information:**

Mac OS X and Unix-like operating systems should be able to install NOAA Ferret and R without any additional dependencies.

NOAA Ferret running under Windows is not currently supported.  The NOAA Ferret [documentation](http://ferret.pmel.noaa.gov/Ferret/downloads/downloading_ferret) has suggestions for running NOAA Ferret on Windows operating systems.

---------------
#### Folders
---------------


--------------------------
#### Environmental data
--------------------------
#### IUCN data

Request spatial data for range areas from IUCN Red List of Threatened Species:  
[http://www.iucnredlist.org](http://www.iucnredlist.org)

**Transform IUCN spatial data from shape file to a mask:**  

Install the GDAL Geospatial Data Abstraction Library:   
[https://trac.osgeo.org/gdal/wiki/BuildHints](https://trac.osgeo.org/gdal/wiki/BuildHints)

Type in bash shell:  

    ogr2ogr -f "GMT" -dim 3 species.gmt species.shp

Install GMT5:    
[http://gmt.soest.hawaii.edu/projects/gmt/wiki/Download](http://gmt.soest.hawaii.edu/projects/gmt/wiki/Download)

Type in GMT5 bash shell (create the same grid as the World Ocean Atlas 1° grid):  

    gmt grdmask -R-179.5/179.5/-89.5/89.5 -I1 -f0x -f1y -NNaN/1/1 species.gmt -Gspecies.nc  

Use NCO tools:   

    ncrename -vz,mask species.nc


-------------------------------
#### Running the analysis code
-------------------------------
Generate climate projections for the end of the century by adding the modeled changes in climate to World Ocean Atlas data.  Results from 6 models are saved in the `data/CMIP5/projections` folder.

    ferret < ferret/Projections_modeldiff_WOA_rcp8.5.jnl

Convert dissolved oxygen to oxygen pressure (pO<sub>2</sub>). Results from 6 models are saved in the `data/CMIP5/projections` folder.  WOA results are saved in the `data/WOA` folder.

    ferret < ferret/Projections_convert_pO2.jnl  
    ferret < ferret/WOA_convert_pO2.jnl

Calculate p50 and p50 depth for the models and data.

    sh sh/Models_p50/p50depth_rcp8.5.sh < sh/Species_global4.csv
    sh sh/WOA_p50/WOA_p50depth.sh < sh/Species_global4.csv

Calculate the change in p50 depth

    sh sh/Models_p50/deltap50depth_rcp8.5.sh < sh/Species_global4.csv
    sh sh/Mean_AllModels/ModelMean_deltap50depth.sh < sh/Species_global4.csv

Convert IUCN Shape Files to NetCDF grid

    sh sh/IUCN/IUCN_shptonc.sh
    sh sh/IUCN/ConvertTo5deg.sh < sh/Species_global4.csv
    sh sh/IUCN/NetCDF_To_ascii.sh < sh/Species_global4.csv

Use IUCN mask to extract P50 depth for the habitat range of each tuna species from the models and WOA data

    sh sh/IUCN_P50Depth/IUCN_modelmean_P50Depth.sh < sh/Species_global4.csv
    sh sh/IUCN_P50Depth/IUCN_modelmean_deltaP50Depth.sh < sh/Species_global4.csv
    sh sh/IUCN_P50Depth/IUCN_WOA_P50Depth.sh < sh/Species_global4.csv

Calculate number of tuna species on a global map

    mkdir results/IUCN
    ferret < ferret/IUCN_GeoNumSpecies.jnl

Calculate projected changes in vertical separation for tuna.  First step is to calculate the number of tuna species with P50 depth measurements globally

    ferret < ferret/IUCN_GeoNumSpecies_P50depthanalysis.jnl
    ferret < ferret/Calculate_P50Depth_CommonArea_deltaseparation.jnl

-----------------------------
#### Verifying the results
-----------------------------


-----------------------------
#### Graphing the results
-----------------------------

-----------------------------
#### Acknowledgements
-----------------------------
