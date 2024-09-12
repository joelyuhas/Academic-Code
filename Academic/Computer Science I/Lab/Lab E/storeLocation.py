import time
"""
    file: storeLocation.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that finds ideal store location based on median and finds the total distance as well
"""

def swap( lst, i, j ): #From class sort code
    """
    swap: List NatNum NatNum -> None
    swap the contents of list at pos i and j.
    Parameters:
        lst - the list of data
        i   - index of one datum
        j   - index of the other datum
    """
    temp = lst[i]
    lst[i] = lst[j]
    lst[j] = temp
def insert( lst, mark ): #From class sort code
    """
    insert: List(Orderable) NatNum -> None
    Move the value at index mark+1 so that it is in its proper place.
    Parameters:
        lst - the list of data 
        mark - represents cutting the list between 
               index mark and index mark+1
    pre-conditions:
      lst[0:mark+1] is sorted.
    post-conditions:
      lst[0:mark+2] is sorted.
    """
    index = mark
    while index > -1 and lst[index] > lst[index+1]:
        swap( lst, index, index+1 )
        index = index - 1
def insertion_sort( lst ): #From class sort code
    """
    insertion_sort : List(Orderable) -> None
    Perform an in-place insertion sort on a list of orderable data.
    Parameters:
        lst - the list of data to sort
    post-conditions:
        The data list has been sorted.
    """
    for mark in range( len( lst ) - 1 ):
        insert( lst, mark )



def findMedian( newlst ):
    """
    findMedian: list -> integer
    takes the given list, test to see if there is anything there, finds its median.
    """
        
    if len(newlst) == 0:        #return value for if there is None
        print("There is nothing here") 
        return 0
    
    insertion_sort( newlst )        #Class sorting technique
    if len(newlst)%2==0:
        x = newlst[len(newlst)//2]
        y = newlst[(len(newlst)//2)-1]
        median = (x + y)/2
    else:
        median = newlst[len(newlst)//2]
    return median



def sumOfDistances( newlst, best ):
    """
    sumOfDistances: List, integer -> integer, integer
    recives list, takes all indexes and compares to "best" value which gathers its differences and adds them together to get total distance
    """
    total = 0
    for n in newlst:
        total += abs(best - n)
    print("Optimal location for store is: ")
    print(best)
    print(" ")
    print("Sum of distances is: ")
    print(total)
    print(" ")
    print("Total elapsed time to sort function is: ")
    return total



def main():
    """
    Compiles all the given inputs and calls the functions.
    """
    file = input("Enter the name of the file: ")
    openFile = open(file)
    
    t0 = time.clock()   #start time
    newlst = []
    for item in openFile :
        newlst += [int(s) for s in item.split() if s.isdigit()]   
    if len(newlst) == 0:    #test to see if file is empty
        print("There is nothing here.")
        return
    q = findMedian( newlst ) 
    totalTime = (time.clock()-t0)  #end time
    
    sumOfDistances( newlst, q ) #results 
    print(totalTime)


main()
