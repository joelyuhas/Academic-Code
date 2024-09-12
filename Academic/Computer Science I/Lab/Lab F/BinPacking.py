from rit_object import *

class Bin(rit_object):
    __slots__ = ( "row", "column" )
    _types = ( int, int )


def fileReader( file ):
    openfile = open(file)
    blockList = []
    for item in openfile:
            blockList += [int(s) for s in item.split() if s.isdigit()]
    if len(blockList) == 0:
        print("There is nothing here bitch")
    blockList.sort( reverse = True )
    return blockList





def isSpaceFree( binSize, row, column, block ):
    if ((len( binSize ) < block + row) or (len( binSize )) < block + column ):
        return False
    for i in range ( row, row +block ):
        for g in range( column, column + block):
            if binSize[i][g] != 0:
                return False
        
   
    return True
def something( Bin, blockList):
    unUsed = []
    for block in blockList:
        if tryPacker(Bin, block) == True:
            pass
        else:
            unUsed.append(block)
    print(unUsed)
    return Bin

def tryPacker( Bin, block ):
        for row in range(len(Bin)):
            for column in range(len(Bin)):
                if isSpaceFree(Bin, row, column, block ) == True:
                    placeBlock( block, Bin, row, column)
                    return True
        return False




def placeBlock( block, Bin, row, column):
    for r in range(row, row+block):
        for c in range(column, column+block):
            Bin[r][c] = block

    return Bin


def printer( Bin ):
    for row in range(len(Bin)):
            for column in range(len(Bin)):
                    print(Bin[row][column], end=" ")
            print()
                    
             




def main():
    binSize= int(input("Enter square bin dimension: "))
    file = input("Block file: ")


    createdBin = [ [0 for col in range( binSize )] for row in range( binSize ) ]
    c = fileReader( file )
    b = createdBin
    q = something( b,c )
    
    printer( q )



    
main()
