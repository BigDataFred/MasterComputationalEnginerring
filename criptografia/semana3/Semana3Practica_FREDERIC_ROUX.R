
######################################
# Practica Semana 3 Frédéric Roux
######################################


# 2 Cifrado de Vernam
source("flujo/vernam.R")
m <- c(0, 1, 1, 0, 1, 0, 0, 1)
clave1 <- c(1, 1, 1, 1, 0)
c1 <- vernam(m, clave1)
clave2 <- c(1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0)
c2 <- vernam(m, clave2)
print( c2 )
mdec<-vernam(c2, clave2)
print(mdec)

# 3 Registros de desplazamiento (LSFRs)
LFSR <- function(cD,s0,n){
  s <- s0
  L <-length(s0)
  out <- NULL
  out <- rbind(out,s0)
  cIx <- which(cD==1)
  k<-2
  j<-length(s)+1
  while (TRUE){
    tmp<-vector(length=L)
    tmp[1]<- sum(out[k-1,cIx])%%2
    tmp[2:L]<-out[k-1,1:L-1]
    out <- rbind(out,tmp)
    s <- c(s,sum(s[j-cIx])%%2)
    if (all(out[k,] ==s0)){
      return(s[1:n])
    }
    k<-k+1
    j<-j+1
  }
  
}

chck<-c(0,1,1,0,0,1,0,0,0,1,1,1,1,0,1)
c1 <- c(1,0,0,1)
s0<-c(0,1,1,0)
out<-LFSR( c1, s0, length(chck) )
print(out)
print(all(out==chck))

chck <- c(0,0,1,1,1,1,0,1,0,1,1,0,0,1,0)
c2 <- c(1,0,0,1)
s0<-c(0,0,1,1)
out<-LFSR( c2, s0, length(chck) )
print(all(out==chck))

chck <- c(0,0,1,1,0,1,1,1,0,1,0,1,0,0,0,0,1,0,0,1,0,1,1,0,0,1,1,1,1,1,0)
c3 <- c(0,0,1,0,1)
s0<-c(0,0,1,1,0)
out<-LFSR( c3, s0, length(chck) )
print(all(out==chck))

chck <- c(0,0,1,1,0,0,1)
c4 <- c(1,1,1)
s0<-c(0,0,1)
out<-LFSR( c4, s0, length(chck) )
print(all(out==chck))


# Cifrado de Vernam utilizando una secuencia generada por un LFSR

cifvernam <- function(){
  out <-NULL
  return(out)
}
  














