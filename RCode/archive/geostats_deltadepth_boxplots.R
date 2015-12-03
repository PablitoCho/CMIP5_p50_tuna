library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_thynnus", "Scomber_japonicus", "Thunnus_maccoyii")

#quartz()
outfile<-paste("~/Code/Projects/CMIP5_p50/graphs/ESM2M_deltadepth.ps")
postscript(outfile, height=5, width=5)

for(a in 1:length(specieslist)){
	
	file<-paste("/Data/Projects/CMIP5_p50/ESM2M/", specieslist[a], "/deltap50depth/esm2m.deltap50depthav.", specieslist[a], ".nc", sep="")
	nc<-open.ncdf(paste(file, sep=""))	
		data<-get.var.ncdf(nc, nc$var[[1]], start=c(1,1), count=c(360, 180))
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(a==1){
			depthtable<-as.matrix(data3)
			colnames(depthtable)<-specieslist[a]		
		}else{
			if(nrow(depthtable)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)				
			}
			depthtable<-cbind(depthtable, data3)
			colnames(depthtable)[a]<-paste(specieslist[a])
		}	
		
	}
	print(apply(depthtable, MARGIN=2, max, na.rm=TRUE))
	print(apply(depthtable, MARGIN=2, min, na.rm=TRUE))

	boxplot(depthtable, main="ESM2M", ylim=c(-350,350), notch=TRUE, outline=FALSE)
	abline(h=0)
dev.off()