"""
Program to demonstrate usage of stacks and queues
via simulation of movie 'Predator'.

file:  choppa.py
"""

from random import *
from cavern import *
from bridge import *
from rit_object import *

def GET_PREDATOR_HITPOINTS():
    return randint(1000, 2000)
       
class Predator(rit_object):
    __slots__ = ('hitPoints')
    _types    = (int)
    
def GET_SOLDIER_HITPOINTS():
    return randint(100, 200)
    
def GET_SOLDIER_WEIGHT():
    return randint(150, 300)
        
class Soldier(rit_object):
    __slots__ = ('name', 'hitPoints', 'weight')
    _types    = (str,    int,         int     )
    
def createSoldier(id):
    name = "Red Shirt #" + str(id)
    hitPoints = GET_SOLDIER_HITPOINTS()
    weight = GET_SOLDIER_WEIGHT()
    return Soldier(name, hitPoints, weight)
    
def welcome():
    print("Predator v1.0")
    print("-------------")
    print("Welcome to the jungle.  Dutch, get your men to da choppa!")

def endingCredits(predator, survivors, brokeBridge):
    if predator.hitPoints > 0:
        print("The predator, with", predator.hitPoints,
            "hit points remaining, claims victory!")
    elif survivors.size > 0:
        print(str(survivors.size), "soldiers reach da choppa", end = '')
        if brokeBridge:
            print(" before the bridge collapses!")
        else:
            print("!")
        while not emptyQueue(survivors):
            soldier = front(survivors)
            dequeue(survivors)
            print(soldier.name, ", with", soldier.hitPoints,
                "hit points remaining, boards da choppa!")
        print("And da choppa flies away to safety!")
    else:
        print("Da choppa waits, but nobody comes...")
    print("THE END.")
    
def main():
    # spawn the predator!
    predator = Predator(GET_PREDATOR_HITPOINTS())
    print("The predator spawns somewhere in the jungle with", 
        predator.hitPoints, "hit points...")
        
    # create the soldiers and push them into the cavern
    numSoldiers = int(input("How many soldiers? "))
    cavern = None
    for id in range(1, numSoldiers+1):
        soldier = createSoldier(id)
        print("Soldier", soldier.name, "with", soldier.hitPoints,
            "hit points and", soldier.weight, "weight, enters the cavern...")
        cavern = push(cavern, soldier)
        
    # get to the choppa!
    cavern = surviveTheCavern(predator, cavern)

    # return  # use to only run first part of simulation

    survivors = Queue(None, None, 0)
    if (size(cavern) > 0):
        input("Hit enter to continue...")
        brokeBridge = crossTheBridge(cavern, survivors)
    else:
        brokeBridge = False

    endingCredits(predator, survivors, brokeBridge)
   
main()
