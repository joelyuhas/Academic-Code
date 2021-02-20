"""
description: Hash Table Using Chaining for CS 141 Lab
file: hashtable.py
language: python3

author: as@cs.rit.edu Amar Saric

student author: jxy8307@g.rit.edu Joel Yuhas
"""

from rit_object import *

class HashTable(rit_object):
    """
       The HashTable data structure contains a collection of values
       where each value is located by a hashable key.
       No two values may have the same key, but more than one
       key may have the same value.
       table is the list holding the hash table
       size is the number of entrys in occupying the hashtable
    """
    
    __slots__ = ('table', 'size') 
    _types = (list, int)

def createHashTable(capacity=100):
    """
    createHashTable: NatNum? -> HashTable
    
    Returns a hash table  as a list of lists. 
    """
    
    return HashTable ([[] for _ in range(capacity)], 0)


def LOAD_FACTOR():
    return 0.75

def resizeHashTable(hTable):
    """
    HashTableToStr: HashTable -> None
    
    Doubles the size of the table as well as adds one to the new size.
    """
    #--------------------------------------------EDITED IN-------------------------------------------
    newTable = createHashTable((len(hTable.table)*2)+1)
    for lst in hTable.table:
        for item in lst:
            if item != None:
                put(newTable, item.key, item.value)        
    hTable = newTable

    return hTable  
    #------------------------------------------------------------------------------------------------

def HashTableToStr(hTable):
    """
    HashTableToStr: HashTable -> String
    """
    
    txt = ''
    ltext = 0
    for lst in hTable.table:
        for entry in lst:
            s = EntryToStr(entry) + ' '
            ltext += len(s)
            txt += s
            if ltext > 51:
                txt += '\n'
                ltext = 0                
    return txt


class Entry(rit_object):
    """
       A class used to hold key/value pairs.
    """
    
    __slots__ = ("key", "value")
    _types = (object, object)


def EntryToStr(entry):
    """
    EntryToStr: Entry -> String
    
    Returns the string representation of the entry.
    """
    
    return "(" + str(entry.key) + ", " + str(entry.value) + ")"


def hash_function(val, n): #MODIFIED
    """
    hash_function: K NatNum -> NatNum
    
    Computes a hash of the val string that is in [0 ... n).
    """
    #--------------------------------------------EDITED IN-------------------------------------------
    keyValue = 0
    w=0
    for i in val:
        keyValue = (ord(i)*(31**w)) + keyValue
        w += 1
    hashcode = keyValue % n
    
    return hashcode
    #------------------------------------------------------------------------------------------------

def imbalance(hTable): #MODIFIED
    """
    keys: HashTable(K, V) -> Num
    
    Computes the imbalance of the hashtable.
    """
    #--------------------------------------------EDITED IN-------------------------------------------
    entity = 0
    used = 0
    imbalance = 0
    index = hash_function('a', len(hTable.table))
    startIndex = index
    stop = 0
    while stop == 0:
        if len(hTable.table[ index ]) != 0:
            entity = entity + (len(hTable.table[ index])-1)
            used += 1
        index = (index + 1) % len(hTable.table)
        if index == startIndex:
            stop += 1
    imbalance = entity/used
    
    return imbalance
    #------------------------------------------------------------------------------------------------

def keys(hTable):
    """
    keys: HashTable(K, V) -> List(K)
    
    Returns a list of keys in the given hashTable.
    """
    
    keys_lst = []
    for lst in hTable.table:
        for entry in lst:
            keys_lst += [entry.key]
    
    return keys_lst

def has(hTable, key):
    """
    has: HashTable(K, V) K -> Boolean
    
    Returns True iff hTable has an entry with the given key.
    """
    
    index = hash_function(key, len(hTable.table))
    for entry in hTable.table[index]:
        if entry.key == key:
            return True
    return False 
    

def put(hTable, key, value): #MODIFIED
    """
    put: HashTable(K, V) K V -> Boolean
    
    Using the given hash table, set the given key to the
    given value. If the key already exists, the given value
    will replace the previous one already in the table.
    
    The table is resized if the load factor of 0.75 is exceeded.
    """
    #--------------------------------------------EDITED IN-------------------------------------------
    
    ### CHECKS LOAD ###
    hashLoad = float((hTable.size+1)/len(hTable.table))
    if  hashLoad > LOAD_FACTOR():
        newTable = resizeHashTable( hTable )
        hTable.table = newTable.table
        put(hTable, key, value)
        
    ### PUT FUNCTION ### 
    index = hash_function(key, len(hTable.table))
    if len(hTable.table[ index ]) != 0 :
        
        for lst in hTable.table[index]: 
            if lst.key == key:
                lst.value =  value
                return True
        (hTable.table[ index ]).append(Entry(key, value))
        hTable.size += 1 
    
    else:
            (hTable.table[ index ]).append(Entry(key, value))
            hTable.size += 1
    #------------------------------------------------------------------------------------------------
            
def get(hTable, key): #MODIFIED
    """
    get: HashTable(K, V) K -> V
    
    Return the value associated with the given key in
    the hash table.

    Precondition: has(hTable, key)
    """
    #--------------------------------------------EDITED IN-------------------------------------------

    index = hash_function(key, len(hTable.table))
    if len(hTable.table[ index ]) != 0 :
        for i in hTable.table[ index ]:
            if i.key == key:
                return i.value
            else:
                pass

    elif hTable.table[ index ] == None:
        raise Exception("Hash table does not contain key:", key)
    #------------------------------------------------------------------------------------------------


    
