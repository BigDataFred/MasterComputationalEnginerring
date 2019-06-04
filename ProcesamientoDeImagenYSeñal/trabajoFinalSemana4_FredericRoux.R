library('imager');
library('mmand');

dev.off();
rm(list=ls());

setwd('~/MasterIngeneriaComputacional2018/ProcesamientoDeImagenYSeñal/');
source("grisImagePlot2.R");
graphics.off()
pdf(file='FREDERIC_ROUX_trabajoFinal_Semana4.pdf',width=5, heigh=10, paper='a4r')

## Matrix A
A <- matrix(c(1,1,1,1,1,1,1,1,1,1,1,
              1,1,1,1,1,1,1,1,1,0,0,
              1,1,1,1,1,1,1,1,1,0,0,
              1,1,1,1,1,1,1,1,1,0,0,
              1,1,1,0,0,1,1,1,1,0,0), nrow = 5, ncol = 11, byrow = TRUE)

## Complementary Matrix of A
CA <- round(!A);

## Padding of Matrices
# Aqui tuve un problema, porque no tenia claro que para la matriz complementaria
# habia que usar unos en vez de zeros para el padding !
padM <- function(M,c){
  Pad <- matrix(c, nrow = dim(M)[1]+2, ncol =  dim(M)[2]+2) # matriz de 0s o 1s
  Pad[2:(dim(M)[1]+1),2:(dim(M)[2]+1)] <- M # en la que insertamos M
  return(Pad);
};

## Initial Padding of A and CA
PadA<- padM(A,0);
PadCA<-padM(CA,1);

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

## A1
HNM<-hnmTransform(PadA,PadCA,B1);# hit-and-miss transform
A1<-PadA-HNM;# thinning
A1<-A1[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];# extract thinned element from padded matrix
grisImagePlot2(A1);

CA1<-round(!A1);# complementary matrix
PadA1<-padM(A1,0);# zero-padding
PadCA1<-padM(CA1,1);# ones-padding

## A2, same as above with structuring element B2
HNM<-hnmTransform(PadA1,PadCA1,B2);
A2<-PadA1-HNM;
A2<-A2[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
CA2<-round(!A2);

grisImagePlot2(A2);

PadA2<-padM(A2,0);
PadCA2<-padM(CA2,1);

## A3, same as above with structuring element B3
HNM<-hnmTransform(PadA2,PadCA2,B3);
A3<-PadA2-HNM;
A3<-A3[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
CA3<-round(!A3);

grisImagePlot2(A3);

PadA3<-padM(A3,0);
PadCA3<-padM(CA3,1);

## A4, same as above with structuring element B4
HNM<-hnmTransform(PadA3,PadCA3,B4);
A4<-PadA3-HNM;
A4<-A4[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
CA4<-round(!A4);

grisImagePlot2(A4);

PadA4<-padM(A4,0);
PadCA4<-padM(CA4,1);

## A5, same as above with structuring element B5
HNM<-hnmTransform(PadA4,PadCA4,B5);
A5<-PadA4-HNM;
A5<-A5[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
CA5<-round(!A5);

grisImagePlot2(A5);

PadA5<-padM(A5,0);
PadCA5<-padM(CA5,1);

## A6, same as above with structuring element B6
HNM<-hnmTransform(PadA5,PadCA5,B6);
A6<-PadA5-HNM;
A6<-A6[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
CA6<-round(!A6);

grisImagePlot2(A6);


PadA6<-padM(A6,0);
PadCA6<-padM(CA6,1);

## A8, first we apply hit-and-miss and thinning based on B8, and then we sub-
#sequently apply hit-and-miss and thinning for B7 to image A6
HNM<-hnmTransform(PadA6,PadCA6,B8);

A8<-PadA6-HNM;
A8<-A8[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];

CA8<-round(!A8);
PadA8<-padM(A8,0);
PadCA8<-padM(CA8,1);

HNM<-hnmTransform(PadA8,PadCA8,B7);

A8<-PadA8-HNM;
A8<-A8[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];

grisImagePlot2(A8);

CA8<-round(!A8);
PadA8<-padM(A8,0);
PadCA8<-padM(CA8,1);

## A8,4, sequence of hit-and-miss and thinning operations using B1-B4
HNM<-hnmTransform(PadA8,PadCA8,B1);
A84<-PadA8-HNM;
A84C = round(!A84);

HNM<-hnmTransform(A84,A84C,B2);
A84<-v-HNM;
A84C = round(!A84);

HNM<-hnmTransform(A84,A84C,B3);
A84<-v-HNM;
A84C = round(!A84);

HNM<-hnmTransform(A84,A84C,B4);
A84<-v-HNM;

A84<-A84[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
A84C = round(!A84);

grisImagePlot2(A84);

PadA84<-padM(A84,0);
PadCA84<-padM(CA84,1);

## A,5 hit-and-miss using B5 again
HNM<-hnmTransform(PadA84,PadCA84,B5);

A85<-PadA84-HNM;
A85<-A85[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
CA85<-round(!A85);

grisImagePlot2(A85);

PadA85<-padM(A85,0);
PadCA85<-padM(CA85,1);

## A,6, hit-and-miss using B6 again and FINAL RESULT !!!
HNM<-hnmTransform(PadA85,PadCA85,B6);

A86<-PadA85-HNM;
A86<-A86[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
CA86<-round(!A86);

grisImagePlot2(A86);

PadA86<-padM(A86,0);
PadCA86<-padM(CA86,1);

##
dev.off() 
