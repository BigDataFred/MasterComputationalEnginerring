#!/usr/bin/env python3
import argparse

def Eval_NumeroRepresentaciones(Cand):
   if Cand==6:
     print('El valor escogido es correcto.')
   else:
     print ('El valor escogido no es correcto.') 


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument(
        'integers', metavar='int', type=int, choices=range(1,100),
         nargs='+', help='An integer in the range 100')
  parser.add_argument(
        '--sum', dest='accumulate', action='store_const', const=sum,
        default=max, help='sum the integers (default: find the max)')
  args = parser.parse_args()
  Cand = args.integers[0]
  Eval_NumeroRepresentaciones(Cand)
