geostats<-read.table("/Data/Projects/CMIP5_p50/ESM2M/P50Depthav_geostats.txt")

#geostats<-read.table("/Data/Projects/CMIP5_p50/ESM2G/P50Depthav_geostats.txt")
geostats<-geostats[,4:13]

colnames(geostats)<-c("experiment","species", "p50", "deltaH", "globalarea", "p50deptharea", "meanp50depth", "varp50depth", "np50depth", "p50depthvol")

control0281<-subset(geostats, geostats$experiment=="control0281")
control0381<-subset(geostats, geostats$experiment=="control0381")
historical<-subset(geostats, geostats$experiment=="historical")
rcp8.5<-subset(geostats, geostats$experiment=="rcp8.5")

control0281<-control0281[,c("species", "p50", "deltaH", "p50depthvol")]
control0381<-control0381[,c("species", "p50", "deltaH", "p50depthvol")]
historical<-historical[,c("species", "p50", "deltaH", "p50depthvol")]
rcp8.5<-rcp8.5[,c("species", "p50", "deltaH", "p50depthvol")]

colnames(control0281)[4]<-"control0281"
colnames(control0381)[4]<-"control0381"
colnames(historical)[4]<-"historical"
colnames(rcp8.5)[4]<-"rcp8.5"

combine.vol<-merge(control0281, control0381)
combine.vol<-merge(combine.vol, historical)
combine.vol<-merge(combine.vol, rcp8.5)

combine.vol$delta.vol<-(combine.vol$rcp8.5-combine.vol$control0381)-(combine.vol$historical-combine.vol$control0281)
combine.vol$delta.vol<-combine.vol$delta.vol/1000000000

combine.vol<-combine.vol[order(combine.vol$deltaH),]
quartz()
barplot(combine.vol$delta.vol, names.arg=combine.vol$species, col="black")
abline(h=0)
