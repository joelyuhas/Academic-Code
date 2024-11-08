from rit_object import *
from dlList import *
from dlNode import *


def customTest_1():
    a = createList()
    print (a)
    lst = ["hello how are you?"]
    append (a, 'hello')
    append (a, 'hi' )
    append (a, 'how' )
    append (a, 'are' )
    c = 4444
    b = c
    c = 555555
    print(b)
    printer(a)

    print()
    print("-------------------INSERTING---------------------")

    insertAt( a, 4, "bmble")
    printer(a)

    print()  
    print("------------------------GETTING---------------------")
    print(get(a, 4))

    print()
    print("-------------------------SETTING---------------------")
    set( a, 4, "not now")
    printer(a)

    print()
    print("----------------------POPPING---------------------")
    pop(a, 4)
    printer(a)

    print()
    print("--------------------------INDEXING---------------------")
    print(index(a, "hi"))
    print(isEmpty(a))



    print()
    print("--------------------------ITER CREATE---------------------")
    print(itr_create( a, 1 ))
    z = itr_create(a,1)
    printer(z)


    print()
    print("--------------------------ITER RESET---------------------")
    itr_reset(z, 0)
    printer(z)

    print()
    print("--------------------------ITER IS VALID---------------------")
    append(a, "its very nice to meet you")
    print(z.generation)
    print(z.lst.generation)
    print(itr_is_valid(z))

    print()
    print("--------------------------ITER HAS NEXT---------------------")
    itr_reset( z, 3)
    print(itr_has_next(z))
    itr_reset( z, 4)
    print(z.node.next)
    print(itr_has_next(z))

    print()
    print("--------------------------ITER HAS PREV---------------------")
    itr_reset( z, 4)
    print(itr_has_prev(z))
    itr_reset( z, 0)
    print(z.node.prev)
    print(itr_has_prev(z))


    print()
    print("--------------------------ITER FETCH---------------------")
    print(itr_fetch(z))
    itr_reset( z, 3)
    print(itr_fetch(z))
    
    
    print()
    print("--------------------------ITER NEXTER---------------------")
    itr_reset( z, 2)
    print(z.node.data)
    print(z.node.next.data)
    print(itr_next(z))
    print(z.node.data)


    print()
    print("--------------------------ITER PREV---------------------")
    print(z.node.data)
    print(z.node.prev.data)
    print(itr_prev(z))
    print(z.node.data)
    

    print()
    print("--------------------------TO STRING---------------------")
    printer(a)
    q = toString(a)
    print(q)




    print()
    print("--------------------------CLEARING---------------------")
    clear( a)
    print(isEmpty(a))
    print (a )

def main2():
    a = createList()
    print (a)
    lst = ["hello how are you?"]
    append (a, 'hello')
    append (a, 'hi' )
    append (a, 'how' )
    append (a, 'are' )
    c = 4444
    b = c
    c = 555555
    print(b)
    printer(a)
    pop(a, 0)
    printer(a)
    pop(a,0)
    printer(a)
    pop(a,0)
    printer(a)
    pop(a,0)
    append (a, "now")
    printer(a)
    append (a, "bow")
    printer(a)
    append (a, "tooow")
    printer(a)

    
    

main2()
