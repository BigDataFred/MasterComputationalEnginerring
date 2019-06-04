### Funcion que segmenta una senal con tamano de ventana (n) y overlap (p)
### para facilitar el calculo vectorial y matricial
buffer <- function(x, n, p) {
  L <- length(x)
  nC <- ceiling(L/(n-p))  
  xPad <- c(rep(0,p), x, rep(0, nC * (n - p) - L))
  xPad <- t(embed( xPad, dim=n)[seq(1, length(xPad) - n + 1, by=n-p), n:1])
  
  return(xPad)
}

### Energia de la transformada de Fourier de tiempo reducido (STFT)
STenergia <- function(x, wl, wn, ovlp) {
	w  <- ftwindow(wl, wn)
	xf <- buffer(x, wl, ovlp)
	xw <- w * xf
	return(colSums(xw^2))
}

### Magnitud de la transformada de Fourier de tiempo reducido (STFT)
STmagnitud <- function(x, wl, wn, ovlp) {
  w  <- ftwindow(wl, wn)
  xf <- buffer(x, wl, ovlp)
  xw <- w * abs(xf)
  return(colSums(xw))
}