### Funcion triangulo
triangle1 <- function(t, desde, hasta) {
	n <- length(t)
	res <- array(0, dim=c(1,n))
	medio <- (hasta-desde)/2
	idx <- which(t >= desde & t < medio)
	res[idx] <- 2*(t[idx]-desde)/((hasta-desde)*(medio-desde))
	idx <- which(t >= medio & t <= hasta)
	res[idx] <- 2*(hasta-t[idx])/((hasta-desde)*(hasta-medio))
	res <- matrix(res)
	
	return(res)
}