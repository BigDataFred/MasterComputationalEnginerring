source("aritmod/euclides.R")
source("aritmod/potmod.R")
source("aritmod/invmod.R")
clavesRSA <- function(p,q)
  # Generación de claves en RSA
  # Entrada: p, q (numeros primos)
  # Salida: claves= lista(privada, publica))
  #                 privada=(p, q, d)
  #                 publica=(n, e)
  {
    n<-p*q
    eul<-n+1-(p+q)
    e<-ceiling(runif(1,max(p,q),eul))
    if (e%%2 ==0){
      e<-e+1
    }
    while (TRUE){
      if ( (euclides(e,p-1)==1) && (euclides(e,q-1)==1)){
        break
      }
      e<-e+2
    }
    d<-invmod(e,eul)
    publica <- c(n, e)
    privada <- c(p, q, d)
    claves <- list(privada=privada, publica= publica)
    return(claves)
  }
