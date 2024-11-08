/******************************************************************************
 An student framework implementation to test the LinkedLists module.  
 Reads in a large list of words and puts them into the data structure, 
 then prints out the first and last six elements in the data structure as 
 well as the total number of words.
 Note: This is only a framework, it does not include ALL the functions or 
       code you will need.
******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "ClassErrors.h"
#include "LinkedLists.h"
#include "DynamicArrays.h"
#include "Timers.h"



void ReadData(FILE *InputFile, LinkedLists *ListPtr, DArray *DPtr)
  {
   	ElementStructs TempData;             /* temp variable to hold data   */
   	Data TempDynamic;
	int lcv = 1;               /* loop control variable        */
   //int strLen;                /* The actual input string length */
   char String[MAX_STR_LEN+2];/* temp variable to hold string */
   char formatStr [32];       /* Used to build the dynamic length */
   int skip = 0;	      /* Used for skipping extra string bits */
   
   /* Build a dynamic format string */
   sprintf(formatStr, "%c%d%c", '%', MAX_STR_LEN+1, 's');
   
   /* Read the data in from the file into the String buffer */
   while (EOF != fscanf(InputFile, formatStr, String))
     {
      /* Insert code here to make sure the input data is not too long
          hint:  use strlen(String)   */
	// checks size
	if (strlen(String) <= MAX_STR_LEN && skip == 0){
		
		// string is correct size, add it

		/*Linked List*/
		TempData.Num = lcv++;
		strncpy(TempData.String, String, MAX_STR_LEN);
		AddToBackOfLinkedList(ListPtr, &TempData);

		/*Dynamic Array*/
		TempDynamic.Num = lcv;
		strncpy(TempDynamic.String, String, MAX_STR_LEN);	
		PushToDArray(DPtr, &TempDynamic);


	}
	else
	{
		// string is too big,

		// toggle mechanism for skipping the extra bits at the end of
		// a string. Know that the next string is part of the 255
		// string because if it is > 255 then it has at least one char
		// that extends over.

		if (skip == 0)
		{ 
			skip = 1;
			fprintf(stderr, "\n");
			fprintf(stderr, "**A string was found to be too big. Ignoring word.**\n");
			fprintf(stderr, "**TestList.c Line 188**\n");
			fprintf(stderr, "\n");
			fflush(stderr);
		}

		else
		{
			skip = 0;
		}
		
		
	
	}

     } /* while() */
  } /* ReadData() */

/* Local functions */
/******************************************************************************
 Program to test the Data structure by reading the Data file provided on
 the command line into the structure, printing out the first and last five
 elements and total number of elements.

 Where: int argc     - the number of parameters on the command line
        char *argv[] - Pointer to the command line parameters
 Returns: 0 - success, 
          2 - can't open input file
          1 - Invalid number of parameters
******************************************************************************/


DECLARE_TIMER(timerRead);
DECLARE_TIMER(timerSearchLL);
DECLARE_TIMER(timerSearchDA);
DECLARE_REPEAT_VAR(repeat);
DECLARE_REPEAT_VAR(repeat1);
DECLARE_REPEAT_VAR(repeat2);
DECLARE_REPEAT_VAR(repeat3);

int main(int argc, char* argv[])
  {
  /* declare local variables */


	int ErrorCode = 0;
	LinkedLists TestLinkedList;
	DArray TestDynamicList;
	FILE *DataFile = NULL;
 

	// Total Timing Macros
	DECLARE_TIMER(timerMain);
	START_TIMER(timerMain);
	BEGIN_REPEAT_TIMING(5,repeat2);

	printf("\n");
	printf("--------------------- Test %d -------------------\n", repeat2);
	printf("\n");


   /* One command line argument is required: the file name     */
   if (3 == argc) /* note that argc 2 means one argument given */
     {
      /* Print out an opening message with the file name 
         then try to open the Data file for input (read mode)   */
	
/*******READING**************************************************************/
	// Data timing macro
	START_TIMER(timerRead);


 	DataFile = fopen(argv[1], "r");

      /* Verify that file was opened correctly */
      if (NULL != DataFile)
        {
         /* Initialize the list */
	printf("Initialzing\n");
	InitLinkedList(&TestLinkedList);
	CreateDArray(&TestDynamicList, 100);	

         /* Read all Data from text file */
	printf("Reading\n");
	ReadData(DataFile, &TestLinkedList, &TestDynamicList);
         
         /* Close the Data file */
	printf("Closing\n");
  	fclose(DataFile);



	//END_REPEAT_TIMING;
	STOP_TIMER(timerRead);
	PRINT_TIMER(timerRead);

/*******READING DONE*********************************************************/

         /* Print the first 6 entries */
         fprintf(stdout, "First 6 words in linked list:\n");
	int i = 6;
	LinkedListNodes *Node;
	Node = TestLinkedList.FrontPtr;
	while (i > 0){
		printf("\n");
		printf("%d: %s",Node->ElementPtr->Num,Node->ElementPtr->String);
		
		if (Node->Next != NULL){
			Node = Node->Next;
		}
		else{
			i = 0;
		
		}

		i--;
	}
	printf("\n");
	printf("\n");



         /* Print the last 6 entries */
         fprintf(stdout, "Last 6 words in linked list:\n");

	i = 6;
	Node = TestLinkedList.BackPtr;
	while (i > 0){
		printf("\n");
		printf("%d: %s",Node->ElementPtr->Num,Node->ElementPtr->String);
		
		if (Node->Previous != NULL){
			Node = Node->Previous;
		}
		else{
			i = 0;
		
		}

		i--;

	}
	printf("\n");
	printf("\n");

         
         /* Print total number of words read */
         fprintf(stdout, "Number of words: %d \n", TestLinkedList.NumElements);


	
/*******SEARCHING************************************************************/
	/*Search With Linked List*/
	fprintf(stdout,"The word being searched for is: %s\n", argv[2]);

	ElementStructs *SearchNode;
	char tempString[256];
	strcpy(tempString, argv[2]);

	fprintf(stdout,"Calling Linked List Search\n");

	START_TIMER(timerSearchLL);
	BEGIN_REPEAT_TIMING(200,repeat1);

	SearchNode = (*SearchList)(&TestLinkedList,tempString);

    	END_REPEAT_TIMING;
	STOP_TIMER(timerSearchLL);
	PRINT_TIMER(timerSearchLL);
	PRINT_RTIMER(timerSearchLL,200);

	printf("Match found: %s\n", SearchNode->String);


	/*Search With Dynamic Array*/
	fprintf(stdout,"Calling Dynamic Array Search\n");
	Data *SearchDArray1;


	START_TIMER(timerSearchDA);
	BEGIN_REPEAT_TIMING(200,repeat3);

	SearchDArray1 = (*SearchDArray)(&TestDynamicList,tempString);

    	END_REPEAT_TIMING;
	STOP_TIMER(timerSearchDA);
	PRINT_TIMER(timerSearchDA);
	PRINT_RTIMER(timerSearchDA,200);



	printf("Match Found: %s\n", SearchDArray1->String);

	fprintf(stdout,"\n");

	
/*******SEARCHING DOEN*******************************************************/



         /* Remove from front of list, print a message */
	ElementStructs *FrontRemove;
	FrontRemove = (*RemoveFromFrontOfLinkedList)(&TestLinkedList);

           fprintf(stdout, "Remove from front of list, new front is: %s \n", TestLinkedList.FrontPtr->ElementPtr->String);
           fprintf(stdout, "Removed value is: %s \n", FrontRemove->String);

         
		FREE_DEBUG(FrontRemove);

         /* Remove from back of list, print a message */
	ElementStructs *BackRemove;
	BackRemove = (*RemoveFromBackOfLinkedList)(&TestLinkedList);



             fprintf(stdout, "Remove from back of list, new back is: %s \n", TestLinkedList.BackPtr->ElementPtr->String);
             fprintf(stdout, "Removed value is: %s \n", BackRemove->String);
           
		FREE_DEBUG(BackRemove);

            
         /* De-allocate the linked list */
         fprintf(stdout, "Destroying the linked list\n"); 
	  DestroyLinkedList(&TestLinkedList);

	  

        } /* if() */
      else
      { /* Error message */
	/* File was incorrect*/
	fprintf(stderr, "File type is incorrect!\n");
	fprintf(stderr, "\n");
	fprintf(stderr, "This program takes in a file and places all words, sperated\n");
	fprintf(stderr, "by a space, and places them into a linked list.\n");
	fprintf(stderr, "\n");
	fprintf(stderr, "To input the desired file, enter the following on the\n");
	fprintf(stderr, "command line:\n");
	fprintf(stderr, "	./TestList.c FILENAME.txt \n");
	fprintf(stderr, "\n");
	fprintf(stderr, "The file that the program tried to open was:\n");
	fprintf(stderr, "	%s\n", argv[1]);

	fprintf(stderr, "\n");

	fflush(stderr);

	ErrorCode = 2;   

      } /* if...else() */
     } /* if() */
   else
     { /* Usage message */
	/* Paramaters were incorrect*/

	fprintf(stderr, "Wrong Program Call!\n");
	fprintf(stderr, "\n");
	fprintf(stderr, "This program takes in a file and places all words, sperated\n");
	fprintf(stderr, "by a space, and places them into a linked list.\n");
	fprintf(stderr, "\n");
	fprintf(stderr, "To input the desired file, enter the following on the\n");
	fprintf(stderr, "command line:\n");
	fprintf(stderr, "	./TestList.c FILENAME.txt \n");
	fprintf(stderr, "\n");

	fprintf(stderr, "\n");

	fflush(stderr);

	ErrorCode = 1;
  
     } /* if...else() */


	RESET_TIMER(timerRead);
	RESET_TIMER(timerSearchLL);
	RESET_TIMER(timerSearchDA);

	END_REPEAT_TIMING;
	STOP_TIMER(timerMain); 
	PRINT_TIMER(timerMain);
	PRINT_RTIMER(timerMain, 5);


   return ErrorCode;
  } /* main() */

 

