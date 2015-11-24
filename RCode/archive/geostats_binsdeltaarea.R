
bins_woa<-read.table("/Data/Projects/CMIP5_p50/WOA/p50depthav_bins.txt")
bins_rcp<-read.table("/Data/Projects/CMIP5_p50/ESM2M/p50depthav_bins.txt")

bins_woa<-bins_woa[,4:17]
colnames(bins_woa)<-c("experiment","species", "p50", "deltaH", "z0_100", "z100_200", "z200_300", "z300_400", "z400_500", "z500_600", "z600_700", "z700_800", "z800_900", "z900_1000")
bins_woa<-bins_woa[order(bins_woa$deltaH),]

bins_rcp<-bins_rcp[,4:17]
colnames(bins_rcp)<-c("experiment","species", "p50", "deltaH", "z0_100", "z100_200", "z200_300", "z300_400", "z400_500", "z500_600", "z600_700", "z700_800", "z800_900", "z900_1000")
bins_rcp<-bins_rcp[order(bins_rcp$deltaH),]

specieslist<-unique(bins_woa$species)

quartz()
par(mfrow=c(3,2))

for(a in 1:length(specieslist)){
	
	species_woa<-subset(bins_woa, bins_woa$species==specieslist[a])
	species_rcp<-subset(bins_rcp, bins_rcp$species==specieslist[a])
	
	
	rownames(species_woa)<-"woa"
	rownames(species_rcp)<-"rcp"
	
	species<-rbind(species_woa, species_rcp)
	
	species<-species[,5:14]

	species["change",]<-(species["rcp",] - species["woa",])
		
	deltaarea<-species["change",]/1000000
	
	deltaarea2<-as.data.frame(t(deltaarea))
	
	deltaarea2$idbin<-rownames(deltaarea2)
	
	print(max(deltaarea2$change))
	print(min(deltaarea2$change))

	if(specieslist[a]=="Thunnus_maccoyii"){

	barplot(deltaarea2$change, names.arg=deltaarea2$idbin, ylim=c(-4000000, 4000000), main=specieslist[a], col="black")
	abline(h=0)
	}else{

	barplot(deltaarea2$change, names.arg=deltaarea2$idbin, ylim=c(-4000000, 4000000), main=specieslist[a], col="black")
	abline(h=0)
		
	}
	
}

