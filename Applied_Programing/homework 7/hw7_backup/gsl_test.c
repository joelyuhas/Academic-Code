 /*********************************************************************
 * Example: Using the GSL (Gnu Scientific Library) to solve a system 
 * of algebraic equations Ax=b via permuted LU factorization. 
 * No error checking
 *
 * Compile: gcc -ansi -lgsl -lgslcblas gsl_example.c -o lu
 *
 * Revision : Juan C. Cockburn, 1/13/13
 * Reference: Golub and Vanloan Algorithms 3.4.1
 * 05/25/2016 - Added P and LU debug info
 *********************************************************************/
     #include <stdio.h>
     #include <gsl/gsl_linalg.h>

#include <string.h>

#include <stdlib.h>
#include <getopt.h>
#include "apmatrix.h"
#include "ClassErrors.h"
#include "Timers.h"
     


DECLARE_TIMER(timerEliminationGSL);
DECLARE_TIMER(timerSolutionGSL);
     
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

    
   /* Gets the job done */
   if(mode == INPUT)
   {

	unsigned int i = 0, j = 0;
	int count = 0, size;
	int buff_size = 256, len, trigger = 0;
	int result;
	char *bb;
	char *line = (char *)malloc(2*sizeof(char));



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
		bb = strtok(line, " 	");
		count = 0;
		buff_size = atoi(bb);
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
			bb = strtok(line, " 	");
			size = atoi(bb);

			/* Error Checking */
			if(size > len){
				printf("\n\n **** WARNING ****\n\n");
				printf(" Inproper input! \n");
				printf(" The matrix was not entered in the correct format\n");
				printf("\n\n  EXITING \n\n");

				return(1);

			}

      /* Local variables */
       int k, l; /* Indices and counters       */
       int s;          /* Sign of the permutation    */
       int nr = size;     /* Matrix dimensions, rows    */
       int nc = size;     /* Matrix dimensions, columns */

       
       /* Declare and allocate matrix and vector variables */
       gsl_matrix *A = gsl_matrix_calloc (nr,nc) ; /* A */
       gsl_vector *b = gsl_vector_calloc (nr) ;    /* b */
       gsl_vector *x = gsl_vector_calloc (nc);     /* x */
       
       gsl_permutation *p = gsl_permutation_alloc (nr); /* Permutation Vector  for LU */

       /* Simple Example */
       /* A 3x3 matrix */
       double *a_data = (double *)malloc(size*size*sizeof(double));
                          
       /* b 3-vector */
       double *b_data = (double *)malloc(size*sizeof(double));
/*double a_data[size*size];
double b_data[size];*/

			
			
		/*
		 * MAIN DATA LOOP
		 * 
		 * Main loop that gets the meat of the data.
		 */
		i = 0;
		j = 0;
		while ( fgets (line, buff_size, DataFile) != NULL){

			/*Splicing Lines*/
			bb = strtok(line, " 	");
			
			/*
			 * CHARACTER LOOP
			 *
			 * Loop that seperates lines into characters and places
			 * them into the A and the B matrix
			 */
			while(bb != NULL){
				/*printf("retreived value %f \n", atof(b));*/
				
				if (j < size){
					
					a_data[size*i+j] = atof(bb);
					/*matA[i][j] = atof(b);*/
					
				} else {
					b_data[i] = atof(bb);
					
				}
				bb = strtok(NULL, " ");
				j++;

			}
			j = 0;
			
			i++;	
		}



       /* Initialize coefficient matrix A and vector b */
       /* use gsl_matrix_set  and gsl_vector_set */
       k = 0 ; l = 0 ; /* set counters  to zero */
       for (i=0;i<nr;i++) {
         for (j=0;j<nc;j++) {
            gsl_matrix_set(A,i,j,a_data[k]) ; 
            k++ ;
         } /* for j */
         
         gsl_vector_set(b,i,b_data[l]) ; 
         l++ ;
       } /* for i */

       /* Print entries of A use gsl_matrix_get and printf */
       /* do not use gsl_matrix_fprintf */

	if(verbose == 1){
       printf("Solution of the system Ax=b via PLU factorizations\n");
       printf("Matrix A:\n");
       for (i = 0; i < nr; i++) {
         for (j = 0; j < nc; j++)
           printf ("%7.2g ", gsl_matrix_get (A, i, j));
       putchar('\n');
       } /* for i */}
	

       

	if(verbose == 1){
       /* Print entries of vector b */
       printf("Vector b:\n");
       gsl_vector_fprintf (stdout, b,"%7.2g") ;}
	

START_TIMER(timerEliminationGSL);

       /* Perform (in place) PLU factorization */
       gsl_linalg_LU_decomp (A, p, &s); /* A is overwritten, p is permutation     */

STOP_TIMER(timerEliminationGSL);
       
       /* Print out the P and LU matrix */
	if(verbose == 1){
       fprintf(stdout, "\nP = [");
       gsl_permutation_fprintf (stdout, p, " %u");
       fprintf(stdout, " ] \n");}
	
       

	if(verbose == 1){
       fprintf(stdout, "LU matrix = \n");
       printf("Matrix LU:\n");
       for (i = 0; i < nr; i++) {
          for (j = 0; j < nc; j++) {
             printf ("%7.2g ", gsl_matrix_get (A, i, j));
          } 
       putchar('\n');
       } /* End for i */ }
	           




START_TIMER(timerSolutionGSL);
       
       /* Find solution using the PLU factors found above and b */
       gsl_linalg_LU_solve (A, p, b, x);

STOP_TIMER(timerSolutionGSL);

       /* Print solution x */
       printf("Solution x:\n");
       gsl_vector_fprintf (stdout, x, "%7.2g");
	
     
       /* Clean up - free heap memory */
       gsl_matrix_free (A);
       gsl_vector_free (b);
       gsl_permutation_free (p);
       gsl_vector_free (x);



PRINT_TIMER(timerEliminationGSL);
PRINT_TIMER(timerSolutionGSL);
}
}
       return 0;
     } /* main */
