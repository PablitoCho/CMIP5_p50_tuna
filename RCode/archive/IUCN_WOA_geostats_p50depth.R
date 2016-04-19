#-------------------------------
# WOA Area with P50 Depth 
#-------------------------------

woa<-read.table("/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area.txt")

woa<-woa[,4:13]
colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "HabitatArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
woa<-woa[,c("species", "p50", "deltaH", "HabitatArea", "P50Area")]

woa<-woa[order(woa$deltaH),]

woa$P50Area<-woa$P50Area/1000000 #convert from m^2 to km^2
woa$P50Area<-woa$P50Area/1000000 #convert to scale y-axis labels, ylab adds zeros

woa$HabitatArea<-woa$HabitatArea/1000000 #convert from m^2 to km^2
woa$HabitatArea<-woa$HabitatArea/1000000 #convert to scale y-axis labels, ylab adds zeros

woa<-woa[,c("P50Area", "HabitatArea")]

woa<-as.matrix(t(woa))


#-------------------------
# P50 Depth WOA
#-------------------------

library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga","Thunnus_thynnus", "Thunnus_orientalis", "Thunnus_maccoyii")

for(a in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN.WOA.p50depthav.", specieslist[a], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[1]], start=c(1,1), count=c(360, 180))
		close.ncdf(nc)
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
depthtable[,5]<-rep(NA) #Thunnus thynnus has almost no habitat area with a P50 depth.


#quartz(height=6, width=4)
outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/IUCN_WOA_geostats.ps")
postscript(outfile, height=6, width=4)
par(mfrow=c(2,1))
par(mar=c(1, 4.5, 0, 0.5))
par(oma=c(3.8, 0, 2, 1))
par(las=1)
par(yaxs="i")

  collist<-c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#bf5b17")

  barplot(woa[2,], ylim=c(0, 300), col="grey", legend=c("P50 Depth", "Habitat"), args.legend = list(x = "topleft", fill=c("black", "grey"), inset=c(0.05, 0.02), cex=0.8), xaxt="n", ylab=expression(paste("area (10"^"6", " km"^"2", ")", sep="")), space=0.8)
  barplot(woa[1,], ylim=c(0, 300), col=collist, xaxt="n", space=0.8, add=TRUE)
  box()
  abline(h=0, lwd=2)
  
  locs<-seq(0.7,8.7,1.2)
   boxplot(depthtable, ylim=c(-1500, 0), xaxt="n", col=collist, ylab="depth (m)", notch=TRUE, outline=FALSE, at=locs)
  axis(side=1, at=locs, labels=FALSE, tick=TRUE)

  specieslist<-c("T. obesus", "T. albacares", "K. pelamis", "T. alalunga", "T. thynnus", "T. orientalis",  "T. maccoyii")
  axis(side=1, at=locs, line=-1, las=2, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.8)
#  mtext("WOA P50Depth", adj=0.65, outer=TRUE)
  
dev.off()


#-------------------
# Zoom in
#-------------------

#boxplot(cdepthtable2, ylim=c(-500, 0), xaxt="n", col=collist, medcol=medcollist, ylab="depth (m) for common areas", notch=TRUE, outline=FALSE)
#  axis(side=1, at=locs, labels=FALSE, tick=TRUE)
#  specieslist<-c("Thunnus\nobesus", "Thunnus\nalbacares", "Katsuwonus\npelamis", "Thunnus\nalalunga", "Thunnus\nthynnus",  "Thunnus\nmaccoyii")
#  axis(side=1, at=c(1.5,4.5,7.5,10.5,13.5,16.5), line=-0.5, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.8)
#  mtext("WOA P50Depth", adj=0.6, outer=TRUE)


