#!/usr/bin/env python3
import sys
import numpy as np


def Check_Answers(the_vector):
   Vector = np.asarray([2/3,1/3,2/3,0,1,1,1,0])
   if Vector.shape[0]!=8:
     print ('Error en la dimension del vector')
   resp = np.sqrt(sum((the_vector-Vector)*(the_vector-Vector)))
   print ('La distancia al vector correcto es ',resp)

   if resp<0.0000001:
     print('Respuesta correcta')
   else: 
    print('Respuesta no correcta')
 

if __name__ == '__main__':
  x = np.asarray(eval(sys.argv[1]))
  Check_Answers(x)
