#!/usr/local/bin/python3
"""
============================== PROJECT SUPPLIED CODE =====================
File: testdllist.py
Author: ben k steele <bks@cs.rit.edu>
Author: [UPDATED BY] Joel Yuhas jxy8307@g.rit.edu
Language: Python 3
Description:  A test module for the linked list data structure, DlList.
"""
from dlList import *
# see main() for imports of the module.

# tests for double-linked list. use as needed for development
def testDoubleLinks( module ) :

    print("\nTesting double links...")
    lstA =  module.createList()
    print( "# more double-linked list tests. use as needed for development." )
    print()

# tests for iterator
def testIterator( module ) :
    print("\nTesting iterator...")
    print("-------------------------------------------------------")
    print("function calls diffrent areas of the nodes, which is why")
    print("there is the descrepancy in some of the True/False values")
    print("-------------------------------------------------------")
    lstA =  module.createList()
    print("size 0 list iteration:", end='\n')
    iter = module.itr_create( lstA, 0 )
    print( module.itr_is_valid( iter ) == True, end=' ')
    print( module.itr_has_next( iter ) == False, end=' ')
    print( module.itr_has_prev( iter ) == False, end=' ')
    print( "(4)", "list tested:", module.toString( lstA ) )

    module.append(lstA, 'a')
    print("size 1 list iteration:", end='\n')

    iter = module.itr_create( lstA )
    print( module.itr_is_valid( iter ) == True, end=' ')
    print( module.itr_has_next( iter ) == True, end=' ')
    print( module.itr_fetch( iter ) == 'a', end=' ')
    print( module.itr_has_next( iter ) == True, end=' ')
    print( "(5)", "list tested:", module.toString( lstA ) )

    print( module.itr_fetch( iter ) == 'a', end=' ' )
    print( module.itr_next( iter ) == 'a', end=' ' )
    print( module.itr_has_next( iter ) == False, end=' ') # went past
    print( module.itr_has_prev( iter ) == True, end=' ')  # can go back
    print( module.itr_prev( iter ) == 'a', end=' ')
    print( "(10)", 'fetched: ', module.itr_fetch( iter ) )

    print( module.itr_has_prev( iter ) == False, end=' ')
    print( module.itr_has_next( iter ) == True, end=' ')
    print( module.itr_next( iter ) == 'a', end=' ')
    print( module.itr_has_next( iter ) == False, end=' ')
    print( module.itr_prev( iter ) == 'a', end=' ')
    print( "(15)" )
    # invalidate the iterator and check the error in attempt to use
    module.append(lstA, 'b')
    try:
        # almost any iterator function will do here...
        module.itr_has_prev( iter )
    except ValueError:
        pass # the expected exception happened

    print("size 2 and larger list iteration:", end='\n')
    
    print( module.itr_is_valid( iter ) == False, end=' ')
    # reset to the last item in the list 'b'
    module.itr_reset( iter, 1 ) 
    print( module.itr_has_next( iter ) == True, end=' ')
    print( module.itr_has_prev( iter ) == True, end=' ')
    print( module.itr_prev( iter ) == 'a', end=' ')
    print( module.itr_next( iter ) == 'a', end=' ')
    print( "(20)" )
    print( module.itr_has_prev( iter ) == True, end=' ')
    print( module.itr_has_next( iter ) == True, end=' ')
    print( module.itr_next( iter ) == 'b', end=' ')
    print( module.itr_has_next( iter ) == False, end=' ')
    print( "(24)", "list tested:", module.toString( lstA ) )

    module.clear(lstA)
    count = 5
    for i in range( 1, count+1 ):
        module.append(lstA, i)
    print( "list for next test:", module.toString( lstA ) )
    print('iterating back to front order using itr_prev function:')
    print("-------------------------------------------------------")
    print("5 will not be present because the function returns prev")
    print("value, not current one")
    print("-------------------------------------------------------")
    # reset to after the last item in the list
    iter = module.itr_create( lstA, lstA.size )
    while module.itr_has_prev( iter ):
        print( module.itr_prev( iter ), end=' ' )
    print()
    iter = module.itr_create( lstA, 0 )
    print('iterating front to back order using itr_next function:')
    print('iterating back to front order using itr_prev function:')
    print("-------------------------------------------------------")
    print("5 will not be present because the function returns next")
    print("value, not current one")
    print("-------------------------------------------------------")
    while module.itr_has_next( iter ):
        print( module.itr_next( iter ), end=' ' )
    print()

    print('checking iterator validity under inserts and deletions...')
    module.itr_reset( iter, 3 ) 
    print( module.itr_is_valid( iter ) == True, end=' ')
    index = 3
    print('deleting element at index:', index, 'value:', module.get( lstA, index ) )
    module.pop( lstA, index )
    print( module.itr_is_valid( iter ) == False, end=' ')
    module.itr_reset( iter ) 
    print( module.itr_is_valid( iter ) == True, end=' ')
    print( 'first element:', module.itr_next( iter ), end=' ' )
    index = 1
    print('inserting "b" at index', index )
    module.insertAt(lstA, index, 'b')
    print( module.itr_is_valid( iter ) == False, end=' ')
    module.itr_reset( iter, 1 ) 
    print( 'element:', module.itr_next( iter ), end=' ' )
    print()
    print( "ending list:", module.toString( lstA ) )


def testStressAppendAndToString( module ):
    print("\nSTRESS Testing append, pop and toString...")
    lstA =  module.createList()
    progress = 1000
    for i in range( 0, 3000 ):
        if (i + 1) % 1000 == 0:
            print('progress:', progress, '...')
            progress += 1000
        if lstA.size != i: print( False, end='')
        module.append(lstA, i)
    print()
    print('popping:...')
    while lstA.size > 200 :
        module.pop(lstA, 0)
        if lstA.size % 1000 == 0 :
            print('still popping; size is:', lstA.size, '...')
    print("data :")
    print( module.toString(lstA) )
    print()

def testAppendAndToString( module ):
    print("\nTesting append and toString...", end=" ")
    lstA =  module.createList()
    print( lstA.size == 0, end=' ')
    print( module.toString(lstA) == '[]', end=' ')
    module.append(lstA, 'a')
    print( lstA.size == 1, end=' ')  
    print( module.toString(lstA) == '[a]', end=' ')
    module.append(lstA, 'b')
    print( module.toString(lstA) == '[a, b]', end=' ')
    print( lstA.size == 2, end=' ')    
    module.append(lstA, 'c')
    print( module.toString(lstA) == '[a, b, c]', end=' ')
    print()
    print( module.toString(lstA) )
    
def testClear( module ):
    print( "\nTesting clear...", end=" ")
    lstA = module.createList()
    module.clear(lstA)
    print( lstA.size == 0, end=' ')
    print( module.toString(lstA) == '[]', end=' ')
    print()
         
def testInsert( module ):
    print( "\nTesting insert...", end=" ")
    lstA = module.createList()
    try:
        module.insertAt(lstA, -1, 'z')
    except IndexError:
        pass
    module.insertAt(lstA, 0, 'b')
    print( lstA.size == 1, end=' ')
    print( module.toString(lstA) == '[b]', end=' ')
    module.insertAt(lstA, 1, 'd')
    print( lstA.size == 2, end=' ')
    print( module.toString(lstA) == '[b, d]', end=' ')
    module.insertAt(lstA, 1, 'c') 
    print( lstA.size == 3, end=' ')
    print( module.toString(lstA) == '[b, c, d]', end=' ')
    module.insertAt(lstA, 0, 'a')
    print( lstA.size == 4, end=' ')
    print( module.toString(lstA) == '[a, b, c, d]', end=' ')
    module.insertAt(lstA, 4, 'e')
    print( lstA.size == 5, end=' ')
    print( module.toString(lstA) == '[a, b, c, d, e]', end=' ') 
    try:
        module.insertAt(lstA, 6, 'z')
    except IndexError:
        pass    
    print()
        
def testGet( module ):
    print( "\nTesting get...", end=" ")
    lstA = module.createList()
    try:
        module.get(lstA, 0)
    except:
        pass
    print( lstA.size == 0, end=' ')
    for ch in ['a','b','c','d']:
        module.append(lstA, ch)
    print( module.get(lstA, 0) == 'a', end=' ')
    print( module.get(lstA, 1) == 'b', end=' ')
    print( module.get(lstA, 2) == 'c', end=' ')
    print( module.get(lstA, 3) == 'd', end=' ')
    print( lstA.size == 4, end=' ')
    try:
        module.get(lstA, 4)
    except:
        pass    
    print()
           
def testSet( module ):
    print( "\nTesting set...", end=" ")
    lstA = module.createList()
    try:
        module.set(lstA, 0, 'z')
    except IndexError:
        pass
    module.append(lstA, 'a')
    module.set(lstA, 0, 'z')
    print( lstA.size == 1, end=' ')
    print( module.toString(lstA) == '[z]', end=' ')
    lstA = module.createList()
    for ch in ['a','b','c','d','e','f']:
        module.append(lstA, ch)        
    module.set(lstA, 0, 'x')
    module.set(lstA, 2, 'y')
    module.set(lstA, 5, 'z')
    print( lstA.size == 6, end=' ')
    print( module.toString(lstA) == '[x, b, y, d, e, z]', end=' ')     
    try:
        module.set(lstA, 6, 'z')
    except IndexError:
        pass
    print()
    
def testPop( module ):
    print( "\nTesting pop...", end=" ")
    lstA = module.createList()
    try:
        module.pop(lstA, 0)
    except IndexError:
        pass
    module.append(lstA, 'a')
    print( module.pop(lstA, 0) == 'a', end=' ')
    print( lstA.size == 0, end=' ')

    for ch in ['a','b','c','d','e','f']:

        module.append(lstA, ch)
    print( module.pop(lstA, 0) == 'a', end=' ')
    print( lstA.size == 5, end=' ')
    print( module.toString(lstA) == '[b, c, d, e, f]', end=' ')
    print( module.pop(lstA, 1) == 'c', end=' ')           
    print( lstA.size == 4, end=' ')
    print( module.toString(lstA) == '[b, d, e, f]', end=' ')
    print( module.pop(lstA, 3) == 'f', end=' ') 
    print( lstA.size == 3, end=' ')
    print( module.toString(lstA) == '[b, d, e]', end=' ')
    try:
        module.pop(lstA, 3)
    except IndexError:
        pass
    print()
          
def testIndex( module ):
    print( "\nTesting index...", end=" ")
    lstA = module.createList()
    try:
        module.index(lstA, 0)
    except:
        pass
    module.append(lstA, 'a')
    print( module.index(lstA, 'a') == 0, end=' ')
    print( lstA.size == 1, end=' ')
    for ch in ['b','c','d','a','b']:
        module.append(lstA, ch)
    print( module.index(lstA, 'a') == 0, end=' ')
    print( module.index(lstA, 'b') == 1, end=' ')
    print( module.index(lstA, 'c') == 2, end=' ')
    print( module.index(lstA, 'd') == 3, end=' ')
    print( lstA.size == 6, end=' ')
    try:
        module.index(lstA, 6)
    except:
        pass
    print()


    

def main():
    """
    main asks user to choose between
    tests using iterative and recursive linked list modules.
    """
    import dlList 
    listmodule = dlList

    testAppendAndToString( listmodule )
    testClear( listmodule )
    testInsert( listmodule )
    testGet( listmodule )
    testSet( listmodule )
    testPop( listmodule )
    testIndex( listmodule )
    # tests for double-linked list
    testDoubleLinks( listmodule )
    # tests for iterator
    testIterator( listmodule )
    testStressAppendAndToString( listmodule )
    print()
    
# main is the tester.
if __name__ == "__main__":
    main()
