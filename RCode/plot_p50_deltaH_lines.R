
data<-read.table("~/Code/Projects/CMIP5_p50/sh/Mean_AllModels/Species_global2.csv", sep=",")
colnames(data)<-c("species", "p50", "deltaH")

#quartz()
OutGraph<-paste("~/Code/Projects/CMIP5_p50/graphs/compare_p50.ps", sep="")
postscript(OutGraph, family="Helvetica", width=6, height=6)

plot(data$p50, rep(5, nrow(data)), pch=16, cex=2.5, axes=FALSE, ylab="", xlab="")
abline(h=5, lwd=2)
text(data$p50, rep(5, nrow(data)), labels=data$species, adj=c(0,1), srt=90)

dev.off()

#quartz()
OutGraph<-paste("~/Code/Projects/CMIP5_p50/graphs/compare_deltaH.ps", sep="")
postscript(OutGraph, family="Helvetica", width=6, height=6)

plot(data$deltaH, rep(5, nrow(data)), pch=16, cex=2.5, axes=FALSE, ylab="", xlab="")
abline(h=5, lwd=2)
text(data$deltaH, rep(5, nrow(data)), labels=data$species, adj=c(0,1), srt=90)

dev.off()