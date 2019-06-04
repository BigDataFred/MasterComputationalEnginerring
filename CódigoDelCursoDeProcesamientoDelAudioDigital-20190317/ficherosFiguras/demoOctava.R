####################################################
###
### Generamos una senal sinusoide compleja (octava)
###
####################################################

require('tuneR')

b = 440
b1 = round(b)
b2 = round(2*b)
sound <- bind(sine(b1, bit=32),
              sine(b2, bit=32),
              sine(b1, bit=32) + sine(b2, bit=32))

sound <- normalize(sound, unit = '32')

play(sound)

writeWave(sound, 'octava.wav')