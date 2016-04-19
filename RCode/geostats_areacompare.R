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

woa$HabitatArea<-woa$HabitatArea/1000000 #convert from m^2 to km^2
woa$HabitatArea<-woa$HabitatArea/1000000 #convert to scale y-axis labels, ylab adds zeros

woaplus<-subset(woa, woa$deltaH>2)
woa0<-subset(woa, woa$deltaH>=-2 & woa$deltaH<=2)
woaminus<-subset(woa, woa$deltaH<(-2))

	outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/Tropics_P50DepthArea200_HabitatArea.ps")
	postscript(outfile, height=4, width=4)
#	quartz(height=4, width=4)
	par(mar=c(4.5, 4.5, 0, 0.5))
	par(oma=c(0, 0, 2, 1))
	par(las=1)
	par(yaxs="i")
	
	plot(woaplus$P50Area200, woaplus$HabitatArea, xlim=c(0,80), ylim=c(0,200), xlab=expression(paste("P"[50], " depth area (10"^"6", " km"^"2", ")", sep="")), ylab=expression(paste("geographic range area (10"^"6", " km"^"2", ")", sep="")), pch=15, col="#7570b3", cex=1.2)
	points(woa0$P50Area200, woa0$HabitatArea, pch=16, col="#d95f02", cex=1.2)
	points(woaminus$P50Area200, woaminus$HabitatArea, pch=17, col="#1b9e77", cex=1.2)
	legend(48, 197, legend=c("exothermic","independent","endothermic"), pch=c(17,16,15), col=c("#1b9e77", "#d95f02", "#7570b3"), cex=0.8, pt.cex=1.2, title="Heat of Reaction")
	text(9, 14, expression(italic("T. thynnus")), cex=0.8, pos=4)
	text(41, 8, expression(italic("T. maccoyii")), cex=0.8, pos=4)
	text(61, 42, expression(italic("T. orientalis")), cex=0.8)
	text(23, 135, expression(italic("T. alalunga")), cex=0.8)
	text(19, 170, expression(italic("T. obesus")), cex=0.8, pos=2)
	text(27, 183, expression(italic("T. albacares")), cex=0.8, pos=2)
	text(37, 178, expression(italic("K. pelamis")), cex=0.8, pos=3)

	dev.off()