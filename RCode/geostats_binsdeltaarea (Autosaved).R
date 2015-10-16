bins<-read.table("/Data/Projects/CMIP5_p50/ESM2M/P50Depthav_bins.txt")

bins<-bins[,4:17]

colnames(bins)<-c("experiment","species", "p50", "deltaH", "z0_100", "z100_200", "z200_300", "z300_400", "z400_500", "z500_600", "z600_700", "z700_800", "z800_900", "z900_1000")

bins<-bins[order(bins$deltaH),]

specieslist<-unique(bins$species)

quartz()
par(mfrow=c(3,2))

for(a in 1:length(specieslist)){
	
	species1<-subset(bins, bins$species==specieslist[a])
	
	rownames(species1)<-species1$experiment	
	
	species2<-species1[,5:14]
	
	
	species2["change",]<-(species2["rcp8.5",] - species2["control0381",]) - (species2["historical",] - species2["control0281",])
	
	deltaarea<-species2["change",]/1000000
	
	deltaarea2<-as.data.frame(t(deltaarea))
	
	deltaarea2$idbin<-rownames(deltaarea2)
	
	#print(max(deltaarea2$change))
	#print(min(deltaarea2$change))

	if(specieslist[a]=="Thunnus_maccoyii"){

	barplot(deltaarea2$change, names.arg=deltaarea2$idbin, ylim=c(-4000000, 4000000), main=specieslist[a], col="black")
	abline(h=0)
	}else{

	barplot(deltaarea2$change, names.arg=deltaarea2$idbin, ylim=c(-1500000, 1500000), main=specieslist[a], col="black")
	abline(h=0)
		
	}
	
}

