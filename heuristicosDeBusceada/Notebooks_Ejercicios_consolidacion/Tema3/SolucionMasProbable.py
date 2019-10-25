#!/usr/bin/env python3
import sys
import numpy as np


def Check_Answers(the_vector):

   if the_vector.shape[0]!=8:
     print('Error en la dimension del vector')
     exit()
   Vector = np.asarray([2.0/3,1.0/3,2.0/3,0,1,1,1,0])
   prob = 1.0
   for i in range(0,8):
     if the_vector[i]==0:
        prob = prob * (1.0-Vector[i])
        #print i,prob,1.0-Vector[i],the_vector[i]  
     else: 
        prob = prob * (Vector[i])   
        #print i,prob,Vector[i],the_vector[i]  

   print ('La probabilidad que da el modelo univariado a esta sol. es  ', prob)

  
   if abs(prob-(8.0/27.0))<(10**-15):
     print('Respuesta correcta')
   else: 
     print('Respuesta no correcta')
 

if __name__ == '__main__':
  x = np.asarray(eval(sys.argv[1]))
  Check_Answers(x)
