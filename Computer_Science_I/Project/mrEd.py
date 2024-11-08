"""
File: mrEd.py
Purpose: a simple text editor that can write to files
Author: Joel Yuhas jxy8307@g.rit.edu
Language: Python 3
Description: Implementation of a double-linked list data structure.

NOTE: Tested and ran from WINDOWS(os) cmd-line in project file directory
      Inside WINDWOS cmd-line, project could be succesfully called and
      exictued
"""

from rit_object import *
from dlList import *
from dlNode import *
import os
from sys import argv

def main():
    """
    Holds all of the commands and their functions
    'inner' short for "input", takes all the commands after argv recives the file
    tested and ran using WINDOWS cmd terminal
    test were succesful
    """
    
    previouseInner = None
    succesfulSave = 0

    file = argv[1]
    if os.path.exists(file):
        isInsert = False
        if os.access(file, os.R_OK):
            openFile = open(file)
            start = createList()
            for line in openFile:
                append(start,line.replace("\n",''))
            openFile.close()
            z1 = itr_create(start)
            while itr_has_next(z1) == True:
                    itr_next(z1)
        
            while True:   
                inner = input("")

#----------------------------------------------[ 'a' ]----------------------------------------------------------------------                 
                if inner == 'a':
                    index = 0
                    isInsert = True
                    while itr_has_prev(z1):
                        itr_prev(z1)
                        index += 1
                    stopper = 0
                    while stopper != 1:
                        inserting = input()
                        if inserting != '.':
                            insertAt(start, index+1 ,inserting)
                            itr_reset(z1, index)
                        else:
                            stopper += 1

                            
#----------------------------------------------[ '.' ]---------------------------------------------------------------------- 
                elif inner == '.':
                    if isInsert == True:
                        isInsert = False
                        continue
                    else:    
                        print(itr_fetch(z1))
                        
                    
#------------------------------------------[ '+ or ENTER' ]-----------------------------------------------------------------                
                elif inner == '+' or inner == '':
                    if itr_has_next(z1):
                        itr_next(z1)
                        print(itr_fetch(z1))
                    else:
                        print('?')


#----------------------------------------------[ '-' ]----------------------------------------------------------------------                 
                elif inner == '-':
                    if itr_has_prev(z1):
                        itr_prev(z1)
                        print(itr_fetch(z1))
                    else:
                        print('?')


#----------------------------------------------[ '$' ]----------------------------------------------------------------------                 
                elif inner == '$':
                    while itr_has_next(z1):
                        itr_next(z1)
                    print(itr_fetch(z1))


#----------------------------------------------[ 'N' ]----------------------------------------------------------------------                 
                elif inner.isdigit():
                    n = 0
                    temp = int(inner)
                    while itr_has_prev(z1):
                        itr_prev(z1)
                    while n < temp:
                        if itr_has_next(z1):
                            itr_next(z1)
                        else:
                            print('?')
                            n = temp
                        n += 1
                    print(itr_fetch(z1))

                
#----------------------------------------------[ 'd' ]----------------------------------------------------------------------             
                elif inner == 'd':
                    index = 0
                    if z1.lst.next != None:
                        while itr_has_prev(z1):
                            itr_prev(z1)
                            index += 1
                        pop(start, index)
                        itr_reset(z1, index)
                        if itr_fetch(z1) != False:
                            print(itr_fetch(z1))


#----------------------------------------------[ 'i' ]----------------------------------------------------------------------             
                elif inner == 'i':
                    index = 0
                    stopper = 0
                    isInsert = True
                    if start.size == 0:
                        while stopper != 1:
                            inserting = input()
                            if inserting != '.':
                                append(start, inserting) 
                                itr_reset(z1, index)
                            else:
                                stopper += 1
                    else:
                        while itr_has_prev(z1):
                            itr_prev(z1)
                            index += 1
                        while stopper != 1:
                            inserting = input()
                            if inserting != '.':
                                insertAt(start, index ,inserting)
                                itr_reset(z1, index)
                            else:
                                stopper += 1


#----------------------------------------------[ '.=' ]----------------------------------------------------------------------                    
                elif inner == '.=':
                    index = 0
                    while itr_has_prev(z1):
                        itr_prev(z1)
                        index += 1
                    print(index+1)
                    itr_reset(z1, index)


#--------------------------- ------------------[ '$=' ]---------------------------------------------------------------------- 
                elif inner == '$=':
                    print(z1.lst.size)


#----------------------------------------------[ 'p' ]----------------------------------------------------------------------                    
                elif inner == 'p':
                    curr = z1.lst.next
                    while curr.next != None:
                        print(curr.data)
                        curr = curr.next
                    if curr.next == None:
                        print(curr.data)

                
                    
#----------------------------------------------[ 'w' ]---------------------------------------------------------------------- 
                elif inner == 'w':
                    n = 0
                    fileName = file
                    count = 0
                    if os.path.exists(fileName):
                            try:
                                fd = open(fileName, "w")
                            except IOError:
                                print('filename is missing. Enter w name_of_file')
                
            
                            curr = z1.lst.next
                            if curr != None:
                                while curr.next != None:
                                    count += fd.write(curr.data)
                                    curr = curr.next
                                if curr.next == None:

                                    count += fd.write(curr.data + '\n')
                            print(count)
                            succesfulSave = 1
                            fd.close
                    else:
                            print('filename is missing. Enter w name_of_file')
                            succesfulSave = 0

        
#---------------------------------------[ 'w/wq [FILE NAME] ]----------------------------------------------------------------------
                elif len(inner) > 1:
                    n = 0
                    fileName = None
                    quiting = 0
                    for i in inner.split():
                        if n == 0:
                            if i == 'w':
                                n += 1
                            if i == 'wq':
                                n += 1
                                quiting += 1
                        elif n == 1:
                            fileName = i
                            n+=1
                    if fileName != None:
                        count = 0
                        if not fileName:
                            fileName = file
                        if os.path.exists(fileName):
                            try:
                                fd = open(fileName, "w")
                            except IOError:
                                print('filename is missing. Enter w name_of_file')
                
            
                            curr = z1.lst.next
                            while curr.next != None:
                                count += fd.write(curr.data)
                                curr = curr.next
                            if curr.next == None:

                                count += fd.write(curr.data + '\n')
                            print(count)
                            succesfulSave = 1
                            fd.close
                        else:
                            print('filename is missing. Enter w name_of_file')
                            succesfulSave = 0

                        if quiting == 1:
                            print("bye" + '\n')
                            quit()

                    
#----------------------------------------------[ 'q' ]----------------------------------------------------------------------
                elif inner == 'q':
                    if previouseInner == None:
                        print("buffer is dirty. Use 'Q' to quit and not save")
                    else:
                        n = 0
                        for i in previouseInner:
                            if i == "w" and n == 0 and succesfulSave == 1 :
                                print("bye")
                                quit()
                            n+=1
                        print("buffer is dirty. Use 'Q' to quit and not save")

    
#----------------------------------------------[ 'Q' ]----------------------------------------------------------------------            
                elif inner == 'Q':
                    if previouseInner == None:
                        print("Forcibly quitting, editor buffer is dirty")
                        print("bye" + '\n')
                        quit()
                    else:
                        n = 0
                        for i in previouseInner:
                            if i == "w" and n == 0 and succesfulSave == 1 :
                                print("Forcibly quitting, editor buffer is not dirty")
                                print("bye" + '\n')
                                quit()
                            n+=1
                        print("Forcibly quitting, editor buffer is dirty")
                        print("bye" + '\n')
                        quit()


#----------------------------------------------[ 'H' ]----------------------------------------------------------------------
                elif inner == 'h':
                    print('Mister Ed Commands (*1*)')
                    print("---------------------------------------------------------------------------")
                    print("'$'            go to last line, make it current and print")
                    print("'$='           print line number of the last line")
                    print("'+'            go to next line, if there is one, and print it (*2*)")
                    print("'-'            go to previouse line, if there is one, and print it")
                    print("'.'            print the current line")
                    print("'.='           print the line number of the current line")
                    print("'h'            print this help table")
                    print("'N'            go to line number N, make it current and print")
                    print("'a'            append begins inserting before the current line")
                    print("'d'            delete current; next line, if any, becomes current")
                    print("'i'            insert begins inserting before the current line")
                    print("'p'            print entire content of the edit buffer")
                    print("'w'            write edits to the specific file")
                    print("'w [fname]'    write edits to the specified file")
                    print("'wq [fname'    write edits [to named file] and quit")
                    print("'q'            quit")
                    print("'Q'            quit forcibly even if there are unsaved edits")
                    print("'/text'        search forward printing lines containing text")
                    print("?text'         search backward printing lines containing text")
                    print('--------------------------------------------------------------------------')
                    print("Notes:")
                    print("(*1*)          Pressing an unknown command key produces a '?'.")
                    print("(*2*)          Pressing the ENTER key also does the '+' function.")

                else:
                    print('?')


#------------------------------ ------------[ '/TEXT or ?TEXT' ]------------------------------------------------------------------  
                if len(inner.replace(" ", '')) > 2:
                    n = 0
                    w = 0
                    lst = []
                    searchForward = 0
                    searchBackward = 0
                    for i in inner:
                        if i == '/' and n == 0:
                            searchForward += 1
                        elif i == '?' and n == 0:
                            searchBackward += 1
                        elif i == 'w' and n== 0:
                            w += 1
                        else:
                            lst.append(i)
                        n += 1
                    word = ''.join(lst)
                    if searchForward != 1 and searchBackward != 1 and w != 1:
                        print("?")
                
                    if searchForward == 1:
                        n = 0
                        itr_reset(z1)
                        while itr_has_next(z1) and n == 0:
                            for i in z1.node.data.split():
                                if i == word:
                                    print( z1.node.data )
                                    n+=1
                            if n != 1:
                                itr_next(z1)
                        if n != 1:
                            for i in z1.node.data.split():
                                if i == word:
                                    print( z1.node.data )
                                    n+=1
                        if n != 1:
                            print("Could not find text")
                         
                    elif searchBackward == 1:
                        n = 0
                        itr_reset(z1, z1.lst.size)
                        while itr_has_prev(z1) and n == 0:
                            for i in z1.node.data.split():
                                if i == word:
                                    print( z1.node.data )
                                    n+=1
                            if n != 1:
                                itr_prev(z1)
                        if n != 1:
                            for i in z1.node.data.split():
                                if i == word:
                                    print( z1.node.data )
                                    n+=1
                        if n != 1:
                            print("Could not find text")
                    
                previouseInner = inner

main()
    


    

    
    

