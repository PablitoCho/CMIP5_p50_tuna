#Change working directory to CMIP5_P50 using the setwd() command or using the Misc menu.  
#getwd() #shows the current working directory for the R gui.  

#If the files have the same data (to 3 significant digits), then the tests are passed.  A passed test means that the analysis code worked!  If the tests fail, the code is not working.

library(ncdf4)


decimalplaces <- function(x) {      
       hold<-strsplit(sub('0+$', '', as.character(x)), ".", fixed=TRUE)
       hold2<-ifelse(hold=="character(0)", list(c("","")), hold)
       df<-data.frame(matrix(unlist(hold2), nrow=length(hold2), byrow=T))
       nchar(as.character(df[,2])) 
   };


TableCompare <- function(filename.new, filename.old) {

	


	new.nc <- nc_open(filename.new)
	old.nc <- nc_open(filename.old)
	
	#Only testing one depth level
	if(new.nc$ndims==2){
	new <- ncvar_get(new.nc, start=c(1,1), count=c(360,180))
	old <- ncvar_get(old.nc, start=c(1,1), count=c(360,180))}
	
	if(new.nc$ndims==3){
	new <- ncvar_get(new.nc, start=c(1,1,1), count=c(360,180,1))
	old <- ncvar_get(old.nc, start=c(1,1,1), count=c(360,180,1))}

	if(new.nc$ndims==4){
	new <- ncvar_get(new.nc, start=c(1,1,1,1), count=c(360,180,1,1))
	old <- ncvar_get(old.nc, start=c(1,1,1,1), count=c(360,180,1,1))}

#--------------------------------------------------------
# Round to 3 significant digits
#--------------------------------------------------------	
	new <- signif(new, digits=4)
	old <- signif(old, digits=4)

	#-----------------------------------------------------
	# Check if there are the same number of rows in files
	#-----------------------------------------------------
	rowcomp <- abs(nrow(new) - nrow(old))

	if (rowcomp > 0) {
		cat("***ERROR***\n")
		cat("*Different Numbers of Rows*\n")
		cat(paste(filename.new, "\n", sep = ""))
		cat(paste(filename.old, "\n", sep = ""))
		cat("--------------\n")
		stop("FAILS TEST, Exiting RScript")
	}

	#--------------------------------------------------------
	# Check if there are the same number of columns in files
	#--------------------------------------------------------
	colcomp <- abs(ncol(new) - ncol(old))

	if (colcomp > 0) {
		cat("***ERROR***\n")
		cat("*Different Numbers of Columns*\n")
		cat(paste(filename.new, "\n", sep = ""))
		cat(paste(filename.old, "\n", sep = ""))
		cat("--------------\n")
		stop("FAILS TEST, Exiting RScript")
	}

	#-----------------------------------------------------
	# Check values in tables
	#-----------------------------------------------------
	numcols <- ncol(new)

	for (i in 1:ncol(new)) {

		diffcols <- abs(new[, i] - old[, i])

		finddiffs <- which(diffcols > 0)

		#---------------------------------
		# Find rounding errors 
		#---------------------------------

		if (length(finddiffs > 0)) {
			vals <- new[finddiffs, i]

			thds <- c()

			for (k in 1:length(vals)) {
					thds <- c(thds, 1 * 10^(-decimalplaces(vals[k])))
			}

			diffvals <- diffcols[finddiffs]
			bigdiffs <- subset(finddiffs, diffvals > thds)

		#-----------------------------
		# Print non-rounding errors 
		#-----------------------------
			if (length(bigdiffs) > 0) {
				for (j in 1:length(bigdiffs)) {
					cat("***ERROR***\n")
					cat("*Different Values*\n")
					cat(paste("col=", i, "\t row=", bigdiffs[j], "\n", sep = ""))
					cat(paste("File 1:\n", sep = ""))
					cat(paste(filename.new, "\n", sep = ""))
					cat(paste("value=", new[bigdiffs[j], i], "\n", sep = ""))
					cat(paste("File 2:\n", sep = ""))
					cat(paste(filename.old, "\n", sep = ""))
					cat(paste("value=", old[bigdiffs[j], i], "\n", sep = ""))
					cat("--------------\n")
					stop("FAILS TEST, Exiting RScript")
				}
			}
		}
	}
	cat("***PASSES ALL COMPARISON TESTS***\n")
	cat(paste("File 1:\n", sep = ""))
	cat(paste(filename.new, "\n", sep = ""))
	cat(paste("File 2:\n", sep = ""))
	cat(paste(filename.old, "\n", sep = ""))
	cat("--------------\n")
	
nc_close(new.nc)
nc_close(old.nc)

}

#Test results for p50 depth in WOA data. 
TableCompare("results/IUCN_WOA/IUCN.WOA.p50depthav.Katsuwonus_pelamis.nc", "testfiles/IUCN.WOA.p50depthav.Katsuwonus_pelamis.nc")
TableCompare("results/IUCN_WOA/IUCN.WOA.p50depthav.Thunnus_albacares.nc", "testfiles/IUCN.WOA.p50depthav.Thunnus_albacares.nc")
TableCompare("results/IUCN_WOA/IUCN.WOA.p50depthav.Thunnus_maccoyii.nc", "testfiles/IUCN.WOA.p50depthav.Thunnus_maccoyii.nc")
TableCompare("results/IUCN_WOA/IUCN.WOA.p50depthav.Thunnus_obesus.nc", "testfiles/IUCN.WOA.p50depthav.Thunnus_obesus.nc")
TableCompare("results/IUCN_WOA/IUCN.WOA.p50depthav.Thunnus_orientalis.nc", "testfiles/IUCN.WOA.p50depthav.Thunnus_orientalis.nc")
TableCompare("results/IUCN_WOA/IUCN.WOA.p50depthav.Thunnus_thynnus.nc", "testfiles/IUCN.WOA.p50depthav.Thunnus_thynnus.nc")

#Test results for projected p50 depth in 2100 from CMIP5 models
TableCompare("results/IUCN_modelmean/IUCN.modelmean.p50depth.Katsuwonus_pelamis.nc", "testfiles/IUCN.modelmean.p50depth.Katsuwonus_pelamis.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.p50depth.Thunnus_albacares.nc", "testfiles/IUCN.modelmean.p50depth.Thunnus_albacares.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.p50depth.Thunnus_maccoyii.nc", "testfiles/IUCN.modelmean.p50depth.Thunnus_maccoyii.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.p50depth.Thunnus_obesus.nc", "testfiles/IUCN.modelmean.p50depth.Thunnus_obesus.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.p50depth.Thunnus_orientalis.nc", "testfiles/IUCN.modelmean.p50depth.Thunnus_orientalis.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.p50depth.Thunnus_thynnus.nc", "testfiles/IUCN.modelmean.p50depth.Thunnus_thynnus.nc")

#Test results for projected changes in P50 depth (deltap50depth)
TableCompare("results/IUCN_modelmean/IUCN.modelmean.deltap50depth.Katsuwonus_pelamis.nc", "testfiles/IUCN.modelmean.deltap50depth.Katsuwonus_pelamis.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.deltap50depth.Thunnus_albacares.nc", "testfiles/IUCN.modelmean.deltap50depth.Thunnus_albacares.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.deltap50depth.Thunnus_maccoyii.nc", "testfiles/IUCN.modelmean.deltap50depth.Thunnus_maccoyii.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.deltap50depth.Thunnus_obesus.nc", "testfiles/IUCN.modelmean.deltap50depth.Thunnus_obesus.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.deltap50depth.Thunnus_orientalis.nc", "testfiles/IUCN.modelmean.deltap50depth.Thunnus_orientalis.nc")
TableCompare("results/IUCN_modelmean/IUCN.modelmean.deltap50depth.Thunnus_thynnus.nc", "testfiles/IUCN.modelmean.deltap50depth.Thunnus_thynnus.nc")

#Test results for changes in the vertical separation between tuna species (deltaseparation)
TableCompare("results/IUCN_modelmean/IUCN.modelmean.deltaseparation.nc", "testfiles/IUCN.modelmean.deltaseparation.nc")
