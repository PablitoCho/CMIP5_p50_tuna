library(RNetCDF)
library(ncdf4)
library(ncdf)

source('Code/Projects/CMIP5_p50/RCode/filled.contour/filled.contour.R', chdir = TRUE)
source('Code/Projects/CMIP5_p50/RCode/filled.contour/filled.legend.R', chdir = TRUE)

trans.lon<-207.5

#-------------------------
# P50 WOA
#-------------------------
		
	file.woa.To<-paste("/Data/Projects/CMIP5_p50/WOA/Thunnus_obesus/p50/woa.p50av.Thunnus_obesus.nc", sep="")
	nc.woa.To<-open.ncdf(paste(file.woa.To, sep=""))
	lons.woa.To<-nc.woa.To$dim$LON$vals	
	lats.woa.To<-nc.woa.To$dim$LAT$vals	
	depths.woa.To<-nc.woa.To$dim$DEPTH$vals	
	data.woa.To<-get.var.ncdf(nc.woa.To, nc.woa.To$var[[2]], start=c(which(lons.woa.To==trans.lon),1,1), count=c(1, 180, 24))
	close.ncdf(nc.woa.To)
	
	rownames(data.woa.To)<-lats.woa.To
	colnames(data.woa.To)<-depths.woa.To
	data.woa.To<-data.woa.To[,ncol(data.woa.To):1]
	
	quartz()
	
	
	
	
	
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(a==1){
			depthtable<-as.matrix(data3)
			colnames(depthtable)<-specieslist[a]		
		}else{
			if(nrow(depthtable)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)				
			}
			depthtable<-cbind(depthtable, data3)
			colnames(depthtable)[a]<-paste(specieslist[a])
		}	
		
	}
depthtable<-depthtable*-1




#quartz(height=8, width=4)
outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/WOA_geostats.ps")
postscript(outfile, height=8, width=4)
par(mfrow=c(3,1))
par(mar=c(1, 4.5, 0, 0.5))
par(oma=c(2, 0, 2, 1))
par(las=1)
par(yaxs="i")

  barplot(woa, ylim=c(0, 200), col=c("black", "white"), legend=c(expression(paste(Delta, "H", "\U2260", "0 (Effect of Temperature)", sep=""), paste(Delta, "H", "\U003D", "0 (No Effect of Temperature)", sep=""))), args.legend = list(x = "topleft", inset=c(0.05, 0.02), cex=1), xaxt="n", ylab=expression(paste("area (10"^"6", " km"^"2", ")", sep="")), space=c(0,0.8), beside=TRUE)
  box()
  abline(h=0, lwd=2)
  
  collist<-c("black", "white","", "black", "white", "", "black", "white", "", "black", "white", "", "black", "white", "", "black", "white")
  medcollist<-c("white", "black", "","white", "black", "","white", "black", "","white", "black", "","white", "black", "","white", "black")
  boxplot(cdepthtable, ylim=c(-1500, 0), xaxt="n", ylab="depth (m)", col=collist, medcol=medcollist, notch=TRUE, outline=FALSE)
  locs<-c(1,2,4,5,7,8,10,11,13,14,16,17)
  axis(side=1, at=locs, labels=FALSE, tick=TRUE)
  
  boxplot(cdepthtable2, ylim=c(-1500, 0), xaxt="n", col=collist, medcol=medcollist, ylab="depth (m) for common areas", notch=TRUE, outline=FALSE)
  axis(side=1, at=locs, labels=FALSE, tick=TRUE)
  specieslist<-c("Thunnus\nobesus", "Thunnus\nalbacares", "Katsuwonus\npelamis", "Thunnus\nalalunga", "Thunnus\nthynnus",  "Thunnus\nmaccoyii")
  axis(side=1, at=c(1.5,4.5,7.5,10.5,13.5,16.5), line=-0.5, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.8)
  mtext("WOA P50Depth", adj=0.6, outer=TRUE)
dev.off()

