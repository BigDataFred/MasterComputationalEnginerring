evalpol <- function(pol, a)
  # Evalua el polinomio pol en a
  # Entrada: pol (vector de coeficientes del polinomio)
  #          pol=pol[1]*x^g+pol[2]*x^{g-1}+ ....+pol[g]*x+pol[g+1]         
  # Salida : valor del polinomio en a,
  #          val=pol[1]*a^g+pol[2]*a^{g-1}+ ....+pol[g]*a+pol[g+1] 
  {
    #Código
    grado <- length(pol)-1
    exp <- c(grado:0)
    pot <- a^exp
    val <- sum(pol*pot)
    return(val)
  }
  

  
