#############################################################
###
### Complex sinewave
###
#############################################################

require(ggplot2)
require(reshape)

N = 500
k = 3
t = seq(-N/2, N/2, by=1)

### Funcion exponencial
tt = complex(imaginary = t)
s = exp(2*pi*k/N*tt)

df <- melt(data.frame(x = t, real = Re(s), imaginary = Im(s)), id = "x")

### Plot
X11(); plot.new();
ggplot(df, aes(x = x, y=value, color=variable)) +
	geom_line(size=1) +
	xlab("time") + 
	ylab("amplitude") +
	theme(legend.title=element_blank())
