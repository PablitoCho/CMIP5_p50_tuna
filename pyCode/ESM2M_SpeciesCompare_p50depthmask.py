#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab

Folder = '/Data/Projects/CMIP5_p50/ESM2M_Blood/'
species1 = ['Thunnus_thynnus', 'Thunnus_obesus', 'Thunnus_maccoyii', 'Thunnus_albacares', 'Scomber_japonicus', 'Katsuwonus_pelamis']

#leftlist = [0.02, 0.216, 0.412, 0.608, 0.804]
leftlist = [0.02, 0.24, 0.48, 0.72]
#bottomlist = [0.755, 0.51, 0.265, 0.02]
#bottomlist = [0.7525, 0.505, 0.2575, 0.01]
bottomlist = [0.76, 0.52, 0.27, 0.02]

width = 0.42
#height = 0.225
height = 0.23
#height = 0.20

g = [[0.06, bottomlist[0], width, height], [0.56, bottomlist[0], width, height],
     [0.06, bottomlist[1], width, height], [0.56, bottomlist[1], width, height],
[0.06, bottomlist[2], width, height], [0.56, bottomlist[2], width, height],
[0.06, bottomlist[3], width, height], [0.56, bottomlist[3], width, height]]

i = 0
while i<len(species1):
  file1 = Folder + '/' + species1[i] + '/p50depthmask/esm2m.rcp85.2081-2100.p50depthmask.' + species1[i] + '.nc'
  nc1 = Dataset(file1,'r')
  file2 = Folder + '/' + species1[i] + '/p50depthmask/esm2m.1981-2000.p50depthmask.' + species1[i] + '.nc'
  nc2 = Dataset(file2,'r')
  lats1 = nc1.variables['YT_OCEAN'][:]
  lons1 = nc1.variables['XT_OCEAN'][:]
  lats2 = nc2.variables['YT_OCEAN'][:]
  lons2 = nc2.variables['XT_OCEAN'][:]
  mask1 = nc1.variables['P50DEPTHMASK'][:]
  mask1 = mask1.squeeze()
  mask2 = nc2.variables['P50DEPTHMASK'][:]
  mask2 = mask2.squeeze()
  fig = plt.figure(1, figsize(8,10))
  axg1 = plt.axes(g[i])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='cyl',lon_0=200)
  mask1_cyclic, lons1_cyclic = addcyclic(mask1[:,:], lons1)
  mask1_cyclic, lons1_cyclic = shiftgrid(20., mask1_cyclic, lons1_cyclic, start=True)
  mask2_cyclic, lons2_cyclic = addcyclic(mask2[:,:], lons2)
  mask2_cyclic, lons2_cyclic = shiftgrid(20., mask2_cyclic, lons2_cyclic, start=True)
  x1, y1 = m(*np.meshgrid(lons1_cyclic, lats1))
  x2, y2 = m(*np.meshgrid(lons2_cyclic, lats2))
  m.drawmapboundary(fill_color='white') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='black', lake_color='0.5')
  if (i == 0) or (i == 2) or (i == 4) or (i == 6):
    m.drawparallels(np.arange(-90.,120.,30.),labels=[1,0,0,0])
  else:
    m.drawparallels(np.arange(-90.,120.,30.),labels=[0,0,0,0])
  m.drawmeridians(np.arange(0.,420.,60.),labels=[0,0,0,0])
  im1 = m.contourf(x1,y1,mask1_cyclic, alpha=1, colors='red')
  im3 = m.contourf(x2,y2,mask2_cyclic, alpha=0.5, colors='blue')
  cb.set_ticks([-200,-100,0,100,200])
  cb.set_ticklabels([-200,-100,0,100,200])
  plt.title(species1[i], fontsize=12)
  plt.suptitle("ESM2M P50 Depth")
  i=i+1

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/ESM2M_species_global.ps'
plt.savefig(outfig, dpi=72, bbox_inches=0)
