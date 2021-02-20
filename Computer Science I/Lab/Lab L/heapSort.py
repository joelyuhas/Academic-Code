"""
file: heapSort.py
version: python3
author: Sean Strout
author: Joel Yuhas jxy8307@g.rit.edu
purpose: Implementation of the heapsort algorithm, not
    in-place, (lst is unmodified and a new sorted one is returned)
"""

import heapq    # mkHeap (for adding/removing from heap)
import testSorts    # run (for individual test run)

def heapSort(lst):
    """
    heapSort(List(Orderable)) -> List(Ordered)
        performs a heapsort on 'lst' returning a new sorted list
    Postcondition: the argument lst is not modified
    """
    if lst == None or len(lst) == 0:
        return
    heap = []
    templst = []
    for i in lst:
        heap.append(i)
    heapq.heapify(heap)
    while len(heap) != 0:
        temp = heapq.heappop(heap)
        templst.append(temp)   
    return templst

if __name__ == "__main__":
    testSorts.run('heapSort')
