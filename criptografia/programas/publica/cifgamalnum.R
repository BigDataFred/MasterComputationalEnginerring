
cifgamalnum <- function(p, g, y, M)
  #Cifrado ElGamal de un mensaje numérico
  # Entrada: p (primo)
  #          g (generador de ZZ_p^*)
  #          y (clave pública del receptor)    
  #          M (equivalente numérico del mensaje en claro)
  # Salida: C=(r, s) (mensaje numérico cifrado)         
  {
    b <- sample(2:(p-2), 1)
    r <- potmod(g,b,p)
    s <- M*potmod(y,b,p)
    return(c(r,s))
  }
