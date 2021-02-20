

def main():
    
    print("Hello Herp, welcome to Derp v1.0 :)")
    """
    inFile = input("Herp, enter symbol table file: ")
    openFile = open(inFile)

    symTbl = dict()
    for line in openFile:
        tempWord = 'a'
        for word in line.split():
            if word.isdigit() == False:
                tempWord = word
            elif word.isdigit() == True:
                symTbl[tempWord] = word

    for varName in symTbl:
        print('name:', varName, '=>', 'Value:', symTbl[varName])
        """

    
    print("Herp, enter prefix expressions, e.g.: + 10 20 (RETURN to quit)...")
    
    


def infix(node):
    """infix: Node -> String | TypeError
    Perform an inorder traversal of the node and return a string that
    represents the infix expression."""


    lst = []

    if isinstance(node, MultiplyNode) == True:
        lst.apppend('(')
        parse(node.left)
        lst.append('*')
        parse(node.right)
        lst.apppend(')')
        
        
    elif isinstance(node, DivideNode) == True:
        lst.apppend('(')
        parse(node.left)
        lst.append('//')
        parse(node.right)
        lst.apppend(')')
        
        

    elif isinstance(node, AddNode) == True:
        lst.apppend('(')
        parse(node.left)
        lst.append('+')
        parse(node.right)
        lst.apppend(')')
        


    elif isinstance(node, SubtractNode) == True:
        lst.apppend('(')
        parse(node.left)
        lst.append('-')
        parse(node.right)
        lst.apppend(')')
        
        

    elif isinstance(node, LiteralNode) == True:
        lst.append(node.val)
        

    elif isinstance(node, VariableNode) == True:
        lst.append(node.name)



main()
