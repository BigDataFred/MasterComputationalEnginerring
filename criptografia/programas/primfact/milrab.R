source("aritmod/potmod.R")
milrab <- function(n,k)
  # Test de primalidad. Algoritmo de Miller-Rabin.
  # Entrada: n número entero impar n>=3,
  #          k  parámetro de seguridad k>=1.
  # Salida: "n es compuesto" o "n es primo con probabilidad mayor que 1-4^{-k}".
  {
    # Chequeos 
    if(n<3){stop("n debe ser >=3")}
    if((n%%2)==0){stop("n debe ser impar")}
    if(k<1){stop("k debe ser>=1")}
    
    # Código
    
  }
