# Fenomeno BEATS
# Union de dos ondas seno cuyas frecuencias difieren en una frecuencia (bps)
# Si bps es menor que el rango del alcance auditivo humano (< 10), escuchamos 
# los pulsos de forma individual. Si bsp es mayor (y un divisor de la frecuencia)
# podemos escuchar un tono con una frecuencia de bps Hz (aunque no exista una sinusoide
# explicita). Esto es debido a que "algo" se esta repitiendo en ese rango.
#
# Notese que la union de dos sonidos es la superposicion de ambos, y matematicamente,
# la superposicion es exactamente una "interferencia".
# Los "beats" se producen por la alternacion regular de interferencias constructivas y
# destructivas.

require(tuneR)

### Frecuencia base (en Hz)
freq <- 440
#freq <- 3520
### Sampling rate
sr <- 16000
### Sample depth
sdbits <- 16
### Longitud de cada nota
secs <- 4.0

### Instantes de tiempo donde crearemos las muestras
tV <- seq(0,secs,1/sr)
### Beat rate (en Hz)
bps <- 5.0
#bps <- 10.0

### Onda seno con frecuencia base
loSampV <- sin(2*pi*freq*tV)
### Onda seno con frecuencia mas alta (bps)
hiSampV <- sin(2*pi*(freq+bps)*tV)
### Las dos ondas juntas
bothV <- loSampV+hiSampV
### Silencio
pauseV <- rep(0, 0.5*sr)

### Tono bajo, pausa, Tono mas alto, pausa, ambos tonos juntos
sndV <- c(loSampV, pauseV, hiSampV, pauseV, bothV)
### Crea la estructura de onda
sndW <- Wave(round(2^(sdbits-5)*sndV), samp.rate=sr, bit=sdbits)
### Para Linux: play(sndW, "rhythmbox")
play(sndW)

### Grabamos la senal
writeWave(sndW, "Beats.wav")