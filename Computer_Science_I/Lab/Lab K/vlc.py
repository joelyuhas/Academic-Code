import math
from rit_object import *
from array_heap import *

"""
    file: vlc.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: Program that uses heaps to minimize the amount
    of bits used to represent symbols in a given text file
"""

class Symbol(rit_object):
    """
    Creates the class Symbol which will be used to store name,
    frequency, and codeword
    """
    __slots__ = ('name', 'frequency', 'codeword')
    _types = (str, int, str)


class Node(rit_object):
    """
    Creates Node class, which will be used to store Symbols
    and thier cumilitive frequencies
    """
    __slots__ = ('symbolList', 'frequency')
    _types = (list, int)

#################### FOUR MAIN FUNCTIONS OF LAB ####################


def compareFunc( n1, n2 ):
    """
    compareFunc: Symbol + Symbol -> lesser Symbol
    Takes in two symbols and returns which one is less than
    the other
    """
    if n1.frequency < n2.frequency:
        return True
    else:
        return False


def fileReader( file ):
    """
    fileReader: file -> lst
    Takes in a file and converts the contents into a list of
    symbols and their correct frequencies
    """
    lst = []
    openFile = open(file)
    for line in openFile:
        for character in line.strip():
            if lst == None:
                lst.append(Symbol( character, 1, "" ))
            elif isIn( lst, character ) != 343434343434:
                index = isIn( lst, character )
                lst[index].frequency = lst[index].frequency + 1
            else:
                lst.append(Symbol( character, 1 ,""))
    return lst
                
                        
def codewordAlgorithm( heap ):
    """
    codeWordAlgorith: heap -> final heap
    Takes in a heap and returns an heap with all the Symbols
    containing the approriate codewords
    """
    while heap.size != 1:
        tempLst= []
        tempA = removeMin( heap )
        tempB = removeMin( heap )
        tempFrequency = tempA.frequency + tempB.frequency
        if isinstance(tempA, Symbol) == True and isinstance(tempB, Symbol) == True:
            tempA.codeword = '0' + tempA.codeword
            tempB.codeword = '1' + tempB.codeword
            #APPENDS
            tempLst.append(tempA)
            tempLst.append(tempB)
            
        elif isinstance(tempA, Node) == True and isinstance(tempB, Symbol) == True:
            nodeApplier( tempA, '0' )
            tempB.codeword = '1' + tempB.codeword
            #APPENDS
            nodeAdder( tempA, tempLst )
            tempLst.append(tempB)
            
        elif isinstance(tempA, Symbol) == True and isinstance(tempB, Node) == True:
            tempA.codeword = '0' + tempA.codeword
            nodeApplier( tempB, '1' )
            #APPENDS
            tempLst.append(tempA)
            nodeAdder( tempB, tempLst )
            
        elif isinstance(tempA, Node) == True and isinstance(tempB, Node) == True:
            nodeApplier( tempA, '0' )
            nodeApplier( tempB, '1' )
            #APPENDS
            nodeAdder( tempA, tempLst )
            nodeAdder( tempB, tempLst )

        
        add(heap,Node(tempLst, tempFrequency))
    
    return heap
    

def display( heap ):
    """
    display: heap -> output display
    Takes in the final heap and displays its values in correct format
    """
    noder = removeMin( heap )
    print("Variable Length Code Output")
    print("-----------------------------------")
    nodePrinter( noder )
    print('Average VLC codeword length: %3f bits per symbol' % VLC(noder))
    print("Average Fixed length codeword length: %3d bits per symbol" % fixedLength(noder))
            

######################## UTILITY FUNCTIONS ###############################
    
def isIn(lst, character):
    """
    isIn: lst + character -> True
    Takes in a list if Symbols and scans said list for the given character.
    Returns True if the character is present, returns a specialied integer
    if the value is False, this is becasue the index can be '0', which python
    will consider as false and may cause other functions to miss items at
    index 0
    """
    for i in lst:
        if i.name == character:
            return lst.index(i)
    return 343434343434

def heapCreate(lst):
    """
    heapCreate: lst -> heap
    Takes in a list and compiles all the entities of that list into a orginized
    heap
    """
    heap = createEmptyHeap( len(lst), compareFunc)
    
    while len(lst) != 0:
        lstItem = lst[0]
        lst.pop(0)
        add(heap, lstItem)   
    return heap

def nodeApplier( node, val ):
    """
    nodeApplier: node + val -> new codeword
    Takes a node and prepends the selected value onto all of the Symbols in
    that node
    """
    for i in node.symbolList:
             i.codeword = str(val) + i.codeword
             
def nodeAdder( node, lst ):
    """
    nodeAdder: node + lst -> lst
    Takes all the items from a node and adds its values to a predetermined list
    """
    for i in node.symbolList:
        lst.append(i)
    return lst

def nodePrinter( node ):
    """
    nodePrinter: node -> output print
    Prints the values of a node in a correct format
    """
    if isinstance(node, Node) == True:
        for i in node.symbolList:
            print('Symbol:  %2s ' % i.name, end='')
            print(' Codeword:  %8s' % i.codeword, end='')
            print('  Frequency:  %5d' % i.frequency)
            
    elif isinstance(node, Symbol) == True: #Only apparent if one value in file
        print('Symbol:  %2s ' % node.name, end='')
        print(' Codeword:  %8s' % node.codeword, end='')
        print('  Frequency:  %5d' % node.frequency)
            
def VLC( node ):
    """
    VLC: node -> average VLC codeword length
    takes the final node and computes the VLC codeword length
    """
    
    numberOfBits = 0
    numberOfSymbols = 0
    if isinstance(node, Node) == True:
        for i in node.symbolList:
            numberOfBits += len(i.codeword)*i.frequency
            numberOfSymbols += i.frequency
            
    elif isinstance(node, Symbol) == True: #Only apparent if one value in file
        numberOfBits += len(node.codeword)*node.frequency
        numberOfSymbols += node.frequency
        
    return numberOfBits/ numberOfSymbols

def fixedLength( node ):
    """
    fixedLength: node ->  fixed length calculation
    computes the fixed length calculation
    """
    numberOfSymbols = 0
    if isinstance(node, Node) == True:
        for i in node.symbolList:
            numberOfSymbols += 1
        q = math.log(numberOfSymbols, 2)
        
    elif isinstance(node, Symbol) == True: #Only apparent if one value in file
        q = 0
        
    return math.ceil(q)

##########################################################################


def main():
    """
    main file which compiles all nessesary functions in correct order
    """
    file = input("Please enter symbol filename: ")
    q = fileReader(file)
    w = heapCreate(q)
    x = codewordAlgorithm( w )
    y = display( x )
    
main()
