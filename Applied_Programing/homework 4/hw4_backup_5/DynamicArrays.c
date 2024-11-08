/**
 ** DynamicArrays.c  - private implementations - student file
 **
 ** Implementation of a (constant growth) Dynamic Array data type             
 **   Modify struc Data in DynamicArrays.h for payload according application  
 **   To change growth policy modify PushToDArray as needed                   
 **                                                                           
 ** Written by: Greg Semeraro,Ph.D.                                           
 ** Modified: Dr. Juan C. Cockburn (jcck@ieee.org)                            
 ** Revised: 02/01/2014 JCCK     
 **          10/02/2015 R Repka 
 **          03/03/2017 R Repka
 **          07/21/2017 R.Repka - added class errors include file
 **          09/25/2017 R.Repka - Minor psuedo code correction
 **/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ClassErrors.h"
#include "DynamicArrays.h"

/***************************************************************************
 CreateDArray -- Allocates memory and initializes DArray state             
        void CreateDArray(DArray *DArrayHead, unsigned int InitialSize)
 Where:
    DArray *DArrayHead       - Pointer to a storage block which holds the
                               data structure entry 
    unsigned int InitialSize - The initial data block size, could be 0
    returns: void            - nothing is returned.
    errors:                  - This routine will print an error message to 
                               stderror and exit with an error code
 **************************************************************************/
void CreateDArray(DArray *DArrayHead, unsigned int InitialSize) {
   /************************************************************************
   Pseudo code: 
   Initialize array with 0 entries used 
   Initialize capacity (you decide, could be zero)
   Based on capacity allocate memory storage, if necessary 
      If initial capacity is zero, no allocation needed 
      else Allocate storage space for payload according to struc Data
   if memory not allocated print error to stderr and exit with a code 
  ************************************************************************/

	Data *tmp = NULL;
	DArrayHead->Capacity = InitialSize;
	DArrayHead->EntriesUsed = 0;
	printf("Initializing Array");

	// checking the inital size
	if (InitialSize != 0) {

		// mallocing to a temp variable
		tmp = (Data *)malloc(InitialSize * sizeof(Data));

		// checking if malloc was succesful
		if (tmp == NULL) {
			fprintf(stderr, "Malloc failed creating the array.\n");
			fprintf(stderr, " DynamicArrays.c Line 53\n");
			fflush(stderr);
		}
		else{
			// assigning the malloced amount back
			DArrayHead->Payload = tmp;
		}
	}
  
} /* CreateDArray() */


/***************************************************************************
  PushToDArray -- Adds data at the end of the dynamic array and updates its 
                  state in the array header.  If full, reallocates memory 
                  space according to growth policy                          
        unsigned int PushToDArray(DArray *DArrayHead, Data *PayloadPtr)     
Where:
    DArray *DArrayHead      - Pointer to a storage block which holds the
                              data structure entry 
    Data * PayloadPtr       - 
    returns: unsigned int   - The index of the last element inserted
    errors:                 - This routine will print an error message to 
                              stderror and exit with an error code 
 **************************************************************************/
unsigned int PushToDArray(DArray *DArrayHead, Data *PayloadPtr)
{
   /************************************************************************
    Pseudo code: 
    Check if the array needs to be made larger 
    If yes, increase the size of the dynamic array 
    Re-allocate storage for the array elements using larger size 
    if memory not re-allocated print error to stderr and exit 
    Copy the Data in PlayloadPtr into the Darray
    Increment the number of elements used in Darray header 
    Return the array index of last element inserted 
   ************************************************************************/
	Data *tmp = NULL;
	int SizeCheck = DArrayHead->Capacity;
	int EntryCheck = DArrayHead->EntriesUsed;
	int EntriesLeft = SizeCheck - EntryCheck;


	if (EntriesLeft <= 0 ) {

		// There are not enough spaces left, need to allocate more
		DArrayHead->Capacity = DArrayHead->Capacity + GROWTH_AMOUNT;

		// reallocing to a temp pointer
		tmp = realloc(DArrayHead->Payload, sizeof(Data)*DArrayHead->Capacity);

		// checking if realloc was successful
		if (tmp == NULL) {
			fprintf(stderr, "Malloc failed pushing to array\n");
			fprintf(stderr, " DynamicArrays.c Line 107\n");
			fflush(stderr);
		}
		else {
			// assigning the realloced amount back
			DArrayHead->Payload = tmp;
		}

		
	}

	//Copying Values into array
	memcpy(&(DArrayHead->Payload[DArrayHead->EntriesUsed]), PayloadPtr, sizeof(Data));

	//incrementing value
	DArrayHead->EntriesUsed++;

	return (unsigned int)(DArrayHead->EntriesUsed -1 );


} /* PushToDArray() */


/*************************************************************************
 DestroyDArray -- Returns the memory back to the heap and updates the   
                  state in the array header      
        void DestroyDArray(DArray *DArrayHead)
  Where:
    DArray *DArrayHead  - Pointer to a storage block which holds the
                          data structure entry 
    returns: void       - nothing is returned.
    errors:             - No errors are reported
*************************************************************************/
void DestroyDArray(DArray *DArrayHead)
{
   /**********************************************************************
    Pseudo code: 
    Set the number of entries used to zero in Darray header 
    Set the capacity to zero in Darray header
    De-allocate the storage for the array elements 
 *************************************************************************/
	free(DArrayHead->Payload);
	DArrayHead->Payload = NULL;
	DArrayHead->Capacity = 0;
	DArrayHead->EntriesUsed = 0;

 
} /* DestroyDArray() */



Data *SearchDArray(DArray *DArrayHead, char *String)
{
	int i = 0;

	/*checks if null*/
	if(DArrayHead->Payload != NULL){
		/*if is true, then a match*/
		while( i <= DArrayHead->Capacity){
			if(strcmp(DArrayHead->Payload[i].String, String) == 0){
				/*printf("Match Found: ");*/
				return(&DArrayHead->Payload[i]);
			}
			i++;
		}
		printf("No Matches!\n");
		return NULL;
	} else {

	printf("Brah the list is empty wat u doin");
	return NULL;
	}


} /* SearchDArray */

