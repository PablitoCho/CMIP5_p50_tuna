
woa<-read.table("/Data/Projects/CMIP5_p50/WOA/WOA_p50depthav_area.txt")
rcp<-read.table("/Data/Projects/CMIP5_p50/ESM2M/ESM2M_p50depthav_area_rcp8.5.txt")

woa<-woa[,4:12]
colnames(woa)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
woa<-woa[,c("species", "p50", "deltaH", "P50Area")]
colnames(woa)[4]<-"woa"

rcp<-rcp[,4:12]
colnames(rcp)<-c("experiment","species", "p50", "deltaH", "OceanArea", "P50Area", "P50DepthAv", "P50DepthVar", "P50DepthN")
rcp<-rcp[,c("species", "p50", "deltaH", "P50Area")]
colnames(rcp)[4]<-"rcp"

area<-merge(woa, rcp, all=TRUE)
area<-area[order(area$deltaH),]

area$change<-area$rcp-area$woa

area$change<-area$change/1000000 #convert from m^2 to km^2
area$change<-area$change/1000000 #convert to scale y-axis labels, ylab adds zeros

#quartz()
outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/ESM2M_deltaarea.ps")
postscript(outfile, height=5, width=5)

barplot(area$change, names.arg=area$species, ylim=c(-5, 15), ylab="10^6 km^2", main="ESM2M", col="black")
abline(h=0)
	
dev.off()

