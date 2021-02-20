from rit_object import *
from PlayerArmor import *
from ItemArmor import *

class Player (rit_object):
    __slots__ = ('name', 'health', 'stamina', 'weapons', 'armor', 'invetory', )
    _types = (str, int, int, object, object, list)


def playerCreate( name, health, stamina ):
    newPlayer = Player( name, health, stamina, None, None, None, )
    return newPlayer

def playerPrint( player ):
    if isinstance(player, Player) == True:
        print("Name: " + player.name )
        print("Health: " + str(player.health))
        print("Stamina: " + str(player.stamina))
        print("Weapons: ")
        print("Armor:------------------------ ")
        armorPrint(player.armor)
        print("Invetory: ")
    else:
        print("Not given a correct Player")
        return

def main():
    steve = playerCreate('steve', 10, 10)
    steve.health = 30
    steve.armor = createArmorSet( gjallihorn() , None, None, None, None, None)
    playerPrint(steve)

main()
