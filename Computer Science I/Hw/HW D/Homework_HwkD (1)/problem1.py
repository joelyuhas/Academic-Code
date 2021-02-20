"""
Debug and Test homework problem for csci141.
"""
#######################################################################
## Student Name: Joel Yuhas
## Problem: The drawI function does not work correctly.
#######################################################################
# Assignment:
# 1. Use a debugger (pdb, idle or pycharm) to debug drawI().
#    Mark correction(s) with the comment "# fixed here" on the changed lines.
#        A Rough Order of Debugging Steps:
#        - first run the program to see how it misbehaves.
#        - set a breakpoint at the first recursion.
#        - run with a depth of 2.
#        - when it reaches the breakpoint, step into the recursion.
#        - use the debugger to examine where the code is in execution
#          at different depth levels; see how depth and size are
#          different in multiple depth levels.
#        - when you think you've found a fix for the problem,
#          stop debugging, change the code, mark the fix, and rerun.
#        - add other break points as and where needed to debug the function.
#        - repeat until you've fixed the code.
#    (debugging and repairing code is 20% of grade) 
#
# 2. Write test_drawI() so that it tests your function's behaviors for
#    these cases:
#    NOTE: PRINT THE DEPTH AND PAUSE BETWEEN TESTS.
#          ALSO CLEAR THE CANVAS BEFORE THE NEXT TEST.
#        0 == depth. reason: this is the base case.
#        1 == depth. reason: the simplest 'i' is drawn correctly.
#        2 == depth. reason: the capital 'I' is drawn correctly.
#        3 == depth. reason: a capital 'I' with 'i's on the ends.
#        4 == depth. reason: a capital 'I' with 'I's on the ends.
#    (testing code is 20% of grade) 

from turtle import *

def initWindow( size ):
    setup(600,600)
    setworldcoordinates( -size-1, -size-1, size, size )
    left(90)
    pensize(3)
    speed(0)

# problem: this code is faulty. use a debugger to diagnose and fix it.
def drawI(depth, size):
    """ drawI draws a recursive 'I' pattern with 
        the letter 'I' coming out of each end
        of the larger 'I' preceding it.
        depth 0 draws nothing.
        depth 1 draws a simple i with no top/bottom bars.
        depth 2 draws the 'I' with top/bottom bars.
        depth 3 draws the 'I' smaller 'I' as the top/bottom bars.
        and so on recursively shrinking the 'I's.
    """
    if(depth < 1):
        pass
    else:
        fd(size/2)
        lt(90)
        drawI(depth-1,size/2)
        rt(180)#fixed here
        drawI(depth-1,size/2)
        lt(90)
        fd(-size/2)#fixed here
        
def drawII(depth, size):
    drawI( depth, size)
    drawI( depth, -size)
        
        
def test_drawI():
    initWindow( 100 )
    drawII( 0, 100 )
    input("Press enter for next test")
    reset()
    initWindow( 100 )
    drawII( 1, 100 )
    input("Press enter for next test")
    reset()
    initWindow( 100 )
    drawII( 2, 100 )
    input("Press enter for next test")
    reset()
    initWindow( 100 )
    drawII( 3, 100 )
    input("Press enter for next test")
    reset()  

def main():
    depth = int( input( "enter depth: " ) )
    size = 100
    initWindow(size)
    drawI(depth, size)
    drawI(depth, -size)#fixed here
    input("Press enter to quit")

if __name__ == "__main__":
    main()
    test_drawI()
    bye()

