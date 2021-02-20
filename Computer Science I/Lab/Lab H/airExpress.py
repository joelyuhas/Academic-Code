from rit_object import *
from myPriorityQueue import *

"""
    file: airExpress.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that creats creates and exicutes a priority queue.
"""

class Passanger(rit_object):
    __slots__ = ( 'name', 'priority' )
    _types    = ( str, int)


def que(filename):
    """
    preconditions: takes in file name.
    postconditions: opens file and places the appropriate values into the queue, tied together by corresponding name and priority using the passanger class.
    """
    que = createPriorityQueue()
    openFile = open(filename)
    if openFile == None:
        print("there is nothing here")
        return
    if que == None:
        pass
        
    for item in openFile:
        for subItem in item.split():
            if subItem == "checkin":
                pass
            elif subItem.isdigit()==True:
                priority = int(subItem)
            else:
                name = subItem
        insert(que, Passanger(name, priority))
    return que

def queCombinder( keeper, adder ):
    """
    preconditions: Takes is two queues, the queue that is being added too, keeper, and the queue that will be added to the other queue, adder.
    postconditions: Returns a single queue with the adder items places into the back of the keeper queue. 
    """
    n=0
    size = adder.size
    while n < size:
        insert(keeper, front(adder))
        remove(adder)
        n+=1
    return keeper

def boarding(que):
    """
    preconditions: recives a single queue.
    postconditions: creates a seperate queue out of top elements on recived queue, continues to create seperate queue until hits a boarding value, from which it either boards the passangers or puts them into a left over queue.
    """
    bdQue = createPriorityQueue()
    loQue = createPriorityQueue()
    n=0
    size = que.size
    while n < size:
        if front(que).name == "board":
            leftOver = queExecutor( queOrginizer(bdQue), front(que).priority, 600)
            remove(que)
            w = 0
            loSize = leftOver.size
            while w < loSize:
                insert(loQue, front(leftOver))
                remove(leftOver)
                w+=1
        else:
            insert( bdQue, front( que ))
            remove(que)            
        n+=1
        queCombinder(bdQue, loQue)
    return queCombinder(bdQue, loQue)

def queOrginizer( que ):
    """
    preconditions: Recives unorginized queue.
    postconditions: Cycles through given queue, places highest value into second queue, continues until no more items are present in original queue. Returns sorted queue.
    """
    m=0
    orderedQue = createPriorityQueue()
    size = que.size
    while m < size:
        n=0
        tempQue = front(que)
        remove(que)
        while n < size:
            if que.size == 0:
                pass
            else:
                if front( que ).priority > tempQue.priority:
                    insert(que, tempQue)
                
                    tempQue = front(que)
                    remove(que)
                else:
                    insert(que,front(que))
                    remove(que)      
            n+=1
        insert(orderedQue, tempQue)
        m +=1
    return orderedQue

    
def queExecutor( que, loadNum, maxNum ):
    """
    preconditions:  recives queue, loading number, and maximum number.
    postconditions: takes items out of queue and either boards them or sets them aside based on their priority value.
    """
    print("Now boarding seats ", maxNum ," down to ", loadNum )
    size = que.size
    n=0
    while n < size:
        if front(que) == None:
            return que
        else:
            if front( que ).priority > loadNum-1: #minus for greater than or equal to board number
                if front( que).name == "board":
                    remove(que)
                else:
                    print( front(que).name, " is now boarding for seat ", front(que).priority)
                    remove(que)
            else:
                insert(que, front(que))
                remove(que)
        n+=1
    
    return que

def endSimulation(que):
    """
    preconditions: Recives queue with unboarded passangers.
    postconditions: Prints unboarded passangers, simulation over.
    """
    print("Gate is closed. (end of simulation)")
    m = 0
    size = que.size
    while m < size:
        if front(que).name != "board":
            print(front(que).name, " was left at the gate.")
            remove(que)
        else:
            remove(que)
        m+=1

    
def main():
    """
    Compilation of functions and exicution as well as calling for file input.
    """
    print("Air Express flight boarding simulation")
    file = input("Enter flight data file name: ")
    endSimulation(boarding(que(file)))
    
    

main()
