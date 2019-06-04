library(cluster)
rm(list=ls())
graphics.off()

#pdf(file='FR??D??RIC_ROUX_Ejercicio3-1_ead_md-v.pdf',width=5, heigh=10, paper='a4r')

load('~/Downloads/ocr.Rdata')

datos0 <- ocr[,1:40]

# Determine number of clusters
wss <- (nrow(datos0)-1)*sum(apply(datos0,2,var))
ib <- matrix(0,nrow=40,ncol=1)
for (i in 2:40) {
  km <- kmeans(datos0, centers=i)
  wss[i] <- sum(kmeans(datos0, centers=i)$withinss)
  ib[i]<-km$betweenss/km$totss
}

image(1:ncol(datos0),1:nrow(datos0),as.matrix(t(datos0)),xlab='Number of variables', ylab='Number of objects',main='Raw data')

par( mfcol=c(2,2) )
plot(1:40, wss, type="b", xlab="Numero de clases", ylab="Within groups sum of squares")
lines(c(20,20),c(min(wss),max(wss)),col="green")
lines(c(0,40),c(wss[20],wss[20]),col="green")
plot(1:40, ib, type="b", xlab="Numero de clases", ylab="??ndice de bondad")
lines(c(20,20),c(min(ib),max(ib)),col="green")
lines(c(0,40),c(ib[20],ib[20]),col="green")

# K-Means Clustering
set.seed(2011)
k<-20
fit <- kmeans(datos0, k)

fit$cluster
cluLab <- fit$cluster

sIx <- sort(fit$cluster, index.return=TRUE)$ix
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

cluID <-sort(unique(fit$cluster))

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
#dev.off() 
