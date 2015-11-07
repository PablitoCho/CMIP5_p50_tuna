library(ncdf)

specieslist<-c("Thunnus_obesus", "Thunnus_albacares", "Katsuwonus_pelamis", "Thunnus_thynnus", "Scomber_japonicus", "Thunnus_maccoyii")


quartz()
par(mfrow=c(3,2))

for(a in 1:length(specieslist)){
	
	#folder<-paste("/Data/Projects/CMIP5_p50/ESM2G/", specieslist[a], "/delta_p50depthav_bins/", sep="")
	folder<-paste("/Data/Projects/CMIP5_p50/ESM2M/", specieslist[a], "/delta_p50depthav_bins/", sep="")
	files<-list.files(folder)
	
	for(b in 1:length(files)){
		nc<-open.ncdf(paste(folder, files[b], sep=""))	
		data<-get.var.ncdf(nc, nc$var[[2]], start=c(1,1), count=c(360, 200))
		data2<-as.vector(data)
		data3<-subset(data2, is.na(data2)==FALSE)
		if(b==1){
			depthtable<-as.matrix(data3)
			colnames(depthtable)<-"d100"			
		}else{
			if(nrow(depthtable)>length(data3)){
				data3<-c(data3, rep(NA, 1, nrow(depthtable)-length(data3)))					
			}else{
				addNA<-matrix(NA, length(data3)-nrow(depthtable), ncol(depthtable))
				depthtable<-rbind(depthtable, addNA)				
			}
			depthtable<-cbind(depthtable, data3)
			colnames(depthtable)[b]<-paste("d", b*100, sep="")
		}	
		
	}
	

	boxplot(depthtable, main=specieslist[a], ylim=c(-500,500))
	abline(h=0)
}
