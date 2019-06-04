library('imager');
library('mmand');
dev.off();
rm(list=ls());
setwd('~/MasterIngeneriaComputacional2018/ProcesamientoDeImagenYSeñal/');
source("grisImagePlot2.R");


# erosion
A <- matrix(rbind(c(1,1,1,1,0,0,0,0,0,1,1,1,1),+
                  c(1,1,1,1,1,1,1,1,1,1,1,1,1),+
                  c(1,1,1,1,1,1,1,1,1,1,1,1,1),+
                  c(1,1,1,1,1,1,1,1,1,1,1,1,1),+
                  c(1,1,1,1,0,0,0,0,0,1,1,1,1))
                  ,nrow=5,ncol=13);

B <- matrix(rbind(c(0,1,0),+
                    c(1,1,1),+
                    c(0,1,0))
            ,nrow=3,ncol=3);


padA <- matrix(0,nrow=dim(A)[1]+2,ncol=dim(A)[2]+2);
padA[2:(dim(A)[1]+1),2:(dim(A)[2]+1)]<-A;
Aer <- erode(padA,B);
Aer <- Aer[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];

grisImagePlot2(A);
grisImagePlot2(padA);
grisImagePlot2(B);
grisImagePlot2(erode(padA,B));
grisImagePlot2(Aer);


#dilatation
dev.off();
d = 12
A <- matrix(1,nrow=d,ncol=d);
B = matrix(1,nrow=d/4,ncol=d/4);
padA <- matrix(0,nrow=dim(A)[1]+2,ncol=dim(A)[2]+2);
padA[2:(dim(A)[1]+1),2:(dim(A)[2]+1)]<-A;

Adil<-dilate_square(padA,B);
Adil<-Adil[2:(dim(A)[1]+1),2:(dim(A)[2]+1)];
  
grisImagePlot2(A);
grisImagePlot2(B);
grisImagePlot2(Adil);
