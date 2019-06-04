################################################################################################
# Ejercicio 4.1
#
# Hacer una an??lisis de conglomerados (clustering) de los datos del fichero adjunto, 
# que consiste en una tabla 200x41, mediante la funci??n 'hclust()'.
#
# En ??l se describen 200 objetos mediante 40 variables num??ricas. 
# Tambi??n tienen una variable cualitativa suplementaria (la 41??), 
# que no ser?? considerada a la hora de formar los cl??steres.
################################################################################################
rm(list=ls())# re-initializacion del entorno de trabajo
graphics.off()# cerrar todas las figuras abiertas

library(cluster)# carga la biblioteca


# nombre del archivo PDF donde se guardaran los resultados
pdf(file='FR??D??RIC_ROUX_Ejercicio4-1_ead_md-v.pdf',width=5, heigh=10, paper='a4r')

# cargar datos OCR
load('~/Downloads/ocr.Rdata')

datos0 <- ocr[,1:40]# descartamos la variable #41

# estandarizar las variables (media 0, varianza 1)
datosS <- scale(datos0, center=TRUE, scale=TRUE)

# visualizacion de la estandardizacion sobre los datos 
plot.new()
par( mfcol=c(1,2) )
image(1:ncol(datos0),1:nrow(datos0),as.matrix(t(datos0)),xlab='Number of variables', ylab='Number of objects',main='Raw data')
image(1:ncol(datosS),1:nrow(datosS),as.matrix(t(datosS)),xlab='Number of variables', ylab='Number of objects',main='Standardized data')

# calcula distancias euclidianas
distancias <- dist(datosS, method="euclidean", upper=TRUE, diag=TRUE)

# hay n*(n-1)/2 de distancias, donde n esta igual al numero de casos
nrow(datosS)*(nrow(datosS)-1)/2 == length(distancias)

# y por lo tanto, podemos visualizar las distancias en una matrix rectangular
image(1:nrow(as.matrix(distancias)),1:ncol(as.matrix(distancias)),as.matrix(distancias),xlab='Sample #', ylab='Sample #',main='Pairwise distance matrix',axes=FALSE)
axis(side = 1, at = c(1,200))
axis(side = 2, at = c(1,200))
box()

# applicamos los diferentes metodos de clustering agregativo
single <- hclust(distancias, method="single")
complete <- hclust(distancias)
average <- hclust(distancias, method="average")
ward <- hclust(distancias, method="ward.D")
ward2 <- hclust(distancias, method="ward.D2")
ward22 <- hclust(distancias^2, method="ward.D")

# Trazado de los dendrograma correspondiente a cada metodo
par( mfcol=c(3,2) )
plot(single, hang=-1, main='Method=Single', sub='', las=1,xlab='')
plot(complete, hang=-1, main='Method=Complete', sub='', las=1,xlab='')
plot(average, hang=-1, main='Method=Average', sub='', las=1,xlab='')
plot(ward, hang=-1, main='Method=Ward', sub='', las=1,xlab='')
plot(ward2, hang=-1, main='Method=Ward^2', sub='', las=1,xlab='')
plot(ward22, hang=-1, main='Method=Ward2', sub='', las=1,xlab='')

# Validaci??n interna con visualizacion de las silhuetas
# funcion para producir las figuras
makeSilPlot <- function (cluMeth){
  par( mfcol=c(1,1) )
  (cut <- cutree(cluMeth, k=2:10))
  for (ix in 1:9){
    etclases <- sort(unique(cut[,ix]))
    plot(silhouette(cut[,ix], distancias), col=etclases+1)
  }
}
#visualizacion de las silhuetas
plot.new()
title(main='Method=Single')
makeSilPlot(single)# hace una silhueta para cada corte entre 2 y 10 clusters
plot.new()
title(main='Method=Complete')
makeSilPlot(complete)
plot.new()
title(main='Method=Average')
makeSilPlot(average)
plot.new()
title(main='Method=Ward')
makeSilPlot(ward)
plot.new()
title(main='Method=Ward^2')
makeSilPlot(ward2)
plot.new()
title(main='Method=Ward22')
makeSilPlot(ward22)

# funcion para calcular el valor mediano s(i)
calASI <-function(cluMeth){
  asi <- matrix(nrow=9,ncol=10) 
  (cut <- cutree(cluMeth, k=2:10))
  for (ix in 1:9){
    tmp<-silhouette(cut[,ix], distancias)
    for (ix2 in unique(tmp[,1])){
      asi[ix,ix2]<-mean(tmp[tmp[,1]==ix2,3])  
    }
  }
  return(asi)
}

# calculamos el valor mediano s(i) para cada metodo con clusters de n  entre 2 y 10
asi1 = calASI(single)
asi2 = calASI(complete)
asi3 = calASI(average)
asi4 = calASI(ward)
asi5 = calASI(ward2)
asi6 = calASI(ward22)

compMeanSi <-function(asi){
  mSi <- 0*seq(0,9,1)
  for (ix in 1:nrow(asi)){
    mSi[ix] <-mean(asi[ix,is.na(asi[ix,])==FALSE])
  }
  return(mSi)
}

mSi1 = compMeanSi(asi1)
mSi2 = compMeanSi(asi2)
mSi3 = compMeanSi(asi3)
mSi4 = compMeanSi(asi4)
mSi5 = compMeanSi(asi5)
mSi6 = compMeanSi(asi6)

# obtenemos el valor maximo mediano s(i)
mx1 <- max(mSi1)# single
mx2 <- max(mSi2)#complete
mx3 <- max(mSi3)#average
mx4 <- max(mSi4)#ward
mx5 <- max(mSi5)#ward^2
mx6 <- max(mSi6)#ward2

plot.new()
par(mfrow=c(2,3))
plot(1:6,round(c(mx1,mx2,mx3,mx4,mx5,mx6)*100)/100,type='o',xlab='',ylab='Max. average s(i)',axes=FALSE)
axis(side=1,at=1:6,labels=c('single','complete','average','ward','ward^2','ward2'),las=2)
axis(side=2,at=c(min(round(c(mx1,mx2,mx3,mx4,mx5,mx6)*100)/100),max(round(c(mx1,mx2,mx3,mx4,mx5,mx6)*1000)/1000)))
box()
image(2:10,1:10,as.matrix(asi2),col=rainbow(255),main='Method=Complete',xlab='k',ylab='Cluster ID',axes=FALSE)
axis(side = 1, at = c(2,10))
axis(side = 2, at = c(1,10))
box()
image(2:10,1:10,as.matrix(asi3),col=rainbow(255),main='Method=Average',xlab='k',ylab='Cluster ID',axes=FALSE)
axis(side = 1, at = c(2,10))
axis(side = 2, at = c(1,10))
box()
image(2:10,1:10,as.matrix(asi4),col=rainbow(255),main='Method=Ward',xlab='k',ylab='Cluster ID',axes=FALSE)
axis(side = 1, at = c(2,10))
axis(side = 2, at = c(1,10))
box()

# Validaci??n externa con la variable # 41
par(mfrow=c(2,3))
(cut <- cutree(complete, k=2:10))
tmp<-silhouette(cut[,9], distancias)
table(cut[,9], ocr[,41])
cm <- as.matrix(table(cut[,9], ocr[,41]))
image(1:10,1:10,cm,axes=FALSE,xlab = 'True cluster id', ylab = 'Assigned cluster id',main='Confusion matrix\nMethod=Complete')
lines(1:10,1:10)
axis(side=1,c(1,10))
axis(side=2,c(1,10))
box()
pct1 = sum(diag(cm))/sum(cm)# calcular el percentaje de clasificaciones correctas

(cut <- cutree(average, k=2:10))
table(cut[,9], ocr[,41])
cm <- as.matrix(table(cut[,9], ocr[,41]))
image(1:10,1:10,cm,axes=FALSE,xlab = 'True cluster id', ylab = 'Assigned cluster id',main='Confusion matrix\nMethod=Average')
lines(1:10,1:10)
axis(side=1,c(1,10))
axis(side=2,c(1,10))
box()
pct2 = sum(diag(cm))/sum(cm)

(cut <- cutree(ward, k=2:10))
table(cut[,9], ocr[,41])
cm <- as.matrix(table(cut[,9], ocr[,41]))
image(1:10,1:10,cm,axes=FALSE,xlab = 'True cluster id', ylab = 'Assigned cluster id',main='Confusion matrix\nMethod=Ward',col = heat.colors(255))
lines(1:10,1:10)
axis(side=1,c(1,10))
axis(side=2,c(1,10))
box()
pct3 = sum(diag(cm))/sum(cm)

# comparar s(i) mediano y percentaje de classifcacion por los metodos complete, ward^2 y ward2
cluDF <-data.frame(c(mx2,mx3,mx4),c(pct1,pct2,pct3),row.names=c('Complete','Average','Ward'))
names(cluDF) <- c('s(i)','%')
cluDF
# los tres metodos tienen un maximo s(i) mediano parecido, aunque el metodo Average tiene
# el s(i) mediano maximo mas alto e un percentaje
# mas alto de clasificaciones corectas (cuando se usa una particion de 10 clusters). 
#Por eso, creo que la mejora particion resulta cuando se usa el metodo Average.

(cut <- cutree(average, k=2:10))

cluLab <- cut[,9]

sIx <- sort(cluLab, index.return=TRUE)$ix
cluLab <- matrix(cluLab,nrow=25)

convertCluLab2Idx<- function(ix){
  ixR <-matrix(0,nrow=nrow(ix),ncol=8)
  ixC <-matrix(0,nrow=nrow(ix),ncol=5)
  for (iter in 1:nrow(ix)){
    ixR[iter,]<-1:8+ix[iter,1]*8-8
    ixC[iter,]<-1:5+ix[iter,2]*5-5
  }
  out <- list( 'indexesRows' =ixR,'indexesColumns' =ixC )
  return(out)  
}

cluID <-sort(unique(cut[,9]))

k=10
par(mfrow=c(ceiling(k/4),4),mai = c(0.1, 0.1, 0.1, 0.1))
for (iter in 1:length(cluID)){
  
  cluIx <- which(cluLab == cluID[iter],arr.ind = TRUE)
  ix2Mat <- convertCluLab2Idx(cluIx)
  
  avg = matrix(0,nrow = 8,ncol = 5)
  for (iter2 in 1:nrow(ix2Mat$indexesRows)){
    avg = avg + datos0[ix2Mat$indexesRows[iter2,],ix2Mat$indexesColumns[iter2,]]
  }
  avg <- avg/nrow(ix2Mat$indexesRows)
  
  image(1:5,1:8,as.matrix(t(avg)),axes=FALSE,xlab = '',ylab = '',col=heat.colors(1e4), main=paste('class',cluID[iter]))
  
}
dev.off() 

