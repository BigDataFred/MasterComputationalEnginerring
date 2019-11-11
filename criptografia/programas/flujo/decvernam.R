source("flujo/LFSR.R")
source("flujo/vernam.R")
source("auxiliares/bit2men.R")
decvernam <- function(alfabeto, cifbits, k, c, s0)
  # Entrada: alfabeto
  #          cifbits (vector de bits que representa el mensaje cifrado)
  #          k (número entero, k>0)
  #          c (coeficientes del polinomio de conexión,
  #             C(D)=1+c[1]*D+ \dots +c[L]*D^L)
  #          s0 (estado inicial, s0=[s_0, s_1, ..., s_{L-1}]
  # Salida: mensaje en claro

  {

  }
