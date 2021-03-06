##############################################
###
### Glissando
###
##############################################

require(tuneR)

### Frecuencia inicial (Hz) = 880 
fStart <- 880

# Frecuencia final = 2*frecuencia inicial (una octava m�s alta)
fEnd <- 2*fStart

# sampling rate, sample depth (16), amplitud (1/2^4 del maximo)
sr <- 10000
sdbits <- 16
ampl <- 2^(sdbits-3)

# nota inicial (1 segundo), 
# a�adir rampa cada 5 segundos, 
# nota final (2 segundos)
fV <- rep(fStart,1*sr)
fV <- c(fV,seq(fStart,fEnd,length=5*sr))
fV <- c(fV,rep(fEnd,2*sr))

# Visualizar la se�al
ventana()
plot(fV, xlab="Tiempo", ylab="Frecuencia", main="Glissando")

# Generar el glissando
sampleV <- sin(2*pi*cumsum(fV/sr))
plSampleV <- ampl*sampleV 
glissW <- Wave(plSampleV, samp.rate=sr, bit=sdbits)

# Escuchar la se�al generada
play(glissW)

# Normalizamos la senal (redondeamos a numeros enteros) 
# para ser exportada mediante writeWave()
glissN <- normalize(glissW, unit="16")
writeWave(glissN, 'glissando.wav')