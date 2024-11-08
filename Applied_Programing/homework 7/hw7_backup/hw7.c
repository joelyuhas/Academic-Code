/**************************************************************************
  Student frame work.   Add and remove as you see fit.
  
  07/14/2017    R. Repka    Initial release
 * ***********************************************************************/
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include "apmatrix.h"
#include "ClassErrors.h"
#include "Timers.h"


#define ITER 50000
#define BUFSIZE 4096





/************************************************************************
  Tests three types of root finding, secant, newton, and bisection,
  based on user input and prints out the timing results.
************************************************************************/
int main(int argc, char* argv[])
{
   /*------------------------------------------------------------------------
      UI variables with sentential values
   ------------------------------------------------------------------------*/
   int verbose = 0;
   enum modes {UNDEF, INPUT} mode = UNDEF;
/*  
 double tol = 0.0;
   double guess1 = INFINITY;   
   double guess2 = INFINITY;
   double result = 0;
   int maxIter = 100;
   func1arg f = &func1;
   func1arg df = &func1Deriv;
   char Coef, Mag;
   double Inc, CoefInt, MagInt;
   
*/

  FILE *DataFile = NULL; 


   /*------------------------------------------------------------------------
     These variables are used to control the getopt_long_only command line 
     parsing utility.  
   ------------------------------------------------------------------------*/
   int rc;
   /* getopt_long stores the option index here. */
   int option_index = 0;
  
   /* This contains the short command line parameters list */
   char *getoptOptions = "vi:"; 
  
   /* This contains the long command line parameter list, it should mostly 
     match the short list                                                  */
   struct option long_options[] = {
      /* These options don’t set a flag.
         We distinguish them by their indices. */
      {"verbose",	no_argument,		0, 'v'},
      {"verb",		no_argument,		0, 'v'},
      {"input",	 	required_argument,	0, 'i'},
      {"in",	 	required_argument,	0, 'i'},

      {0, 0, 0, 0}
   };
  
   opterr = 1;           /* Enable automatic error reporting */
   while ((rc = getopt_long_only(argc, argv, getoptOptions, long_options, 
                                                    &option_index)) != -1) {
       
      /* Detect the end of the options. */
      switch (rc)
        {
        case 'v':                    /* Verbose */
          verbose = 1;
          break;
        case 'i':                    /* Input File */
          mode = INPUT;
	  DataFile = fopen(optarg, "r");
          break;
	case ':':
	fprintf(stderr, "An operand is missing\n");
	break;

        case '?':  /* Handled by the default error handler */
	 fprintf(stderr, "An invalid optn was selected\n");
	 fflush(stderr);
          break;

       default:
          printf ("Internal error: undefined option %0xX\n", rc);
	  fflush(stderr);
          exit(PGM_INTERNAL_ERROR);
       } /* End switch */
   } /* end while */

   /*------------------------------------------------------------------------
     Check for command line syntax errors
   ------------------------------------------------------------------------*/

   if ((optind < argc)   ){
      fprintf(stderr, "Tests root finding methods\n");
      fprintf(stderr, "usage: hw7 -in[put] [FILENAME]   <-verb[ose]> \n");
      fprintf(stderr, " e.g:   hw7 -input FILENAME -verb\n"); 
      fflush(stderr);
      return(PGM_INTERNAL_ERROR);
   }  /*End if error */

    
   /* Performs the root finding with bisection */
   if(mode == INPUT)
   {

	unsigned int i = 0, j = 0;
	int count = 0, size;
	int buff_size = 256, len, trigger = 0;
	int result;
	char *b;
	char *line = (char *)malloc(2*sizeof(char));
	
	double **matA;

	double *vecB;

	rVector *rvecB, *rvecX;
	iVector *ivec;
	Matrix mat, * primeMat;
	 


	if (NULL != DataFile)
	{
		
		/*
		 * INITILZATION SECTION
		 *
		 * Getting the first value so it can set the size
		 * Then dynamically checks to ensure that the size picked
		 * will work as well	
		 */
		fgets (line, buff_size, DataFile); 
		len = strlen(line);

			

		b = strtok(line, " 	");
		count = 0;
		buff_size = atoi(b);
		line =  (char *)realloc(line, (8*buff_size)*sizeof(char));


		/*
		 * DYNAMIC ALLOCATION SECTION
		 *
		 * Used for dynamically alocating the line/buffer size and
		 * ensuring it is correct.
		 *
 		 * Rewinds every time so that the program is sure not to miss
		 * any values.
		 * 
		 * Reads twice, once to read the first two numbers, second to
		 */
		while(len == buff_size - 1 || trigger == 0){
			rewind(DataFile);
			buff_size = buff_size * 2;
			fgets (line, buff_size, DataFile); 
			fgets (line, buff_size, DataFile); 
			len = strlen(line);

			line =  (char *)realloc(line, (2*buff_size)*sizeof(char));
			trigger = 1;
		}
		

		int tempArray[buff_size];
		rewind(DataFile);

		
		/*
		 * READING AND MATRIX INITILIZATION SECTION
		 *
		 * Gets the first line to set matrix size
		 */
		fgets (line, buff_size, DataFile); 
			b = strtok(line, " 	");
			
			
			/* setting Matrix A */
			size = atoi(b);


			/* Error checking, if the size is greater then len
			   then theres most likely an issue and should 
			   abandon ship */
			if(size > len){
				printf("\n\n **** WARNING ****\n\n");
				printf(" Inproper input! \n");
				printf(" The matrix was not entered in the correct format\n");
				printf("\n\n  EXITING \n\n");

				return(1);

			}


			mat.nr = size;
			mat.nc = size;


			primeMat = m_alloc(size, size);
			rvecB = rv_alloc(size);
			rvecX = rv_alloc(size);
			ivec = iv_alloc(size);
			
			
		/*
		 * MAIN DATA LOOP
		 * 
		 * Main loop that gets the meat of the data.
		 */
		i = 0;
		j = 0;
		while ( fgets (line, buff_size, DataFile) != NULL){

			/*Splicing Lines*/
			b = strtok(line, " 	");
			
			/*
			 * CHARACTER LOOP
			 *
			 * Loop that seperates lines into characters and places
			 * them into the A and the B matrix
			 */
			while(b != NULL){
				
					


				if (j < size){
					primeMat->mat[i][j] = atof(b);
				} else {
					rvecB->vec[i] = atof(b);
					ivec->ivec[i] = atoi(b);
				}
				b = strtok(NULL, " ");
				j++;
			}
			j = 0;
			
			i++;	

		}


		/*
		 * VERBOSE PRINTING
		 */
		if(verbose == 1){
			printf("A= \n");
			m_print(primeMat, " % 6.4f");
			printf("\nb= \n");
			rv_print(rvecB,"      % 6.4f\n");
			printf("\n");
		}


		/*
		 * PLU_SOLVER CALL
		 */
		PLU_solve(primeMat, ivec, rvecB, rvecX);

		if(verbose == 1){
			printf("P = [");
			iv_print(ivec," % d");
			printf(" ] \n");
			printf("LU = \n");
			m_print(primeMat, " % 6.4f");
		}
		printf("x= \n");
		rv_print(rvecX,"      % 6.4f\n");
		printf("\n");






		/*
		 * FREE/CLOSE
		 *
		 * Closing and Freeing the data
		 */
		fclose(DataFile);
		free(line);
		rv_free(rvecB);
		rv_free(rvecX);
		iv_free(ivec);
		m_free(primeMat);

	}else{
	fprintf(stderr, "File type is incorrect!\n");

	}

   }  /* End INPUT   */
        
    return (PGM_SUCCESS);
}
