from rit_object import *
from math import *

"""
    file: mountainclimbing.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: Program that finds local maximum around given point
"""



class DPoint(rit_object):
    __slots__ =  ( 'x', 'y', 'z' )
    _types = ( float, float, float)
    


def evaluate( x, y ):
    z = sin(x*x)*2-y*cos(x*y)-x
    return z


def maxPoint( pointList ):
    o = pointList[0]
    for i in pointList:
        if i.z > o.z:
            o = i
    return o
            
    
def hillClimb( x, y, d ):
    zz = float(0)
    lst = []
    
    initial = DPoint(x, y, zz)
    initial.z = evaluate(initial.x, initial.y)
    lst.append( initial)

    new0 = DPoint(initial.x-d, initial.y, zz)
    new0.z = evaluate(new0.x, new0.y)
    lst.append( new0 )

    new1 = DPoint(initial.x+d, initial.y, zz)
    new1.z = evaluate(new1.x, new1.y)
    lst.append( new1 )

    new2 = DPoint(initial.x, initial.y-d, zz)
    new2.z = evaluate(new2.x, new2.y)
    lst.append( new2 )

    new3 = DPoint(initial.x, initial.y+d, zz)
    new3.z = evaluate(new3.x, new3.y)
    lst.append( new3 )
    



    return lst

def main():
    x = float(input("enter the initial x value: "))
    y = float(input("enter the initial y value: "))
    d = float(input ("enter the step disptance: "))
    maxNum = maxPoint( hillClimb( x, y, d ) )
    print( "the local maximum is at (", maxNum.x, maxNum.y,") = ", maxNum.z)

main()
