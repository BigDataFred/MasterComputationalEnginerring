##################################################################################################################################################################
# 1 Da el código cuya ejecución traza el gráfico que viene a continuación, a partir del fichero de datos '9.4.DAT' recogido durante la lección.
#
saveName <-'FredericRouxEj2_1.pdf'
pdf(saveName,width=8,height=5)
y <- scan('9.4.DAT')
x <- 1800:1997
plot(x,y,type='l',col='red',xlab='',ylab='',yaxt="none",bty='l')
axis(2, seq(67,475,67*2+2), las=2,ylab='Precio ($)')
mtext(side=1,'Año',col='red',padj=4)
mtext(side=2,'Precio ($)',col='red',las=2,adj=1.1)
mtext(side=3,'Evolución del precio del cobre ($)\n en el periodo 1800-1997',col='blue',font=4) 
dev.off()
##################################################################################################################################################################
