#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import pandas
import pylab

Folder = 'results'
species1 = ['Thunnus_obesus', 'Thunnus_albacares', 'Katsuwonus_pelamis', 'Thunnus_thynnus', 'Thunnus_orientalis', 'Thunnus_maccoyii']
#species2 = ['Thunnus obesus', 'Thunnus albacares', 'Katsuwonus pelamis', 'Thunnus thynnus', 'Thunnus orientalis', 'Thunnus maccoyii']
species2 = ['bigeye tuna', 'yellowfin tuna', 'skipjack tuna', 'Atlantic bluefin tuna', 'Pacific bluefin tuna', 'southern bluefin tuna']

bottomlist = [0.72, 0.43, 0.14]
width = 0.46
height = 0.24

g = [[0.02, bottomlist[0], width, height], [0.52, bottomlist[0], width, height],
     [0.02, bottomlist[1], width, height], [0.52, bottomlist[1], width, height],
     [0.02, bottomlist[2], width, height], [0.52, bottomlist[2], width, height]]

i = 0
while i<len(species1):
  file = Folder + '/modelmean/modelmean.deltap50depth.' + species1[i] + '.nc'
  file2 = 'data/IUCN/csv_5deg/IUCN_5deg_' + species1[i] + '.csv'
  nc = Dataset(file,'r')
  lats = nc.variables['LAT'][:]
  lons = nc.variables['LON'][:]
  depth = nc.variables['MODELMEAN'][:]
  depth = depth.squeeze()
  agree = pandas.read_csv(file2, names=['lons', 'lats'])
  agree['lons2'] = np.where(agree['lons'] <= 20 , agree['lons'] + 360, agree['lons'])
  agreelons = agree['lons2']
  agreelats = agree['lats']
  fig = plt.figure(1, figsize=(6,5.75))
  axg1 = plt.axes(g[i])
  m = Basemap(llcrnrlat=-80.,urcrnrlat=80.,projection='eck4',lon_0=205)
  depth_cyclic, lons_cyclic = shiftgrid(20., depth, lons, start=True)
  x, y = m(*np.meshgrid(lons_cyclic, lats))
  a, b = m(pandas.DataFrame.as_matrix(agreelons), pandas.DataFrame.as_matrix(agreelats))
  m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
  m.drawcoastlines()
  m.fillcontinents(color='grey', lake_color='0.5')
  levels=[-200,-150, -100, -50, 0, 50, 100, 150, 200]
  im1 = m.contourf(x,y,depth_cyclic, levels, cmap=plt.cm.RdBu_r, extend='both')
  im2 = m.scatter(a,b,s=1.2, marker='o', facecolor='0', lw=0)
  plt.title(species2[i], fontsize=12)
#  plt.suptitle("Model Mean P50 Depth Change")
#  if i==5:
#    cb_axes = plt.subplot2grid((4, 2), (0, 1), rowspan=3)
#    cb = m.colorbar(im1,ax=cb_axes, size="30%")
#    cb.set_ticks([-200,-150,-100,-50,0,50,100,150,200])
#    cb.set_ticklabels([-200,'',-100,'',0,'',100,'',200])
  i=i+1

cax = fig.add_axes([0.29, 0.06, 0.42, 0.03])
cb=fig.colorbar(im1, cax=cax, orientation='horizontal')
cb.set_ticklabels([-200,'',-100,'',0,'',100,'',200])
pylab.text(0.6, 1.3, 'compression', fontsize=12)
pylab.text(0.01, 1.3, 'expansion', fontsize=12)

pylab.text(-0.6, -0.8, 'Change in\nP$_{50}$ depth (m)', fontsize = 12)

outfig = 'graphs/modelmean_deltap50depthav.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
