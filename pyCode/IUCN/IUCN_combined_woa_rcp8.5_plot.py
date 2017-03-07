#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import pandas
np.set_printoptions(threshold=np.nan)

Folder = '/Data/Projects/CMIP5_p50'
species1 = ['Thunnus_obesus', 'Katsuwonus_pelamis', 'Thunnus_orientalis']
species2 = ['bigeye tuna', 'skipjack tuna', 'Pacific bluefin tuna']

bottomlist = [0.72, 0.43, 0.14]
width = 0.46
height = 0.24

g = [[0.02, bottomlist[0], width, height], [0.52, bottomlist[0], width, height],
     [0.02, bottomlist[1], width, height], [0.52, bottomlist[1], width, height],
     [0.02, bottomlist[2], width, height], [0.52, bottomlist[2], width, height]]

i = 0
j = 0
while i<len(species1):
  file_WOA = Folder + '/WOA/'+ species1[i] + '/p50depth/woa.p50depthav.' + species1[i] + '.nc'
  file_IUCN = Folder + '/IUCN/csv_5deg/IUCN_5deg_' + species1[i] + '.csv'
  file_model = Folder + '/modelmean/modelmean.deltap50depth.' + species1[i] + '.nc'
  nc_WOA = Dataset(file_WOA,'r')
  lats = nc_WOA.variables['LAT'][:]
  lons = nc_WOA.variables['LON'][:]
  depth = nc_WOA.variables['P50DEPTHAV'][:]
  depth = depth.squeeze()
  geoarea = pandas.read_csv(file_IUCN, names=['lons', 'lats'])
  geoarea['lons2'] = np.where(geoarea['lons'] <= 20 , geoarea['lons'] + 360, geoarea['lons'])
  geoarealons = geoarea['lons2']
  geoarealats = geoarea['lats']
  fig = plt.figure(1, figsize(6,5.75))
  axg1 = plt.axes(g[j])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='eck4',lon_0=205)
  depth_cyclic, lons_cyclic = addcyclic(depth[:,:], lons)
  depth_cyclic, lons_cyclic = shiftgrid(20., depth_cyclic, lons_cyclic, start=True)
  x1, y1 = m(*np.meshgrid(lons_cyclic, lats))
  a1, b1 = m(pandas.DataFrame.as_matrix(geoarealons), pandas.DataFrame.as_matrix(geoarealats))
  m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='grey', lake_color='0.5')
  levels=[0,100,200,300,400,500,600,700,800,900,1000]
  im1 = m.contourf(x1,y1,depth_cyclic,levels, cmap='plasma_r',extend='max')
  im2 = m.scatter(a1,b1,s=1.2, marker='o', facecolor='0', lw=0)
  plt.title(species2[i], fontsize=12)

  nc_model = Dataset(file_model,'r')
  lats = nc_model.variables['LAT'][:]
  lons = nc_model.variables['LON'][:]
  depth = nc_model.variables['MODELMEAN'][:]
  depth = depth.squeeze()
  fig = plt.figure(1, figsize(6,5.75))
  axg1 = plt.axes(g[j+1])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='eck4',lon_0=205)
  depth_cyclic, lons_cyclic = addcyclic(depth[:,:], lons)
  depth_cyclic, lons_cyclic = shiftgrid(20., depth_cyclic, lons_cyclic, start=True)
  x2, y2 = m(*np.meshgrid(lons_cyclic, lats))
  a2, b2 = m(pandas.DataFrame.as_matrix(geoarealons), pandas.DataFrame.as_matrix(geoarealats))
  m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='grey', lake_color='0.5')
  levels=[-200,-150, -100, -50, 0, 50, 100, 150, 200]
  im1 = m.contourf(x2,y2,depth_cyclic, levels, cmap=plt.cm.RdBu_r, extend='both')
  im2 = m.scatter(a2,b2,s=1.2, marker='o', facecolor='0', lw=0)
  plt.title(species2[i], fontsize=12)

#  plt.suptitle("WOA P50 Depth, Stippling=IUCN Habitat")
  i=i+1
  j=j+1
#cb = m.colorbar(im1,"bottom", size="10%", pad="5%")
#cb.set_ticks([0,250,500,750,1000])
#cb.set_ticklabels([0,250,500,750,1000])

cax = fig.add_axes([0.29, 0.06, 0.42, 0.03])
cb=fig.colorbar(im1, cax=cax, ticks=levels, orientation='horizontal')
cb.set_ticklabels([0,'',200,'',400,'',600,'',800,'',1000])

pylab.text(0.3, 1.4, 'P$_{50}$ depth (m)', fontsize = 12)

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/WOA.p50depthav.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
