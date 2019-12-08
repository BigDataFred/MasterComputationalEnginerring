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
    s <- 0
    t <- n-1
    while(t%%2==0)
    {
      s <- s+1
      t <- t/2
    }
    
    fin <- FALSE
    contador<-0
    
    while( (contador < k) && (fin == FALSE) ){
      a <- sample(2:(n-2), 1)
      y<-potmod(a,t,n)
      if ((y != 1) && (y!= n-1)){
        j<-1
        while( (j<s) && (y!=n-1) && (fin==FALSE)){
          y <- potmod(y,2,n)
          if (y==1){
            fin<-TRUE
          }
          j<-j+1
        }
        if (y!=n-1){
          fin<-TRUE
        }
      }
      contador<-contador+1
    }
    
    if (fin == TRUE){
      return(sprintf("%d es compuesto",n))
    }
    else{
      return(sprintf("%d es primo con probabilidad mayor que 1-4^{-%d}",n,k))
    }
  }
