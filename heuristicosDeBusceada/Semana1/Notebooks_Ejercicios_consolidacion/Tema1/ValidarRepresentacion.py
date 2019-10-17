#!/usr/bin/env python3
import sys
import numpy as np


def Check_Answers(vector):

  
   if vector.shape[0]!=8:
     print('Error en la dimension del vector')
     exit()

   ver_1 = np.sum(vector[[0,6]]==vector[0])
   ver_2 = np.sum(vector[[1,2,3,4]]==vector[1])
   ver_3 = np.sum(vector[[5,7]]==vector[5])
   #print(ver_1,ver_2,ver_3)
   ver_tot = np.sum(ver_1+ver_2+ver_3)==8 and (vector[0]!=vector[1]) and (vector[0]!=vector[5]) and (vector[1]!=vector[5])
   #print(ver_1,ver_2,ver_3,ver_tot)
   if ver_tot==True:
     print('Respuesta correcta')
   else: 
     print('Respuesta no correcta')
 

if __name__ == '__main__':
  x = np.asarray(eval(sys.argv[1]))
  Check_Answers(x)
