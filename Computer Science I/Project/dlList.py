"""
File: dlList.py
Purpose: rit_object-based double-linked list for CS141 project.
Author: ben k steele <bks@cs.rit.edu>
Author: Joel Yuhas jxy8307@g.rit.edu
Language: Python 3
Description: Implementation of a double-linked list data structure.
"""

from dlNode import *    # and by extension, rit_object


#==========================================================================
#===================== LINKED LIST CLASS DEFINITION =======================
#==========================================================================                               


class DlList( rit_object ):
    """
       A class that encapsulates a node-based linked list
       The head is the first node in the linked structure.
    """
    __slots__ = (  'size', 'next', 'generation' )
    _types    = (  int, object, int )

class Iter(rit_object):
    """
    A class that creates an iterator which will be used
    for the funcitons.
    """
    __slots__ = ( 'node', 'generation', 'lst' )
    _types    = ( object, int, object )


#==========================================================================
#===================== LINKED LIST CLASS CONSTRUCTOR ======================
#==========================================================================                            


def createList():
    """
       createList: None -> DlList
       creates and returns a empty starter list
    """

    lst = DlList( 0, None, 0 )
    return lst


#==========================================================================
#======================== LINKED LIST FUNCTIONS ===========================
#==========================================================================                                


def clear( lst ):
    """
       clear: DlList -> clear DlList
       clears the given DlList
    """
    
    lst.size = 0
    lst.next = None
    lst.generation = 0

def toString( lst ):
    """
       toString DlList -> String
       takes the items in the DlList and converts them to a
       continouse String
    """
    
    result = '['
    curr = lst.next
    while not curr == None :
        if curr.next == None :
            result +=  str( curr.data )
        else:
            result += str( curr.data ) + ', ' 
        curr = curr.next
    result += ']'

    return result

def append( lst, value ): ### UPDATES GENERATION
    """
       append: DlList + value -> DlList with value
       takes in a DlList and value and adds the value in the
       correct position while also ensureing that the
       next and prev values are correct
    """
    
    if lst.next == None:
        lst.next = Node( value, None, None)  
    else:
        curr = lst
        while curr.next != None:
                curr = curr.next
        curr.next = Node( value, None, curr )
    lst.size += 1
    lst.generation += 1

def insertAt( lst, index, value ): ### UPDATES GENERATION
    """
       insertAt: DlList + index + value -> DlList with value
       located in correct position
       takes in a DlList that is to be modified and the position
       of the value and puts it in there
    """
    if index < 0:
        return
    elif  index > lst.size:
        append(lst, value)

    elif index == 0:
        nexter = lst.next
        lst.next = Node( value, nexter, None)
        if nexter != None:
            nexter.prev = lst.next
    else:
        prev = lst.next
        while index > 1:
            if prev.next != None:
                prev = prev.next
                index -= 1
        if prev.next != None:
            nexter = prev.next
            prev.next = Node( value, nexter, prev )
            nexter.prev = prev.next
        else:
            nexter = prev.next
            prev.next = Node( value, nexter, prev )

    lst.size += 1
    lst.generation +=1

def get( lst, index ):
    """
       get: DlList + index -> Node
       searches DlList for index and returns that Nodes data
    """

    if index < 0 or index >= lst.size:
        raise IndexError( str( index ) + ' is out of range.' )

    curr = lst.next
    while index > 0:
        curr = curr.next
        index -= 1
    return curr.data

def set( lst, index, value ):
    """
       set: lst + index + value -> updated DlList with
       new value
       takes in DlList as well as an index and swaps index's
       value for the new one
    """

    if index < 0 or index >= lst.size:
        raise IndexError( str( index ) + ' is out of range.' )

    curr = lst.next
    while index > 0:
        curr = curr.next
        index -= 1
    curr.data = value

def pop( lst, index ): #### UPDATES GENERATION
    """
       pop: DlList + index -> DlList with removed item
       removes Node positiend at index
    """

    if index < 0 or index >= lst.size:
        raise IndexError( str( index ) + ' is out of range.' )

    if index == 0:
        value = lst.next.data
        lst.next = lst.next.next
        if lst.next != None:
            lst.next.prev = None
    else:
        prev = lst.next
        while index > 1:
            prev = prev.next
            index -= 1
        if prev.next.next != None:
            value = prev.next.data
            prev.next = prev.next.next
            prev.next.prev = prev
        else:
            value = prev.next.data
            prev.next = prev.next.next
           

    lst.size -=1
    lst.generation += 1
    return value

def index( lst, value ):
    """
       index: lst + value -> int
       takes in the DlList and a value and searches list
       for that value
    """

    pos = 0
    curr = lst.next
    while not curr == None :
        if curr.data == value:
            return pos

        pos += 1
        curr = curr.next

    raise ValueError( str( value ) + " is not present in the list" )


#==========================================================================
#============================= ITERATOR CODE ==============================
#==========================================================================

              

def isEmpty( lst ):
    """
       isEmpty: DlList -> Boolean
       takes in a DlList and checks to see if it is empty
    """
    
    if lst.next == None:
        return True
    else:
        return False


def itr_create( lst, index = 0 ):
    """
       itr_create: DlList + index -> iterator
       creates an iterator and puts it at the specified position
    """
    
    Iter.lst = lst
    curr = lst.next
    if index == 0:
        Iter.node = curr
        Iter.generation = lst.generation
    else:
        while index > 0:
            if curr.next != None:
                curr = curr.next
            index -= 1
        Iter.node = curr
        Iter.generation = lst.generation
    return Iter

   
def itr_reset( iter, index = 0):
    """
       itr_reset: Iter + index -> new Iter
       updates the Iter to make sure that its genearation
       is the same as the list it is referenced to
    """
    
    curr = iter.lst.next
    if index == None:
        print('wat')
    elif index == 0:
        iter.node = curr
    else:
        while index > 0:
            if curr.next != None:
                curr = curr.next
            index -= 1
        iter.node = curr
    iter.generation = iter.lst.generation
    return iter
    

def itr_is_valid( iter ):
    """
       itr_is_valid: Itrer -> Boolean
       checks to see if the Iter is valid, meaning that its
       generation matches the generation of the list it is
       being refered to
    """
    
    if iter.generation == iter.lst.generation:
        return True
    else:
        return False


def itr_has_next( iter ):
    """
       itr_has_next: Iter -> Boolean
       checks the current Iter to see if there is a next value
    """
    
    if iter.generation != iter.lst.generation:
        iter_reset(iter,0)
    elif iter.node == None:
        return False
    else:
        if iter.node.next == None:
            return False
        else:
            return True

    
def itr_has_prev( iter ):
    """
       itr_has_prev: Iter -> Iter -> Boolean
       checks the current Iter to see if there is a prev value
    """
    
    if iter.node == None:
        return False
    elif iter.node.prev == None:
        return False
    elif iter.node.prev.data != None:
        return True
    else:
        return False

    
def itr_fetch( iter ):
    """
       itr_fetch: Iter -> False/Data
       checks to see if there is a correct value that can be
       obtained and then obtains the value the iterator is
       referencing 
    """
    
    if iter.node == None:
        return False
    else:
        return iter.node.data

   
def itr_next( iter ):
    """
       itr_next: Iter -> next Iter
       updates the Iter so that it now refers to the next Iter
    """
    
    if iter.node == None:
        return False
    else:
        curr = iter.node.data
        iter.node = iter.node.next
        return curr
    

def itr_prev( iter ):
    """
       itr_prev: iter -> prev Iter
       updates the Iter so that it now referes to the prev Iter
    """
    
    if iter.node == None:
        return False
    else:
        curr = iter.node.prev.data
        iter.node = iter.node.prev
        return curr


#############################################################################
############################ UTILITY FUNCITON ###############################

    
def printer( head ):
    """
       printer: DlList -> printed values
       A utility function that is used only during testing and
       development, prints all the data values of the nodes in
       the DlList as well as their next and prev values and how
       they relate to eachother
    """
    
    if isinstance(head, DlList) == True:
        print( "size: " + str(head.size) )
        print( head.next)
        print( "generation: " + str(head.generation))
        print()
        while head.next != None:
            head = head.next
            print("data: " + str(head.data) )
            if head.next != None:
                print("next: " + str(head.next.data) )
            if head.prev != None:
                print( "prev: " + str(head.prev.data))
            print()
    elif isinstance(head,dlNode) == True:
        print("ASDFDSFASDFASFSDFASF")
        print( "data: " + head.node.data )
        print( "next: " + str(head.node.next.data) )
        if head.node.prev != None:
            print( "prev: " + str(head.node.prev.data) )
        else:
            print( "prev: " + str(None) )
        print( "generation: " + str(head.generation) )
        print( head.lst )
