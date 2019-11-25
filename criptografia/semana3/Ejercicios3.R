## Ejercicios Semana4

##################################################
# 1a
##################################################
# C(D) = 1+0*D+1*D^{2}+0*D{3}+1*D{4}
# C(D) = 1+D^{2}+D{4}

LSFR <- function(cD,s){
  ix <- which(cD ==1 )
  L <- length(s)
  out <- rbind(NULL,s)
  k<-2
  while (TRUE){
    tmp<-vector(length = L)
    tmp[1] <- (sum( out[k-1,ix] ))%%2
    tmp[2:L] <- out[k-1,1:(L-1)]
    out <- rbind(out,tmp)
    if (all(out[k,] == out[1,])){
      out <- out[1:k,]
      return(out)  
    }
    k <- k+1
  }  
}

formatLSFR <- function(s){
  tmp<-NULL
  idx = 1:dim(s)[2]
  for (ix in dim(s)[2]:1){tmp<-c(tmp,s[,ix])}
  return(tmp)
}

################
cD <- c(1,0,0,1)
sInit <- c(0,0,1,1)
s <- LSFR(cD,sInit)
p <- dim(s)[1]-1
print(p)
print(s)
print(formatLSFR(s))
#################


cD <- c(1,0,0,1)
sInit <- c(0,1,1,0)
s <- LSFR(cD,sInit)
p <- dim(s)[1]-1
print(s)
print(formatLSFR(s))
print(p)
print(paste("Periodo = 2{^L}-1",p == 2^{length(sInit)}-1))
print(paste("Registro no singular:",length(cD) == length(sInit)))

cD <- c(0,1,0,1)
sInit <- c(1,0,1,0)
s <- LSFR(cD,sInit)
p <- dim(s)[1]-1
print(s)
print(formatLSFR(s))
print(p)
print(paste("Periodo = 2{^L}-1",p == 2^{length(sInit)}-1))
print(paste("Registro no singular:",length(cD) == length(sInit)))

# El polinomio c(D) = 1+ D^{2}+D^{4} no es irreducilbe en Z_{2}
# 1+ D^{2}+D^{4} <=> (1+D+D^{2})^{2} <=> 1+D^{2}+D^{4}

##################################################
#1b
##################################################
# C(D) = 1+1*D+0*D^{2}+1*D{3}
# C(D) = 1+D+D{3}

cD <- c(1,0,1)
sInit <- c(1,1,1)
s <- LSFR(cD,sInit)
p <- dim(s)[1]-1
print(s)
print(formatLSFR(s))
print(p)
print(paste("Periodo = 2{^L}-1",p == 2^{length(sInit)}-1))
print(paste("Registro no singular:",length(cD) == length(sInit)))

# El polinomio c(D) = 1+ D+D^{3} es irreducilbe en Z_{2}
# 1+ D+D^{3} <=> (1+D^{2})(1+D) <=> 1+D+D^{2}+D^{3}

##################################################
# 2a
##################################################

cD1 <- c(1,0,0,1)
sInit1 <- c(0,1,0,1)
s1 <- LSFR(cD1,sInit1)
p1 <- dim(s1)[1]-1

cD2 <- c(0,0,1,1)
sInit2 <- c(1,0,1,0)
s2 <- LSFR(cD2,sInit2)
p2 <- dim(s2)[1]-1

print(formatLSFR(s1)[1:19])
print(formatLSFR(s2)[1:19])

print(formatLSFR(s1)[1:19])
print(formatLSFR(s2)[19:1])

##################################################
# 3a
##################################################
# C(D) = D^{4} + D^{3} +D^{2} +D +1
# C(D) = (1+D)(D^3+D+1)
# C(D) = D^3+D+1+D^4+D^2+D <=> D^4+D^3+D^2+2D+1

# C(D) = D^{4} + D^{3} +D^{2} +D +1
# C(D) = (1+D^2)(D^2+D+1)
#C(D) = (D^2+D+1+D^4+D^3+D^2) <=> D^4+D^3+2D^2+D+1

##################################################
# 3b
##################################################

##################################################
# 3c
##################################################

##################################################
# 3d
##################################################
cD= c(1,1,1,1)
sInit <- rbind(c(0,0,0,1),c(0,0,1,0),c(0,1,0,0),c(1,0,0,0),c(0,0,1,1),c(0,1,1,0),c(1,1,0,0),c(1,0,0,1),c(0,1,0,1),c(1,0,1,0),c(0,1,1,1),c(1,0,1,1),c(1,1,0,1),c(1,1,1,0),c(1,1,1,1))
for (ix in 1:dim(sInit)[1]){
  s<- LSFR(cD,sInit[ix,])
  print(s)
  p<- dim(s)[1]-1
  print(paste(ix,p))
  if (ix==2){
    break
  }
}

##################################################
# 4
##################################################
cD <- c(1,0,0,1)
sInit <- c(0,0,1,1)
s<- LSFR(cD,sInit)
p <- dim(s)[1]-1

print(formatLSFR(s))
print(p)  

