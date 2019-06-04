################################################
###
### Examina un sonido
###
################################################

require(tuneR)


### Crearemos un objeto Wave a partir de un fichero wav
### Visualizaremos la informacion del objeto y lo oiremos
s <- "oboe_A4.wav"
#s <- "piano_A4.wav"
#s <- "welcome.wav"
#s <- "flanger.wav"

sonido <- readWave(path_sonido(s))


### Escuchar el sonido
### Una vez escuchado el sonido, cerrar el player para continuar
### con la ejecucion
play(sonido)

### Informacion general del sonido
print(sonido)

### Valores minimo y maximo
maxL <- max(sonido@left)
minL <- min(sonido@left)
whichMaxL <- which.max(sonido@left)
whichMinL <- which.min(sonido@left)
cat("Left channel range=", maxL-minL, 
	"(max=", maxL, "@", whichMaxL, "; min=",
    minL, "@", whichMinL, ")\n")

### Si es un sonido estereo
if (sonido@stereo) {
	maxR <- max(sonido@right)
	minR <- min(sonido@right)
	whichMaxR <- which.max(sonido@right)
	whichMinR <- which.min(sonido@right)
	cat("Right channel range=", maxR-minR, 
		"(max=", maxR, "@", whichMaxR, "; min=",
		minR, "@", whichMinR, ")\n")
}

### Visualizaremos las primeras 5000 muestras
### Si el sonido es estereo, visualizar ambos canales
nSampPlot <- min(5000, length(sonido@left))
nGraph <- 1
if (sonido@stereo) 
	nSampPlot <- min(nSampPlot, length(sonido@right))
if (sonido@stereo) 
	nGraph <- 2

ventana()
par(mfrow = c(1, nGraph))
plot(sonido@left[1:nSampPlot], main="Left channel", 
	xlab="Time", ylab="Amplitude", type='l')

if (sonido@stereo) 
	plot(sonido@right[1:nSampPlot], main="Right channel", 
		xlab="Time", ylab="Amplitude", type='l')