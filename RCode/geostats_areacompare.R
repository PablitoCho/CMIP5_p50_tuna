#-------------------------------
# WOA Area with P50 Depth 
#-------------------------------

woa<-read.table("/Data/Projects/CMIP5_p50/IUCN_WOA/IUCN_WOA_p50depthav_area_200_tropics.txt")

woa<-woa[,5:15]
colnames(woa)<-c("species", "p50", "deltaH", "OceanArea", "HabitatArea", "P50Area", "P50Area200", "HA200", "P50DepthAv", "P50DepthVar", "P50DepthN")
#woa<-woa[,c("species", "p50", "deltaH", "HabitatArea", "P50Area200")]

woa$HA200<-ifelse(woa$HA200==-1e34, 0, woa$HA200)

#woa<-woa[order(woa$deltaH),]

woa$P50Area200<-woa$P50Area200/1000000 #convert from m^2 to km^2
woa$P50Area200<-woa$P50Area200/1000000 #convert to scale y-axis labels, ylab adds zeros

woa$P50Area<-woa$P50Area/1000000 #convert from m^2 to km^2
woa$P50Area<-woa$P50Area/1000000 #convert to scale y-axis labels, ylab adds zeros

woa$HabitatArea<-woa$HabitatArea/1000000 #convert from m^2 to km^2
woa$HabitatArea<-woa$HabitatArea/1000000 #convert to scale y-axis labels, ylab adds zeros

woa$HA200<-woa$HA200/1000000 #convert from m^2 to km^2
woa$HA200<-woa$HA200/1000000 #convert to scale y-axis labels, ylab adds zeros

woa<-woa[,c("P50Area", "HabitatArea")]

woa<-as.matrix(t(woa))