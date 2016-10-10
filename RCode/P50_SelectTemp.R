p50<-function(ref_p50, ref_Temp, deltaH, alt_Temp){

ref_Temp<-ref_Temp+273
alt_Temp<-alt_Temp+273

R <- 0.008314

delta_p50 <- (deltaH*((1/ref_Temp)-(1/alt_Temp))/(2.303*R)) 	

p50 <- 10^(log(ref_p50, base=10) - delta_p50)	
	
return(p50)
	
}