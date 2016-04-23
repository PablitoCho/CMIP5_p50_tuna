library(RNetCDF)
library(ncdf4)
library(viridis)

source('~/Code/Projects/CMIP5_p50/RCode/filled.contour/filled.contour.R', chdir = TRUE)
source('~/Code/Projects/CMIP5_p50/RCode/filled.contour/filled.legend.R', chdir = TRUE)

trans.lon<-207.5

#-------------------------
# P50 WOA
#-------------------------
		
	file.woa.To<-paste("/Data/Projects/CMIP5_p50/WOA/Thunnus_obesus/p50/woa.p50av.Thunnus_obesus.nc", sep="")
	nc.woa.To<-nc_open(paste(file.woa.To, sep=""))
	lons.woa.To<-nc.woa.To$dim$LON$vals	
	lats.woa.To<-nc.woa.To$dim$LAT$vals	
	depths.woa.To<-nc.woa.To$dim$DEPTH$vals	
	data.woa.To<-ncvar_get(nc.woa.To, nc.woa.To$var[[2]], start=c(which(lons.woa.To==trans.lon),1,1), count=c(1, 180, 24))
	nc_close(nc.woa.To)
	
	rownames(data.woa.To)<-lats.woa.To
	colnames(data.woa.To)<-depths.woa.To*-1
	data.woa.To<-data.woa.To[,ncol(data.woa.To):1]
	
	file.woa.Tm<-paste("/Data/Projects/CMIP5_p50/WOA/Thunnus_maccoyii/p50/woa.p50av.Thunnus_maccoyii.nc", sep="")
	nc.woa.Tm<-nc_open(paste(file.woa.Tm, sep=""))
	lons.woa.Tm<-nc.woa.Tm$dim$LON$vals	
	lats.woa.Tm<-nc.woa.Tm$dim$LAT$vals	
	depths.woa.Tm<-nc.woa.Tm$dim$DEPTH$vals	
	data.woa.Tm<-ncvar_get(nc.woa.Tm, nc.woa.Tm$var[[2]], start=c(which(lons.woa.Tm==trans.lon),1,1), count=c(1, 180, 24))
	nc_close(nc.woa.Tm)
	
	rownames(data.woa.Tm)<-lats.woa.Tm
	colnames(data.woa.Tm)<-depths.woa.Tm*-1
	data.woa.Tm<-data.woa.Tm[,ncol(data.woa.Tm):1]
	
	file.woa.To.depth<-paste("/Data/Projects/CMIP5_p50/WOA/Thunnus_obesus/p50depth/woa.p50depthav.Thunnus_obesus.nc", sep="")
	nc.woa.To.depth<-nc_open(paste(file.woa.To.depth, sep=""))
	lons.woa.To.depth<-nc.woa.To.depth$dim$LON$vals	
	lats.woa.To.depth<-nc.woa.To.depth$dim$LAT$vals	
	data.woa.To.depth<-ncvar_get(nc.woa.To.depth, nc.woa.To.depth$var[[1]], start=c(which(lons.woa.To.depth==trans.lon),1), count=c(1, 180))
	nc_close(nc.woa.To.depth)
	names(data.woa.To.depth)<-lats.woa.To.depth
	data.woa.To.depth2<-data.woa.To.depth*-1

	
	file.woa.Tm.depth<-paste("/Data/Projects/CMIP5_p50/WOA/Thunnus_maccoyii/p50depth/woa.p50depthav.Thunnus_maccoyii.nc", sep="")
	nc.woa.Tm.depth<-nc_open(paste(file.woa.Tm.depth, sep=""))
	lons.woa.Tm.depth<-nc.woa.Tm.depth$dim$LON$vals	
	lats.woa.Tm.depth<-nc.woa.Tm.depth$dim$LAT$vals	
	data.woa.Tm.depth<-ncvar_get(nc.woa.Tm.depth, nc.woa.Tm.depth$var[[1]], start=c(which(lons.woa.Tm.depth==trans.lon),1), count=c(1, 180))
	nc_close(nc.woa.Tm.depth)
	names(data.woa.Tm.depth)<-lats.woa.Tm.depth
	data.woa.Tm.depth2<-data.woa.Tm.depth*-1
	
	
	file.woa.po2<-paste("/Data/WOA/WOA_o2/WOA_po2av_annual_1deg.nc", sep="")
	nc.woa.po2<-nc_open(paste(file.woa.po2, sep=""))
	lons.woa.po2<-nc.woa.po2$dim$LON$vals	
	lats.woa.po2<-nc.woa.po2$dim$LAT$vals
	depths.woa.po2<-nc.woa.po2$dim$DEPTH$vals		
	data.woa.po2<-ncvar_get(nc.woa.po2, nc.woa.po2$var[[2]], start=c(which(lons.woa.po2==trans.lon),1,1), count=c(1, 180, 24))
	nc_close(nc.woa.po2)
	rownames(data.woa.po2)<-lats.woa.po2	
	colnames(data.woa.po2)<-depths.woa.po2*-1
	data.woa.po2<-data.woa.po2[,ncol(data.woa.po2):1]
	
	file.habitat.To<-paste("/Data/Projects/CMIP5_p50/IUCN/nc/IUCN_Thunnus_obesus.nc")
	nc.habitat.To<-nc_open(paste(file.habitat.To, sep=""))
	lons.habitat.To<-nc.habitat.To$dim$lon$vals
#	lons.habitat.To<-ifelse(lons.habitat.To<0, lons.habitat.To+360, lons.habitat.To)		
	lats.habitat.To<-nc.habitat.To$dim$lat$vals	
	data.habitat.To<-ncvar_get(nc.habitat.To, nc.habitat.To$var[[1]], start=c(which(lons.habitat.To==-152.5),1), count=c(1, 180))
	data.habitat.To<-data.habitat.To*-25

	file.habitat.Tm<-paste("/Data/Projects/CMIP5_p50/IUCN/nc/IUCN_Thunnus_maccoyii.nc")
	nc.habitat.Tm<-nc_open(paste(file.habitat.Tm, sep=""))
	lons.habitat.Tm<-nc.habitat.Tm$dim$lon$vals
#	lons.habitat.Tm<-ifelse(lons.habitat.Tm<0, lons.habitat.Tm+360, lons.habitat.Tm)	
	lats.habitat.Tm<-nc.habitat.Tm$dim$lat$vals	
	data.habitat.Tm<-ncvar_get(nc.habitat.Tm, nc.habitat.Tm$var[[1]], start=c(which(lons.habitat.Tm==-152.5),1), count=c(1, 180))
	data.habitat.Tm<-data.habitat.Tm*-25
	data.habitat.Tm[150]<-NA #Remove point that is on land due to the conversion from the shape to grid file
	

#-------------------------
# Create Plot
#-------------------------

graphout<-paste("~/Code/Projects/CMIP5_p50/graphs/IUCN_WOA_PacificTransect.ps")
postscript(graphout, width=5.5, height=7)
#	quartz(width=5.5, height=7)
	par(plt = c(0.17,0.75,0.60,0.95), #c(left, right, bottom, top)  
    las = 1,                      # orientation of axis labels
    cex.axis = 1,                 # size of axis annotation
    tck = -0.04,
    xaxs="i",
    yaxs="i")

#	filled.contour3(x=as.numeric(rownames(data.woa.To)), y=as.numeric(colnames(data.woa.To)), z=data.woa.To, zlim=c(0,10), color.palette=colorRampPalette(viridis(20, begin=1, end=0)), ylab="Depth (m)", xlab="", lwd=1)
	
	filled.contour3(x=as.numeric(rownames(data.woa.To)), y=as.numeric(colnames(data.woa.To)), z=data.woa.To, xlim=c(-70, 70), ylim=c(-1500,0), zlim=c(0,3), nlevels=10, color.palette=viridis, axes=FALSE, ylab="depth (m)", xlab="", lwd=1)
	contour(x=as.numeric(rownames(data.woa.po2)), y=as.numeric(colnames(data.woa.po2)), z=data.woa.po2, add=TRUE, nlevels=15, levels=c(1,2,5,10,15), col="white")
	axis(side=1, at=seq(-70,70,20), labels=FALSE)
	axis(side=2, at=seq(-1600,0,200), labels=TRUE)
	axis(side=3, at=c(-70,70), lwd.ticks=0, labels=FALSE)
	axis(side=4, at=seq(-1600,0,200), labels=FALSE)
	lines(as.numeric(names(data.woa.To.depth)), data.woa.To.depth2, col="#FF1493", lwd=2.5)
#	points(lats.habitat.To, data.habitat.To, pch=20, cex=0.3)
	
	par(new = "TRUE",
    plt = c(0.8,0.85,0.60,0.95),   # define plot region for legend
    las = 1,
    cex.axis = 0.8,
    tck=-0.4)

#filled.legend(x=as.numeric(rownames(data.woa.To)), y=as.numeric(colnames(data.woa.To)), z= data.woa.To, zlim=c(0,10), color.palette=colorRampPalette(viridis(20, begin=1, end=0)))

filled.legend(x=as.numeric(rownames(data.woa.To)), y=as.numeric(colnames(data.woa.To)), z=data.woa.To, zlim=c(0,3), nlevels=10, color.palette=viridis)
filled.legend(x=as.numeric(rownames(data.woa.To)), y=as.numeric(colnames(data.woa.To)), z=data.woa.To, zlim=c(0,3), nlevels=10, color.palette=viridis)


	par(new = "TRUE",
	plt = c(0.17,0.75,0.15,0.5), #c(left, right, bottom, top)  
    las = 1,                      # orientation of axis labels
    cex.axis = 1,                 # size of axis annotation
    tck = -0.04,
    xaxs="i",
    yaxs="i")

#	filled.contour3(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z=data.woa.Tm, zlim=c(0,10), color.palette=colorRampPalette(viridis(20, begin=1, end=0)), ylab="Depth (m)", xlab="", lwd=1)

	filled.contour3(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z=data.woa.Tm, xlim=c(-70, 70), ylim=c(-1500,0), zlim=c(0,10), nlevels=10, color.palette=viridis, axes=FALSE, ylab="depth (m)", xlab="degrees latitude", lwd=1)
	contour(x=as.numeric(rownames(data.woa.po2)), y=as.numeric(colnames(data.woa.po2)), z=data.woa.po2, add=TRUE, nlevels=15, levels=c(1,2,5,10,15), col="white")
	axis(side=1, at=seq(-70,70,20), labels=TRUE)
	axis(side=2, at=seq(-1600,0,200), labels=TRUE)
	axis(side=3, at=c(-70,70), lwd.ticks=0, labels=FALSE)
	axis(side=4, at=seq(-1600,0,200), labels=FALSE)
	lines(as.numeric(names(data.woa.Tm.depth)), data.woa.Tm.depth2, col="#FF1493", lwd=2.5)
#	points(lats.habitat.Tm, data.habitat.Tm, pch=20, cex=0.3)
	
	par(new = "TRUE",
    plt = c(0.8,0.85,0.15,0.5),   # define plot region for legend
    las = 1,
    cex.axis = 0.8,
    tck=-0.4)

#	filled.legend(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z= data.woa.Tm, zlim=c(0,10), color.palette=colorRampPalette(viridis(20, begin=1, end=0)))

	filled.legend(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z=data.woa.Tm, zlim=c(0,10), color=viridis, nlevels=10)
	filled.legend(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z=data.woa.Tm, zlim=c(0,10), color=viridis, nlevels=10)

#dev.off()