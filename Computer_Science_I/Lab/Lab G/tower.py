from tower_animate import *
from myNode import *
from myStack import *
"""
    file: tower.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that solves the tower of hannoi
"""




def otherPile(fromPile, toPile):
    """
    Preconditions: Recives two stakcs and looks for which item has the smallest disk
    Postcondition: returns the position of the lowest disk
    """
    if fromPile + toPile == 1:
        return 2
    if fromPile + toPile == 2:
        return 1
    return 0

def mover(fromPile, otherPile, stacklist):
    stacklist[otherPile] = push( stacklist[otherPile] , top(stacklist[fromPile]))
    stacklist[fromPile] = pop(stacklist[fromPile])
    animate_move(stacklist, fromPile , otherPile)

def towerOfHannoi(fromPile, toPile, otherPile, stackList, N ):
    """
    Preconditions: takes in two stacks as well as the number of disk
    Postcondition: exicutes the animaitons and solves the tower of hannoi
    """
    global moves
    if N==1:

        mover( fromPile, toPile, stackList)
        moves += 1
        
    else:
        
        towerOfHannoi(fromPile, toPile, otherPile, stackList, N-1)
        
        mover( fromPile, otherPile, stackList)
        
        towerOfHannoi(toPile, otherPile, fromPile, stackList, N-1)
        moves += 1

    
def main():
    """
    Main is the function that collections all the other funcitons and sets them up in proper order in order to exicute
    """
    moves = 0
    disk = int(input("Enter number of disks: "))
    fromPile = None
    toPile = None
    otherPile = None
    for i in range(disk , 0, -1 ):
        fromPile = push(fromPile , i)
    stackList = [ fromPile , None , None ]
    
    animate_init(disk)
    
    towerOfHannoi(fromPile, toPile, otherPile, stackList, disk)

    print("Total number of moves: ", moves)
    input("Press enter to quit...")
    animate_finish()

main()
