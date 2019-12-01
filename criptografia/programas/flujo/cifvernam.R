source("auxiliares/men2bit.R")
source("flujo/LFSR.R")
source("flujo/vernam.R")
cifvernam <- function(alfabeto, mensaje, k, c, s0)
  # Entrada: alfabeto
  #           mensaje 
  #           k (número entero, k>0)
  #          c (coeficientes del polinomio de conexión,
  #             C(D)=1+c[1]*D+ \dots +c[L]*D^L)
  #          s0 (estado inicial, s0=(s_0, s_1, ..., s_{L-1})
  # Salida: vector de bits que representa el mensaje cifrado

  {
  b <- men2bit(alfabeto,mensaje,k)
  nb <- length(b)
  clave<-LFSR(c,s0,nb)
  C <- vernam(b, clave)
  return(C)
  }
