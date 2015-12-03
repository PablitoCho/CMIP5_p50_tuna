bins_rcp<-read.table("/Data/Projects/CMIP5_p50/ESM2M/deltap50depth_bins.txt")

bins_rcp<-bins_rcp[,4:17]
colnames(bins_rcp)<-c("statistic","species", "p50", "deltaH", "z0_100", "z100_200", "z200_300", "z300_400", "z400_500", "z500_600", "z600_700", "z700_800", "z800_900", "z900_1000")
bins_rcp<-bins_rcp[order(bins_rcp$deltaH),]

specieslist<-unique(bins_woa$species)

quartz()
par(mfrow=c(3,2))

for(a in 1:length(specieslist)){
	
	species_rcp<-subset(bins_rcp, bins_rcp$species==specieslist[a])
		
	species<-species_rcp[,5:14]
	
	deltadepth<-as.data.frame(t(species))
	colnames(deltadepth)<-"deltadepth"
	deltadepth$idbin<-rownames(deltadepth)


	if(a==1){

	barplot(deltadepth$deltadepth, names.arg=deltadepth$idbin, ylim=c(-160, 160), main=specieslist[a], col="black")
	abline(h=0)
	}else{

	barplot(deltadepth$deltadepth, names.arg=deltadepth$idbin, ylim=c(-160, 160), main=specieslist[a], col="black")
	abline(h=0)
		
	}
	
}

