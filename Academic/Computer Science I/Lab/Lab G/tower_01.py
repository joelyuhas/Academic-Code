from rit_object import * 
from tower_animate import *
 
moves = 0
def stacks(block):
   
    stack = None
 
    for i in range(block , 0 , -1):
        stack = push(stack , i)
    stacklist = [ stack , None , None ]
 

    return stacklist
 
def Hanoi(stack1 , stack2 , stack3 , remaining , stacklist):
 
    if remaining > 0:
        Hanoi( stack1, stack3, stack2, remaining-1 , stacklist)
 
        move( stack1 , stack3 , stacklist)
 
        global moves
 
        moves += 1
 
        Hanoi(stack2 , stack1 , stack3 , remaining-1 , stacklist)
 
def move(stack1, stack3, stacklist):
    stacklist[stack3] = push( stacklist[stack3] , top(stacklist[stack1]))
    stacklist[stack1] = pop(stacklist[stack1])
    animate_move(stacklist, stack1 , stack3)
 
def main():
    block = int(input("How many blocks in your Hanoi?: "))
    animate_init(block)
    stacklist = stacks(block)
    Hanoi( 0 , 1 , 2 , block , stacklist)
    print("Hanoi completed in ", moves, "moves.")
    input('Press any key to quit')
    animate_finish()
 
main()
