source("aritmod/potmod.R")
clavesdh <- function(p,g, xA, xB)
# Intercambio de claves de Diffie-Hellman
# Entrada: p (número primo),
#          g (generador de Z_p^*),
#          xA (número entre 1 y p-2),
#          xB (número entre 1 y p-2).
# Salida: (yA, yB, K)
#         yA es la información enviada por A,
#         yB la información enviada por B,
#         K es la clave compartida.
#                 
  {
  yA<- potmod(g,xA,p)
  yB<- potmod(g,xB,p)
  K<- potmod(g,xA*xB,p)
  
   return(c(yA,yB,K))
  }
