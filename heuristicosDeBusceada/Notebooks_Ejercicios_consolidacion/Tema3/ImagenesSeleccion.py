#!/usr/bin/env python3
import argparse
import sys

def Check_Answers():
   Answers = [0,1,1,0,0,0]
   nargs = len(sys.argv)-1
   ncorr = 4
   tot_resp = 0
   for index in args.integers[0:]: 
     #print (index,tot_resp)
     tot_resp = tot_resp + Answers[index-1]
   if tot_resp==0:
     print('Ninguna de las respuestas es correcta.')
   elif tot_resp==ncorr and nargs==ncorr:
     print('Todas las respuestas escogidas son correctas y no falta ninguna.')
   elif tot_resp<nargs:
     print ('No todas las respuestas son correctas.')
   elif tot_resp>0 and tot_resp==nargs:
     print ('Todas las respuestas son correctas pero falta algun algoritmo por incluir')
 

 

if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument(
        'integers', metavar='int', type=int, choices=range(1,7),
         nargs='+', help='Un entero en el rango (1,6)')
  parser.add_argument(
        '--sum', dest='accumulate', action='store_const', const=sum,
        default=max, help='sum the integers (default: find the max)')
  args = parser.parse_args()
  Check_Answers()
