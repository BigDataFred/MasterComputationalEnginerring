################################################
###
### Generamos notas famosas
###
################################################

### Generar una señal y oirla a partir de las notas:
###    Middle C=261.626Hz (standard tuning, C4)
###    Concert A (A above middle C)=440Hz
###    Middle C=256Hz(Scientific tuning)
###    La nota más baja de un piano A=27.5Hz
###    La nota más alta de un piano C=4186.009Hz

require(tuneR)

# Middle C = 261.626Hz (standard tuning, C4)
sonido <- sine(261.626, bit = 32)
play(sonido)
writeWave(sonido, 'middleC.wav')

# Concert A (A above middle C) = 440Hz
sonido <- sine(440, bit = 32)
play(sonido)
writeWave(sonido, '440.wav')

# Middle C = 256 Hz (Scientific tuning)
sonido <- sine(256, bit = 32)
play(sonido)
writeWave(sonido, 'middleCst.wav')

# Nota mas baja de un piano A = 27.5Hz
sonido <- sine(27.5, bit = 32)
play(sonido)
writeWave(sonido, 'notaA.wav')

# Nota mas alta de un piano C = 4186.009Hz
sonido <- sine(4186.009, bit = 32)
play(sonido)
writeWave(sonido, 'notaC.wav')