#############################################################
###
### Generamos el sonido más grave de una guitarra 
### que corresponde a una frecuencia de 82.4Hz y 
### el más agudo a 698.5Hz
###
#############################################################

require(tuneR)

sonido <- sine(82.4, bit = 32)
play(sonido)
writeWave(sonido, 'guitarraLow.wav')

sonido <- sine(698.5, bit = 32)
play(sonido)
writeWave(sonido, 'guitarraHigh.wav')