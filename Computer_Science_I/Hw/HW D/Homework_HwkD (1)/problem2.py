"""
Debug and Test homework problem for csci141.
"""
#######################################################################
## Student Name: Joel Yuhas
## Problem: The is_reverse_of function does not work correctly.
#######################################################################
# Assignment:
# 1. Add code to test_is_reverse_of() to create a suite of test cases 
#    that test the is_reverse_of function. use the test_case() function.
#    TODO: READ THE CODE TO SEE HOW IT WORKS FIRST.
#    (test code is 20% of grade)
#
# 2. Use a debugger (pdb, idle or pycharm) to debug is_reverse_of().
#    Mark correction(s) with the comment "# fixed here" on the changed lines.
#    (debugging and repairing code is 20% of grade) 

def is_reverse_of( st1, st2 ):
    """
    is_reverse_of : String String -> Boolean
    is_reverse_of tells if one string is the reverse of another.
    preconditions: st1 and st2 are character strings.
    """
    if len( st1 ) != len( st2 ):
        return False
    i = 0
    j = len( st2 )-1 # fixed here
    while j > 0:
        if st1[i] != st2[j]:
            return False
        i += 1
        j -= 1
    return True

def test_case( st1, st2, expected ):
    """
    test_case calls is_reverse_of and checks for expected result.
    """
    result = is_reverse_of( st1, st2 )
    print( 'is_reverse_of( "', st1, '" , "', st2, '" ) == ', result
         , sep='', end='. ' )
    if result != expected:
        print( "incorrect." )   # prints incorrect if answer is unexpected.
    else:
        print()

def test_is_reverse_of():
    """
    a suite of pass/fail test cases to validate that is_reverse_of works.
    """
    print( "begin test_is_reverse_of" )
    
    test_case( "a", "", False )
    test_case( "ab", "aba", False )
    test_case( "yes", "sey", True )

    print( "end test_is_reverse_of" )
    

    

#######################################################################
if __name__ == "__main__":
    test_is_reverse_of()         # Run the test function.

