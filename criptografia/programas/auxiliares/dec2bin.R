source("auxiliares/cambiobase.R")
dec2bin <- function(n, k)
  # Entrada: n (entero no negativo, expresado en base decimal)
  #          k (entero positivo)
  # Salida: representación binaria de n,
  #         longitud del vector de salida: k bits,
  #         bit más significativo a la izquierda.
  {
    # Chequeo
    if(n<0){stop("n debe ser no negativo")}
    if(k<=0){stop("k debe ser positivo")}
    if(2^k<=n){stop("k es menor que el número de bits necesarios")}

    # Código
    nbin <- cambiobase(n, 2)
    l <- length(nbin)
    if(k>l)
      {
        nbin <- c(rep(0, k-l), nbin)
      }
    return(nbin)
  }
