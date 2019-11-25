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
    xbin <- cambiobase(x,2)# representacion binaria de x
    z<-1# z0 
    for (ix in 1:length(xbin)){
      z<-z^{2}%%n
      if (xbin[ix]==1){
        z<-(z*a)%%n
      }
    }
    return(z)
  }
