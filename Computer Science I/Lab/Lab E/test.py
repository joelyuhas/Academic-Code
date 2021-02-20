def quickSelect( lst, k ):
    print(lst)
    length = len(lst)
    pivot = lst[length//2]
    print(pivot)
    smallLst = []
    largeLst = []
    i = 0
    
    while i < length:
        if lst[i] < pivot:
            smallLst += lst[i]
        elif lst[i] > pivot:
            largeLst += lst[i]
        i += 1


quickSelect( [101, 12, 124, 45], 1 )
