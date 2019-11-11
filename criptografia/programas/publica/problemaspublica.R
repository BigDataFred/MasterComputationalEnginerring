print("Problema 1")
#Tratar de romper el cifrado RSA cuya clave pública es (n,e)=(48959, 6529)
#factorizando n ``por fuerza bruta'' (dividiendo n por 3, 5, 7, ...). 
#Descifrar a continuación el mensaje ``CHUBBBVDCEMOBUFMBKYB''.
#Se ha utilizado el alfabeto LETTERS, el texto en claro ha sido  partido en
#3-gramas y el texto cifrado en 4-gramas. 
n <- 48959
e <- 6529
#Factorizamos n por fuerza bruta
p <- 3
while(n%%p!=0){p <- p+2}
q <- n/p
cat("(p,q)=",c(p,q), "\n")
#Obtenemos d
source("aritmod/invmod.R")
eul <- n-(p+q)+1
d <- invmod(e, eul)
cat("d=",d, "\n")
#Desciframos
source("publica/decRSAch.R")
descifrado <- decRSAch(p, q, d, LETTERS, "CHUBBBVDCEMOBUFMBKYB", 3, 4)
cat("El descifrado es:", descifrado, "\n")

print("Problema 2")
#Tratar de romper el cifrado cuya clave pública es (n,e)=(536813567, 3602561)
#factorizando n ``por fuerza bruta'' (dividiendo n por 3, 5, 7, ...). 
#Descifrar a continuación el mensaje "axyfiudbkwngupbfpnazyahrchcf"
#Se ha utilizado el alfabeto letters, el texto en claro ha sido  partido en
#6-gramas y el texto cifrado en 7-gramas. 
#Realizar el descifrado utilizando y sin utilizar el Teorema chino del resto.




print("Problema 3")
#Las claves públicas RSA de los usuarios A, B son:
#(n, e_A)=(817, 19), (n, e_B)=(817, 29). 
#El cifrado del mensaje M es: C_A=191$, C_B=362.
#Obtener M por un ataque de módulo común.





print("Problema 4")
#La clave pública RSA de un usuario es (n, e)=(46927, 39423).
#El cifrado del mensaje M es C=20736. Obtener por un ataque cíclico.


