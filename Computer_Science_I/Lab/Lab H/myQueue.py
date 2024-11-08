"""
A queue class. None is used to indicate the back of the queue
(as well as the front of an empty queue).

file: myQueue.py
"""

from myNode import *

class Queue(rit_object):
    """
    object is specified as the type of the 'front' and
    'back' slots so that either None or a Node object
    can be used as valid assignments.
    """
    __slots__ = ( 'front', 'back', 'size' )
    _types    = ( object,  object, int    )

def createQueue():
    """make an empty Queue and return it"""
    return Queue( None, None, 0 )

def enqueue(queue, element):
    """Insert an element into the back of the queue"""
    newnode = Node(element, None)
    if emptyQueue(queue):
        queue.front = newnode
    else:
        queue.back.next = newnode
    queue.back = newnode
    queue.size += 1
    
def dequeue(queue):
    """Remove the front element from the queue (returns None)"""
    if emptyQueue(queue):
        raise IndexError("dequeue on empty queue") 
    queue.front = queue.front.next
    if emptyQueue(queue):
        queue.back = None
    queue.size -= 1
    
def front(queue):
    """Access and return the first element in the queue without removing it"""
    if emptyQueue(queue):
        raise IndexError("front on empty queue") 
    return queue.front.data
    
def back(queue):
    """Access and return the last element in the queue without removing it"""
    if emptyQueue(queue):
        raise IndexError("back on empty queue") 
    return queue.back.data
    
def emptyQueue(queue):
    """Is the queue empty?"""
    return queue.front == None
