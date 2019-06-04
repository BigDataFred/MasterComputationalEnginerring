#############################################################
###
### Convolucion
###
#############################################################
###
### y[n] = (x1[n]*x2[n])_n = sum(x1[m]x2[n-m], m = 0..N-1)
###

require(ggplot2)
require(reshape)
require(gridExtra)

source("code/triangle1.R")
source("code/rectangle1.R")

t <- seq(0, 70, by=1)
x1 <- triangle1(t, 0, 30)
x2 <- rectangle1(t, 0, 30)

### Convolucion
c  <- convolve(x1, rev(x2), type="open")

df1 <- melt(data.frame(x = t, triangle = x1, rectangle = x2), id = "x")

### Plot
p1 <- ggplot(df1, aes(x = x, y=value)) +
		facet_wrap(~variable, scales="free") + 
		geom_line(size=1) +
		xlab("") + 
		ylab("")

df2 <- data.frame(x=1:length(c), y=c)

### Plot
p2 <- ggplot(df2, aes(x = x, y=y)) +
		geom_line(size=1) +
		xlab("") + 
		ylab("")

### Plots en una misma figura
X11(); plot.new();
grid.arrange(p1, p2, ncol=1)