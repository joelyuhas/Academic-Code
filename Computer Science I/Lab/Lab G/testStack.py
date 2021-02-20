"""
Program to test stack implementation.  Assumes None is
used to indicate the bottom of (or an empty) stack.

file:  testStack.py
"""

from myStack import *
from rit_object import *

def main():
    # begin with an empty stack
    stackCh = None
    print("Creating empty stack...")
    print("Stack empty?", True == emptyStack(stackCh))
    
    # add first element
    print("push A...")
    stackCh = push(stackCh, 'A')
    print("Stack not empty?", False == emptyStack(stackCh))
    print("top is A?", 'A' == top(stackCh))
    
    # add second element
    print("push B...")
    stackCh = push(stackCh, 'B')
    print("top is B?", 'B' == top(stackCh))
    
    # add third element
    print("push C...")
    stackCh = push(stackCh, 'C')
    print("top is C?", 'C' == top(stackCh))
    
    # pop top element, C
    print("pop...")
    stackCh = pop(stackCh)
    print("Stack not empty?", False == emptyStack(stackCh))
    print("top is B?", 'B' == top(stackCh))
    
    # add fourth element
    print("push D...")
    stackCh = push(stackCh, 'D')
    print("top is D?", 'D' == top(stackCh))
    
        
    
main()
