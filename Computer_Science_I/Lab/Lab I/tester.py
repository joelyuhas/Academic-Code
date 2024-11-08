def hash_function(val, n):
    """
    hash_function: K NatNum -> NatNum
    
    Computes a hash of the val string that is in [0 ... n).
    """
    keyValue = 0
    w=0
    for i in val:
        keyValue = (ord(i)*(31**w)) + keyValue
        w += 1
    hashcode = keyValue % n
    print(hashcode)
    return
def main():
    lst = list()
    if lst == None:
        print("W")
    else:
        print("asfsdfas")

        
main()
