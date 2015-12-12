#-------------------------------
# WOA Area with P50 Depth 
#-------------------------------

woa<-read.table("/Data/Projects/CMIP5_p50/WOA/WOA_p50depthav_area.txt")

woa<-woa[,4:13]
colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50Area_DeltaH0", "P50DepthAv", "P50DepthVar", "P50DepthN")
woa<-woa[,c("species", "p50", "deltaH", "P50Area_DeltaH0")]

woa<-woa[order(woa$deltaH),]

woa$P50Area<-woa$P50Area/1000000 #convert from m^2 to km^2
woa$P50Area<-woa$P50Area/1000000 #convert to scale y-axis labels, ylab adds zeros

#-------------------------
# P50 Depth WOA
#-------------------------

library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_thynnus", "Scomber_japonicus", "Thunnus_maccoyii")

for(a in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/WOA/", specieslist[a], "/p50depth/woa.p50depthav.", specieslist[a], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[2]], start=c(1,1), count=c(360, 180))
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
#	print(apply(depthtable, MARGIN=2, max, na.rm=TRUE))
#	print(apply(depthtable, MARGIN=2, min, na.rm=TRUE))




#quartz(height=10, width=5)
outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/WOA_geostats_deltaH0.ps")
postscript(outfile, height=10, width=5)
par(mfrow=c(2,1))
par(mar=c(2, 4, 2, 2))
par(las=1)

par(yaxs="i")

  barplot(woa$P50Area, names.arg=woa$species, ylim=c(0, 200), xaxt="n", ylab="10^6 km^2", main="WOA P50 Depth, deltaH=0", col="black")
  abline(h=0, lwd=2)

  boxplot(depthtable, ylim=c(-1500, 0), ylab="depth (m)", notch=TRUE, outline=FALSE)

dev.off()

