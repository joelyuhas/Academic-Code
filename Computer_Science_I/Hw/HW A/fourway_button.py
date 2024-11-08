from turtle import *
"""
    file: fourway_button.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that creats a four way button picture using turtle
"""

def main():
    c()
    c1()
    extri()
    rt()
    extri()
    rt()
    extri()
    rt()
    extri()
    hideturtle()
    input("hit enter to close")


def rt():
    right(90)
    
def extri():
    sp()
    triangle()
    bk()

def sp():
    up()
    forward(40)
    right(90)
    down()
    
def bk():
    up()
    right(90)
    forward(40)
    down()
    right(180)

def triangle():
    forward(20)
    left(120)
    forward(40)
    left(120)
    forward(40)
    left(120)
    forward(20)
    
def c():
    right(90)
    up()
    forward(20)
    down()
    left(90)
    circle(20)
    left(90)
    up()
    forward(20)
    right(90)
    down()

def c1():
    right(90)
    up()
    forward(100)
    down()
    left(90)
    circle(100)
    left(90)
    up()
    forward(100)
    right(90)
    down()
    
main()
