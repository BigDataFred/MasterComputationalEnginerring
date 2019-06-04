### Ondas aperiodicas: Ruido blanco
### http://www.di.fc.ul.pt/~jpn/r/noise/noise.html

################################################################
### Generar una se?al de ruido blanco, visualizarla, 
### escucharla y obtener su espectrograma
###
################################################################

require(GeneCycle)
require(tuneR)
require(seewave)

set.seed(101)

# numero de muestras
n <- 1000
xs <- seq(-5,5,len=250)

###############################################################
#### Mediante el paquete GeneCycle
###############################################################
### Ruido
norm.xs  <- dnorm(xs,0,2.5)
norm.set <- rnorm(n,0,2.5)

###############################################################
#### Mediante el paquete GeneCycle
###############################################################
harmonics = 1:10000
ruido <- noise(kind = "white", duration=4, xunit="time")
# en Hz
f.data <- GeneCycle::periodogram(norm.set)

###############################################################
#### Grafico Final
###############################################################
X11(); plot.new();
par(mfrow=c(1,2))
plot(xs, norm.xs, type="l", xlab="x", 
		ylab="density", col="red", lwd=2) # pdf
plot(1:n, norm.set, type="l", xlab="t", ylab="f(t)", 
		main="Gaussian White Noise")

###############################################################
#### Grafico Final
###############################################################
X11(); plot.new();
par(mfrow=c(1,2))
plot(1:n, norm.set[1:n] , type="l", xlab="t", ylab="f(t)", 			
		main="Gaussian White Noise")
plot(f.data$freq[harmonics]*length(norm.set), 
     	f.data$spec[harmonics]/sum(f.data$spec), 
     	xlab="Harmonics (Hz)", ylab="Amplitute Density", 
     	type="l", log="xy")

###############################################################
#### Grabamos la senal
###############################################################
# Oimos el audio
savewav(ruido, filename="www/white.wav")