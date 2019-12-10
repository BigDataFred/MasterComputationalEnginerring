setwd("/Users/froux/MasterIngeneriaComputacional2018/criptografia/programas/")

source("aritmod/potmod.R")
source("aritmod/euclides.R")
source("aritmod/euclidesext.R")
source("aritmod/invmod.R")
source("primfact/milrab.R")
source("primfact/pollard.R")
source("primfact/fermat.R")

# Question 3
congr <- function(a,b,n){
    chck<-vector(length=2)
    chck[1]<-((a-b)%%n)==0
    chck[2]<- (a%%n == b%%n)
  return(all(chck==TRUE))  
}

isGenerator <- function(x,n){
  chck2<-vector(length=length(x))
  for (ix in 1:length(x)){
    c <- vector(length=n)
    for (ix2 in 0:(n-1)){
      c[ix2]<-potmod(x[ix],ix2,n)
    }
    chck2[ix] <- sum( diff(sort(c)) ) == (n-1)  
  }
  return(all(chck2))
}

x1 <- c( 3, 5, 6, 7, 10, 11, 12, 14)
x2 <- c(2, 3, 10, 13, 14, 15)
x3 <- c(5, 7, 10, 11, 14, 15, 17, 19, 20, 21)

out<-isGenerator(x1 ,23)
print(paste("x1",out,sep=" "))
out<-isGenerator(x2 ,23)
print(paste("x2",out,sep=" "))
out<-isGenerator(x3 ,23)
print(paste("x3",out,sep=" "))

# log5 2 mód 23
z <- potmod(5,2,23)
print(paste("log5 2 mód 23:",5^{z}%%23,sep=" "))

# Question 4
#log3 11 = 7 mód 17
p<-17
g<-3
ya<-5
yb<-11
xb <- potmod(g,yb,p)
xa <- potmod(g,ya,p)
k<-potmod(g,xa*xb,p)
print(paste("K:",k,sep=" "))

# Question 5
p <- 3413
g <- 2
x <- 1051
y <- potmod(g,x,p)
k <-c(p,g,y)
print(paste("k:",k,sep=" "))

# Question 6
M <- 2015
b<-21
r <- potmod(g,b,p)
s <-M*potmod(y,b,p)
C<-c(r,s)
print(paste("C:",C,sep=" "))

# Question 7
p <- 83
g <- 6
y <- 34
r<-20
s<-7

M<-matrix(nrow=p-1,ncol=2)
for (ix in 1:(p-1)){
  M[ix,]<- c(ix,s*potmod(r,p-ix-1,p)  )
}

print(M[order(M[,2]),])

# Question 8
p<-11
q<-13
d<-7
n<-p*q
eul<-(p-1)*(q-1)
cnt<-0
selIx<-vector()
for (ix in 2:eul-1){
  if (euclides(ix,eul)==1 && invmod(ix,eul)==d){
    cnt<-cnt+1
    selIx[cnt]<-ix
  }
}
k<-c(n,selIx)
print(paste("K:",k,sep=" "))

# Question 9
n<-247
e<-211
eul<-216

#pq=247
#p+q = 32
#q = 32-p
#p(32-p) = 247
#-p^2 + 32p = 247
#-p^2 + 32p -247 =0
#p^2 - 32p +247 =0
#(p-19)(p-13)=0
f <- fermat(n,100)
p=f[1]
q=f[2]
d<-invmod(e,eul)

print(c(p,q,d))

# Question 10
n<-77
ea<-7
eb<-13
k1 <- c(n,ea)
k2 <- c(n,eb)
Ca<-48
Cb<-69
out<-euclidesext(ea,eb)
u<-out[2]
v<-out[3]
u*ea+v*eb ==1
M1 <- potmod(Ca,u,n)
M2 <- potmod(Cb,abs(v),n)
print(M1)
print(M2)