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
#Thunnus thynnus is removed from the table because it has no habitat with a P50 depth.
depthtable<-depthtable[,c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_orientalis", "Thunnus_maccoyii")]


#------------------------
# Plot P50 Depth Changes 
#------------------------

outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/IUCN_deltadepth_modelmean.ps")
postscript(outfile, height=3.5, width=4.5, family="Times")
#quartz(height=3.5, width=4.5)
par(mar=c(1, 4.5, 1, 3.5))
par(oma=c(3.8, 0, 1, 1))
par(las=1)
par(yaxs="i")
par(tck = 0.03) 
par(mgp = c(2,0.3,0))
collist<-c("#1b9e77", "#d95f02", "#d95f02", "#7570b3", "#7570b3", "#7570b3", "#7570b3")

#Create boxplots 
locs<-seq(0.7,6.5,1.2)
vlocs<-c(1.3, 3.7)
depthtable[,5]<-depthtable[,5]/3.2  #Adjust Thunnus_maccoyii y-axis
boxplot(depthtable, col=collist, xaxt="n", ylab="Change in depths (m)", ylim=c(-250, 250), at=locs, cex.axis=0.8, notch=TRUE, outline=FALSE, lty=1)
abline(h=0, lwd=1)
boxplot(depthtable, col=collist, xaxt="n", yaxt="n", at=locs, notch=TRUE, outline=FALSE, add=TRUE, lty=1)
specieslist<-c("bigeye", "yellowfin", "skipjack", "P. bluefin", "S. bluefin")
axis(side=1, at=locs, line=-1, las=2, labels=specieslist, tick=TRUE, outer=TRUE, cex.axis=0.8, tck=0.03)
#Add axis for Thunnus_maccoyii
altaxis<-c(-600,-300,0,300,600)
converttcks<-altaxis/3.2
axis(side=4, at=converttcks, line=-3.5, labels=altaxis, tick=TRUE, outer=TRUE, lwd=1, cex.axis=0.8, tck=0.03, adj=0.5) 
mtext("Change in depths (m)", side=4, at=0.2, las=0, line=2, adj=0.5)
#Add lines and text to the plot
abline(v=vlocs[1], lty=2, lwd=1.5)
abline(v=vlocs[2], lty=2, lwd=1.5)
segments(4.9, -60, 4.9, 250, lty=1)
arrows(4.9,-60, 6.2, -60, lwd=1, lty=1, length=0.08, angle=30)
text(4.85, -40,"y-axis", cex=0.8, pos=4)
text(4.55, -85,"S. bluefin", cex=0.8, pos=4)
text(-0.05, -200,"exo-\nthermic", cex=0.8, pos=4)
text(1.5, -200,"independent", cex=0.8, pos=4)
text(3.9, -200,"endothermic", cex=0.8, pos=4)
mtext("ocean surface", side=3, las=1, at=6.7, cex=0.8)
mtext("ocean bottom", side=1, las=1, at=6.7, line=-0.2, cex=0.8)

dev.off()

#--------------------------
# Calculate Statistics
#---------------------------
Median_O2Temp<-apply(depthtable, MARGIN=2, FUN=median, na.rm=TRUE)
Median_O2<-apply(depthtable_Thist, MARGIN=2, FUN=median, na.rm=TRUE)

Median_O2Temp[5]<-Median_O2Temp[5]*3.2
Median_O2[5]<-Median_O2[5]*3.2

Median_O2Temp-Median_O2

