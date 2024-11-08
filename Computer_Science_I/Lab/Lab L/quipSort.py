"""
file: quipSort.py
version: python3
author: Sean Strout
author: Joel Yuhas jxy8307@g.rit.edu
purpose: Implementation of the quicheSort algorithm (not in place),
    It first uses quickSort, using the median-of-3 pivot, until it
    reaches a recursion limit bounded by int(math.log(N,2)).
    Here, N is the length of the initial list to sort.
    Once it reaches that depth limit, it switches to using heapSort instead of
    quicksort.
"""

import heapSort            # heapSort
import math                 # log2 (for quicksort depth limit)
import testSorts

def medianOf3(lst):
    """
    medianOf3: lst -> 3 Integers
    From a lst of unordered data, find and return the the median value from
    the first, middle and last values.
    """
    if len(lst) == 0:
        return
    if len(lst) == 1:
        return lst[0]
    elif len(lst) == 2:
        if lst[0] < lst[1]:
            return lst[0]
        else:
            return lst[1]
    firstValue = lst[0]
    lastValue = lst[len(lst)-1]
    middleValue = len(lst)//2
    tempLst = [firstValue, middleValue, lastValue]
    tempLst.sort()
    return tempLst[1]

def quipSortRec(lst, limit):
    """
    A non in-place, depth limited quickSort, using median-of-3 pivot.
    Once the limit drops to 0, it uses heapSort instead.
    """
    if limit == 0:
        temp = heapSort.heapSort(lst)
        return temp
    else:
        if len(lst) == 0:
            return
        if len(lst) == 1:
            templst = []
            templst.append(lst[0])
            return templst
        if len(lst) == 2:
            speciallst = []
            a = lst[0]
            b = lst[1]
            if a < b:
                speciallst.append(a)
                speciallst.append(b)
                return speciallst
            else:
                speciallst.append(b)
                speciallst.append(a)
                return speciallst
        else:
            templst = lst[:]
            lesslst = []
            greaterlst = []
            pivot = medianOf3(templst)
            for i in templst:
                if i <= pivot:
                    lesslst.append(i)
                else:
                    greaterlst.append(i)
            finallst = quipSortRec(lesslst, limit - 1) +  quipSortRec(greaterlst, limit -1)
    return finallst

def quipSort(lst):
    """
    The main routine called to do the sort.  It should call the
    recursive routine with the correct values in order to perform
    the sort
    """
    limit = math.log(len(lst),2) 
    temp = quipSortRec(lst, int(limit) ) ###converts the log from a float to a integer that way it makes deduction easier and cleaner
    return temp

if __name__ == "__main__":
    testSorts.run('quipSort')
