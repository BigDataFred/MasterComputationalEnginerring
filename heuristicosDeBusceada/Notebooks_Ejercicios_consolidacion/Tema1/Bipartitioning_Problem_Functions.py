#!/usr/bin/env python3
import sys
import numpy as np


def Read_Bipart_Instance(fname):   
 hdl = open(fname, 'r')
 mylist = hdl.readlines()
 hdl.close()
 n = eval(mylist[0])
 edge_weights = zeros((n,n))      
 for i in range(n):
   for j,val in enumerate(mylist[i+1].split()):     
     edge_weights[i,j]=eval(val)         
 return edge_weights


def Eval_Bipart_instance(edge_weights,solution):
 n = edge_weights.shape[0]         # Número de nodos
 balance =  np.sum(solution) # Numero de nodos en una de las partes
 fval = 0                  # Peso de las aristas entre partes del grafo
 for i in range(n-1):
     for j in range(i+1,n):
       if solution[i]==1-solution[j]:      # Si estan en partes diferentes  
          fval = fval+edge_weights[i,j]
 feasible=(balance==n/2)
 return feasible,fval,balance


# La función bin_array convierte un número decimal a binario.
def bin_array(num, m): #    """Returns an array representing the binary representation of num in m bits."""
    bytes = int(math.ceil(m / 8.0))
    num_arr = np.arange(num, num+1, dtype='>i%d' %(bytes))
    return np.unpackbits(num_arr.view(np.uint8))[-1*m:]     

def exhaustive_bip_search(edge_weights):
  n = weights.shape[0] 
  best_val = 0                  # Mejor valor
  best_sol = []                 # Mejor solución  
  for i in range(2**n):         # Se busca en el espacio completo
    sol = bin_array(i,n)        # Se convierte a binario
    feasible,fval,balance = Eval_Bipart_instance(edge_weights,sol)  # Se evalua la función
    if fval<best_val and feasible==1:                     # Si es mejor que el mejor valor hasta el momento se actualiza
      best_val = fval                                     # el mejor valor
      best_sol = sol   
      print(i,best_val,best_sol)  
  return best_sol



if __name__ == '__main__':
  file_name = sys.argv[1]
  edge_weights = Read_Bipart_Instance(file_name) 
  sol = eval(sys.argv[2])
  
  feasible,fval,fweight=Eval_Bipart_instance(edge_weights,sol)  
  best_sol = exhaustive_bip_search(edge_weights)
  feasible,fval,balance = Eval_Bipart_instance(edge_weights,best_sol)
  print(feasible,fval,balance)
