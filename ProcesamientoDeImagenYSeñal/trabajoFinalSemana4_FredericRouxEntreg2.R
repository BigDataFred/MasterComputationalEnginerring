# use the following libraries
library('imager');
library('mmand');

# clear workspace
rm(list=ls());

# set path and filename for resulting PDF-file
setwd('~/MasterIngeneriaComputacional2018/ProcesamientoDeImagenYSeñal/');
source("grisImagePlot2.R");
graphics.off()
pdf(file='FREDERIC_ROUX_trabajoFinal_Semana4Entreg2.pdf',width=5, heigh=10, paper='a4r')

## Matrix A: 1 = Black, 0 = White
A <- matrix(c(1,1,1,1,1,1,1,1,1,1,1,
              1,1,1,1,1,1,1,1,1,0,0,
              1,1,1,1,1,1,1,1,1,0,0,
              1,1,1,1,1,1,1,1,1,0,0,
              1,1,1,0,0,1,1,1,1,0,0), nrow = 5, ncol = 11, byrow = TRUE)

## Structuring Elements as defined in Figure P9.21
# 1 = D, 0 = W-D, NA = don't care
B1<-matrix(rbind(c(0,0,0),c(NA,1,NA),c(1,1,1)),nrow=3,ncol=3);
B3<-matrix(rbind(c(1,NA,0),c(1,1,0),c(1,NA,0)),nrow=3,ncol=3);
B5<-matrix(rbind(c(1,1,1),c(NA,1,NA),c(0,0,0)),nrow=3,ncol=3);
B7<-matrix(rbind(c(0,NA,1),c(0,1,1),c(0,NA,1)),nrow=3,ncol=3);

B2<-matrix(rbind(c(NA,0,0),c(1,1,0),c(1,1,NA)),nrow=3,ncol=3)
B4<-matrix(rbind(c(1,1,NA),c(1,1,0),c(NA,0,0)),nrow=3,ncol=3)
B6<-matrix(rbind(c(NA,1,1),c(0,1,1),c(0,0,NA)),nrow=3,ncol=3)
B8<-matrix(rbind(c(0,0,NA),c(0,1,1),c(NA,1,1)),nrow=3,ncol=3)


## Complementary Matrix
compMat <- function(X){
  CX <- round(!X);  
  return(CX);
}

# Zero padding of Matrix
# Aqui tuve un problema, porque no tenia claro que para la matriz complementaria
# habia que usar unos en vez de zeros para el padding !
padMat <- function(M,c){
  Pad <- matrix(c, nrow = dim(M)[1]+2, ncol =  dim(M)[2]+2) # matriz de 0s o 1s
  Pad[2:(dim(M)[1]+1),2:(dim(M)[2]+1)] <- M # en la que insertamos M
  return(Pad);
};

## hit-and-miss transform
# A*B = A erode D & A complementaria erode W-D, 
#donde como pone en la diapositiva , 
#D son los pixeles grises de la mascara y W-D los pixeles en blanco.
hnmTransform<-function(M,CM,E){
  tmp1<-E;#D
  tmp2<-1-E;# W-D
  HNM<-erode(M,tmp1)&erode(CM,tmp2); # 
  HNM[HNM==TRUE]<-1;
  HNM[HNM==FALSE]<-0;
  return(HNM);
};

# Thinning
thinMat <- function(X1,X2,HNM){
  X1<-X1-HNM;
  X1<-X1[2:(dim(X2)[1]+1),2:(dim(X2)[2]+1)];# extract thinned element from padded matrix
  return(X1);
}

## Complementary Matrix
CA <- compMat(A)

## Initial Padding of A and CA
PadA<- padMat(A,0);
PadCA<-padMat(CA,1);


## do the image processing by applying hit and miss thinning with different complementery elements
b <- c("B1","B2","B3","B4","B5","B6","B8","B7","B1","B2","B3","B4","B5","B6")#complementary elements
x<-array(0,dim=c(length(b),dim(A)[1],dim(A)[2]));
for (ix in 1:length(b)){
  print(b[ix]);
  HNM<-hnmTransform(PadA,PadCA,eval(parse(text=b[ix])));# hit-and-miss transform
  A<-thinMat(PadA,A,HNM);# thinning
  x[ix,1:dim(A)[1],1:dim(A)[2]]<-A;
  CA<-compMat(A);# complementary matrix
  PadA<-padMat(A,0);# zero-padding
  PadCA<-padMat(CA,1);# ones-padding  
}

# do the graphical representation of the outcome of each image processing step performed above
for (ix in 1:dim(x)[1]){
  grisImagePlot2(x[ix,1:dim(A)[1],1:dim(A)[2]]);
}
##
dev.off() 
