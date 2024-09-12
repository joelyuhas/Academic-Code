from rit_object import *

"""
    file: pack.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: Program that packs boxes into bins!
"""

class Bin(rit_object):
    """
    Creates the class structre for futre use
    """
    __slots__ = ( "row", "column" )
    _types = ( int, int )



def isSpaceFree( binSize, row, column, block ):
    """
    PreConditions: Recives the size of bin, row value, column value, and block size
    PostConditions: outputs either False if location is not 0, returns true if location is 0
    """
    if ((len( binSize ) < block + row) or (len( binSize )) < block + column ):
        return False
    for i in range ( row, row +block ):
        for g in range( column, column + block):
            if binSize[i][g] != 0:
                return False
    return True

def placeBlock( block, Bin, row, column):
    """
    PreConditions: recives block size, bin size, row and colums
    PostConditions: fills designated row and colom areas with number corresponding to size of box
    """
    for r in range(row, row+block):
        for c in range(column, column+block):
            Bin[r][c] = block
    return Bin

def tryPacker( Bin, block ):
    """
    PreConditions: recives bin and list of blocks
    PostConditions: returns ture if block is packed, returns false if block is not packed
    """
    for row in range(len(Bin)):
        for column in range(len(Bin)):
            if isSpaceFree(Bin, row, column, block ) == True:
                placeBlock( block, Bin, row, column)
                return True
    return False
    
def packer( Bin, blockList):
    """
    PreConditions: recives bin and list of blocks
    PostConditions: uses trypacker to pack list full of boxes
    """
    unUsed = []
    for block in blockList:
        if tryPacker(Bin, block) == True:
            pass
        else:
            unUsed.append(block)
    return Bin



########################################################################################
##                               UTILITY FUNCTIONS                                    ##
########################################################################################



def freeSpaceFinder( Bin ):
    """
    PreConditions: takes in filled bin
    PostConditions: returns number of zeros left in bin
    """
    freeSpace = 0
    for row in range(len(Bin)):
            for column in range(len(Bin)):
                if Bin[row][column] == 0:
                    freeSpace += 1
    return freeSpace

def fileReader( file ):
    """
    PreConditions: recives a file
    PostConditions: opens the file and and converts contents into integers and places them in a list
    """
    openfile = open(file)
    blockList = []
    for item in openfile:
            blockList += [int(s) for s in item.split() if s.isdigit()]
    if len(blockList) == 0:
        print("There is nothing here.")
    blockList.sort( reverse = True )
    return blockList

def unUsed( Bin, blockList):
    """
    PreConditions: takes in bin size and list of blocks
    PostConditions: returns all the blocks that were not useed
    """
    unUsed = []
    for block in blockList:
        if tryPacker(Bin, block) == True:
            pass
        else:
            unUsed.append(block)
    return unUsed

def printer( Bin ):
    """
    PreConditions: takes in the final bin
    PostConditions: prints the contents of bin in specific format
    """
    for row in range(len(Bin)):
            for column in range(len(Bin)):
                    print(Bin[row][column], end=" ")
            print()
                    
             

########################################################################################
##                             COMPILATION OF FUCTIONS                                ##
########################################################################################


def main():
    """
    compiles all the functions and their values and uses them to get desired results
    """
    binSize= int(input("Enter square bin dimension: "))
    file = input("Block file: ")


    createdBin = [ [0 for col in range( binSize )] for row in range( binSize ) ]
    createdBin_01 = [ [0 for col in range( binSize )] for row in range( binSize ) ]
    
    printer( packer( createdBin, fileReader( file ) ) )
    print("Free Spaces: ", freeSpaceFinder( createdBin ) )
    print("Unpacked blocks: ", unUsed( createdBin_01, fileReader( file ) ) )


    
main()
