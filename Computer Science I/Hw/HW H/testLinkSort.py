from rit_object import *
from slList import *

"""
    file: testLinkSort.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: takes document, puts integers into list, sorts list in ascending order.
"""



def readFile(filename):
    """
    preconditions: takes in file name
    postconditions: opens file and sorts the items in file.
    """
    lst = createList()
    openFile = open(filename)
    if openFile == None:
        print("there is nothing here")
        return
    for i in openFile:
        append(lst, int(i))
    
    return lst


def main():
    """Input String -> String
       Recives input from user and calls the inputs.
    """
    fileName = input("Enter the name of the the file: ")
    unSortedLst = readFile(fileName)
    print("The unsorted list is: ", end="")
    print(toString(unSortedLst))
    sortedLst = linkSort(unSortedLst)
    print("the sorted list is: ", end="")
    print(toString(sortedLst))

main()
    
