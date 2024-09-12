"""
file: treemap.py
language: python3
author: jxy8307@g.rit.edu Joel Yuhas
description: Binary tree creation, searching and conversion to string
"""

from rit_object import *

class TreeMap (rit_object):
    __slots__ = ('left', 'key', 'value', 'right')
    _types = ( object, str, int, object )


def mapInsert ( key, value, mp ):
    """
    mapInsert: BinarySearchTree -> BinarySearchTree + Item (key, value, tree)
    Takes a tree map and prints the items in order
    """
    tempMap = TreeMap ( None, key, value, Map )
    if mp == None:
        mp = tempMap
    else:
        if key < mp.key:
                if mp.left == None:
                    mp.left = tempMap
                else:
                    mapInsert( key, value, mp.left )
        elif key > mp.key:
                if mp.right == None:
                    mp.right == tempMap
                else:
                    mapInsert( key, value, mp.left )
        else:
                mp.value = value

def mapToString ( mp ):
    """
    mapToString: BinarySearchTree -> String
    Takes a tree map and prints the items in order
    """
    if mp == None:
        return ''
    else:
       return "("  + mapToString( mp.left )  + ',' + str( mp.key)  + '->'  +  str( mp.value ) + ',' +  mapToString( mp.right ) + ")"   

def mapSearch ( mp, key ):
    """
    mapSearch: BinarySearchTree * Number -> Boolean
    Takes a tree map and a key and searches the map for the key
    """
    if mp == None:
       return None
    else:
       if key == mp.key:
          return mp.value
       elif key < mp.key:
          return mapSearch ( mp.left, key )
       elif key > mp.value:
          return mapSearch ( mp.right, vkey )

