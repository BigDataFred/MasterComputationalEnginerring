##
# Da el código que genere la siguiente diana en un documento del tipo pdf. 
# Observa que la circunferencia externa es más gruesa, y que los números no están en el centro de la correspondiente franja.
require(plotrix)
rm(list=ls())

saveName <-'FredericRouxEj3_1.pdf'
pdf(saveName,width=5,height=5) # 552 x 465

#graphics.off()
#dev.list()
#dev.cur()
r <- 1:10
alpha <- seq(0,2*pi, length.out=100)
par(bty='n',pty='s',lwd=1)
plot(r[1]*cos(alpha),r[1]*sin(alpha),type="l",col="black",ylim=(c(-10,10)),xlim=(c(-10,10)),xlab="",ylab="",xaxt="none",yaxt="none")
draw.circle(0,0,1,border="black",col="red")
text(0,r[1]-0.175,sort(r,decreasing=TRUE)[1])
for (curIter in 2:10){
  print(curIter)
  if (curIter < 10){
    par(lwd=1)
  }
  else {
    par(lwd=3)
  }
  lines(r[curIter]*cos(alpha),r[curIter]*sin(alpha),type="l",col="black")
  text(0,r[curIter]-0.175,sort(r,decreasing=TRUE)[curIter],font = 2)
}

dev.off()

