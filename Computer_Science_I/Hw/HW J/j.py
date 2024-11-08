"""
Author- Anthony Rios (air6274@rit.edu)
CS 141
HW J
"""
 
from rit_object import *
 
class TreeMap(rit_object):
    __slots__ = ("left", "key", "value", "right")
    _types = (object, str, int, object)
 
def mapInsert(key, value, map):
    emptyMap = TreeMap(None, key, value, None)
    if map == None:
        map = emptyMap
 
    left = map.left
    right = map.right
 
    if key < map.key:
        if left is None:
            map.left = emptyMap
        else:
            mapInsert(key, value,left)
    elif key > map.key:
        if right is None:
            map.right = emptyMap
        else:
            mapInsert(key, value,right)
    else:
        map.value = value
    return map
 
def mapToString(map):
    if map == None:
        return "_"
    else:
        left = mapToString(map.left)
        right = mapToString(map.right)
        key = map.key
        value = str(map.value)
 
        return "(" + left + "," + key + "->" + value + "," + right + ")"
 
 
def mapSearch(key, map):
 
    if map == None:
        return None
 
    if map.key == key:
        return map.value
 
    if map.key > key:
        mapSearch(key, map.left)
 
    elif map.key < key:
        mapSearch(key, map.right)
