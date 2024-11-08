"""
File: slList.py
Purpose: rit_object-based single-linked list for CS141 LECTURE.
Author: ben k steele <bks@cs.rit.edu>
Author: sean strout <sps@cs.rit.edu>
Language: Python 3
Description: Implementation of a single-linked list data structure.
"""

from slNode import *    # and by extension, rit_object

###########################################################
# LINKED LIST CLASS DEFINITION                                
###########################################################

class SlList( rit_object ):
    """
       A class that encapsulates a node-based linked list
       The head is the first node in the linked structure.
    """
    __slots__ = ( 'head', 'size' )
    _types    = ( object, int )

###########################################################
# LINKED LIST CLASS CONSTRUCTOR                                
###########################################################

def createList():
    """
       Constructs and returns an empty list.
       Parameters:
           None
       Returns: 
           An empty list
    """

    lst = SlList( None, 0 )
    return lst

###########################################################
# LINKED LIST FUNCTIONS                                
###########################################################

def clear( lst ):
    """
       Make a list empty.
       Parameters:
           lst ( SlList ) - the linked list
       Returns:
           None
    """

    lst.head = None
    lst.size = 0

def toString( lst ):
    """
       Converts the linked list into a string that
       looks like a list printed by Python. 

       Parameters:
           lst ( SlList ) - The linked list
       Returns:
           A string representation of the list ( e.g. '[1, 2, 3]' )
    """

    result = '['
    curr = lst.head
    while not curr == None :
        if curr.next == None :
            result +=  str( curr.data )
        else:
            result += str( curr.data ) + ', ' 
        curr = curr.next
    result += ']'

    return result

def append( lst, value ):
    """
       Add a node containing the value to the end of the list. 

       Parameters:
           lst ( SlList ) - The linked list
           value ( any type ) - The data to append to the end of the list
       Returns:
           None
    """

    if lst.head == None :
        lst.head = Node( value, None )
    else:
        curr = lst.head
        while curr.next != None :
            curr = curr.next
        curr.next = Node( value, None )
    lst.size += 1

def insertAt( lst, index, value ):
    """
       Insert a new element before the index.

       Parameters:
           lst ( SlList ) - The list to insert value into
           index ( int ) - The 0-based index to insert before
           value ( any type ) - The data to be inserted into the list
       Preconditions:
           0 <= index <= lst.size, raises IndexError exception
       Returns:
           None
    """

    if index < 0 or index > lst.size:
        raise IndexError( str( index ) + ' is out of range.' )

    if index == 0:
        lst.head = Node( value, lst.head )
    else:
        prev = lst.head
        while index > 1:
            prev = prev.next
            index -= 1
        prev.next = Node( value, prev.next )

    lst.size += 1

def get( lst, index ):
    """
       Returns the element that is at index in the list.

       Parameters:
           lst ( SlList ) - The list to insert value into
           index ( int ) - The 0-based index to get   
       Preconditions:
           0 <= index < lst.size, raises IndexError exception   
       Returns:
           value at the index
    """

    if index < 0 or index >= lst.size:
        raise IndexError( str( index ) + ' is out of range.' )

    curr = lst.head
    while index > 0:
        curr = curr.next
        index -= 1
    return curr.data

def set( lst, index, value ):
    """
       Sets the element that is at index in the list to the value.

       Parameters:
           lst ( SlList ) - The list to insert value into
           index ( int ) - The 0-based index to set
           value ( any type )   
       Preconditions:
           0 <= index < lst.size, raises IndexError exception   
       Returns:
           None
    """

    if index < 0 or index >= lst.size:
        raise IndexError( str( index ) + ' is out of range.' )

    curr = lst.head
    while index > 0:
        curr = curr.next
        index -= 1
    curr.data = value

def pop( lst, index ):
    """
       Remove and return the element at index.

       Parameters:
           lst ( SlList ) - The list from which to remove
           index ( int ) - The 0-based index to remove   
       Preconditions:
           0 <= index < lst.size, raises IndexError exception   
       Returns:
           The value ( any type ) being popped
    """

    if index < 0 or index >= lst.size:
        raise IndexError( str( index ) + ' is out of range.' )

    if index == 0:
        value = lst.head.data
        lst.head = lst.head.next
    else:
        prev = lst.head
        while index > 1:
            prev = prev.next
            index -= 1
        value = prev.next.data
        prev.next = prev.next.next

    lst.size -=1
    return value

def index( lst, value ):
    """
       Returns the index of the first occurrence of a value in the list

       Parameters:
           lst ( SlList ) - The list to insert value into
           value ( any type ) - The data being searched for 
       Preconditions:
           value exists in list, otherwise raises ValueError exception
       Returns:
           The 0-based index of value
    """

    pos = 0
    curr = lst.head
    while not curr == None :
        if curr.data == value:
            return pos

        pos += 1
        curr = curr.next

    raise ValueError( str( value ) + " is not present in the list" )



########################################################################################

def linkSort( lst ):
    """
       Sorts a Linked list in ascending order

       Parameters:
           lst ( SlList ) - The list to insert value into
           value ( any type ) - The data being searched for 
       Preconditions:
           value exists in list, otherwise returns none
       Returns:
           A list, in new order


    """
    if lst == None:
        return None
    i=0
    head = lst.head
    
    while i < lst.size:
        n = 0
        currentNode = head.next
        
        while n < lst.size:
            if  currentNode != None and currentNode.data < head.data:
                tempHead = head.data
                tempNode = currentNode.data
                nodeIndex = index(lst, tempHead)
                headIndex = index(lst, tempNode)
                set(lst, headIndex, tempHead)
                set(lst, nodeIndex, tempNode)
            n += 1
            if currentNode != None:    
                currentNode = currentNode.next
        head = head.next
        i+=1
        print(toString(lst))

    return lst

