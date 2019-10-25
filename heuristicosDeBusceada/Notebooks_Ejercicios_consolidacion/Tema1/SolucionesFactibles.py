#!/usr/bin/env python3
import argparse

def SolucionesFactibles(Cand):
   if Cand==45:
     print('El valor escogido es correcto.')
   else:
     print ('El valor escogido no es correcto.') 


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument(
        'integers', metavar='int', type=int, choices=range(1,101),
         nargs='+', help='An integer in the range 100')
  parser.add_argument(
        '--sum', dest='accumulate', action='store_const', const=sum,
        default=max, help='sum the integers (default: find the max)')
  args = parser.parse_args()
  Cand = args.integers[0]
  SolucionesFactibles(Cand)
