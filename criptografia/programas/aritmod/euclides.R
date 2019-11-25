euclides <- function(a,b)
  # Entrada: a, b (enteros no negativos)
  # Salida: d=mcd(a, b)
  {
    #Chequeos
    if(a<0){stop("a  debe ser no negativo")}
    if(b<0){stop("b  debe ser no negativo")}
    
    #Código
    while(b!=0){
      tmp<-a
      r <- a %% b
      a<-b
      b<-r
      }
      return(a)
  }
