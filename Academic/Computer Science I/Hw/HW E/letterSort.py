from string import ascii_lowercase
"""
    file: letterSort.py
    language: python3
    author: jxy8307@g.rit.edu Joel Yuhas 
    description: takes a document, reads each line, converts to lower case and removes duplicates, prints original and sorted layout.
"""

def letterPrep ( wordlist ):
    """String -> String
       takes in word document, converts first line to lowercase word and complies into list.
    """
    num = [] #creates first list
    b = 0
    for word in wordlist: #strips words and brings to lower case
        word = word.strip()
        word = word.lower()
        if word not in num:#gets rid of duplicates
            num.append(word)
    print("Input words:")
    while b < len(num): #prints words accordingly
            wordi=num[b]
            print(wordi)
            b += 1
    return num


def letterSort( wordlist ):
    """String -> String
       takes list of words, determines first letter, puts into appropriate box of corresponding letter.
    """
    letterbin = [ [] for _ in range (26)]
    wordTot= []
    print(" ")
    print("Sorted words:")
    last = []
    for word in wordlist: #puts words based on their first letter into appropriate boxes
        j = 0
        b = 0
        letter = word[0]
        while j < 26: #takes ord of letter to correspond to boxes
            if (ord(letter)) == (j + 97):
                letterbin[j] = letterbin[j] + [word]
                j += 1
            else:
                j += 1
    while b < 26: #prints words accordingly
        if letterbin[b]:
            print('\n'.join(letterbin[b]))
            b += 1
        else:
            b +=1
            
def main():
    """Input String -> String
       Recives input from user and calls the inputs.
    """
    wordlist = input("Enter the name of the the file: ")
    letterSort( letterPrep( open( wordlist ) ) )
    

main()



