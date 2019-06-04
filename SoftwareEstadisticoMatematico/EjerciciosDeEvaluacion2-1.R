###########################################################################################
saveName <-'FredericRouxEj2_2.pdf'
pdf(saveName,width=8,height=5)
theta <- seq(0,pi,len=100)
r <- cos(2*theta)
r[r<0]<-0
r<- c(-2*sqrt(r),2*sqrt(r))
par(bty='n',lwd=5)
plot(r*cos(theta),r*sin(theta),type='l',col='red',xaxt="none",yaxt="none",xlab='',ylab='')
mtext(side=3,'Lemniscata',col='black',font=2,cex=0.75)
dev.off()
###########################################################################################
