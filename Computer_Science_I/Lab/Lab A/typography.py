from turtle import *

"""
    file: typography.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that creats characters using turtle and then strings them together to form words.
"""


def main(): #compilation of letters
    a()
    ss()
    b()
    ss()
    r()
    ss()
    a()
    ss()
    c()
    ss()
    a()
    ss()
    d()
    ss()
    a()
    ss()
    b()
    ss()
    r()
    ss()
    a()
    ss()
    ss()
    ss()
    c()
    ss()
    s()
    ss()
    i()
    
    input("Hit Enter to Close..")

def ss(): #space button
    up()
    forward(5)
    down()

def a(): #capital 'A'
    left(90)
    forward(20)
    right(90)
    forward(20)
    right(90)
    forward(5)
    right(90)
    forward(20)
    forward(-20)
    left(90)
    forward(15)
    left(90)

def b(): #capital 'B'
    left(90)
    forward(20)
    right(90)
    forward(20)
    right(90)
    forward(10)
    right(90)
    forward(20)
    forward(-20)
    left(90)
    forward(10)
    right(90)
    forward(20)
    right(180)
    forward(20)

def r(): #capital 'R'
    left(90)
    forward(20)
    right(90)
    forward(20)
    right(90)
    forward(10)
    right(90)
    forward(20)
    left(90)
    forward(2)
    left(90)
    forward(10)
    right(90)
    forward(8)
    left(90)
    up()
    forward(15)

def c(): #capital 'C'
    left(90)
    forward(20)
    right(90)
    forward(20)
    right(90)
    up()
    forward(20)
    down()
    left(90)
    forward(-20)
    forward(20)

def d(): #capital 'D'
    left(90)
    forward(20)
    right(90)
    forward(20)
    right(90)
    forward(20)
    left(90)
    forward(-20)
    forward(20)

def s(): #capital 'S'
    forward(20)
    left(90)
    forward(10)
    left(90)
    forward(20)
    right(90)
    forward(10)
    right(90)
    forward(20)
    right(90)
    up()
    forward(20)
    left(90)

def i(): #capital 'I'
    forward(20)
    forward(-10)
    left(90)
    forward(20)
    right(90)
    forward(-10)
    forward(20)
    right(90)
    up()
    forward(20)
    left(90)
    
    
    
main()
