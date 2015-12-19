#-------------------------------
# WOA Area with P50 Depth 
#-------------------------------

woa<-read.table("/Data/Projects/CMIP5_p50/WOA/WOA_p50depthav_area.txt")

woa<-woa[,4:13]
colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50Area_deltaH0", "P50DepthAv", "P50DepthVar", "P50DepthN")
woa<-woa[,c("species", "p50", "deltaH", "P50Area", "P50Area_deltaH0")]

woa<-woa[order(woa$deltaH),]

woa$P50Area<-woa$P50Area/1000000 #convert from m^2 to km^2
woa$P50Area<-woa$P50Area/1000000 #convert to scale y-axis labels, ylab adds zeros

woa$P50Area_deltaH0<-woa$P50Area_deltaH0/1000000 #convert from m^2 to km^2
woa$P50Area_deltaH0<-woa$P50Area_deltaH0/1000000 #convert to scale y-axis labels, ylab adds zeros

woa<-woa[,c("P50Area", "P50Area_deltaH0")]

woa<-as.matrix(t(woa))
rownames<-c("deltaH ", )


#-------------------------
# P50 Depth WOA
#-------------------------

library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga","Thunnus_thynnus", "Thunnus_maccoyii")

for(a in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/WOA/", specieslist[a], "/p50depth/woa.p50depthav.", specieslist[a], ".nc", sep="")
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

#-------------------------
# P50 Depth WOA, deltaH0
#-------------------------

library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga","Thunnus_thynnus", "Thunnus_maccoyii")

for(a in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/WOA/", specieslist[a], "/p50depth/woa.p50depthav.", specieslist[a], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[2]], start=c(1,1), count=c(360, 180))
		close.ncdf(nc)
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(a==1){
			depthtable.H0<-as.matrix(data3)
			colnames(depthtable.H0)<-specieslist[a]		
		}else{
			if(nrow(depthtable.H0)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable.H0)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable.H0), ncol(depthtable.H0))
				depthtable.H0<-rbind(depthtable.H0, addNA)				
			}
			depthtable.H0<-cbind(depthtable.H0, data3)
			colnames(depthtable.H0)[a]<-paste(specieslist[a])
		}	
		
	}
depthtable.H0<-depthtable.H0*-1

#-----------------------------------
# Combine Depth Tables with Spacers
#-----------------------------------
addNA<-matrix(NA, nrow(depthtable)-nrow(depthtable.H0), ncol(depthtable.H0))
depthtable.H0<-rbind(depthtable.H0, addNA)	

cdepthtable<-cbind(depthtable[,"Thunnus_obesus"], depthtable.H0[,"Thunnus_obesus"], matrix(NA,nrow(depthtable),1), depthtable[,"Thunnus_albacares"], depthtable.H0[,"Thunnus_albacares"], matrix(NA,nrow(depthtable),1), depthtable[,"Katsuwonus_pelamis"], depthtable.H0[,"Katsuwonus_pelamis"], matrix(NA,nrow(depthtable),1), depthtable[,"Thunnus_alalunga"], depthtable.H0[,"Thunnus_alalunga"], matrix(NA,nrow(depthtable),1), depthtable[,"Thunnus_thynnus"], depthtable.H0[,"Thunnus_thynnus"], matrix(NA,nrow(depthtable),1), depthtable[,"Thunnus_maccoyii"], depthtable.H0[,"Thunnus_maccoyii"])


#-------------------------
# P50 Depth WOA Common Area
#-------------------------

library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga","Thunnus_thynnus", "Thunnus_maccoyii")

for(a in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/WOA/", specieslist[a], "/p50depth/woa.p50depth.common.", specieslist[a], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[1]], start=c(1,1), count=c(360, 180))
		close.ncdf(nc)
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(a==1){
			depthtable2<-as.matrix(data3)
			colnames(depthtable2)<-specieslist[a]		
		}else{
			if(nrow(depthtable2)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable2)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable2), ncol(depthtable2))
				depthtable2<-rbind(depthtable2, addNA)				
			}
			depthtable2<-cbind(depthtable2, data3)
			colnames(depthtable2)[a]<-paste(specieslist[a])
		}	
		
	}
depthtable2<-depthtable2*-1

#-------------------------------------
# P50 Depth WOA, deltaH0 Common Area
#-------------------------------------

library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga","Thunnus_thynnus", "Thunnus_maccoyii")

for(a in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/WOA/", specieslist[a], "/p50depth/woa.p50depth.common.", specieslist[a], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[2]], start=c(1,1), count=c(360, 180))
		close.ncdf(nc)
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(a==1){
			depthtable2.H0<-as.matrix(data3)
			colnames(depthtable2.H0)<-specieslist[a]		
		}else{
			if(nrow(depthtable2.H0)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable2.H0)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable2.H0), ncol(depthtable2.H0))
				depthtable2.H0<-rbind(depthtable2.H0, addNA)				
			}
			depthtable2.H0<-cbind(depthtable2.H0, data3)
			colnames(depthtable2.H0)[a]<-paste(specieslist[a])
		}	
		
	}
depthtable2.H0<-depthtable2.H0*-1

#-----------------------------------
# Combine Depth Tables with Spacers
#-----------------------------------
addNA<-matrix(NA, nrow(depthtable2.H0)-nrow(depthtable2), ncol(depthtable.H0))
depthtable2<-rbind(depthtable2, addNA)	

cdepthtable2<-cbind(depthtable2[,"Thunnus_obesus"], depthtable2.H0[,"Thunnus_obesus"], matrix(NA,nrow(depthtable2),1), depthtable2[,"Thunnus_albacares"], depthtable2.H0[,"Thunnus_albacares"], matrix(NA,nrow(depthtable2),1), depthtable2[,"Katsuwonus_pelamis"], depthtable2.H0[,"Katsuwonus_pelamis"], matrix(NA,nrow(depthtable2),1), depthtable2[,"Thunnus_alalunga"], depthtable2.H0[,"Thunnus_alalunga"], matrix(NA,nrow(depthtable2),1), depthtable2[,"Thunnus_thynnus"], depthtable2.H0[,"Thunnus_thynnus"], matrix(NA,nrow(depthtable2),1), depthtable2[,"Thunnus_maccoyii"], depthtable2.H0[,"Thunnus_maccoyii"])



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

