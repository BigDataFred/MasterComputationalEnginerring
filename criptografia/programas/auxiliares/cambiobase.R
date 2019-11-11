cambiobase <- function(x,b)
  # Entrada: x (entero no negativo)
  #          b (entero mayor o igual que 2)
  # Salida:  vector de enteros que representan los
  #          dígitos de x en la base b
  {
    # Chequeos
    if(x<0){stop("x debe ser no negativo")}
    if(b<2){stop("b debe ser mayor que 1")}
 
    # Código
    if(x==0){base.b <- 0}
    else
      {
        ndigits <- floor(logb(x, base=b))+1
        base.b <- rep(0,ndigits)
        for(i in 1:ndigits)
          {
             base.b[ndigits-i+1] <- x%%b
             x <- x%/%b
          }
      }
    return(base.b)
  }
