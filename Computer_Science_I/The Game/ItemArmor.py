from rit_object import *


class ArmorItem (rit_object):
    __slots__ = ('name', 'typ', 'deff', 'special')
    _types = (str, str, int, object)

def createArmor(name, typ, deff, spe):
    newArmor = ArmorItem(name, typ, deff, spe)
    return newArmor
#-----------------------------------------------------------------

def defHead():
    return createArmor('defHead', 'head', 0, None)
    
def defBody():
    return createArmor('defBody', 'body', 0, None)

def defArms():
    return createArmor('defArms', 'arms', 0, None)

def defLegs():
    return createArmor('defLegs', 'legs', 0, None)

def defBanner():
    return createArmor('defBanner', 'banner', 0, None)

def defEnchanter():
    return createArmor('defEnchanter', 'enchanter', 0, None)
#---------------------------------------------------------------------    

def gjallihorn():
    gjallihorn = createArmor('gjallihorn', 'head', 100, None)
    return gjallihorn
