/******************************************************************************
 An student framework implementation of doubly linked lists that holds 
 elements containing a 256 character string and a sequence number.
 12/24/2017 - R. Repka     Removed AddToFrontOfLinkedList()
******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ClassErrors.h"
#include "LinkedLists.h"

/******************************************************************************
 Initialize the linked list data structure

 Where: LinkedLists *ListPtr - Pointer to the linked list to create
 Returns: nothing
 Errors: none
******************************************************************************/
void InitLinkedList(LinkedLists *ListPtr)
{
	ElementStructs *InitA = NULL;
	ListPtr->NumElements = 0;
	ListPtr->FrontPtr = NULL;
	ListPtr->BackPtr = NULL;

}


/******************************************************************************
 Adds a node to the back of the list.

 Where: LinkedLists *ListPtr    - Pointer to the linked list to add to
        ElementStructs *DataPtr - Pointer to the data to add to the list
 Returns: nothing
 Errors: Prints to stderr and exits
******************************************************************************/
void AddToBackOfLinkedList(LinkedLists *ListPtr, ElementStructs *DataPtr)
{

/*--------Creating Temp Variables, node, and alocation Memeory--------------*/
	/*Initaizlizing Node*/
	LinkedListNodes *Node;
	Node->ElementPtr = NULL;
	Node->Next = NULL;
	Node->Previous = NULL;


	/*Creating ElemnetStruct Malloc*/
	ElementStructs *tmp = NULL;
	tmp = (ElementStructs *)malloc(sizeof(ElementStructs));
	if (tmp == NULL){
		fprintf(stderr, "MALLOC FAILED!\n");
		fprintf(stderr, "LinkedList.c Line ...\n");
	}	
	else{
		/*Now have malloced sized block saved in Node*/
		Node->ElementPtr = tmp;
	}


	/*Copying Value into Node*/
	memcpy(&(Node->ElementPtr[0], DataPtr, sizeof(ElementStructs));



/*--------Adding to Linked List---------------------------------------------*/
	/*Case where List is empty*/
	if (ListPtr->BackPtr == NULL){
		DataPtr->Num = 0;
		ListPtr->BackPtr = Node;
		ListPtr->FrontPtr = Node;
		ListPtr->NumElements = 1;

	}
	/*List is not Empty*/
	else{
		DataPtr->Num = ListPtr->NumElements;
		Node->Previous = ListPtrBackPtr;
		ListPtr->BackPtr = Node;
		ListPtr->NumElements = ListPtr->NumElements + 1;

	}

}

/******************************************************************************
 Removes a node from the front of the list and returns a pointer to the node
 data removed. On empty lists should return a NULL pointer.
 Note: This will destroy the node but not the associated ElementStruct data element.
  
 Where: LinkedLists *ListPtr    - Pointer to the linked list to remove from
 Returns: Pointer to the node removed or NULL for none
 Errors: none
******************************************************************************/
ElementStructs *RemoveFromFrontOfLinkedList(LinkedLists *ListPtr)
{
	/*Empty Case*/
	if( ListPtr->FrontPtr == NULL ){
		return (NULL);
	}
	else{
		ListPtr->FrontPtr	
		

	}

}

/******************************************************************************
 Removes a node from the back of the list and returns a pointer to the node
 data removed. On empty lists should return a NULL pointer.
 Note: This will destroy the node but not the associated ElementStruct data element.
  
 Where: LinkedLists *ListPtr    - Pointer to the linked list to remove from
 Returns: Pointer to the node removed or NULL for none
 Errors: none
******************************************************************************/
ElementStructs *RemoveFromBackOfLinkedList(LinkedLists *ListPtr)
{

}


/******************************************************************************
 De-allocates the linked list and resets the struct fields (in the header) 
 to indicate that the list is empty.

 Where: LinkedLists *ListPtr    - Pointer to the linked list to destroy
 Returns: nothing
 Errors: none
******************************************************************************/
void DestroyLinkedList(LinkedLists *ListPtr)
{

}


/******************************************************************************
 Searches the linked list for a provided word. If found, returns the pointer
 to the element struct. If not found, returns a NULL pointer
 
 Where: LinkedLists *ListPtr - Pointer to the linked list to search
        char *String         - Pointer to the string to search
 Returns: Pointer to the element if found, NULL otherwise
 Errors: none
 * ***************************************************************************/
ElementStructs *SearchList(LinkedLists *ListPtr, char *String)
{

}




