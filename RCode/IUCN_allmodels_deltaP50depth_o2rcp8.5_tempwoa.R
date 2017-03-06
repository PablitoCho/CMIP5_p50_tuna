
#-------------------------------
# Change in Area with P50 Depth 
#-------------------------------
#models<-c("cesm1", "esm2g", "esm2m", "hadgem2", "ipsl", "mpi")
#folder<-paste("/Data/Projects/CMIP5_p50/IUCN_models/")

#area.all<-as.data.frame(matrix(NA, 0, 7))

#for(a in 1:length(models)){

#woa<-read.table("/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area.txt")
#rcp<-read.table(paste(folder, "/IUCN_", models[a], "_p50depthav_area_rcp8.5.txt", sep=""))

#woa<-woa[,4:13]
#colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "HabitatArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
#woa<-woa[,c("species", "p50", "deltaH", "P50Area")]
#colnames(woa)[4]<-"woa"

#rcp<-rcp[,4:13]
#colnames(rcp)<-c("experiment","species", "p50", "deltaH", "OceanArea", "HabitatArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
#rcp<-rcp[,c("species", "p50", "deltaH", "P50Area")]
#colnames(rcp)[4]<-"rcp"
#rcp$model<-rep(models[a])

#area<-merge(woa, rcp, all=TRUE)
#area<-area[order(area$deltaH),]

#area$change<-area$rcp-area$woa

#area$change<-area$change/1000000 #convert from m^2 to km^2
#area$change<-area$change/1000000 #convert to scale y-axis labels, ylab adds zeros

#area.all<-rbind(area.all, area)
#}

#specieslist<-unique(area.all[,c("species", "deltaH")])
#specieslist<-specieslist[order(specieslist$deltaH),]
#specieslist<-specieslist$species

#for(d in 1:length(specieslist)){
#	one<-subset(area.all, area.all$species==specieslist[d])
#	one<-one[,c("model", "change")]
#	if(d==1){areatable<-one}else{areatable<-cbind(areatable,one[,2])}
#	colnames(areatable)[d+1]<-specieslist[d]
#}
#rownames(areatable)<-areatable$model
#areatable<-areatable[,-1]
#areatable<-as.matrix(areatable)

#-----------------------------
# Average Change in P50 Depth
#-----------------------------
library(ncdf4)
specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_thynnus", "Thunnus_orientalis", "Thunnus_maccoyii")
  for(c in 1:length(specieslist)){
	file<-paste("/Data/Projects/CMIP5_p50/IUCN_modelmean/IUCN.modelmean.deltap50depth.", specieslist[c], ".nc", sep="")
	nc<-nc_open(paste(file, sep=""))	
		data<-ncvar_get(nc, nc$var[[1]], start=c(1,1), count=c(360, 180))
		nc_close(nc)
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
#Thunnus thynnus has no habitat area with a P50 depth.
depthtable<-depthtable[,c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_orientalis", "Thunnus_maccoyii")]

#-----------------------------------------
# Average Change in P50 Depth, Oxygen Only
#-----------------------------------------
library(ncdf4)
specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_thynnus", "Thunnus_orientalis", "Thunnus_maccoyii")
  for(c in 1:length(specieslist)){
	file<-paste("/Data/Projects/CMIP5_p50/IUCN_modelmean/IUCN.modelmean.deltap50depth.O2rcp85.TempWOA.", specieslist[c], ".nc", sep="")
	nc<-nc_open(paste(file, sep=""))	
		data<-ncvar_get(nc, nc$var[[1]], start=c(1,1), count=c(360, 180))
		nc_close(nc)
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(c==1){
			depthtable_Thist<-as.matrix(data3)
			colnames(depthtable_Thist)<-paste(specieslist[c], sep="")		
		}else{
			if(nrow(depthtable_Thist)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable_Thist)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable_Thist), ncol(depthtable_Thist))
				depthtable_Thist<-rbind(depthtable_Thist, addNA)				
			}
			depthtable_Thist<-cbind(depthtable_Thist, data3)
			colnames(depthtable_Thist)[c]<-paste(specieslist[c], sep="")
		}	
		
	}
#Thunnus thynnus has no habitat area with a P50 depth.
depthtable_Thist<-depthtable_Thist[,c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_orientalis", "Thunnus_maccoyii")]


#--------------------------
# Calculate Area Statistics
#---------------------------

#areatable_means<-apply(areatable, MARGIN=2, FUN=mean)
#areatable_sd<-apply(areatable, MARGIN=2, FUN=sd)
#areatable_se<-areatable_sd/sqrt(6)

#up_se<-areatable_means+areatable_se
#down_se<-areatable_means-areatable_se

#------------------------
# Plot P50 Depth Changes 
#------------------------

outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/IUCN_deltadepth_modelmean.ps")
#postscript(outfile, height=5.5, width=4, family="Times")
quartz(height=5.5, width=5)
par(mfrow=c(2,1))
par(mar=c(1, 4.5, 1, 3.5))
par(oma=c(3.8, 0, 1, 1))
par(las=1)
par(yaxs="i")
par(tck = 0.03) 
#collist<-c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#bf5b17")
collist<-c("#1b9e77", "#d95f02", "#d95f02", "#7570b3", "#7570b3", "#7570b3", "#7570b3")

#barplot(areatable_means, ylim=c(-2, 10), col=collist, xaxt="n", ylab=expression(paste("change in area (10"^"6", " km"^"2", ")", sep="")), beside=TRUE)
#locs<-seq(0.7,8.7,1.2)
#arrows(locs,areatable_means, locs, up_se, lwd=2, length=0.1, angle=90)
#arrows(locs,areatable_means, locs, down_se, lwd=3, length=0.1, angle=90, col="white")
#box()
#locs<-seq(0.7,8.7,1.2)
#axis(side=1, at=locs, labels=FALSE, tick=TRUE)
#abline(h=0)

locs<-seq(0.7,6.5,1.2)
vlocs<-c(1.3, 3.7)
depthtable[,5]<-depthtable[,5]/3.2
boxplot(depthtable, col=collist, xaxt="n", ylab="Change in depths (m)", ylim=c(-250, 250), at=locs, cex.axis=0.8, notch=TRUE, outline=FALSE, lty=1)
axis(side=1, at=locs, labels=FALSE, tick=TRUE, tck=0.03)
abline(h=0, lwd=1)
boxplot(depthtable, col=collist, xaxt="n", yaxt="n", at=locs, notch=TRUE, outline=FALSE, add=TRUE, lty=1)
altaxis<-c(-600,-300,0,300,600)
converttcks<-altaxis/3.2
axis(side=4, at=converttcks, line=-3.5, labels=altaxis, tick=TRUE, outer=TRUE, lwd=1, cex.axis=0.8, tck=0.03, adj=0.5)
mtext("Change in depths (m)", side=4, at=0.2, las=0, line=3, adj=0.5)
abline(v=vlocs[1], lty=3, lwd=1.5)
abline(v=vlocs[2], lty=3, lwd=1.5)
segments(4.9, -60, 4.9, 250, lty=1)
arrows(4.9,-60, 6.2, -60, lwd=1, lty=1, length=0.1, angle=30)
text(5, -45,"this", cex=0.8, pos=4)
text(4.9, -85,"y-axis", cex=0.8, pos=4)
text(0, -200,"exo-\nthermic", cex=0.8, pos=4)
text(1.6, -200,"independent", cex=0.8, pos=4)
text(4, -200,"endothermic", cex=0.8, pos=4)
mtext("(a)", side=3, at=0.2)
mtext("ocean surface", side=3, las=1, at=5.4, cex=0.8)
mtext("ocean bottom", side=1, las=1, at=5.4, line=-0.2, cex=0.8)

depthtable_Thist[,5]<-depthtable_Thist[,5]/3.2
boxplot(depthtable_Thist, col=collist, xaxt="n", ylab="Change in depths (m)", ylim=c(-250, 250), at=locs, notch=TRUE, outline=FALSE, lty=1, cex.axis=0.8)
axis(side=1, at=locs, labels=FALSE, tick=TRUE, tck=0.03)
abline(h=0, lwd=1)
boxplot(depthtable_Thist, col=collist, xaxt="n", yaxt="n", ylim=c(-400, 800), at=locs, notch=TRUE, outline=FALSE, add=TRUE, lty=1)
specieslist<-c("bigeye", "yellowfin", "skipjack", "P. bluefin", "S. bluefin")
axis(side=1, at=locs, line=-1.7, las=2, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.8, tck=0.03)
axis(side=4, at=converttcks, line=-3.5, labels=altaxis, tick=TRUE, outer=TRUE, lwd=1, cex.axis=0.8, tck=0.03, adj=0.5)
mtext("Change in depths (m)", side=4, at=0.2, las=0, line=3, adj=0.5)
abline(v=vlocs[1], lty=3, lwd=1.5)
abline(v=vlocs[2], lty=3, lwd=1.5)
segments(4.9, -60, 4.9, 250, lty=1)
arrows(4.9,-60, 6.2, -60, lwd=1, lty=1, length=0.1, angle=30)
text(5, -45,"this", cex=0.8, pos=4)
text(4.9, -85,"y-axis", cex=0.8, pos=4)
text(0, -200,"exo-\nthermic", cex=0.8, pos=4)
text(1.6, -200,"independent", cex=0.8, pos=4)
text(4, -200,"endothermic", cex=0.8, pos=4)
mtext("(b)", side=3, at=0.2)
mtext("ocean surface", side=3, las=1, at=5.4, cex=0.8)
#dev.off()

#--------------------------
# Calculate Statistics
#---------------------------
Median_O2Temp<-apply(depthtable, MARGIN=2, FUN=median, na.rm=TRUE)
Median_O2<-apply(depthtable_Thist, MARGIN=2, FUN=median, na.rm=TRUE)

Median_O2Temp-Median_O2

