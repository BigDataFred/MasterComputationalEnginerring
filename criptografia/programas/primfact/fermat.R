fermat <- function(n, N)
  # Implementa el método de factorización de Fermat.
  # Devuelve dos factores f1, f2 de n, de forma que n=f1*f2.
  # Entrada: n entero positivo impar
  #          N número máximo de pasos
  # Salida:  (f1, f2) (vector de enteros: f1, f2 factores de n)
  #
  {
    # Chequeo
    if ((n%%2==0)|(n<=0)){stop("n debe ser un entero positivo impar")}

    # Código
    t<-ceiling( sqrt(n) )
    s <- sqrt(t^{2}-n)
    contador<-0
    while ( (contador < N) && (s != as.integer(s)) ){
      t<-t+1
      s<-sqrt(t^{2}-n)
      contador<-contador+1
    }
    if ( (contador<N) && ((t-s)!=1)){
      factores<-c(t+s,t-s)      
    } else {
      factores<-"No se ha encontrado la factorizacion"
    }
    return(factores)
  }

  
  
  
