from math import *
from turtle import *

"""
    file: clover.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that creats mickey function and then adds to the bottom to create a clover tpye image using turtle
"""



def golden_ratio():
    """
    Returns the golden ratio. Avoids 'magic numbers'
    """
    return (1+sqrt(5))/2


def mickey(depth, size):
    """
    pre-conditions: turtle is down, facing east
    post-conditions: turtle has drawn 'mickey' the amount of times specified by 'depth', pen is down, facing west
    """
    
    if depth==0:
        pass
    else:
        circle(size, 120)
        right(180)
        mickey(depth-1, size/golden_ratio())
        right(180)
        circle(size,120)
        right(180)
        mickey(depth-1, size/golden_ratio())
        right(180)
        circle(size,120)
        
        
        

def clover(depth, size):
    """
    pre-conditions: clover is down, facing east, ready to exicute 'mickey' function
    post-conditions:clover is down, facing west, 'mickey' has been exicuted based on 'depth'
    """
    right(180)
    mickey(depth-1,size/golden_ratio())
    
       

def main():
    """
    pre-conditions: turtle is down, facing east, ready to exicute, turtle is hidden
    post-conditions: 'mickey' and 'clover' have been exicuted and prompt has appeared waiting for user to hit enter to terminate
    """
    hideturtle()
    depth = int(input("enter depth: "))
    size = int(input("enter size: "))
    
    speed(0)
    mickey(depth, size)
    clover(depth, size)
    input("Hit enter to close")
    
    


main()
