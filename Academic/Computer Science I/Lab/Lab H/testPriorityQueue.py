from rit_object import *
from myPriorityQueue import *

"""
    file: testPriorityQueue.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that test PriorityQueue function and the funtions within it.
"""

class Patron(rit_object):
    __slots__ = ("name", "priority")
    _types = (str, int)

def main():
    """
    Contains lines of code to exicute and test the functions.
    """
    pq= createPriorityQueue()
    print("Creating Queue")
    print( "Is the queue empty?", emptyQueue(pq) == True)
    insert(pq, Patron("Fred", 5))
    print("Is front not Fred/5?",front(pq).name != "Fred" and front(pq).priority != 5)
    insert(pq, Patron("Wilma", 7))
    print( "Is front Wilma/7", front(pq).name == "Wilma" and front(pq).priority == 7)
    print("Is size 2?", 2 == pq.size)

    
    print("dumping the queue:")
    while not emptyQueue(pq):
        print(remove(pq))

        
    print( "Is the queue empty?", emptyQueue(pq) == True)
    print("Adding more elements")
    insert(pq, Patron("Snuffulufugus", 343))
    print("Is front Snuffulufugus/343?", front(pq).name == "Snuffulufugus" and front(pq).priority == 343)
    insert(pq, Patron("Shabalabadingdong", 434))
    print("Is front Winderwaberwaber/293?", front(pq).name == "Winderwaberwaber" and front(pq).priority == 293)
    insert(pq, Patron("Shabalabadingdong", 434))
    print("Is back Shabalabadingdong/434?", back(pq).name == "Shabalabadingdong" and back(pq).priority == 434)
    insert(pq, Patron("Shmidyeagermanjetson", 1))
    print("Is front not Shmidyeagermanjetson/1?", front(pq).name != "Shmidyeagermanjetson" and front(pq).priority != 1)
    print("Is size 4?", 4 == pq.size)
    remove(pq)
    print("Is Front Shabalabadingdong/434?", front(pq).name == "Shabalabadingdong" and front(pq).priority == 434)
    print("Is size 3?", 3 == pq.size)


    print("dumping the queue:")
    while not emptyQueue(pq):
        print(remove(pq))
    print( "Is the queue empty?", emptyQueue(pq) == True)  

    
        

main()
