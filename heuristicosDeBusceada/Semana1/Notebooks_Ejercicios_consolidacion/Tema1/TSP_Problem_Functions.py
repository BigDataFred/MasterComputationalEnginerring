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

if __name__ == '__main__':
  file_name = sys.argv[1]
  DistMat = Read_Instance(file_name)
  solucion = sys.argv[2]
  val_tsp = Eval_TSP_instance(Dist_Mat,solucion)
