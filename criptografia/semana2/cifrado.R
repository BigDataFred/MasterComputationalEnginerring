
# cifredo afin
men<-"ENVIAME LA CLAVE"
out <- cifafin(c(LETTERS, " "), men, 3,  13, 9)
chck<-"ERMXGDKTRMPIIKMK X"  
print(out==chck)


decafin(c(LETTERS, " "), out, 3,  13, 9)

decafin(c(LETTERS, " "), "GKXIMXERMZKXLRHR X", 3,  13, 9)
