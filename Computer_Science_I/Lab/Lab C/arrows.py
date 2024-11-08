from turtle import *
from random import *
from math import *

"""

"""
def MAX_FIGURES():
    """Maximum number of individual figure elements"""
    return 500

def MAX_DISTANCE():
    """Maximum number of distance"""
    return 30

def MAX_SIZE():
    """Maximum size for triangle"""
    return 30

def MAX_ANGLE():
    """Maximum angle that turntle can turn"""
    return 30




def ranDistance():
    """Sets random distance for triangles"""
    return randint(1,MAX_DISTANCE())
                   
def ranSize():
    """Sets random size for triangles"""
    return randint(1,MAX_SIZE())

def ranAngle():
    """Sets random angle for triangles"""
    return randint(-MAX_ANGLE(), MAX_ANGLE())



def boundingBoxDraw(bs):
    """
    
    """
    up()
    forward(bs)
    left(90)
    down()
    forward(bs)
    left(90)
    forward(bs*2)
    left(90)
    forward(bs*2)
    left(90)
    forward(bs*2)
    left(90)
    forward(bs*2)
    up()
    goto(0,0)
    down()

def boundingBoxStoper(x, y, bs):
    """
    Sets the box for which the triangles may not be drawn out of
    """
    if x < -bs+5:
        setheading(0)
        forward(10)
    else:
        pass
    
    if bs-5 < x:
        setheading(180)
        forward(10)
    else:
        pass

    if y < -bs+5:
        setheading(90)
        forward(10)
    else:
        pass

    if bs-5 < y:
        setheading(270)
        forward(10)
    else:
        pass

    if x < -bs+5 and y < -bs+5:
        setheading(315)
        forward(10)
    else:
        pass
    
    if x <-bs+5  and bs-5 < y:
        setheading(45)
        forward(10)
    else:
        pass

    if bs-5 < x and y < -bs+5 :
        setheading(225)
        forward(10)
    else:
        pass

    if bs-5 < x and bs-5 < y:
        setheading(135)
        forward(10)
    else:
        pass


        
def drawFigureRec(d, area, bs):
    """
    Draws the traingles recursivly based on random size, distance and color and fills color as well
    """
    size = ranSize()
    c1 = random()
    c2 = random()
    c3 = random()
    pencolor( c1, c2, c3 )
     
    if d == 0:
        print("The total painted area is ",end="")
        print(area, end="")
        print(" units ")
        return

    else:
        up()
        fd(ranDistance())
         
        x,y = position()
        boundingBoxStoper(x, y, bs)

        right(90)
        down()
        color( c1, c2, c3)
        begin_fill()
        fd(size/2)
        left(120)
        fd(size)
        left(120)
        fd(size)
        left(120)
        fd(size/2)
        end_fill()
 
        left(90)
        left(ranAngle())
        area += (size*size)*(sqrt(3)/4)

        drawFigureRec(d-1, area, bs)



def drawFigureItr(d, area, bs):
    """
    Draws the traingles iterivly based on random size, distance and color and fills color as well
    """
    size = ranSize()
    
    while 0 < d:
        size = ranSize()
        up()
        fd(ranDistance())
        
        x,y = position()
        boundingBoxStoper(x, y, bs)
        
        right(90)
        down()
        co1 = random()
        co2 = random()
        co3 = random()
        pencolor( co1, co2, co3 )
        color( co1, co2, co3 )
        begin_fill()
        fd(size/2)
        left(120)
        fd(size)
        left(120)
        fd(size)
        left(120)
        fd(size/2)
        end_fill()

        
        left(90)
        left(ranAngle())
        area += (size*size)*(sqrt(3)/4)

        d = d-1

    print("The total painted area is ",end="")
    print(area, end="")
    print(" units ", end="")    


        
def turtleState():
    """
    Sets the state for which the turtle is to obtain
    """
    hideturtle()
    speed(0)

  

def main():
    """
    compiles the functions and exicutes arrows as well as prints final que
    """
    d = int(input("Arrows (0-500):  "))
    bs=100
    
    if -1 < d < 501:
        
        turtleState()
        boundingBoxDraw(bs)
        drawFigureRec(d, 0, bs)
        
        input("Hit enter to continue")
        reset()

        turtleState()
        boundingBoxDraw(bs)
        drawFigureItr(d, 0, bs)
        
    else:
        input("Arrows must be between 0 and 500 inclsive")
        bye()

    
main()
