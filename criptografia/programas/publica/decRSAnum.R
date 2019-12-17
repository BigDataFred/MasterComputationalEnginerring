source("aritmod/potmod.R")
decRSAnum <-  function(p, q, d, C)
  # Entrada: p, q, d (clave privada RSA)
  #          C (equivalente numérico del mensaje cifrado)
  # Salida: M (equivalente numérico del mensaje en claro)   
  {
    n <- p*q
    M <-potmod(C,d,n)
    return(M)
  }
