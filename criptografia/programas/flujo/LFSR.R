
LFSR<- function(c, s0, n)
  # Genera una secuencia de n bits producida por un LFSR 
  # Entrada: c (coeficientes del polinomio de conexión,
  #             C(D)=1+c[1]*D+ ... +c[L]*D^L)
  #          s0 (estado inicial, s0=[s_0, s_1, ..., s_{L-1}]
  #          n (longitud de la secuencia) 
  # Salida: secuencia de n bits
  {
    # Chequeo
    L <- length(c)
    if(length(s0)!=L)
      {
        stop("El polinomio de conexión y el estado inicial
              tienen tamaños distintos")
      }

    # Código
    s <- s0
    cIx <- which(c==1)
    j<-length(s)+1
    while (TRUE){
      s <- c(s,sum(s[j-cIx])%%2)
      if (length(s) ==n){ # all(out[k,] ==s0)
        return(s[1:n])
      }
      j<-j+1
    }
  }

