
source("aritmod/euclides.R")
fx <- function(x){
  out <- x^2+x+1
}

n<-3421
X0 <- 2
X<- vector()
X[1] <- fx(X0)
cnt<-1
for (ix in 2:10){
  X[ix] <- fx(X[ix-1]) %% n
  for (k in (ix-1):1){
   mcd<-euclides(abs(X[ix]-X[k]),n)
   if (mcd !=1 && mcd !=n){
     print(c(cnt,mcd,n/mcd))
   }
  }
  cnt<-cnt+1
}


n<-1007
x0<-sqrt(n)
t <- round(x0)

f = TRUE
while(f==TRUE){
  chck <- t^2-n  
  if (chck%%sqrt(chck) ==0){
    s<-sqrt(chck)
    break
  } else {
    t<-t+1
  }
}
print(c(t,s))