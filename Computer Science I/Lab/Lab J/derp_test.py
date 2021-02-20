"""
141 Tree Lab - Derp the Interpreter

Derp is a simple interpreter that parses and evaluates prefix expressions 
containing basic arithmetic operators (*,//,-,+).  It performs arithmetic with
integer only operands that are either literals or variables (read from a 
symbol table).  It dumps the symbol table, produces the expression infix with 
parentheses to denote order of operation, and evaluates/produces the result of 
the expression.

Author: Sean Strout (sps@cs.rit.edu)

Author: Joel Yuhas jxy8307@g.rit.edu
"""

from derp_node import *
    
####REMOVED PREVIOUSE HASHTAGGED NOTES FOR CLEANLINESS
    
def parse(tokens):
    """parse: list(String) -> Node
    From a prefix stream of tokens, construct and return the tree,
    as a collection of Nodes, that represent the expression.
    """
    if tokens == None:
        print ("There is nothing here")
        return
    
    global n
    while len(tokens) != 0:
        if tokens[n] == '*':
            n+=1
            left = parse(tokens)
            right = parse(tokens)
            return MultiplyNode( left, right )

        elif tokens[n] == '//':
            n+=1
            left = parse(tokens)
            right = parse(tokens)
            return DivideNode( left, right )

        elif tokens[n] == '-':
            n+=1
            left = parse(tokens)
            right = parse(tokens)
            return SubtractNode( left, right )

        elif tokens[n] == '+':
            n+=1
            left = parse(tokens)
            right = parse(tokens)
            return AddNode( left, right )

        elif tokens[n].isdigit():
            n+=1
            val = int(tokens[n-1])
            return LiteralNode( val )

        elif tokens[n].isdigit() == False:
            n+=1
            name = str(tokens[n-1])
            return VariableNode( name )
        

def infix(node):
    """infix: Node -> String | TypeError
    Perform an inorder traversal of the node and return a string that
    represents the infix expression."""

    global lst

    if isinstance(node, MultiplyNode) == True:
        lst.append('(')
        infix(node.left)
        lst.append('*')
        infix(node.right)
        lst.append(')')
        
    elif isinstance(node, DivideNode) == True:
        lst.append('(')
        infix(node.left)
        lst.append('//')
        infix(node.right)
        lst.append(')')

    elif isinstance(node, AddNode) == True:
        lst.append('(')
        infix(node.left)
        lst.append('+')
        infix(node.right)
        lst.append(')')
        
    elif isinstance(node, SubtractNode) == True:
        lst.append('(')
        infix(node.left)
        lst.append('-')
        infix(node.right)
        lst.append(')')
        
    elif isinstance(node, LiteralNode) == True:
        lst.append(node.val)
        
    elif isinstance(node, VariableNode) == True:
        lst.append(node.name)

    else:
        print("Character is not a reconized function!")
        return
        
    return lst
 
  
      
def evaluate(node, symTbl):
    """evaluate: Node * dict(key=String, value=int) -> int | TypeError
    Given the expression at the node, return the integer result of evaluating
    the node.
    Precondition: all variable names must exist in symTbl"""
    
    if isinstance(node, MultiplyNode) == True:
        return evaluate(node.left, symTbl) * evaluate(node.right, symTbl)
           
    elif isinstance(node, DivideNode) == True:
        return evaluate(node.left, symTbl) // evaluate(node.right, symTbl)
        
    elif isinstance(node, AddNode) == True:
        return evaluate(node.left, symTbl) + evaluate(node.right, symTbl)
    
    elif isinstance(node, SubtractNode) == True:
        return evaluate(node.left, symTbl) - evaluate(node.right, symTbl)
    
    elif isinstance(node, LiteralNode) == True:
        return node.val
    
    elif isinstance(node, VariableNode) == True:
        for q in symTbl:
            
            if str(q) == str(node.name):
                return int(symTbl[q])
        
    
def symTblConst(openFile):
    """
    symTblConst: file -> dictonary
    Opens a file, puts the items into and their values into a dictnary and prints those value pairs as well.
    """
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
    
    return symTbl
                     
def main():
    """main: None -> None
    The main program prompts for the symbol table file, and a prefix 
    expression.  It produces the infix expression, and the integer result of
    evaluating the expression
    """
    
    print("Hello Herp, welcome to Derp v1.0 :)")
    inFile = input("Herp, enter symbol table file: ")
    openFile = open(inFile)
    symTbl = symTblConst(openFile)
    print("Herp, enter prefix expressions, e.g.: + 10 20 (RETURN to quit)...")
    
    while True:
        prefixExp = input("derp> ")
        if prefixExp == "":
            break
        ### --------LIST FORMATION------ ###
        preLst = []
        for i in prefixExp.split():
            preLst.append(i)  
        ### ------------PARSE----------- ###
        global n
        n = 0
        root = parse(preLst)
        ### ------------INFIX----------- ###   
        global lst
        lst = []
        infEqaution = infix(root)
           
        print("Derping the infix expression:", end=" ")
        for w in infEqaution:
            print(w, end=" ")
        print()
        ### -----------EVALUATE--------- ###
        result = evaluate( root, symTbl )
        print( "Derping the evaluation:", result )
         
    print("Goodbye Herp :(")
    
if __name__ == "__main__":
    main()
