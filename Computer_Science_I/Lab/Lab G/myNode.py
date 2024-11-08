"""
A Node class containing a data slot and a next slot.

Note that with rit_object, a class having a slot of the same
type as the class itself uses the name of the class as a string
to indicate the type of that slot.

file: myNode.py
"""

from rit_object import *

class Node(rit_object):
    __slots__ = ('data', 'next')
    _types    = (object, 'Node')
    
