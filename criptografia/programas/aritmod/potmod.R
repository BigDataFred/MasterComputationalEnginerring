source("auxiliares/cambiobase.R")

potmod <- function(a,x,n)
  # Entrada: a (entero)
  #          x (entero no negativo)
  #          n (entero mayor que 1)
  # Salida:  z=a^x (mod n) (entero)
  {
    # Chequeos
    # No se necesita comprobar que x es no negativo, ya que al calcular
    # cambiobase(x, 2) ya se efectúa el chequeo
    if(n<=1){stop("n debe ser mayor que 1")}

    #Código
 
  }
