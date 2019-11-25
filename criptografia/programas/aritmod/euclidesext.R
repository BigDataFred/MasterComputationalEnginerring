euclidesext <- function(a,b)
  # Entrada: a, b (enteros no negativos)
  # Salida: (d, u, v) (vector de enteros)
  #         d=mcd(a, b),
  #         u, v son enteros tales que d=ua+vb.
  {
    #Chequeos
    if(a<0){stop("a  debe ser no negativo")}
    if(b<0){stop("b  debe ser no negativo")}

    #Código
    t <- 1
    s <- 0 
    g <- 0
    h <- 1
    
    while(b>0){
      q <-a%/%b
      r<- a-q*b
      u<-t-q*s
      v<-g-q*h
      
      a<-b
      b<-r
      t<-s
      s<-u
      g<-h
      h<-v
    }
  atg<-c(a,t,g)  
  return(atg)
  }
