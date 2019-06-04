#############################################################
###
### Sinewave plot
###
#############################################################

A = 0.8
f0 = 1000
phi = pi/2
fs  = 44100
t = seq(from=-0.002, to=0.002, by=1.0/fs)

# x[n] = A * cos(w*n*T+phi) = A * cos(2*pi*f*n*T + phi)
# A = amplitud
# w = frecuencia angular (en radianes)
# f = w/2*pi = frecuencia (en Hz)
# phi = fase inicial (en radianes)
# n = indice de tiempo
# T = 1 /fs = periodo de muestreo (en segundos) donde t = nT = n/fs

x = A * cos(2*pi*f0*t+phi)

### Plot
X11(); plot.new();
plot(t, x, xlab="Time", ylab="Amplitude", type='l')