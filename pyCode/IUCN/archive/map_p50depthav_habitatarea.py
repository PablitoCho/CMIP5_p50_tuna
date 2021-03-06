#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import pandas

Folder = '/Data/Projects/CMIP5_p50'
species1 = ['Thunnus_obesus', 'Thunnus_albacares', 'Katsuwonus_pelamis', 'Thunnus_alalunga', 'Thunnus_thynnus', 'Thunnus_maccoyii', 'Thunnus_orientalis']
species2 = ['Thunnus obesus', 'Thunnus albacares', 'Katsuwonus pelamis', 'Thunnus alalunga', 'Thunnus thynnus', 'Thunnus maccoyii', 'Thunnus_orientalis']


#leftlist = [0.02, 0.216, 0.412, 0.608, 0.804]
#leftlist = [0.02, 0.24, 0.48, 0.72]
#bottomlist = [0.755, 0.51, 0.265, 0.02]
bottomlist = [0.7525, 0.505, 0.2575, 0.01]
#bottomlist = [0.66, 0.42, 0.17]

width = 0.42
#height = 0.225
#height = 0.23
height = 0.20

g = [[0.04, bottomlist[0], width, height], [0.54, bottomlist[0], width, height],
     [0.04, bottomlist[1], width, height], [0.54, bottomlist[1], width, height],
     [0.04, bottomlist[2], width, height], [0.54, bottomlist[2], width, height],
     [0.04, bottomlist[3], width, height]]

i = 0
while i<len(species1):
  file = Folder + '/WOA/'+ species1[i] + '/p50depth/woa.p50depthav.' + species1[i] + '.nc'
  file2 = Folder + '/IUCN/csv_5deg/IUCN_5deg_' + species1[i] + '.csv'
  nc = Dataset(file,'r')
  lats = nc.variables['LAT'][:]
  lons = nc.variables['LON'][:]
  depth = nc.variables['P50DEPTHAV'][:]
  depth = depth.squeeze()
  agree = pandas.read_csv(file2, names=['lons', 'lats'])
  agree['lons2'] = np.where(agree['lons'] <= 20 , agree['lons'] + 360, agree['lons'])
  agreelons = agree['lons2']
  agreelats = agree['lats']
  fig = plt.figure(1, figsize(8,10))
  axg1 = plt.axes(g[i])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='cyl',lon_0=200)
  depth_cyclic, lons_cyclic = addcyclic(depth[:,:], lons)
  depth_cyclic, lons_cyclic = shiftgrid(20., depth_cyclic, lons_cyclic, start=True)
  x, y = m(*np.meshgrid(lons_cyclic, lats))
  a, b = m(agreelons, agreelats)
  m.drawmapboundary(fill_color='0.7') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='black', lake_color='0.5')
  im1 = m.pcolor(x,y,depth_cyclic,cmap=plt.cm.jet_r, vmin=0, vmax=1000)
  im2 = m.scatter(a,b,s=1, marker='o', facecolor='0', lw=0)
  cb = m.colorbar(im1,"bottom", size="5%", pad="2%")
  cb.set_ticks([0,250,500,750,1000])
  cb.set_ticklabels([0,250,500,750,1000])
  plt.title(species2[i], fontsize=12)
  plt.suptitle("WOA P50 Depth, Stippling=IUCN Habitat")
  i=i+1

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/p50_habitats.ps'
plt.savefig(outfig, dpi=100, bbox_inches=0)
