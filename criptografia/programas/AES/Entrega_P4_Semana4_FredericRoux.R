####################################
source("AES/KeyExpansion.R")       #
source("AES/cifAES.R")             #
source("AES/decAES.R")             #
####################################
#
# Entrega Practica 4, Semana 4, 
# Dec 2019, F.Roux

#2.1. Expansion de Clave
####################################

# 1. claveinicial1
claveinicial1 <-c("00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "0a", "0b", "0c", "0d", "0e", "0f")
claveinicial1<-as.hexmode( claveinicial1 )

# 2. claveinicial2
claveinicial2 <-c("2b", "7e", "15", "16", "28", "ae", "d2", "a6", "ab", "f7", "15", "88", "09", "cf", "4f", "3c")
claveinicial2<-as.hexmode( claveinicial2 )

# Solucion:
#1. claveexpandida1:
claveexpandida1<-KeyExpansion(claveinicial1)

#2. claveexpandida2:
claveexpandida2<-KeyExpansion(claveinicial2)

print("Claves expandidas:")
print("claveexpandida1:")
print(claveexpandida1)
print("claveexpandida2:")
print(claveexpandida2)

#2.2. Cifrado
####################################
mensaje1 <- as.hexmode(c("00", "11", "22", "33", "44", "55", "66", "77","88", "99", "aa", "bb", "cc", "dd", "ee", "ff"))
mensaje2 <- as.hexmode(c("32", "43", "f6", "a8", "88", "5a", "30", "8d","31", "31", "98", "a2", "e0", "37", "07", "34"))

men2cif1<-cifAES(mensaje1,claveinicial1)
men2cif2<-cifAES(mensaje2,claveinicial2)

print("Mensajes cifrados:")
print("cifrado1:")
print(men2cif1)
print("cifrado2:")
print(men2cif2)
  
#2.3. Descifrado
####################################
cif2men1 <- decAES(men2cif1, claveinicial1)
cif2men2 <- decAES(men2cif2, claveinicial2)
  
print("Mensajes de-cifrados:")
print("mensaje1:")
print(mensaje1)
print("decifrado1:")
print(cif2men1)
print(all(cif2men1 == mensaje1))
print("mensaje2:")
print(mensaje2)
print("decifrado2:")
print(cif2men2)
print(all(cif2men2 == mensaje2))
  
  
  