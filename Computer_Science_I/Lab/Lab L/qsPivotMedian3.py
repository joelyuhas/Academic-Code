"""
file: qsPivotMedian3.py
version: python3
author: Sean Strout
author: Joel Yuhas jxy8307@g.rit.edu
purpose: Implementation of the quick-sort algorithm (not in-place).  The 
    pivot is chosen always to be the median-of-3 (the median of
    the first, middle and last values)
"""

import testSorts        # run (for individual test run)

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
    
def quickSort(lst):
    """
    quickSort: List(lst) -> List(result)
        Where the return 'result' is a totally ordered 'lst'.
        It uses the median-of-3 to select the pivot

    e.g.  quickSort([1,8,5,3,4]) == [1,3,4,5,8]
    """
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
        finallst = quickSort(lesslst) +  quickSort(greaterlst)
    return finallst
   
if __name__ == "__main__":
    testSorts.run('qsPivotMedian3')
