def que(filename):
    """
    preconditions: takes in file name
    postconditions: opens file and sorts the items in file.
    """
    que = createPriorityQueue()
    openFile = open(filename)
    if openFile == None:
        print("there is nothing here")
        return
    if que == None:
        
    for item in openFile:
        for subItem in item:
            pat = patron()
            if subItem == "checkin":
                pass
            elif subItem == "boarding":
                pass
            elif subItem.isdigit()==True:
                pat.priority = int(subItem)
            elif:
                pat.name = subItem
        insert(que, pat)
                
    print(queue)    
    return queue
