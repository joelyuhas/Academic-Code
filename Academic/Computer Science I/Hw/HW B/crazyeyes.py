from turtle import *
from math import *

def draw_circle_from_center( size ):
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
    
    sri = (100-srink)/100
    
    if size < 5:
        pass
    
    else:
        up()
        forward(skew)
        forward(size)
        left(90)
        down()
        circle(size)
        right(90)
        up()
        forward(-size)
        down()
        
        draw_shrinking_eye_rec( size*sri, srink, skew )        
    


def draw_shrinking_eye_iter( size, srink, skew ):
    sri = (100-srink)/100
    
    while size > 5:
        up()
        forward(skew)
        forward(size)
        left(90)
        down()
        circle(size)
        right(90)
        up()
        forward(-size)
        down()
        
        size = size*sri

def draw_eyeballs( size, srink, skew):
    
    up()
    forward(size+5)
    down()

    draw_shrinking_eye_rec( size, srink, skew )

    
    up()
    goto (0,0)
    setheading(180)
    forward(size+5)
    down()

    draw_shrinking_eye_iter( size, srink, skew )
        
   
    

def init():
    hideturtle()
    pass
    

def main():
    speed(0)
    size = int(input("Enter the size(50-100): "))
    srink = int(input("enter srink(1-100): "))
    skew = int(input("enter skew: "))


    draw_eyeballs( size, srink, skew )
    

    input("hit enter to close")

main()
