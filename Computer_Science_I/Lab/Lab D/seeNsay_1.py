"""

"""

def runLen( string, character ):
    if character == "":
        return 0
    elif character == string[0]:
        return 1 + runLen( string[1:],character )
    else:
        return 0


def see( string ):
    num = 0
    this = list( string )
    this.extend([' ', ' ', ' ',])
    while (num < len(this)+4):
        if string == "":
            return print('there is nothing to say!')
        
        elif (this[num] != this[num+1]) and (this[num] != this[num+2]) and (this[num] != this[num-1]):
            if this[num] == '0':
                print('10', end="")
            
            elif this[num] == '1':
                print('11', end="")
            
            elif this[num] == '2':
                print('12', end="")

            elif this[num] == '3':
                print('13',end="")


        elif (this[num] == this[num+1]) and (this[num] != this[num+2]):
            if this[num] == '0':
                print('20', end="")
            
            elif this[num] == '1':
                print('21', end="")

            elif this[num] == '2':
                print('22', end="")

            elif this[num] == '3':
                print('23', end="")
       

        if (this[num] == this[num+1]) and (this[num] == this[num+2]):
            if this[num] == '0':
                print('30')
            
            elif this[num] == '1':
                print('31', end="") 

            elif this[num] == '2':
                print('32', end="")

            elif this[num] == '3':
                print('33', end="")
                
        num += 1


def say( string ):
    num = 0
    this = list( string )
    this.extend([' ', ' ', ' ',])
    while (num < len(this)+4):
        if string == "":
            return print('')
        
        elif (this[num] != this[num+1]) and (this[num] != this[num+2]) and (this[num] != this[num-1]):
            if this[num] == '0':
                print('one zero. ', end="")
            
            elif this[num] == '1':
                print('one one. ', end="")
            
            elif this[num] == '2':
                print('one two. ', end="")

            elif this[num] == '3':
                print('one three. ',end="")


        elif (this[num] == this[num+1]) and (this[num] != this[num+2]):
            if this[num] == '0':
                print('two zero. ', end="")
            
            elif this[num] == '1':
                print('two one. ', end="")

            elif this[num] == '2':
                print('two two. ', end="")

            elif this[num] == '3':
                print('two three. ', end="")
       

        if (this[num] == this[num+1]) and (this[num] == this[num+2]):
            if this[num] == '0':
                print('three zero. ')
            
            elif this[num] == '1':
                print('three, one. ', end="") 

            elif this[num] == '2':
                print('three two. ', end="")

            elif this[num] == '3':
                print('three three. ', end="")
                
        num += 1


runLen('11100','1')        
see( '00110011001100011000' )
