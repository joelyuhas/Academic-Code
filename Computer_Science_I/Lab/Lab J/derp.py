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
    
    while len(tokens) != 0:
        if tokens[0] == '*':
            tokens.pop(0)
            left = parse(tokens)
            tokens.pop(0)
            right = parse(tokens)
            return MultiplyNode( left, right )

        elif tokens[0] == '//':
            tokens.pop(0)
            left = parse(tokens)
            tokens.pop(0)
            right = parse(tokens)
            return DivideNode( left, right )

        elif tokens[0] == '-':
            tokens.pop(0)
            left = parse(tokens)
            tokens.pop(0)
            right = parse(tokens)
            return SubtractNode( left, right )

        elif tokens[0] == '+':
            tokens.pop(0)
            left = parse(tokens)
            tokens.pop(0)
            right = parse(tokens)
            return AddNode( left, right )

        elif tokens[0].isdigit():
            val = int(tokens[0])
            return LiteralNode( val )

        elif tokens[0].isdigit() == False:
            name = str(tokens[0])
            return VariableNode( name )
        

def infix(node):
    """infix: Node -> String | TypeError
    Perform an inorder traversal of the node and return a string that
    represents the infix expression."""


    if isinstance(node, MultiplyNode) == True:
        return ('( ' + infix(node.left) + ' * ' + infix(node.right)+ ' )')
        
    elif isinstance(node, DivideNode) == True:
        return ('( ' + infix(node.left) + ' // ' + infix(node.right)+ ' )')

    elif isinstance(node, AddNode) == True:
        return ('( ' + infix(node.left) + ' + ' + infix(node.right)+ ' )')
        
    elif isinstance(node, SubtractNode) == True:
        return ('( ' + infix(node.left) + ' - ' + infix(node.right)+ ' )')
        
    elif isinstance(node, LiteralNode) == True:
        return str(node.val)
        
    elif isinstance(node, VariableNode) == True:
        return str(node.name)

    else:
        print("Character is not a reconized function!")
        return
        

 
  
      
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
        root = parse(preLst)
        ### ------------INFIX----------- ###     
        print("Derping the infix expression:", end=" ")
        print(infix(root))
        ### -----------EVALUATE--------- ###
        result = evaluate( root, symTbl )
        print( "Derping the evaluation:", result )
         
    print("Goodbye Herp :(")
    
if __name__ == "__main__":
    main()
