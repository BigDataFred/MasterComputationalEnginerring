source("auxiliares/men2num.R")
source("auxiliares/num2men.R")
source("aritmod/potmod.R")
decgamal <- function(p, x, alfabeto, cifrado, k)
  #Descifrado ElGamal de un mensaje de texto
  # Entrada: p (primo)
  #          x (clave privada receptor)
  #          cifrado (mensaje de texto cifrado)
  #          k (entero positivo)
  # Salida: mensaje en claro    
  {
    D<-{}
    for (ix in 1:length(cifrado)){
      l <- nchar(cifrado[ix])/2
      r<- men2num( alfabeto, substr(cifrado[ix], 1, l) ,l )
      s<- men2num( alfabeto, substr(cifrado[ix], l+1, 2*l), l )
      tmp <- (s*potmod(r,p-1-x,p))%%p
      D <- c(D,num2men(alfabeto, tmp, k)) 
    }

    return(D)
  }











