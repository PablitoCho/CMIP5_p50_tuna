
models<-c("cesm1", "esm2g", "esm2m", "hadgem2", "ipsl", "mpi")
folder<-paste("/Data/Projects/CMIP5_p50/")

area.all<-as.data.frame(matrix(NA, 0, 7))

#-------------------------------
# Change in Area with P50 Depth 
#-------------------------------

for(a in 1:length(models)){

woa<-read.table("/Data/Projects/CMIP5_p50/WOA/WOA_p50depthav_area.txt")
rcp<-read.table(paste(folder, models[a], "/", models[a], "_p50depthav_area_rcp8.5.txt", sep=""))

woa<-woa[,4:13]
colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50Area_DeltaH0", "P50DepthAv", "P50DepthVar", "P50DepthN")
woa<-woa[,c("species", "p50", "deltaH", "P50Area_DeltaH0")]
colnames(woa)[4]<-"woa"

rcp<-rcp[,4:13]
colnames(rcp)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50Area_DeltaH0", "P50DepthAv", "P50DepthVar", "P50DepthN")
rcp<-rcp[,c("species", "p50", "deltaH", "P50Area_DeltaH0")]
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

#library(lattice)
#area.all$species<-factor(area.all$species, levels=specieslist$species)
#barchart(change~species,data=area.all,groups=model, origin=0, ylab="delta area 10^6 km^2")

#-------------------------
# Change in P50 Depth
#-------------------------

library(ncdf)
specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga", "Thunnus_thynnus", "Thunnus_maccoyii")
models<-c("cesm1", "esm2g", "esm2m", "hadgem2", "ipsl", "mpi")

for(b in 1:length(models)){
  for(c in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/", models[b], "/", specieslist[c], "/deltap50depth/", models[b], ".deltap50depthav.", specieslist[c], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[2]], start=c(1,1), count=c(360, 180))
		close.ncdf(nc)
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(c==1){
			depthtable<-as.matrix(data3)
			colnames(depthtable)<-paste(specieslist[c], ".", models[b], sep="")		
		}else{
			if(nrow(depthtable)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)				
			}
			depthtable<-cbind(depthtable, data3)
			colnames(depthtable)[c]<-paste(specieslist[c], ".", models[b], sep="")
		}	
		
	}
	if(b==1){
	  	depthtable.all<-depthtable
	}else{
	
	  if(nrow(depthtable.all)>nrow(depthtable)){
				addNA<-matrix(NA, nrow(depthtable.all)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)			
			}else{
				addNA<-matrix(NA, nrow(depthtable)-nrow(depthtable.all), ncol(depthtable.all))
				depthtable.all<-rbind(depthtable.all, addNA)				
			}
			
	  depthtable.all<-cbind(depthtable.all, depthtable)
	}
}
#	print(apply(depthtable, MARGIN=2, max, na.rm=TRUE))
#	print(apply(depthtable, MARGIN=2, min, na.rm=TRUE))
         
depthtable.all2<-depthtable.all[,c("Thunnus_obesus.cesm1", "Thunnus_obesus.esm2g", "Thunnus_obesus.esm2m", "Thunnus_obesus.hadgem2", "Thunnus_obesus.ipsl", "Thunnus_obesus.mpi", "Thunnus_albacares.cesm1", "Thunnus_albacares.esm2g", "Thunnus_albacares.esm2m", "Thunnus_albacares.hadgem2", "Thunnus_albacares.ipsl", "Thunnus_albacares.mpi", "Katsuwonus_pelamis.cesm1", "Katsuwonus_pelamis.esm2g", "Katsuwonus_pelamis.esm2m", "Katsuwonus_pelamis.hadgem2", "Katsuwonus_pelamis.ipsl", "Katsuwonus_pelamis.mpi", "Thunnus_alalunga.cesm1", "Thunnus_alalunga.esm2g", "Thunnus_alalunga.esm2m", "Thunnus_alalunga.hadgem2", "Thunnus_alalunga.ipsl", "Thunnus_alalunga.mpi", "Thunnus_thynnus.cesm1", "Thunnus_thynnus.esm2g", "Thunnus_thynnus.esm2m", "Thunnus_thynnus.hadgem2", "Thunnus_thynnus.ipsl", "Thunnus_thynnus.mpi", "Thunnus_maccoyii.cesm1", "Thunnus_maccoyii.esm2g", "Thunnus_maccoyii.esm2m", "Thunnus_maccoyii.hadgem2", "Thunnus_maccoyii.ipsl", "Thunnus_maccoyii.mpi")]


#---------------------------------
# Change in P50 Depth Common Area
#---------------------------------

library(ncdf)
specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_alalunga", "Thunnus_thynnus", "Thunnus_maccoyii")
models<-c("cesm1", "esm2g", "esm2m", "hadgem2", "ipsl", "mpi")

for(b in 1:length(models)){
  for(c in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/", models[b], "/", specieslist[c], "/deltap50depth/", models[b], ".deltap50depthav.commonarea.", specieslist[c], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[2]], start=c(1,1), count=c(360, 180))
		close.ncdf(nc)
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(c==1){
			depthtable<-as.matrix(data3)
			colnames(depthtable)<-paste(specieslist[c], ".", models[b], sep="")		
		}else{
			if(nrow(depthtable)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)				
			}
			depthtable<-cbind(depthtable, data3)
			colnames(depthtable)[c]<-paste(specieslist[c], ".", models[b], sep="")
		}	
		
	}
	if(b==1){
	  	depthtable.all<-depthtable
	}else{
	
	  if(nrow(depthtable.all)>nrow(depthtable)){
				addNA<-matrix(NA, nrow(depthtable.all)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)			
			}else{
				addNA<-matrix(NA, nrow(depthtable)-nrow(depthtable.all), ncol(depthtable.all))
				depthtable.all<-rbind(depthtable.all, addNA)				
			}
			
	  depthtable.all<-cbind(depthtable.all, depthtable)
	}
}
#	print(apply(depthtable, MARGIN=2, max, na.rm=TRUE))
#	print(apply(depthtable, MARGIN=2, min, na.rm=TRUE))
         
depthtable.all2<-depthtable.all[,c("Thunnus_obesus.cesm1", "Thunnus_obesus.esm2g", "Thunnus_obesus.esm2m", "Thunnus_obesus.hadgem2", "Thunnus_obesus.ipsl", "Thunnus_obesus.mpi", "Thunnus_albacares.cesm1", "Thunnus_albacares.esm2g", "Thunnus_albacares.esm2m", "Thunnus_albacares.hadgem2", "Thunnus_albacares.ipsl", "Thunnus_albacares.mpi", "Katsuwonus_pelamis.cesm1", "Katsuwonus_pelamis.esm2g", "Katsuwonus_pelamis.esm2m", "Katsuwonus_pelamis.hadgem2", "Katsuwonus_pelamis.ipsl", "Katsuwonus_pelamis.mpi", "Thunnus_alalunga.cesm1", "Thunnus_alalunga.esm2g", "Thunnus_alalunga.esm2m", "Thunnus_alalunga.hadgem2", "Thunnus_alalunga.ipsl", "Thunnus_alalunga.mpi", "Thunnus_thynnus.cesm1", "Thunnus_thynnus.esm2g", "Thunnus_thynnus.esm2m", "Thunnus_thynnus.hadgem2", "Thunnus_thynnus.ipsl", "Thunnus_thynnus.mpi", "Thunnus_maccoyii.cesm1", "Thunnus_maccoyii.esm2g", "Thunnus_maccoyii.esm2m", "Thunnus_maccoyii.hadgem2", "Thunnus_maccoyii.ipsl", "Thunnus_maccoyii.mpi")]



#quartz(height=8, width=4)
outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/delta_allmodels_deltaH0.ps")
postscript(outfile, height=8, width=4)
par(mfrow=c(3,1))
par(mar=c(1, 4.5, 0, 0.5))
par(oma=c(2, 0, 2, 1))
par(las=1)

barplot(areatable, ylim=c(-5, 20), col=c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f"), legend=rownames(areatable), args.legend = list(x = "topleft", inset=c(0.05, 0.02), cex=0.7), xaxt="n", ylab=expression(paste("change in area (10"^"6", " km"^"2", ")", sep="")), space=c(0,2), beside=TRUE)
box()
locs<-c(seq(2.5,7.5,1), seq(10.5,15.5,1), seq(18.5,23.5,1), seq(26.5,31.5,1), seq(34.5,39.5,1), seq(42,47,1))
axis(side=1, at=locs, labels=FALSE, tick=TRUE)
abline(h=0)

#locs<-c(seq(1,6,1), seq(8,13,1), seq(15,20,1), seq(22,27,1), seq(29,34,1), seq(36,41,1))
locs<-c(seq(1,6,1), seq(9,14,1), seq(17,22,1), seq(25,30,1), seq(33,38,1), seq(41,46,1))
cols<-c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f")
boxplot(depthtable.all2, col=cols, xaxt="n", ylab="change in depths (m)", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE)
axis(side=1, at=locs, labels=FALSE, tick=TRUE)
abline(h=0)
boxplot(depthtable.all2, col=cols, xaxt="n", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE, add=TRUE)
specieslist<-c("Thunnus\nobesus", "Thunnus\nalbacares", "Katsuwonus\npelamis", "Thunnus\nalalunga", "Thunnus\nthynnus",  "Thunnus\nmaccoyii")
axis(side=1, at=c(3.5,11.5,19.5,27.5,35.5,43.5), line=-0.8, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.7)

boxplot(depthtable2.all2, col=cols, xaxt="n", ylab="change in depths (m) common area", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE)
axis(side=1, at=locs, labels=FALSE, tick=TRUE)
abline(h=0)
boxplot(depthtable2.all2, col=cols, xaxt="n", ylim=c(-500, 500), at=locs, notch=TRUE, outline=FALSE, add=TRUE)
specieslist<-c("Thunnus\nobesus", "Thunnus\nalbacares", "Katsuwonus\npelamis", "Thunnus\nalalunga", "Thunnus\nthynnus",  "Thunnus\nmaccoyii")
axis(side=1, at=c(3.5,11.5,19.5,27.5,35.5,43.5), line=-0.8, labels=specieslist, tick=FALSE, outer=TRUE, cex.axis=0.7)

mtext("CMIP5 Models P50Depth, deltaH = 0", adj=0.7, line=0.2, outer=TRUE)

dev.off()

