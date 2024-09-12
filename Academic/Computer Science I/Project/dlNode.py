"""
============================== PROJECT SUPPLIED CODE =====================
File: dlNode.py
Purpose: rit_object based double linked node for CS1 project.
Author: ben k steele <bks@cs.rit.edu>
Language: Python 3
Description:  A representation of a double linked node intended
for use as the building block for a double-linked list.
"""

from rit_object import *

###########################################################
# NODE CLASS DEFINITIONS
###########################################################

class Node( rit_object ):
    """
       Slots of a double linked node structure
       data: an object reference allows any kind of element
       next: either a Node reference or None
    """
    # syntax is rit_object version 2.5b
    __slots__ = ( 'data', 'next', 'prev' )
    _types    = ( object, "Node", "Node" )

def test_node():
    """
    test_node tests the {NoneType, Node} type constructions
    """
    EMPTY = None

    node1 = Node( 'first', EMPTY, EMPTY )
    print( node1.data == 'first' and node1.next == None and node1.prev == None )

    node2 = Node( 'two', EMPTY, EMPTY )
    # linking 2 nodes together takes 2 steps
    node1 = Node( 'one', node2, EMPTY )
    node2.prev = node1

    print( node1.data == 'one' )
    print( node1.next == node2 )
    print( node2.prev == node1 )
    print( isinstance( node1.next, Node ) )
    print( isinstance( node1.prev, NoneType ) )
    print( node1.next.data == 'two' )
    print( node1.next.next == None )
    print( node1.next.prev == node1 )
    print( node2.prev.data == 'one' )
    print( node2.prev.prev == None )


if __name__ == "__main__":
    test_node()

