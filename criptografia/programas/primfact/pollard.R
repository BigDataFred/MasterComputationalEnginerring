source("auxiliares/evalpol.R")
source("aritmod/euclides.R")
pollard  <- function(n, p, x0, N)
  # Implementa el método rho de Pollard.
  # Devuelve dos factores f1, f2 de n, de forma que n=f1*f2.
  # Entrada: n entero positivo impar
  #          p (vector de coeficientes de un  polinomio sobre Z_n
  #             p[1]*x^g+p[2]*x^{g-1}+ ....+p[g]*x+p[g+1]) 
  #          x_0 (entero) semilla
  #          N (entero) número máximo de pasos
  # Salida: (f1, f2) (vector de enteros: f1, f2 factores de n)
  {
  # Chequeo
  if ((n%%2==0)|(n<3)){stop("n debe ser un entero impar mayor que 2")}
  
  # Código
  factores <- "No se ha encontrado factorizacion"
  b<-x0
  contador<-0
  factoresencontrados<-FALSE
  
  while ( (contador < N) && (factoresencontrados==FALSE) ){
    
    a<-1
    v<-evalpol(p,x0)
    chck<-vector(length=2)
    while (TRUE){
      chck[1]<-((a-v)%%n)==0
      chck[2]<- (a%%n == v%%n)
      if (all(chck==TRUE)){
        break
      }
      a<-a+1
    }
    b<-c(b,a)
    j<-1
    while ((j<length(b)) && (factoresencontrados==FALSE)){
      d<- euclides(abs(a-b[j]),n)
      if ((d>1) && (d<n)){
        factores<-c(d,n/d)
        factoresencontrados<-TRUE
      }
      j<-j+1
    }
    if (factoresencontrados==FALSE){
      x0<-a
      contador<-contador+1
    }
  }
  return(factores)
}
