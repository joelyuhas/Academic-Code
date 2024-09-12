"""
    file: findWord.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: program that counts the number of words
"""

    
def countWords( textFileName ):
    """countWords recives textFileName 
       TextFileName is striped, and its white spaces are counted and added, variables are also established
    """
    count = 0
    inWhite = False
    for currentWord in textFileName:
            i = 0
            while( currentWord[i] != "\n" ):
                """Recives line of text from file
                   if the next character is either a ' ' or 'is alpha'(,.+ etc.) then count one and return true, else count one and return false and repeat
                """
                if((currentWord[i] == ' ') or (currentWord[i].isalpha() == False))  and (inWhite == False):
                    """
                    """
                    count += 1
                    inWhite = True
                    i += 1
                else: 
                    inWhite = False
                    i += 1
            inWhite = False
    count = count + 1
    return count
    

def main():
    """calls countWords and sets up program to recieve name of files
       File is exicuted, textFileName is opened and printed
    """
    textFileName = input("Enter text file name: ")
    print(countWords( open(textFileName )), end="")
    print(" words")

    
main()

