#!/usr/bin/env python3
import sys
import numpy as np


def Read_Scheduling_Instance(fname):   
 hdl = open(fname, 'r')
 mylist = hdl.readlines()
 hdl.close()
 n_jobs = eval(mylist[1].split()[0])
 n_machines = eval(mylist[1].split()[1])

 processingtimes = zeros((n_jobs,n_machines))    
    
 for i in range(n_jobs):
   for j,val in enumerate(mylist[i+3].split()):   
       processingtimes[i,j] = eval(val)         
            
 return n_jobs,n_machines,processingtimes
        


def Eval_Scheduling_instance(processingtimes,solution):
 n_jobs = processingtimes.shape[0]         # Número de trabajos
 n_machines = processingtimes.shape[1]          # Número de maquinas 
 timeTable = zeros((1,n_machines));
 prev_machine=0;
 first_pos =solution[0];
 j = range(n_machines)
 timeTable = np.cumsum(processingtimes[j,first_pos]);

 # Calcula el tiempo total de terminación de los trabajos
 fval = timeTable[n_machines-1];
 for z in range(1,n_jobs):
    job = solution[z]-1    
    timeTable[0] = timeTable[0] + processingtimes[0,job]
    prev_machine = timeTable[0]
    for machine in range(1,n_machines):
	   timeTable[machine] = np.max([prev_machine,timeTable[machine]])+ processingtimes[machine,job]
	   prev_machine = timeTable[machine]
    fval = fval + timeTable[machine-1]	
 return fval

if __name__ == '__main__':
  file_name = sys.argv[1]
  edge_weights = Read_Scheduling_Instance(file_name) 
  sol = eval(sys.argv[2])
  
  n_jobs,n_machines,processingtimes = Read_Scheduling_Instance(file_name)         
  print(n_jobs,n_machines,processingtimes)
  fval = Eval_Scheduling_instance(processing_times,sol)  
 
