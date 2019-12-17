source("aritmod/potmod.R")
cifRSAnum <- function(n, e, M)
  # Entrada: n, e (clave pública RSA)
  #          M (equivalente numérico del mensaje en claro)
  # Salida:  C (equivalente numérico del mensaje cifrado)         
  {
    C <-potmod(M,e,n)
    
    return(C)
  }
