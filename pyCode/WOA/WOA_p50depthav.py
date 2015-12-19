#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab

Folder = '/Data/Projects/CMIP5_p50/WOA/'
species1 = ['Thunnus_obesus', 'Thunnus_albacares', 'Katsuwonus_pelamis', 'Thunnus_alalunga', 'Thunnus_thynnus', 'Thunnus_maccoyii']


leftlist = [0.02, 0.216, 0.412, 0.608, 0.804]
#bottomlist = [0.755, 0.51, 0.265, 0.02]
#bottomlist = [0.7525, 0.505, 0.2575, 0.01]
bottomlist = [0.66, 0.42, 0.17]

width = 0.42
#height = 0.225
#height = 0.2575
height = 0.20

g = [[0.04, bottomlist[0], width, height], [0.54, bottomlist[0], width, height],
     [0.04, bottomlist[1], width, height], [0.54, bottomlist[1], width, height],
[0.04, bottomlist[2], width, height], [0.54, bottomlist[2], width, height]]

i = 0
while i<len(species1):
  file = Folder + species1[i] + '/p50depth/woa.p50depthav.' + species1[i] + '.nc'
  nc = Dataset(file,'r')
  lats = nc.variables['LAT'][:]
  lons = nc.variables['LON'][:]
  lons2 = lons+360
  depth = nc.variables['P50DEPTHAV'][:]
  depth = depth.squeeze()
  fig = plt.figure(1, figsize(8,10))
  axg1 = plt.axes(g[i])
  m = Basemap(llcrnrlon=20.,llcrnrlat=-80.,urcrnrlon=380.,urcrnrlat=80.,projection='cyl',lon_0=180)
  x, y = m(*np.meshgrid(lons, lats))
  a, b = m(*np.meshgrid(lons2, lats))
  m.drawmapboundary(fill_color='0.7') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='black', lake_color='0.5')
      #    if (i == 0) or (i == 2) or (i == 4) or (i == 6):
      #      m.drawparallels(np.arange(-90.,120.,30.),labels=[1,0,0,0])
#  else:
#    m.drawparallels(np.arange(-90.,120.,30.),labels=[0,0,0,0])
#  m.drawmeridians(np.arange(0.,420.,60.),labels=[0,0,0,0])
  im1 = m.pcolor(x,y,depth,cmap=plt.cm.jet_r, vmin=0, vmax=500)
  im2 = m.pcolor(a,b,depth,cmap=plt.cm.jet_r, vmin=0, vmax=500)
  cb = m.colorbar(im1,"bottom", size="5%", pad="2%")
  cb.set_ticks([0,100,200,300,400,500])
  cb.set_ticklabels([0,100,200,300,400,500])
  plt.title(species1[i], fontsize=12)
  plt.suptitle("WOA P50 Depth")
  i=i+1

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/WOA_p50depthav.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
