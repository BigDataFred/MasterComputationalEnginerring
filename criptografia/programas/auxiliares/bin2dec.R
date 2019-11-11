source("auxiliares/evalpol.R")

bin2dec <- function(nbin)
  # Entrada: nbin (vector de bits que representa un entero n en forma binaria)     
  # Salida : valor del entero n en base decimal
{
  # Código
  n=evalpol(nbin,2)
  return(n)
}
