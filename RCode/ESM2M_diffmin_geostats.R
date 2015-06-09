geostats<-read.table("~/Dropbox/Manuscripts/CMIP5_p50/Results/ESM2M/ESM2M.rcp85.diffmin.geostats.txt")
geostats<-geostats[,4:14]

#deltadiffmin = ddm
#deltadepthdiffmin = dddm

colnames(geostats)<-c("species", "p50", "deltaH", "av.ddm", "sd.ddm", "av.dddm", "sd.dddm", "av.abs.ddm", "sd.abs.ddm", "av.abs.dddm", "sd.abs.dddm")

barplot(geostats$av.ddm, names.arg=geostats$species)

barplot(geostats$av.dddm, names.arg=geostats$species)

barplot(geostats$av.abs.ddm, names.arg=geostats$species)

barplot(geostats$av.abs.dddm, names.arg=geostats$species)