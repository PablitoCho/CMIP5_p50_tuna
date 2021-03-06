library(ncdf4)
library(viridis)

source('RCode/filled.contour/filled.contour.R', chdir = TRUE)
source('RCode/filled.contour/filled.legend.R', chdir = TRUE)

trans.lon<-207.5

#-------------------------
# P50 WOA
#-------------------------
		
	file.woa.To<-paste("results/WOA/Thunnus_obesus/p50/woa.p50av.Thunnus_obesus.nc", sep="")
	nc.woa.To<-nc_open(paste(file.woa.To, sep=""))
	lons.woa.To<-nc.woa.To$dim$LON$vals	
	lats.woa.To<-nc.woa.To$dim$LAT$vals	
	depths.woa.To<-nc.woa.To$dim$DEPTH$vals	
	data.woa.To<-ncvar_get(nc.woa.To, nc.woa.To$var[[2]], start=c(which(lons.woa.To==trans.lon),1,1), count=c(1, 180, 24))
	nc_close(nc.woa.To)
	
	rownames(data.woa.To)<-lats.woa.To
	colnames(data.woa.To)<-depths.woa.To*-1
	data.woa.To<-data.woa.To[,ncol(data.woa.To):1]
	
	file.woa.Tm<-paste("results/WOA/Thunnus_maccoyii/p50/woa.p50av.Thunnus_maccoyii.nc", sep="")
	nc.woa.Tm<-nc_open(paste(file.woa.Tm, sep=""))
	lons.woa.Tm<-nc.woa.Tm$dim$LON$vals	
	lats.woa.Tm<-nc.woa.Tm$dim$LAT$vals	
	depths.woa.Tm<-nc.woa.Tm$dim$DEPTH$vals	
	data.woa.Tm<-ncvar_get(nc.woa.Tm, nc.woa.Tm$var[[2]], start=c(which(lons.woa.Tm==trans.lon),1,1), count=c(1, 180, 24))
	nc_close(nc.woa.Tm)
	
	rownames(data.woa.Tm)<-lats.woa.Tm
	colnames(data.woa.Tm)<-depths.woa.Tm*-1
	data.woa.Tm<-data.woa.Tm[,ncol(data.woa.Tm):1]
	
	file.woa.To.depth<-paste("results/WOA/Thunnus_obesus/p50depth/woa.p50depthav.Thunnus_obesus.nc", sep="")
	nc.woa.To.depth<-nc_open(paste(file.woa.To.depth, sep=""))
	lons.woa.To.depth<-nc.woa.To.depth$dim$LON$vals	
	lats.woa.To.depth<-nc.woa.To.depth$dim$LAT$vals	
	data.woa.To.depth<-ncvar_get(nc.woa.To.depth, nc.woa.To.depth$var[[1]], start=c(which(lons.woa.To.depth==trans.lon),1), count=c(1, 180))
	nc_close(nc.woa.To.depth)
	names(data.woa.To.depth)<-lats.woa.To.depth
	data.woa.To.depth2<-data.woa.To.depth*-1

	
	file.woa.Tm.depth<-paste("results/WOA/Thunnus_maccoyii/p50depth/woa.p50depthav.Thunnus_maccoyii.nc", sep="")
	nc.woa.Tm.depth<-nc_open(paste(file.woa.Tm.depth, sep=""))
	lons.woa.Tm.depth<-nc.woa.Tm.depth$dim$LON$vals	
	lats.woa.Tm.depth<-nc.woa.Tm.depth$dim$LAT$vals	
	data.woa.Tm.depth<-ncvar_get(nc.woa.Tm.depth, nc.woa.Tm.depth$var[[1]], start=c(which(lons.woa.Tm.depth==trans.lon),1), count=c(1, 180))
	nc_close(nc.woa.Tm.depth)
	names(data.woa.Tm.depth)<-lats.woa.Tm.depth
	data.woa.Tm.depth2<-data.woa.Tm.depth*-1
	
	
	file.woa.po2<-paste("data/WOA/WOA_po2av_annual_1deg.nc", sep="")
	nc.woa.po2<-nc_open(paste(file.woa.po2, sep=""))
	lons.woa.po2<-nc.woa.po2$dim$LON$vals	
	lats.woa.po2<-nc.woa.po2$dim$LAT$vals
	depths.woa.po2<-nc.woa.po2$dim$DEPTH$vals		
	data.woa.po2<-ncvar_get(nc.woa.po2, nc.woa.po2$var[[2]], start=c(which(lons.woa.po2==trans.lon),1,1), count=c(1, 180, 24))
	nc_close(nc.woa.po2)
	rownames(data.woa.po2)<-lats.woa.po2	
	colnames(data.woa.po2)<-depths.woa.po2*-1
	data.woa.po2<-data.woa.po2[,ncol(data.woa.po2):1]	

#-------------------------
# Create Plot
#-------------------------

graphout<-paste("graphs/IUCN_WOA_PacificTransect.ps")
postscript(graphout, width=4, height=6)
#	quartz(width=4, height=6)
	par(plt = c(0.2,0.95,0.60,0.95), #c(left, right, bottom, top)  
    las = 1,                      # orientation of axis labels
    cex.axis = 1,                 # size of axis annotation
    tck = -0.04,
    xaxs="i",
    yaxs="i")

	yaxislabels<-seq(0, 1600, 200)
	yaxislabels<-yaxislabels[length(yaxislabels):1]
	
	filled.contour3(x=as.numeric(rownames(data.woa.To)), y=as.numeric(colnames(data.woa.To)), z=data.woa.To, xlim=c(-70, 70), ylim=c(-1500,0), zlim=c(0,6), nlevels=6, color.palette=viridis, axes=FALSE, ylab="depth (m)", xlab="", lwd=1)
	contour(x=as.numeric(rownames(data.woa.po2)), y=as.numeric(colnames(data.woa.po2)), z=data.woa.po2, add=TRUE, nlevels=15, levels=c(1,2,5,10,15), col="white")
	axis(side=1, at=seq(-70,70,20), labels=FALSE)
	axis(side=2, at=seq(-1600,0,200), labels=yaxislabels)
	axis(side=3, at=c(-70,70), lwd.ticks=0, labels=FALSE)
	axis(side=4, at=seq(-1600,0,200), labels=FALSE)
	lines(as.numeric(names(data.woa.To.depth)), data.woa.To.depth2, col="#FF1493", lwd=2.5)


	par(new = "TRUE",
	plt = c(0.20,0.95,0.20,0.55), #c(left, right, bottom, top)  
    las = 1,                      # orientation of axis labels
    cex.axis = 1,                 # size of axis annotation
    tck = -0.04,
    xaxs="i",
    yaxs="i")

	filled.contour3(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z=data.woa.Tm, xlim=c(-70, 70), ylim=c(-1500,0), zlim=c(0,6), nlevels=6, color.palette=viridis, axes=FALSE, ylab="depth (m)", lwd=1)
	contour(x=as.numeric(rownames(data.woa.po2)), y=as.numeric(colnames(data.woa.po2)), z=data.woa.po2, add=TRUE, nlevels=15, levels=c(1,2,5,10,15), col="white")
	axis(side=1, at=seq(-70,70,20), labels=TRUE)
	axis(side=2, at=seq(-1600,0,200), labels=yaxislabels)
	axis(side=3, at=c(-70,70), lwd.ticks=0, labels=FALSE)
	axis(side=4, at=seq(-1600,0,200), labels=FALSE)
	lines(as.numeric(names(data.woa.Tm.depth)), data.woa.Tm.depth2, col="#FF1493", lwd=2.5)
	mtext("degrees latitude", side=1, line=2 )
	
	par(new = "TRUE",
    plt = c(0.2,0.95,0.06,0.09),   # define plot region for legend
    las = 1,
    cex.axis = 0.8,
    tck=-0.4)


	filled.legend(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z=data.woa.Tm, zlim=c(0,6), horiz=TRUE, color=viridis, nlevels=6)
	filled.legend(x=as.numeric(rownames(data.woa.Tm)), y=as.numeric(colnames(data.woa.Tm)), z=data.woa.Tm, zlim=c(0,6), horiz=TRUE, color=viridis, nlevels=6)
mtext(expression(paste('P'[50], ' (kPa)', sep="")), side=2, adj=1.05, padj=0.75)

dev.off()