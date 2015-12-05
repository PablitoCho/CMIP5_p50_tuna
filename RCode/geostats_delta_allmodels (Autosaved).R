library(lattice)

models<-c("cesm1", "esm2g", "esm2m", "hadgem2", "ipsl", "mpi")
folder<-paste("/Data/Projects/CMIP5_p50/")

area.all<-as.data.frame(matrix(NA, 0, 7))


#-------------------------------
# Change in Area with P50 Depth 
#-------------------------------

for(a in 1:length(models)){

woa<-read.table("/Data/Projects/CMIP5_p50/WOA/WOA_p50depthav_area.txt")
rcp<-read.table(paste(folder, models[a], "/", models[a], "_p50depthav_area_rcp8.5.txt", sep=""))

woa<-woa[,4:12]
colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
woa<-woa[,c("species", "p50", "deltaH", "P50Area")]
colnames(woa)[4]<-"woa"

rcp<-rcp[,4:12]
colnames(rcp)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
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
area.all$species<-factor(area.all$species, levels=specieslist$species)


quartz()
barchart(change~species,data=area.all,groups=model, origin=0, ylab="delta area 10^6 km^2")

#-------------------------
# Change in P50 Depth
#-------------------------

library(ncdf)
specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_thynnus", "Scomber_japonicus", "Thunnus_maccoyii")

for(b in 1:length(models)){
  for(c in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/", models[b], "/", specieslist[c], "/deltap50depth/", models[b], ".deltap50depthav.", specieslist[c], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[1]], start=c(1,1), count=c(360, 180))
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(c==1){
			depthtable<-as.matrix(data3)
			colnames(depthtable)<-specieslist[c]		
		}else{
			if(nrow(depthtable)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)				
			}
			depthtable<-cbind(depthtable, data3)
			colnames(depthtable)[c]<-paste(specieslist[c])
		}	
		
	}
}
#	print(apply(depthtable, MARGIN=2, max, na.rm=TRUE))
#	print(apply(depthtable, MARGIN=2, min, na.rm=TRUE))

#quartz(height=10, width=5)
outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/ESM2M_delta.ps")
postscript(outfile, height=10, width=5)
par(mfrow=c(2,1))
par(mar=c(2, 4, 2, 2))
par(las=1)

  barplot(area$change, names.arg=area$species, ylim=c(-5, 15), xaxt="n", ylab="10^6 km^2", main="ESM2M", col="black")
  abline(h=0)

  boxplot(depthtable, ylim=c(-350,350), ylab="depth (m)", notch=TRUE, outline=FALSE)
  abline(h=0)

dev.off()

