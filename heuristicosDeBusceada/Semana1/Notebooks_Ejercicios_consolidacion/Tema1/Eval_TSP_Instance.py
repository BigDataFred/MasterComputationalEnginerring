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

def Read_Instance

if __name__ == '__main__':
  file_name = sys.argv[1]
  Read_Instance(file_name)
