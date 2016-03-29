#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import pandas

Folder = '/Data/Projects/CMIP5_p50'
species1 = ['Thunnus_obesus', 'Thunnus_orientalis']
species2 = ['Thunnus obesus', 'Thunnus orientalis']

bottomlist = [0.5, 0.05]
width = 0.8
height = 0.5

g = [[0.1, bottomlist[0], width, height], [0.1, bottomlist[1], width, height]]

i = 0
while i<len(species1):
  file = Folder + '/modelmean/modelmean.deltap50depth.' + species1[i] + '.nc'
  file2 = Folder + '/IUCN/csv_5deg/IUCN_5deg_' + species1[i] + '.csv'
  nc = Dataset(file,'r')
  lats = nc.variables['LAT'][:]
  lons = nc.variables['LON'][:]
  depth = nc.variables['MODELMEAN'][:]
  depth = depth.squeeze()
  agree = pandas.read_csv(file2, names=['lons', 'lats'])
  agree['lons2'] = np.where(agree['lons'] <= 20 , agree['lons'] + 360, agree['lons'])
  agreelons = agree['lons2']
  agreelats = agree['lats']
  fig = plt.figure(1, figsize(5,5.5))
  axg1 = plt.axes(g[i])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='eck4',lon_0=205)
  depth_cyclic, lons_cyclic = addcyclic(depth[:,:], lons)
  depth_cyclic, lons_cyclic = shiftgrid(20., depth_cyclic, lons_cyclic, start=True)
  x, y = m(*np.meshgrid(lons_cyclic, lats))
  a, b = m(pandas.DataFrame.as_matrix(agreelons), pandas.DataFrame.as_matrix(agreelats))
  m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='grey', lake_color='0.5')
  im1 = m.pcolor(x,y,depth_cyclic,cmap=plt.cm.BrBG, vmin=-200, vmax=200)
  im2 = m.scatter(a,b,s=1.2, marker='o', facecolor='0', lw=0)
  plt.title(species2[i], fontsize=12)
#  plt.suptitle("Model Mean P50 Depth Change")
  i=i+1

cb = m.colorbar(im1,"bottom", size="10%", pad="5%")
cb.set_ticks([-200,-100,0,100,200])
cb.set_ticklabels([-200,-100,0,100,200])
plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/modelmean_deltap50depthav.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
