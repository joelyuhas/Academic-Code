
"""
    file: seeNsay.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that compiles index, which then sees and says the number according to a predetermined pattern
"""



def runLen( string, character ):
    """

    """
    if string == "":
        return 0 
    else: 
        return 1 + runLen( string[1:],character ) #returns a Integer and shortens the string


    
def see( string ):
    """ 
    see: String -> String
    takes count, char, temp, i, count holds the number of consecutive numbers, char holds the numeber being counted, temp holds the saved numbers, i is used for iteration.
    """
    count = 0
    char = string[0]
    temp = ""
    x= runLen(string, string[0])
    i=0
    if string == "":
        print("There is nothing to see")
    while (i<x):
        if (string[i] == char):
            count +=1
            i+=1
        elif(string[i] !=char):
            temp+=str(count)
            temp+=char
            char = string[i]
            count = 1
            i += 1
    temp+=str(count)
    temp+=char
    print(temp,end="")
    print(" : ", end="")
    return temp #returns the string which can be used by say



def say ( string ):
    """
    say: String -> String
    takes given string from say (temp) and cycles through string transforming numbers into coresponding word, also adds periods to identify pairs of numbers.
    """
    num = 0
    this = list( string )
    if string == "":
            return print('there is nothing to see!')
    while (num < len(this)):
        if string[num]== '0':
                print('zero', end="")
        elif string[num]== '1':
                print('one', end="")
        elif string[num]== '2':
                print('two', end="")
        elif string[num] == '3':
                print('three', end="")
        if num%2!=0:
            print(".", end="")
        print(" ", end="")
        num += 1
        

        
def seeNsay( index ):
    """
    seeNsay: Integer -> String
    takes into acount specific varaities of index and relates them with the proper see and say functions while compiling them into a proper orientation.
    """
    i0='0'
    i1='10'
    i2='1110'
    i3='3110'
    i4='132110'
    i5='1113122110'
    i6='311311222110'
    i7='13211321322110'
    if index == 0:
        print("", end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i0))
    elif index == 1:
        print(i0, end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i1))
    elif index == 2:
        print(i1, end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i2))
    elif index == 3:
        print(i2, end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i3))
    elif index == 4:
        print(i3, end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i4))
    elif index == 5:
        print(i4, end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i5))
    elif index == 6:
        print(i5, end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i6))
    elif index == 7:
        print(i6, end="")
        print(" : ", end="")
        print(index, end="")
        print(" : ", end="")
        say(see(i7))
    else:
        print("Index out of range!")


def main():
    """
    compiles all the functions and allows user to interact, specifically with index.
    """
    y = int(input("What is your index?(0-7)"))
    seeNsay(y)
    print("")
    input("Press enter to quit...")

main()
    
    
 
