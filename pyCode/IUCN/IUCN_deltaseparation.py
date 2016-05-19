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
bottom = 0.1
width = 0.9
height = 0.9

file = '/Data/Projects/CMIP5_p50/IUCN_modelmean/IUCN.modelmean.deltaseparation.nc'
nc = Dataset(file,'r')
lats = nc.variables['LAT'][:]
lons = nc.variables['LON'][:]
nsp = nc.variables['CHANGE'][:]
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
levels=[0,1,2,3]
im1 = m.contourf(x,y,nsp_cyclic,levels, colors=('#e6ab02','#386cb0','#f0027f'))


cax = fig.add_axes([0.1, 0.15, 0.8, 0.06])
cb=fig.colorbar(im1, cax=cax, ticks=[0.5,1.5,2.5,3.5],orientation='horizontal')
cb.ax.set_xticklabels(['expansion','mixed','compression'])
text(0.17,-2, 'change in vertical separation', fontsize=12)

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/deltaseparation.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
