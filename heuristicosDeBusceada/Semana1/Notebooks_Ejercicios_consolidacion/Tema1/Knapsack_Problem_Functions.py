#!/usr/bin/env python3
import sys
import numpy as np


 
def Read_Knapsack_Instance(fname):  
  capacity = np.loadtxt(fname+'_c.txt',delimiter=',',unpack=True)   # Capacidad de la mochila
  weights  = np.loadtxt(fname+'_w.txt',delimiter=',',unpack=True)   # Peso de los objetos
  profits  = np.loadtxt(fname+'_p.txt',delimiter=',',unpack=True)   # Valores de los objetos
  best = np.loadtxt(fname+'_s.txt',delimiter=',',unpack=True)       # Optimal solucion    
  return capacity,weights,profits,best

def Eval_Knapsack_instance(capacity,weights,profits,solution):
 n = weights.shape[0]         # Número de objetos
 fval = 0                     # Valor  total de los objetos
 fweight = 0                  # Peso total de los objetos
 for i in range(n):    
   fval = fval + profits[i]*solution[i]     
   fweight = fweight+weights[i]*solution[i]
 feasible = (fweight<=capacity)  # Es una solución factible?
 return feasible,fval,fweight


# La función bin_array convierte un número decimal a binario.
def bin_array(num, m): #    """Returns an array representing the binary representation of num in m bits."""
    bytes = int(math.ceil(m / 8.0))
    num_arr = np.arange(num, num+1, dtype='>i%d' %(bytes))
    return np.unpackbits(num_arr.view(np.uint8))[-1*m:]     

def exhaustive_search(capacity,weights,profits):
  n = weights.shape[0] 
  best_val = 0                  # Mejor valor
  best_sol = []                 # Mejor solución  
  for i in range(2**n):         # Se busca en el espacio completo
    sol = bin_array(i,n)        # Se convierte a binario
    feasible,fval,fweight = Eval_Knapsack_instance(capacity,weights,profits,sol)  # Se evalua la función
    if fval>best_val and feasible==1:                     # Si es mejor que el mejor valor hasta el momento se actualiza
      best_val = fval                                     # el mejor valor
      best_sol = sol   
      print(i,best_val,best_sol)  
  return best_sol



if __name__ == '__main__':
  file_name = sys.argv[1]
  capacity,weights,profits,best = Read_Knapsack_Instance(file_name) 
  sol = eval(sys.argv[2])
  
  feasible,fval,fweight=Eval_Knapsack_instance(capacity,weights,profits,solution)  
  
  best_sol = exhaustive_search(capacity,weights,profits)
  feasible,fval,fweight=Eval_Knapsack_instance(capacity,weights,profits,best_sol)
  print(feasible,fval,fweight)
