source("aritmod/euclidesext.R")

invmod <- function(a,n)
  # Entrada: a, n (enteros positivos, relativamente primos)       
  # Salida:  a^{-1} (mod n) 
  {
    #Chequeos
    if(a<=0|n<=0){stop("a,n deben ser positivos")}
    x<-euclidesext(a,n)
    if(x[1]!=1){stop("los números no son primos relativos")}

    #Código
    inv <- x[2] # u
    inv <- inv%%n # mod(n)
   return(inv)
  }
