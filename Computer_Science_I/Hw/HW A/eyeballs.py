from turtle import *
from math import *


"""
    file: eyeballs.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that creats beautiful circules using a mixture of recursion
"""


def draw_circle_from_center( size ):
    """
    draws the main circle
    """
    up()
    forward(size)
    left(90)
    down()
    circle(size)
    right(90)
    up()
    forward(-size)
    down()
    
    

def draw_shrinking_eye_rec( size, srink, skew ):
    """
    uses tail recursion to draw circles
    """
    
    sri = (100-srink)/100
    
    if size < 5:
        pass
    
    else:
        up()
        forward(-skew)
        draw_circle_from_center( size )
        
        draw_shrinking_eye_rec( size*sri, srink, skew )        
    


def draw_shrinking_eye_iter( size, srink, skew ):
    """
    uses loops to draw circles
    """
    sri = (100-srink)/100
    
    while size > 5:
        up()
        forward(-skew)
        draw_circle_from_center( size )
        
        size = size*sri

def draw_eyeballs( size, srink, skew):
    """
    sets up canvas to draw circles
    """
    
    up()
    forward(size+10)
    down()
    draw_shrinking_eye_rec( size, srink, skew )  
    up()
    goto (0,0)
    setheading(180)
    forward(size+5)
    down()
    draw_shrinking_eye_iter( size, srink, skew )
        
   
    

def init():
    """
    hides turtle and sets speed
    """
    hideturtle()
    speed(0)
    
    

def main():
    
    size = int(input("Enter the size(50-100): "))
    srink = int(input("Enter the shrink percentage (1-50): "))
    skew = int(input("Enter the eyeball skew: "))


    init()
    draw_eyeballs( size, srink, skew )

    input("hit enter to close")
    quit()

main()
