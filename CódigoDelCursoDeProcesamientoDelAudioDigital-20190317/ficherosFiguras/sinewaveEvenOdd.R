#############################################################
###
### Even and odd functions
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

df2 <- df
levels(df2$variable)[levels(df2$variable)=="real"]      <- "cosine(even)"
levels(df2$variable)[levels(df2$variable)=="imaginary"] <- "sine(odd)"

### Plot
X11(); plot.new();
ggplot(df2, aes(x = x, y=value)) +
	facet_wrap(~variable) + 
	geom_line(size=1) +
	xlab("time") + 
	ylab("amplitude") +
	geom_vline(xintercept=0, colour="green", size=1.2)