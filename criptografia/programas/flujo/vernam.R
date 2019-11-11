
vernam <- function(menbits, clave)
  # Entrada: menbits (vector de bits
  #                    que representa el mensaje en claro)                   
  #          clave (vector de bits)
  # Salida:  vector de bits 
  #          que representa el mensaje cifrado.
  # La longitud clave debe ser mayor o igual que la de menbits.
  {
     #Chequeo
    if(length(clave)<length(menbits))
      {
        stop("La longitud de la clave es menor que la del mensaje")
      }

    #Codigo
  
  }
