#geostats<-read.table("/Data/Projects/CMIP5_p50/ESM2M/P50Depthav_geostats.txt")

geostats<-read.table("/Data/Projects/CMIP5_p50/ESM2G/P50Depthav_geostats.txt")
geostats<-geostats[,4:12]

colnames(geostats)<-c("experiment","species", "p50", "deltaH", "globalarea", "p50deptharea", "meanp50depth", "varp50depth", "np50depth")

geostats$SDp50depth<-geostats$varp50depth/geostats$np50depth

control0281<-subset(geostats, geostats$experiment=="control0281")
control0381<-subset(geostats, geostats$experiment=="control0381")
historical<-subset(geostats, geostats$experiment=="historical")
rcp8.5<-subset(geostats, geostats$experiment=="rcp8.5")

control0281<-control0281[,c("species", "p50", "deltaH", "p50deptharea")]
control0381<-control0381[,c("species", "p50", "deltaH", "p50deptharea")]
historical<-historical[,c("species", "p50", "deltaH", "p50deptharea")]
rcp8.5<-rcp8.5[,c("species", "p50", "deltaH", "p50deptharea")]

colnames(control0281)[4]<-"control0281"
colnames(control0381)[4]<-"control0381"
colnames(historical)[4]<-"historical"
colnames(rcp8.5)[4]<-"rcp8.5"

combine.area<-merge(control0281, control0381)
combine.area<-merge(combine.area, historical)
combine.area<-merge(combine.area, rcp8.5)

combine.area$delta.area<-(combine.area$rcp8.5-combine.area$control0381)-(combine.area$historical-combine.area$control0281)
combine.area$delta.area<-combine.area$delta.area/1000000

combine.area<-combine.area[order(combine.area$deltaH),]
quartz()
barplot(combine.area$delta.area, names.arg=combine.area$species, ylim=c(-12000000, 12000000), col="black")
abline(h=0)
