"""
Stack implementation using Node class and
using None to indicate the bottom of the stack.

file:  myStack.py
"""

from myNode import *
    
def push(node, element):
    """Add an element to the top of the stack"""
    newnode = Node(element, node)
    return newnode
    
def top(node):
    """Return top element on stack.  Does not change stack"""
    if emptyStack(node):
        raise IndexError("top on empty stack") 
    return node.data

def pop(node):
    """Remove the top element in the stack.  Returns new top"""
    if emptyStack(node):
        raise IndexError("pop on empty stack") 
    return node.next
    
def emptyStack(node):
    """Is the stack empty?"""
    return node == None

def size(node):
    """Return the # of elements including this node"""
    if emptyStack(node):
        return 0
    else:
        return 1 + size(node.next)
