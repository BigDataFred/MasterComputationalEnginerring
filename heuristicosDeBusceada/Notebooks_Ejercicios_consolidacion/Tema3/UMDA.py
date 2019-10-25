#!/usr/bin/env python3

import numpy as np
import random
from operator import attrgetter, itemgetter
from deap import algorithms, base, creator, tools, benchmarks

def evalOneMax(individual):
    return (sum(individual),)

class UMDA(object):
    def __init__(self, n_, pop_size, trunc_parameter):
        self.n = n_
        self.N = pop_size
        self.univ_prob = 0.5*np.ones((1,self.n))  
        #print(self.univ_prob.shape)
        #print(self.univ_prob)      
        self.truncation = int(trunc_parameter * self.N)

    def generate(self, ind_init):
        # Generate N individuals and put them into the provided class
        arz = np.zeros(shape=(self.N,self.n))    
        #print (self.n,self.N)
        for i in range(0,self.n):
          #print(i)
          aux = np.random.rand(self.N, 1) 
          #print(aux)     
          #print(self.univ_prob[0,i])
          ind = np.where(aux<=self.univ_prob[0,i])          
          #print(ind[0])
          arz[ind[0],i] = 1           
        #print(arz)
        return list(map(ind_init, arz))
    
    def update(self, population):
        # Sort individuals so the best is first
        sorted_pop = sorted(population, key=attrgetter("fitness"), reverse=True)
        #print(np.sum(sorted_pop,0))        
        # Compute the probabilistic vector (frequency of ones in each variable)
        self.univ_prob[0,:] = np.sum(sorted_pop[:self.truncation],0)/self.truncation    
        #print(self.univ_prob.shape)
        print(self.univ_prob)   
        

creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", np.ndarray, fitness=creator.FitnessMax) 

if __name__ == '__main__':
    n, N = 100, 100
    trunc_par = 0.5 
    strategy = UMDA(n,N,trunc_par)
   
    toolbox = base.Toolbox()
    toolbox.register("evaluate", evalOneMax)
    toolbox.register("generate", strategy.generate, creator.Individual)
    toolbox.register("update", strategy.update)
    
    # Np equality function (operators.eq) between two arrays returns the
    # equality element wise, which raises an exception in the if similar()
    # check of the hall of fame. Using a different equality function like
    # np.array_equal or np.allclose solve this issue.
    hof = tools.HallOfFame(1, similar=np.array_equal)
    stats = tools.Statistics(lambda ind: ind.fitness.values)
    stats.register("avg", np.mean)
    stats.register("std", np.std)
    stats.register("min", np.min)
    stats.register("max", np.max)
    
    algorithms.eaGenerateUpdate(toolbox, ngen=15, stats=stats, halloffame=hof,verbose=True)
    
    print(hof[0].fitness.values[0])
