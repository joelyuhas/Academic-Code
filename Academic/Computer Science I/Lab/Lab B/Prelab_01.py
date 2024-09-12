from turtle import *

"""
    file: mickey.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: create a recursion model to create mickey mouse ears contiunuosly

    side note: the function does work
"""

def mickey1(s):
    circle(s,120)
    

def mickey2(s,n):
    if n==0:
        pass
    
    else:
        mickey1(s)
        right(180)
        mickey2(s/2,n-1)
        right(180)
        mickey1(s)
        right(180)
        mickey2(s/2,n-1)
        right(180)
        mickey1(s)

    
mickey2(100,3)
