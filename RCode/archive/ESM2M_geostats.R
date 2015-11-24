area<-read.table("~/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/ESM2M.rcp85.p50depthav.geostats.txt", sep="\t")

colnames(area)<-c("species", "p50", "deltaH", "area.c.hist", "area.c.rcp85", "area.hist", "area.rcp85", "mean", "sd")

area$species<-gsub("I / \\*:   ", "", area$species)

area$areachange<-(area$area.rcp85-area$area.c.rcp85)-(area$area.hist-area$area.c.hist)

area$areachange<-area$areachange/1000000  # convert m^2 to km^2

barplot(area$areachange, ylim=c(-15e+06, 15e+06), names.arg=area$species)

mean(area$areachange) # in km^2

#write.table()