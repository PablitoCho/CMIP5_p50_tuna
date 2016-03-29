#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import pandas

Folder = '/Data/Projects/CMIP5_p50'
species1 = ['Thunnus_obesus', 'Thunnus_albacares', 'Katsuwonus_pelamis', 'Thunnus_alalunga', 'Thunnus_thynnus', 'Thunnus_orientalis', 'Thunnus_maccoyii']
species2 = ['Thunnus obesus', 'Thunnus albacares', 'Katsuwonus pelamis', 'Thunnus alalunga', 'Thunnus thynnus', 'Thunnus orientalis', 'Thunnus maccoyii']


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
  fig = plt.figure(1, figsize(7.5,8))
  axg1 = plt.axes(g[i])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='eck4',lon_0=205)
  depth_cyclic, lons_cyclic = addcyclic(depth[:,:], lons)
  depth_cyclic, lons_cyclic = shiftgrid(20., depth_cyclic, lons_cyclic, start=True)
  x, y = m(*np.meshgrid(lons_cyclic, lats))
  a, b = m(pandas.DataFrame.as_matrix(agreelons), pandas.DataFrame.as_matrix(agreelats))
  m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='grey', lake_color='0.5')
  levels=[-200,-150, -100, -50, 0, 50, 100, 150, 200]
  im1 = m.contourf(x,y,depth_cyclic, levels, cmap=plt.cm.PiYG_r, extend='both')
  im2 = m.scatter(a,b,s=1.2, marker='o', facecolor='0', lw=0)
  plt.title(species2[i], fontsize=12)
#  plt.suptitle("Model Mean P50 Depth Change")
#  if i==5:
#    cb_axes = plt.subplot2grid((4, 2), (0, 1), rowspan=3)
#    cb = m.colorbar(im1,ax=cb_axes, size="30%")
#    cb.set_ticks([-200,-150,-100,-50,0,50,100,150,200])
#    cb.set_ticklabels([-200,'',-100,'',0,'',100,'',200])
  i=i+1

cax = fig.add_axes([0.54, 0.2, 0.42, 0.03])
cb=fig.colorbar(im1, cax=cax, orientation='horizontal')
cb.set_ticklabels([-200,'',-100,'',0,'',100,'',200])

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/modelmean_deltap50depthav.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
