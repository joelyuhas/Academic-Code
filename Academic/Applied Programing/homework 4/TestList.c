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
int main(int argc, char* argv[])
  {
  /* declare local variables */
	int ErrorCode = 0;
	LinkedLists TestLinkedList;
	FILE *DataFile = NULL;
 
   /* One command line argument is required: the file name     */
   if (2 == argc) /* note that argc 2 means one argument given */
     {
      /* Print out an opening message with the file name 
         then try to open the Data file for input (read mode)   */
	
 	DataFile = fopen(argv[1], "r");

      /* Verify that file was opened correctly */
      if (NULL != DataFile)
        {
         /* Initialize the linked list */
	InitLinkedList(&TestLinkedList);

         /* Read all Data from text file */
	 ReadData(DataFile, &TestLinkedList);
         
         /* Close the Data file */
  	fclose(DataFile);

         /* Print the first 6 entries */
         fprintf(stdout, "First 6 words in linked list:\n");
	 printf(TestLinkedList.NumElements);
	 printf("\n");
	 printf(TestLinkedList.FrontPtr.ElementPtr.Num);
	 printf("\n");
	 printf(TestLinkedList.FrontPtr.ElementPtr.String);
	 printf("\n");
          
         /* Print the last 6 entries */
         fprintf(stdout, "Last 6 words in linked list:\n");
         
         /* Print total number of words read */
         fprintf(stdout, "Number of words: %d \n", TestLinkedList.NumElements);
         
         /* Remove from front of list, print a message */
             fprintf(stdout, "Remove from front of list, new front is: %s \n", );
             fprintf(stdout, "Removed value is: %s \n", );

         
         /* Remove from back of list, print a message */
             fprintf(stdout, "Remove from back of list, new back is: %s \n", );
             fprintf(stdout, "Removed value is: %s \n", );
           
            
         /* De-allocate the linked list */
         fprintf(stdout, "Destroying the linked list\n"); 

        } /* if() */
      else
      { /* Error message */
   
      } /* if...else() */
     } /* if() */
   else
     { /* Usage message */
  
     } /* if...else() */

   return ErrorCode;
  } /* main() */

 void ReadData(FILE *InputFile, LinkedLists *ListPtr)
  {
   ElementStructs *TempData;             /* temp variable to hold data   */
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
		TempData->Num = lcv++;
		strncpy(TempData->String, String, MAX_STR_LEN);
		AddToBackOfLinkedList(ListPtr, ListPtr, TempData);
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

