
##################################################
#Ejercicio de evaluaci??n 11.1
##################################################
rm(list=ls())
graphics.off()
setwd('/Users/froux/MasterIngeneriaComputacional2018/EAD-MD-v')
pdf(file='FREDERIC_ROUX_Ej11-1_ead_md-v.pdf',width=5, heigh=10, paper='a4r')
par( mfrow=c(1,2) )

#El fichero de datos pint.txt contiene los conocidos datos sobre las valoraciones que ciertos expertos 
#han hecho sobre las obras de pintores de reconocido prestigio(*). 
#(*) Las columas del fichero se corresponden con las variables:
#1- Nombre del autor; 
#2- Nombre abreviado del autor; 
#3- Escuela a la que pertenece el autor (1: RENACIMIENTO, 2: MANIERISMO, 3: SEISCIENTOS, 4: VENECIANA, 5: LOMBARDA, 6: SIGLO XVI, 7: SIGLO XVII, 8: FRANCESA); 
# Valoraci??n en
#4- Composici??n; 
#5- Dibujo; 
#6- Color; 
#7- Expresi??n
data <- read.delim('/Users/froux/Downloads/Datos-20190121/pint.txt',header=F,sep='')
colnames(data) <- c('Nombre','Abr','Escuela','Composicion','Dibujo','Color','Expresion')

#Realizar un ACP sobre las variables cuantitativas. 
#Decidir si realizar sobre la matriz de correlaciones o covarianzas el an??lisis.
x<-data[,4:7]
for (ix in 1:ncol(x)){
  print( max(x[,ix])-min(x[,ix]) )
} 
for (ix in 1:ncol(x)){
  print( sd(x[,ix]) )
} 
cor(x,x)

out <- princomp(x,cor = F)

#Obtener la descomposici??n de la variabilidad por componentes en t??rminos de porcentaje.
summary(out)

#Interpretar las dos primeras componentes.
cor(x,out$scores)

#Representar los autores seg??n los valores de las dos primeras componentes.
pId <- data$Abr
n<-nrow(data)
plot(c(min(out$scores[,1]),max(out$scores[,1])), c(min(out$scores[,2]),max(out$scores[,2])), type = "n",xlab = '1st Principal Comp.',ylab = '2nd Principal Comp.')  # setting up coord. system
points(out$scores[,1],out$scores[,2],col = "white")
for (ix in 1:n){
  print(pId[ix])
  text(out$scores[ix,1],out$scores[ix,2],pId[ix],cex = .55)
}

#Representar los autores seg??n los valores de las dos primeras componentes mostrando 
#la escuela a la que pertenecen.
sId <-unique(data$Escuela)
n <- length(sId)
cl <- colors(distinct = TRUE)
set.seed(15887) # to set random generator seed
C <- sample(cl, n)
plot(c(min(out$scores[,1]),max(out$scores[,1])), c(min(out$scores[,2]),max(out$scores[,2])), type = "n",xlab = '1st Principal Comp.',ylab = '2nd Principal Comp.')  # setting up coord. system
for (ix in 1:n){
  idx<-which(data$Escuela==sId[ix])  
  for (ix2 in 1:length(idx)){
    text(out$scores[idx[ix2],1],out$scores[idx[ix2],2],pId[idx[ix2]],cex = .55,col=C[ix])
  }
}



dev.off() 


