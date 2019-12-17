
decgamalnum <- function(p, x, C)
  # Descifrado ElGamal de un mensaje numérico
  # Entrada: p (primo)
  #          x (clave privada receptor)  
  #          C (mensaje cifrado)
  # Salida: M (equivalente numérico del mensaje en claro)         
  {
    r<-C[1]
    s<-C[2]
    D <- (s*potmod(r,(p-1-x),p))%%p
    return(D)
  }



  
