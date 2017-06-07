#ipython --pylab
import scipy
from mpl_toolkits.basemap import Basemap, addcyclic, shiftgrid
from netCDF4 import Dataset
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import pandas
import pylab
np.set_printoptions(threshold=np.nan)
plt.rc('font', family='serif', serif='Times New Roman')

left1 = 0.025
bottom1 = 0.15
width1 = 0.45
height1 = 0.8

fig = plt.figure(1, figsize=(5,3))

axg1 = plt.axes([left1,bottom1,width1,height1])
file_hist = 'results/WOA/Thunnus_maccoyii/p50depth/woa.p50depthav.Thunnus_maccoyii.nc'
file2_hist = 'data/IUCN/csv_5deg/IUCN_5deg_Thunnus_maccoyii.csv'
nc = Dataset(file_hist,'r')
lats = nc.variables['LAT'][:]
lons = nc.variables['LON'][:]
depth = nc.variables['P50DEPTHAV'][:]
depth = depth.squeeze()
agree = pandas.read_csv(file2_hist, names=['lons', 'lats'])
agree['lons2'] = np.where(agree['lons'] <= 20 , agree['lons'] + 360, agree['lons'])
agreelons = agree['lons2']
agreelats = agree['lats']
m = Basemap(lat_1=-40.,lat_2=0.,llcrnrlon=70,llcrnrlat=-36,urcrnrlon=140, urcrnrlat=0, projection='lcc',lon_0=140)
x, y = m(*np.meshgrid(lons, lats))
a, b = m(pandas.DataFrame.as_matrix(agreelons), pandas.DataFrame.as_matrix(agreelats))
m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
m.drawcoastlines()
m.fillcontinents(color='grey', lake_color='0.5')
levels=[0,100,200,300,400,500,600,700,800,900,1000]
im1 = m.contourf(x,y,depth,levels, cmap='plasma_r',extend='max')
im2 = m.scatter(a,b,s=5, marker='o', facecolor='0', lw=0)
plt.title("Present-day (WOA Data)", fontsize=12)

left2 = 0.525
bottom2 = 0.15
width2 = 0.45
height2 = 0.8

axg2 = plt.axes([left2,bottom2,width2,height2])
file_future = 'results/modelmean/modelmean.p50depth.Thunnus_maccoyii.nc'
file2_future = 'data/IUCN/csv_5deg/IUCN_5deg_Thunnus_maccoyii.csv'
nc = Dataset(file_future,'r')
lats = nc.variables['LAT'][:]
lons = nc.variables['LON'][:]
depth = nc.variables['MODELMEAN'][:]
depth = depth.squeeze()
agree = pandas.read_csv(file2_future, names=['lons', 'lats'])
agree['lons2'] = np.where(agree['lons'] <= 20 , agree['lons'] + 360, agree['lons'])
agreelons = agree['lons2']
agreelats = agree['lats']
m = Basemap(lat_1=-40.,lat_2=0.,llcrnrlon=70,llcrnrlat=-36,urcrnrlon=140, urcrnrlat=0, projection='lcc',lon_0=140)
x, y = m(*np.meshgrid(lons, lats))
a, b = m(pandas.DataFrame.as_matrix(agreelons), pandas.DataFrame.as_matrix(agreelats))
m.drawmapboundary(fill_color='#cccccc') #fill_color='0.5'
m.drawcoastlines()
m.fillcontinents(color='grey', lake_color='0.5')
levels=[0,100,200,300,400,500,600,700,800,900,1000]
im1 = m.contourf(x,y,depth,levels, cmap='plasma_r',extend='max')
im2 = m.scatter(a,b,s=5, marker='o', facecolor='0', lw=0)
plt.title("Future (RCP 8.5)", fontsize=12)

cax = fig.add_axes([0.29, 0.08, 0.42, 0.05])
cb=fig.colorbar(im1, cax=cax, ticks=levels, orientation='horizontal')
cb.set_ticklabels([0,'',200,'',400,'',600,'',800,'',1000])
pylab.text(0.28, 1.4, 'P$_{50}$ depth (m)', fontsize = 12)

outfig = 'graphs/southernbluefin_spawning.ps'
plt.savefig(outfig, dpi=300, bbox_inches=0)
