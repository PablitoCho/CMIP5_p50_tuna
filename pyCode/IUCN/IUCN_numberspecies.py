#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import pandas
np.set_printoptions(threshold=np.nan)

left = 0.04
bottom = 0.04
width = 0.9
height = 0.9

file = '/Data/Projects/CMIP5_p50/IUCN/geography_numspecies.nc'
nc = Dataset(file,'r')
lats = nc.variables['LAT'][:]
lons = nc.variables['LON'][:]
nsp = nc.variables['NUMSPECIES'][:]
nsp = nsp.squeeze()
fig = plt.figure(1, figsize(4,3))
axg1 = plt.axes([left,bottom,width,height])
m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='eck4',lon_0=200.5)
nsp_cyclic, lons_cyclic = addcyclic(nsp[:,:], lons)
nsp_cyclic, lons_cyclic = shiftgrid(20.5, nsp_cyclic, lons_cyclic, start=True)
x, y = m(*np.meshgrid(lons_cyclic, lats))
m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
m.drawcoastlines()
m.fillcontinents(color='grey', lake_color='0.5')
levels=[1,2,3,4,5,6,7]
im1 = m.contourf(x,y,nsp_cyclic,levels, colors=('#ffff33','#e41a1c','#377eb8','#984ea3','#4daf4a','#ff7f00'))

cb = m.colorbar(im1,"bottom", size="10%", pad="5%", ticks=[0.5,1.5,2.5,3.5,4.5,5.5,6.5])
cb.ax.set_xticklabels(['1','2','3','4','5','6'])
#cb.set_ticks([0,250,500,750,1000])
#cb.set_ticklabels([0,250,500,750,1000])
#cb=fig.colorbar(im1, cax=cax, ticks=levels, orientation='horizontal')
#cb.set_ticklabels([0,1,2,3,4,5,6])

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/Geo_NumSpecies.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
