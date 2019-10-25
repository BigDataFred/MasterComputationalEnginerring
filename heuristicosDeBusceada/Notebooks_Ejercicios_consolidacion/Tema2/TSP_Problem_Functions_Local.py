#!/usr/bin/env python3
import sys
import numpy as np

def Read_Instance(fname):
 hdl = open(fname, 'r')
 mylist = hdl.readlines()
 hdl.close()
 n = eval(mylist[0])
 distances  = np.zeros((n,n))
 for i in range(n):
   for j,val in enumerate(mylist[i+1].split()):     
     distances[i,j]=eval(val)         
 return distances

def Eval_TSP_instance(Dist_Matrix,perm):
 n = Dist_Matrix.shape[0]   
 perm = np.asarray(perm) - 1                           # La representación en python comienza en cero   
 val_tsp = Dist_Matrix[perm[0],perm[n-1]]  # Distancia entre la primera y última ciudad
 for i in range(n-1):
   val_tsp = val_tsp + Dist_Matrix[perm[i],perm[i+1]]     # Distancia entre ciudades consecutivas   
 return val_tsp    


# Function that deletes two edges and reverses the sequence in between the deleted edges
def stochasticTwoOpt(perm):
    result = perm.copy() # make a copy
    size = len(result)
    # select indices of two random points in the tour
    p1, p2 = random.randrange(0,size), random.randrange(0,size)
    # do this so as not to overshoot tour boundaries
    exclude = set([p1])
    if p1 == 0:
        exclude.add(size-1)
    else:
        exclude.add(p1-1)
    
    if p1 == size-1:
        exclude.add(0)
    else:
        exclude.add(p1+1) 
                       
    while p2 in exclude:
        p2 = random.randrange(0,size)

    # to ensure we always have p1<p2        
    if p2<p1:
        p1, p2 = p2, p1
     
    # now reverse the tour segment between p1 and p2       
    aux = result[p1:p2].copy()
    result[p1:p2] = aux[::-1]    
    return result





# TwoOpt crea una vecindad basda en el operador two-opt de forma determinista
# Todas las permutaciones que se pueden obtener con two-opt están en la vecindad
def TwoOpt(perm):
    n = perm.shape[0]
    n_neighbors = n*(n-1)/2 - n           # Número de vecinos
    neighbors = np.zeros((n_neighbors,n)) # Guardaremos todos los vecinos en neighbors
    ind = 0
    for i in range(n-1):
      for j in range(i+2,n):        # Las posiciones a elegir para el two-opt no deben ser consecutivas
        if not(i==0 and j==n-1):    # Las posiciones no deben ser primera y última (son circularmente consecutivas)
          neighbors[ind,:] = perm    
          aux = perm[i:j+1].copy() 
          neighbors[ind,i:j+1] = aux[::-1]   # Se invierte el camino entre posiciones elegidas
          ind = ind + 1   
    return neighbors

# Swap crea una vecindad basada en el operador de intercambio entre posiciones
# Todas las permutaciones que se pueden obtener como un swap entre la primera posición
# y cualquiera de las restantes están en la vecindad

def Swap(perm):
    n = perm.shape[0]
    n_neighbors = n-1           # Número de vecinos
    neighbors = np.zeros((n_neighbors,n)) # Guardaremos todos los vecinos en neighbors
    ind = 0
    for i in range(1,n):
          neighbors[ind,:] = perm    
          neighbors[ind,i] = perm[0]
          neighbors[ind,0] = perm[i]  
          ind = ind + 1   
    return neighbors

# Complement crea una vecindad basada en el operador de complemento entre posiciones
# en la cual cada valor i en la permutación es sustituido por el valor (n-i) excepto para i=n,
# que permanece igual
# Cada permutación tiene un único vecino


def Complement(perm):
    n = perm.shape[0]
    n_neighbors = 1                       # Número de vecinos
    neighbors = np.zeros((n_neighbors,n)) # Guardaremos todos los vecinos en neighbors
    pos_n = np.where(perm==n)
    neighbors[0,:] = (n-perm)             # Se sustituye por el complemento     
    neighbors[0,pos_n] = n                # Se mantiene el valor de n igual
    return neighbors

# Decrease crea una vecindad basada en obtener una nueva solución restando un valor "v" a cada posición
# y crear una solución vecina por cada valor de v en (1,...,n-1). Cuando la resta da valor cero, se pasa
# a n
# Ej: permutacion original:   5 3 4 2 1:
#     permutaciones vecinas:  (4 2 3 1 5),(3,1,2,5,4),(2,5,1,4,3),(1,4,5,3,2)
                             

def Decrease(perm):
    n = perm.shape[0]
    n_neighbors = n-1                       # Número de vecinos    
    neighbors = np.zeros((n_neighbors,n)) # Guardaremos todos los vecinos en neighbors
    auxperm = perm.copy()
    for i in range(n-1):
      auxperm = auxperm-1
      pos_0 = np.where(auxperm==0)
      auxperm[pos_0] = n  
      neighbors[i,:] = auxperm                                
    return neighbors





def Local_Search_TwoOpt(Dist_Matrix):    
 n = Dist_Matrix.shape[1]   
 init_sol = np.random.permutation(n)+1 
 best_val = Eval_TSP_instance(Dist_Matrix,init_sol)              # Mejor valor
 best_sol = init_sol                                             # Mejor solución  
 improvement = True
 number_evaluations = 1   
 while improvement:                    # Mientras se mejore el valor de la función
    neighbors = TwoOpt(best_sol)            # Todos los vecinos
    n_neighbors = neighbors.shape[0]
    number_evaluations =  number_evaluations + n_neighbors  # Se calcula es número de evaluaciones
    best_val_among_neighbors = best_val
    for i in range(n_neighbors):                    # Se recorren todos los vecinos buscando el mejor 
      sol = neighbors[i,:]   
      fval =  Eval_TSP_instance(Dist_Matrix,sol)    # Se evalua la función
      if fval<best_val_among_neighbors:             # Si es mejor que el mejor valor entre los vecinos hasta el momento
        best_val_among_neighbors = fval             # se actualiza el mejor valor
        best_sol_among_neighbors = sol   
    improvement = (best_val_among_neighbors<best_val) #  Se determina si ha habido mejora con respecto al ciclo anterior  
    if improvement:                                
      best_val = best_val_among_neighbors           # Se actualiza el mejor valor y la mejor solución 
      best_sol = best_sol_among_neighbors      
      print(best_val,best_sol, number_evaluations)  
 return best_val, best_sol, number_evaluations    


if __name__ == '__main__':
  file_name = sys.argv[1]
  DistMat = Read_Instance(file_name)
  solucion = sys.argv[2]
  val_tsp = Eval_TSP_instance(Dist_Mat,solucion)
