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

#----------------------
# Plot Averages Area
#----------------------

areatable_means<-apply(areatable, MARGIN=2, FUN=mean)
areatable_sd<-apply(areatable, MARGIN=2, FUN=sd)
areatable_se<-areatable_sd/sqrt(6)

up_se<-areatable_means+areatable_se
down_se<-areatable_means-areatable_se

outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/delta_allmodels_meanarea.ps")
#postscript(outfile, height=5, width=5)
quartz()
barplot(areatable_means, ylim=c(-2, 10), col=c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f"), xaxt="n", ylab=expression(paste("change in area with P50 depth (10"^"6", " km"^"2", ")", sep="")), beside=TRUE)
locs<-seq(0.7,8.7,1.2)
arrows(locs,areatable_means, locs, up_se, lwd=3, length=0.1, angle=90)
arrows(locs,areatable_means, locs, down_se, lwd=3, length=0.1, angle=90)
box()
locs<-seq(0.7,8.7,1.2)
specieslist<-c("Thunnus\nobesus", "Thunnus\nalbacares", "Katsuwonus\npelamis", "Thunnus\nalalunga", "Thunnus\nthynnus",  "Thunnus\norientalis", "Thunnus\nmaccoyii")
axis(side=1, at=locs, labels=FALSE, tick=TRUE)
axis(side=1, at=locs, line=-4.4, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.6)
abline(h=0)
#dev.off()





#------------------------
# Plot Averages Vertical
#------------------------
library(ncdf)
specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga", "Thunnus_orientalis", "Thunnus_maccoyii")
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

outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/delta_allmodels_meandepthchange.ps")
#postscript(outfile, height=5, width=5)
par(las=1)
quartz()
locs<-seq(0.7,7.5,1.2)
boxplot(depthtable, col=c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f"), xaxt="n", ylab="change in depths (m) common area", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE)
axis(side=1, at=locs, labels=FALSE, tick=TRUE)
abline(h=0, lwd=2)
boxplot(depthtable, col=c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f"), xaxt="n", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE, add=TRUE)
specieslist<-c("Thunnus\nobesus", "Thunnus\nalbacares", "Katsuwonus\npelamis", "Thunnus\nalalunga", "Thunnus\norientalis", "Thunnus\nmaccoyii")
axis(side=1, at=seq(0.7, 7, 1.2), line=-4.4, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.6)
#dev.off()



