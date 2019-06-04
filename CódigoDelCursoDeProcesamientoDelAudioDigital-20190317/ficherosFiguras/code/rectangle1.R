### Funcion rectangulo
rectangle1 <- function(t, desde, hasta) {
	n <- length(t)
	res <- array(0, dim=c(1,n))
	idx <- which(t >= desde & t <= hasta)
	res[idx] <- rep(1, length(idx))
	res <- matrix(res)
	
	return(res)
}