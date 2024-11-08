


def say( s ):
     for letter in string:
        i = 0
        while( letter[i] != "\n"):
            if letter == "":
               i += 1
               return print( "There is nothing to see!")
            elif:
               if c ==0 :
                   i += 1
                   return 'one' + 'zero'
               elif c == 1:
                   i += 1
                   return 'one' + 'one'
               elif c == 2:
                   i += 1
                   return 'one' + 'two'
               else:
                   i += 1
                   return 'one' + 'three'
            elif:
                if c ==0 :
                   i += 1
                   return 'two' + 'zero'
               elif c == 1:
                   i += 1
                   return 'two' + 'one'
               elif c == 2:
                   i += 1
                   return 'two' + 'two'
               else:
                   i += 1
                   return 'two' + 'three'
               
            elif:
               if c ==0 :
                   i += 1
                   return 'three' + 'zero'
               elif c == 1:
                   i += 1
                   return 'three' + 'one'
               elif c == 2:
                   i += 1
                   return 'three' + 'two'
               else:
                   i += 1
                   return 'three' + 'three'



    
def see( s ):
    num = 0
    for num in s:
        i = 0
        while( i < 2):
            if num[i] == "":
              
               print( "There is nothing to see!")
            elif( num[i] == '1'):
                
                if num[i] ==0 :
                   print('10' )
                elif num[i] == 1:
            
                   print( '11')
                elif num[i] == 2:
                
                   print( '12')

                else:
                 
                  print ('13')  
                print('a')
            elif( num[i] == '2'):
                
                if num[i] ==0 :
                 
                   print( '20')
                elif num[i] == 1:
                 
                   print ('21')
                elif num[i] == 2:
                 
                   print( '22')
                else:
                  
                   print( '23')
                   
                print('b')
            
            elif num[i] == '3':

                if num[i] ==0 :
                  
                  print('30')
                elif num[i] == 1:
                   
                   print( '31' )
                elif num[i] == 2:
                
                   print( '32' )
                else:
              
                   print( '33' )
                print('c')
            print('y')
        
            i += 1
             
            
        
    print('w')

def seeNsay( index ):
    while s != "":
        number = runLen( s, s[0] )
        if number == 0:
                runLen( s, s[1:] )
        elif number == 1:
            return 'one'
                if


def see( string ):
    num = 0
    this = list( string )

    
    if string == "":
            return print('there is nothing to see!')
        
    x = runLen(string, string[num])
    
    while (num < len(this)):
        if x== 1:
            if string[num]== '0':
                print('10 ', end="")
                
            
            elif string[num]== '1':
                 print('11 ', end="")
            
            elif string[num]== '2':
                 print('12 ', end="")
            
            elif string[num]== '3':
                 print('13 ', end="")

            
        elif x== 2:
            if string[num]== '0':
                print('20 ', end="")
            
            elif string[num]== '1':
                 print('21 ', end="")
            
            elif string[num]== '2':
                 print('22 ', end="")
            
            elif string[num]== '3':
                 print('23 ', end="")
            

        elif x == 3:
            if string[num]== '0':
                print('30 ', end="")
            
            elif string[num]== '1':
                 print('31 ', end="")
            
            elif string[num]== '2':
                 print('32 ', end="")
            
            elif string[num]== '3':
                 print('33 ', end="")
        
        if x == 0:
            
            num += 1
            
        else:
            num += x
