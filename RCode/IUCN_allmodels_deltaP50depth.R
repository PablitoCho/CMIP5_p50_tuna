models<-c("cesm1", "esm2g", "esm2m", "hadgem2", "ipsl", "mpi")
folder<-paste("/Data/Projects/CMIP5_p50/IUCN_models/")

area.all<-as.data.frame(matrix(NA, 0, 7))

#-------------------------------
# Change in Area with P50 Depth 
#-------------------------------

for(a in 1:length(models)){

woa<-read.table("/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area.txt")
rcp<-read.table(paste(folder, "/IUCN_", models[a], "_p50depthav_area_rcp8.5.txt", sep=""))

woa<-woa[,4:13]
colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "HabitatArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
woa<-woa[,c("species", "p50", "deltaH", "P50Area")]
colnames(woa)[4]<-"woa"

rcp<-rcp[,4:13]
colnames(rcp)<-c("experiment","species", "p50", "deltaH", "OceanArea", "HabitatArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
rcp<-rcp[,c("species", "p50", "deltaH", "P50Area")]
colnames(rcp)[4]<-"rcp"
rcp$model<-rep(models[a])

area<-merge(woa, rcp, all=TRUE)
area<-area[order(area$deltaH),]

area$change<-area$rcp-area$woa

area$change<-area$change/1000000 #convert from m^2 to km^2
area$change<-area$change/1000000 #convert to scale y-axis labels, ylab adds zeros

area.all<-rbind(area.all, area)
}

specieslist<-unique(area.all[,c("species", "deltaH")])
specieslist<-specieslist[order(specieslist$deltaH),]
specieslist<-specieslist$species

for(d in 1:length(specieslist)){
	one<-subset(area.all, area.all$species==specieslist[d])
	one<-one[,c("model", "change")]
	if(d==1){areatable<-one}else{areatable<-cbind(areatable,one[,2])}
	colnames(areatable)[d+1]<-specieslist[d]
}
rownames(areatable)<-areatable$model
areatable<-areatable[,-1]
areatable<-as.matrix(areatable)

#-----------------------------
# Average Change in P50 Depth
#-----------------------------
library(ncdf)
specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga", "Thunnus_thynnus", "Thunnus_orientalis", "Thunnus_maccoyii")
  for(c in 1:length(specieslist)){
	file<-paste("/Data/Projects/CMIP5_p50/IUCN_modelmean/IUCN.modelmean.deltap50depth.", specieslist[c], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[1]], start=c(1,1), count=c(360, 180))
		close.ncdf(nc)
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(c==1){
			depthtable<-as.matrix(data3)
			colnames(depthtable)<-paste(specieslist[c], sep="")		
		}else{
			if(nrow(depthtable)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)				
			}
			depthtable<-cbind(depthtable, data3)
			colnames(depthtable)[c]<-paste(specieslist[c], sep="")
		}	
		
	}
depthtable[,5]<-rep(NA) #Thunnus thynnus has almost no habitat area with a P50 depth.

#----------------------
# Plot Averages Area
#----------------------

areatable_means<-apply(areatable, MARGIN=2, FUN=mean)
areatable_sd<-apply(areatable, MARGIN=2, FUN=sd)
areatable_se<-areatable_sd/sqrt(6)

up_se<-areatable_means+areatable_se
down_se<-areatable_means-areatable_se

outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/IUCN_delta_modelmean.ps")
postscript(outfile, height=6, width=4)
#quartz(height=6, width=4)
par(mfrow=c(2,1))
par(mar=c(1, 4.5, 0, 0.5))
par(oma=c(3.8, 0, 2, 1))
par(las=1)
par(yaxs="i")
collist<-c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#bf5b17")

barplot(areatable_means, ylim=c(-2, 10), col=collist, xaxt="n", ylab=expression(paste("change in area (10"^"6", " km"^"2", ")", sep="")), beside=TRUE)
locs<-seq(0.7,8.7,1.2)
arrows(locs,areatable_means, locs, up_se, lwd=2, length=0.1, angle=90)
#arrows(locs,areatable_means, locs, down_se, lwd=3, length=0.1, angle=90, col="white")
box()
locs<-seq(0.7,8.7,1.2)
axis(side=1, at=locs, labels=FALSE, tick=TRUE)
abline(h=0)

locs<-seq(0.7,8.7,1.2)
boxplot(depthtable, col=collist, xaxt="n", ylab="change in depths (m)", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE)
axis(side=1, at=locs, labels=FALSE, tick=TRUE)
abline(h=0, lwd=2)
boxplot(depthtable, col=collist, xaxt="n", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE, add=TRUE)
specieslist<-c("T. obesus", "T. albacares", "K. pelamis", "T. alalunga", "T. thynnus", "T. orientalis",  "T. maccoyii")
axis(side=1, at=locs, line=-1, las=2, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.8)
dev.off()



