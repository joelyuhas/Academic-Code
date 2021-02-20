from rit_object import *
from ItemArmor import *

class PlayerArmor (rit_object):
    __slots__ = ('head', 'body', 'arms', 'legs', 'banner','enchanter','deff' )
    _types = (object, object, object, object, object, object, object)

def defaultArmor():
    return PlayerArmor(defHead(), defBody(), defArms(), defLegs(), defBanner(), defEnchanter)

def createArmorSet(head, body, arms, legs, banner, enchanter):
    totalDefense = 0
    error = 0
    
    if head == None:
        h1 = defHead()
    else:
        h1 = head
    if body == None:
        b1 = defBody()
    else:
        b1 = body
    if arms == None:
        a1 = defArms()
    else:
        a1 = arms
    if legs == None:
        l1 = defLegs()
    else:
        l1 = legs
    if banner == None:
        b2 = defBanner()
    else:
        b2 = banner
    if enchanter == None:
        e1 = defEnchanter()
    else:
        e1 = enchanter
        

    if h1.typ != 'head':
        print("Head is not Head")
        error += 1
    else:
        totalDefense += h1.deff
        
    if b1.typ != 'body':
        print("Body is not Body")
        error += 1
    else:
        totalDefense += b1.deff
        
    if a1.typ != 'arms':
        print("Arms is not Arms")
        error += 1
    else:
        totalDefense += a1.deff
        
    if l1.typ != 'legs':
        print("Legs is not Legs")
        error += 1
    else:
        totalDefense += l1.deff
        
    if b2.typ != 'banner':
        print("Banner is not Banner")
        error += 1
        
    if e1.typ != 'enchanter':
        print("Enchanter is not Enchanter")
        error += 1
        
    if error == 0:
        newArmor = PlayerArmor(h1, b1, a1, l1, b2, e1, totalDefense)
        return newArmor


    
    


def armorPrint( armor ):
    print("Head: " + str(armor.head))
    print("Body: " + str(armor.body))
    print("Arms: " + str(armor.arms))
    print("Legs: " + str(armor.legs))
    print("Banner: " + str(armor.banner))
    print("Enchanter: " + str(armor.enchanter))
    print("Defense: " + str(armor.deff))
    print("--------------------------------")
