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
species1 = ['Thunnus_obesus', 'Thunnus_albacares', 'Katsuwonus_pelamis', 'Thunnus_thynnus', 'Thunnus_orientalis', 'Thunnus_maccoyii']
#species2 = ['Thunnus obesus', 'Thunnus albacares', 'Katsuwonus pelamis', 'Thunnus thynnus', 'Thunnus orientalis', 'Thunnus maccoyii']
species2 = ['bigeye tuna', 'yellowfin tuna', 'skipjack tuna', 'Atlantic bluefin tuna', 'Pacific bluefin tuna', 'southern bluefin tuna']

bottomlist = [0.7, 0.4, 0.1]
width = 0.46
height = 0.25

g = [[0.02, bottomlist[0], width, height], [0.52, bottomlist[0], width, height],
     [0.02, bottomlist[1], width, height], [0.52, bottomlist[1], width, height],
     [0.02, bottomlist[2], width, height], [0.52, bottomlist[2], width, height]]

i = 0
while i<len(species1):
  file = Folder + '/modelmean/modelmean.p50depth.' + species1[i] + '.nc'
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
  fig = plt.figure(1, figsize(6,5.5))
  axg1 = plt.axes(g[i])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='eck4',lon_0=205)
  depth_cyclic, lons_cyclic = addcyclic(depth[:,:], lons)
  depth_cyclic, lons_cyclic = shiftgrid(20., depth_cyclic, lons_cyclic, start=True)
  x, y = m(*np.meshgrid(lons_cyclic, lats))
  a, b = m(pandas.DataFrame.as_matrix(agreelons), pandas.DataFrame.as_matrix(agreelats))
  m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='grey', lake_color='0.5')
  levels=[0,100,200,300,400,500,600,700,800,900,1000]
  im1 = m.contourf(x,y,depth_cyclic,levels, cmap='plasma_r',extend='max')
  im2 = m.scatter(a,b,s=1.2, marker='o', facecolor='0', lw=0)
  plt.title(species2[i], fontsize=12)
#  plt.suptitle("WOA P50 Depth, Stippling=IUCN Habitat")
  i=i+1

#cb = m.colorbar(im1,"bottom", size="10%", pad="5%")
#cb.set_ticks([0,250,500,750,1000])
#cb.set_ticklabels([0,250,500,750,1000])

cax = fig.add_axes([0.54, 0.05, 0.42, 0.03])
cb=fig.colorbar(im1, cax=cax, ticks=levels, orientation='horizontal')
cb.set_ticklabels([0,'',200,'',400,'',600,'',800,'',1000])

plt.show()

outfig = '/Users/kasmith/Code/Projects/CMIP5_p50/graphs/rcp85.p50depthav.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
