#!/usr/local/bin/python3

"""
File: testList.py
Author: Sean Strout <sps@cs.rit.edu>
Contributor: ben k steele <bks@cs.rit.edu>
Language: Python 3
Description:  A test module for the linked list data structure, SlList.
"""

# see main() for imports of the module.

def testStressAppendAndToString( module ):
    print("STRESS Testing append, pop and toString...")
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
    print("Testing append and toString...", end=" ")
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
    
def testClear( module ):
    print( "Testing clear...", end=" ")
    lstA = module.createList()
    module.clear(lstA)
    print( lstA.size == 0, end=' ')
    print( module.toString(lstA) == '[]', end=' ')
    print()
         


def testInsert( module ):
    print( "Testing insert...", end=" ")
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
    print( "Testing get...", end=" ")
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
    print( "Testing set...", end=" ")
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
    print( "Testing pop...", end=" ")
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
    print( "Testing index...", end=" ")
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
    
def testClone( module ):
    print( "Testing clone...", end=" ")
    lstA = module.createList()
    lstB = None
    try:
        lstB = module.clone( lstA )
    except AttributeError:
        print( '\tclone function is not available.' )
        return
    print( lstA.size == 0, end=' ' )
    print( lstB.size == 0, end=' ' )
    print( module.toString( lstA ) == '[]', end=' ' )
    print( module.toString( lstB ) == '[]', end=' ' )
    module.append( lstA, 'a' )
    lstB = module.clone( lstA )
    print( lstA.size == 1, end=' ' )
    print( lstB.size == 1, end=' ' )
    print( module.toString( lstA ) == '[a]', end=' ' )
    print( module.toString( lstB ) == '[a]', end=' ' )
    module.append( lstA, 'b' )
    print( module.toString( lstA ) == '[a, b]', end=' ' )
    print( module.toString( lstB ) == '[a]', end=' ' )
    for ch in ['c','d','e','f']:
        module.append( lstA, ch )
    lstB = module.clone( lstA )
    print( lstA.size == 6, end=' ' )
    print( lstB.size == 6, end=' ' )
    print( module.toString( lstA ) == '[a, b, c, d, e, f]', end=' ' )
    print( module.toString( lstB ) == '[a, b, c, d, e, f]', end=' ' )
    module.remove( lstA, 'd' )
    module.remove( lstB, 'f' )
    print( module.toString( lstA ) == '[a, b, c, e, f]', end=' ' )
    print( module.toString( lstB ) == '[a, b, c, d, e]', end=' ' )
    print()

def testExtend(  module ):
    print( "Testing extend..." , end=" ")
    lstA = module.createList()
    lstB = module.createList()
    try:
        module.extend( lstA, lstB )
    except AttributeError:
        print( '\textend function is not available.' )
        return
    print( lstA.size == 0, end=' ' )
    print( lstB.size == 0, end=' ' )
    print( module.toString( lstA ) == '[]', end=' ' )
    print( module.toString( lstB ) == '[]', end=' ' )
    module.append( lstA, 'a' )
    module.extend( lstA, lstB)
    print( lstA.size == 1, end=' ' )
    print( lstB.size == 0, end=' ' )
    print( module.toString( lstA ) == '[a]', end=' ' )
    print( module.toString( lstB ) == '[]', end=' ' )
    lstA = module.createList()
    module.append( lstB, 'a' )
    module.extend( lstA, lstB)
    print( lstA.size == 1, end=' ' )
    print( lstB.size == 1, end=' ' )
    print( module.toString( lstA ) == '[a]', end=' ' )
    print( module.toString( lstB ) == '[a]', end=' ' )
    lstA = module.createList()
    lstB = module.createList()
    for ch in ['a','b','c','d']:
        module.append( lstA, ch)
    for ch in ['e','f','g']:
        module.append( lstB, ch)
    module.extend( lstA, lstB)
    print( lstA.size == 7, end=' ' )
    print( lstB.size == 3, end=' ' )
    print( module.toString( lstA ) == '[a, b, c, d, e, f, g]', end=' ' )
    print( module.toString( lstB ) == '[e, f, g]', end=' ' )
    module.remove( lstA, 'f' )
    module.remove( lstB, 'e' )
    print( lstA.size == 6, end=' ' )
    print( lstB.size == 2, end=' ' )
    print( module.toString( lstA ) == '[a, b, c, d, e, g]', end=' ' )
    print( module.toString( lstB ) == '[f, g]', end=' ' )
    print()

def testRemove( module ):
    print("Testing remove...", end=" ")
    lstA = module.createList()
    try:
        module.remove(lstA, 'z')
    except AttributeError:
        print( '\tremove function is not available.' )
        return
    except ValueError:
        pass
    module.append(lstA, 'a')
    module.remove(lstA, 'a')
    print(lstA.size == 0, end=' ')
    print(module.toString(lstA) == '[]', end=' ')
    module.append(lstA, 'a')
    module.append(lstA, 'a')
    module.remove(lstA, 'a')
    print(lstA.size == 1, end=' ')
    print(module.toString(lstA) == '[a]', end=' ')
    module.append(lstA, 'b')
    module.remove(lstA, 'b')
    print(lstA.size == 1, end=' ')
    print(module.toString(lstA) == '[a]', end=' ')
    for ch in ['a','b','c','d','a','b','c']:
        module.append(lstA, ch)
    module.remove(lstA, 'a')
    module.remove(lstA, 'c')
    module.remove(lstA, 'd')
    print(lstA.size == 5, end=' ')
    print(module.toString(lstA) == '[a, b, a, b, c]', end=' ')
    try:
        module.remove(lstA, 'z')
    except ValueError:
        pass
    print()

def testCount( module ):
    print( "Testing count...", end=" ")
    lstA = module.createList()
    try:
        print( module.count( lstA, 'a' ) == 0, end=' ' )
    except AttributeError:
        print( '\tcount function is not available.' )
        return
    print( lstA.size == 0, end=' ' )
    module.append( lstA, 'a' )
    print( module.count( lstA, 'a' ) == 1, end=' ' )
    print( lstA.size == 1, end=' ' )
    module.append( lstA, 'b' )
    print( module.count( lstA, 'b' ) == 1, end=' ' )
    print( lstA.size == 2, end=' ' )
    module.append( lstA, 'a' )
    print( module.count( lstA, 'a' ) == 2, end=' ' )
    print( lstA.size == 3, end=' ' )
    print( module.count( lstA, 'z' ) == 0, end=' ' )
    print( lstA.size == 3, end=' ' )
    print()

def testPyListToSlList( module ):
    print( "Testing pyListToSlList...", end=" ")
    try:
        print( module.toString(module.pyListToSlList([])) == '[]', end=' ')
    except AttributeError:
        print( '\tpyListToSlList function is not available.' )
        return
    print( module.toString(module.pyListToSlList(['a'])) == '[a]', end=' ')
    print( module.toString(module.pyListToSlList(['a','b'])) == '[a, b]', end=' ')
    print( module.toString(module.pyListToSlList(['a','b','c','d'])) == '[a, b, c, d]', end=' ')
    print()

def testSlListToPyList( module ):
    print( "Testing slListToPyList...", end=" ")
    lstA = module.createList()
    try:
        print( module.slListToPyList(lstA) == [], end=' ')
    except AttributeError:
        print( '\tslListToPyList function is not available.' )
        return
    module.append(lstA, 'a')
    print( module.slListToPyList(lstA) == ['a'], end=' ')
    module.append(lstA, 'b')
    print( module.slListToPyList(lstA) == ['a', 'b'], end=' ')
    for ch in ['c','d','e','f']:
        module.append(lstA, ch)
    print( module.slListToPyList(lstA) == ['a', 'b', 'c', 'd', 'e', 'f'], end=' ')
    print()
  

def main():
    """
    main asks user to choose between
    tests using iterative and recursive linked list modules.
    """
    import slList 
    listmodule = slList

    testAppendAndToString( listmodule )
    testClear( listmodule )
    testInsert( listmodule )
    testGet( listmodule )
    testSet( listmodule )
    testPop( listmodule )
    testIndex( listmodule )
    testStressAppendAndToString( listmodule )
    # remaining tests are for potential homework implementation additions
    testClone( listmodule )
    testExtend( listmodule )
    testRemove( listmodule )
    testCount( listmodule )
    testPyListToSlList( listmodule )
    testSlListToPyList( listmodule )
    print()
    
# main is the tester.
if __name__ == "__main__":
    main()
