deltaH<-function(p501, Temp1, p502, Temp2){

Temp1<-Temp1+273
Temp2<-Temp2+273

H <- 2.303*0.00831*(log(p502, base=10)-log(p501, 10))/((1/Temp2)-(1/Temp1))

return(H)

}