import time
"""
    file: selectMedian.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that finds ideal store location based on median and finds the total distance as well using a different method
"""


def quickSelect( lst, k ):
    """
    quickSelect: list, integer -> integer
    divides the list in half continuously until the kth value of list (based on least to gretest order) is found
    """
    length = len(lst)       #declares variables and list
    pivot = lst[length//2]
    smallLst = []
    largeLst = []
    
    i = 0
    while i < length:       #divides into smaller and larger list
        if lst[i] < pivot:
            smallLst.append(lst[i])           
        elif lst[i] > pivot:
            largeLst.append(lst[i])
        i += 1
        
    count = lst.count(pivot)
    m = len(smallLst)
    if k >= m and k < m + count:
        return pivot
    elif m > k:
        return quickSelect( smallLst, k )
    else:
        return quickSelect( largeLst, k - m - count )


def sumOfDistances( lst, best ):
    """
    sumOfDistances: List, integer -> integer, integer
    recives list, takes all indexes and compares to "best" value which gathers its differences and adds them together to get total distance. Checks to see if there is anything there.
    """
    total = 0
    for n in lst:
        total += abs(best - n)
    print("Location for store based on k: ")
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
    k = input("Enter the value for K: ")

    openfile = open(file)

    t0 = time.clock()       #starts time
    newlst = []
    for item in openfile:
        newlst += [int(s) for s in item.split() if s.isdigit()]
    print(newlst)
    if len(newlst) == 0:    #test to see if file is empty
        print("There is nothing here!")
        return
    if int(k) > len(newlst):
        print("K is too big!") #test to see if k is too big
        return
    q = quickSelect( newlst, int(k) )
    totalTime = (time.clock()-t0) #ends time
    
    sumOfDistances( newlst,q ) #results 
    print(totalTime)


    
main()
