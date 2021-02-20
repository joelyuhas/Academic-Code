/********************************************************************
 * Applied Programming:                                             
 *    Solution of Overdetermined System of Equations Ax=b arising   
 *    in least square problems via QR factorizations using the GSL                                                 *                                                                  
 * Compilation:  gcc -ansi -g -lgsl -lgslcblas  hw8.c DynamicArrays.c -o  hw8
 *                                                                  
 * Tested in Ubuntu 12.04 LTS                                       
 * Revised: Juan C. Cockburn, April 9, 2015 (juan.cockburn@rit.edu) 
 * 10/10/2015 R. Repka - Minor clean up
 * 10/26/2016 R. Repka - Major re-write, added QR and norm solution modes
 * 11/12/2017 R. Repka - Minor comment change for norm of residuals, removed
 *                       "c" in GE_FindPoint
 * 11/28/2016 R. Repka - Added Pearson function
 * 07/11/2017 R. Repka  - Switched to getopt_long_only
 ********************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string.h>
#include <getopt.h>
#include <gsl/gsl_math.h>
#include <gsl/gsl_blas.h>
#include <gsl/gsl_vector.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_linalg.h>
#include "ClassErrors.h"
#include "DynamicArrays.h"

/*****************************************************************************
 Function prototypes 
*****************************************************************************/
void readPoints (FILE *file, DArray *DArrayPtr);
void Norm_FindPoint(int nr, int nc, const DArray *points, gsl_vector *x_ls, 
                                                                 int verbose);
void GE_FindPoint(int nr, int nc, const DArray *points, gsl_vector *x_ls, 
                                                                 int verbose);
double RSquareError(int nr, int nc, const DArray *points, 
                                                      const gsl_vector *x_ls);
double normOfResiduals(int nr, int nc, const DArray *points, 
                                                      const gsl_vector *x_ls);
double pearson_correl(int nr, int nc, const DArray *points,
                                                      const gsl_vector *x_ls);
double evalPoly(int nc, double x, const gsl_vector *x_ls);




  int count = 0;

/*****************************************************************************
 This program uses least squares to generate approximate functions
    usage: hw8 (-ge | -norm) -order  num   -points  file  [-verbose] \n");
 
 Returns: 0 for success, non-zero for errors
 *****************************************************************************/
int main(int argc, char *argv[])
{
  DArray points;
  FILE *pointsFile;
  int rows, columns, i;
  double result1, result2, result3;

  gsl_vector *x_ls; /* least squares solution   */

 

   /* your code here  */

   int verbose = 0;
   int order = 0;
   enum modes {UNDEF, GE, NORM} mode = UNDEF;


   /*------------------------------------------------------------------------
     These variables are used to control the getopt_long_only command line 
     parsing utility.  
   ------------------------------------------------------------------------*/
   int rc;
   /* getopt_long stores the option index here. */
   int option_index = 0;
  
   /* This contains the short command line parameters list */
   char *getoptOptions = "vgno:p:"; 
  
   /* This contains the long command line parameter list, it should mostly 
     match the short list                                                  */
   struct option long_options[] = {
      /* These options don’t set a flag.
         We distinguish them by their indices. */
      {"verbose",	no_argument,		0, 'v'},
      {"verb",		no_argument,		0, 'v'},
      {"v",		no_argument,		0, 'v'},
      {"ge",		no_argument,		0, 'g'},
      {"norm",		no_argument,		0, 'n'},
      {"order",	 	required_argument,	0, 'o'},
      {"o",	 	required_argument,	0, 'o'},
      {"points",	required_argument,	0, 'p'},
      {"p",		required_argument,	0, 'p'},


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
        case 'p':                    /* Input File */
	  pointsFile = fopen(optarg, "r");
          break;
        case 'g':                    /* Input File */
	  mode = GE;
          break;
        case 'n':                    /* Input File */
	  mode = NORM;
          break;
        case 'o':                    /* Input File */
	  order = atoi(optarg);
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



	CreateDArray(&points, 100);

	readPoints(pointsFile, &points);
	rows = count/2;
	columns = order + 1;
   	x_ls = gsl_vector_alloc(columns);


 
   /* Performs the root fifinding method*/
   if(mode == GE)
   {

	GE_FindPoint(rows, columns, &points, x_ls, verbose);
	printf("\n \n  Lease Squares Solution Via GE QR\n");
	printf("  f(x) = ");
	for(i = 0; i < columns; i++){
		printf("%g", gsl_vector_get(x_ls, i));
		if (i == 1){
		printf("x");
		}
		else if (i > 1 && i ) {
		printf("x^%d", i);
		}
		if( i != columns - 1){
		printf(" + ");
		}
	}
	printf("\n");

	result1 = normOfResiduals(rows, columns, &points, x_ls); 
 	printf("\n  Norm of Residuals error = %g \n", result1);


	result2 = RSquareError(rows, columns, &points, x_ls);	
 	printf("  R**2 Correlation        = %g \n", result2);


	result3 = pearson_correl(rows, columns, &points, x_ls);
 	printf("  Pearson Correlation     = %g \n", result3);
	









   }
   if(mode == NORM)
   {

	Norm_FindPoint(rows, columns, &points, x_ls, verbose);
	printf("\n \n  Lease Squares Solution Via Norm Factorization\n");
	printf("  f(x) = ");
	for(i = 0; i < columns; i++){
		printf("%g", gsl_vector_get(x_ls, i));
		if (i == 1){
		printf("x");
		}
		else if (i > 1 && i ) {
		printf("x^%d", i);
		}
		if( i != columns - 1){
		printf(" + ");
		}
	}
	printf("\n");

	result1 = normOfResiduals(rows, columns, &points, x_ls); 
 	printf("\n  Norm of Residuals error = %g \n", result1);


	result2 = RSquareError(rows, columns, &points, x_ls);	
 	printf("  R**2 Correlation        = %g \n", result2);


	result3 = pearson_correl(rows, columns, &points, x_ls);
 	printf("  Pearson Correlation     = %g \n", result3);



   }



	 






  

  
 
 /* Clean up */
   gsl_vector_free(x_ls);  
   DestroyDArray(&points);
   
  return PGM_SUCCESS; /* main */
}


/*---------------------------------------------------------------------------
  Find the least squares approximation to data "points" of order "nc" using
  the Gaussian Elimination approach.
  
  Where: int nr           - The number of points (rows) of the input file
         int nc           - The number of columns (order) of the solution
         DArray *points   - Pointer to the x,y data
         gsl_vector *x_ls - The solution is returned here
         int verbose      - Verbose flag

  Returns: nothing
  Errors: Assumes the standard GSL error handler
---------------------------------------------------------------------------*/
void GE_FindPoint(int nr, int nc, const DArray *points, gsl_vector *x_ls, int verbose) {
   double x;
   int i, j, k, flip = 0;
   double exponent;

   gsl_matrix *A;    /* coefficient matrix       */
   gsl_vector *b;    /* coefficient vector       */
   gsl_vector *tau;  /* Householder coefficients */
   gsl_vector *res;  /* vector of residuals      */
  

   /* Allocate space for Matrices and vectors */
   A   = gsl_matrix_alloc(nr, nc); /* Data matrix */
   b   = gsl_vector_alloc(nr);     /* Data vector */
   tau = gsl_vector_alloc(nc);     /* required place holder for GSL */
   res = gsl_vector_alloc(nr);     /* Contains the residual */



   
   /*------------------------------------------------------------------------  
     your code here, GSL fragments you might find useful 
      gsl_matrix_set(A, i, j, x);
      gsl_vector_set(b, i, y);
  
      gsl_matrix_get(A, i, j));
      gsl_vector_get(b, i));
   ------------------------------------------------------------------------*/  



	for(i = 0; i < nr*2; i++){
		if(flip == 0){
			for(j = 0; j< nc; j++){
				exponent = 1;
				for(k = 0; k < j; k++){
					
					exponent = exponent * points->Payload[i].X;
				}
	   			gsl_matrix_set(A, i/2, j, exponent);

			}
			flip = 1;
		} else {
			gsl_vector_set(b, i/2, points->Payload[i].X);
			/*gsl_vector_set(b, i/2, i/2);*/
			flip = 0;
		}
	}
   
   
if (verbose == 1){

	printf("\n\nA(%d x %d)\n", nr, nc);
	for(i = 0; i < nr; i++){
		if(i < 3 || i > nr - 4){
			printf("  %d:  ", i);
			for(j = 0; j< nc; j++){
				printf(" %f ", gsl_matrix_get(A,i,j));
			}
		printf("\n");
		}
		if(i == 5){
			printf("  ...\n");
		}
	}

	printf("\n\nb(%d x %d)\n", nr, 1);
	for(i = 0; i < nr; i++){

		if(i < 3 || i > nr - 4){
		printf("  %d:  ", i);

		printf(" %f ", gsl_vector_get(b,i));
		
		printf("\n");

		}
		if(i == 5){
			printf("  ...\n");
		}
		
	}


}
   
   
   /*  Solve Ax=b directly via QR factorization */
   /*  Find QR decomposition: (note that gls_linalg_QR_decomp overwrites A )
    *  On return, the vector tau and the columns of the lower triangular part of
    *  the matrix A have the Householder coefficients and vectors */
   gsl_linalg_QR_decomp(A, tau);

   /* Solve R x_ls = Q^T b, R is upper triangular */
   /* Note that we pass the "overwritten A", tau and b as input arguments
    * On return x_ls has the least square solution and res the residual vector Ax-b  */
   gsl_linalg_QR_lssolve(A, tau, b, x_ls, res);

	/*for(i = 0; i < nc; i++){
			 printf(" %f \n", gsl_vector_get(x_ls,i));
	}*/


  /* Free memory  */
  gsl_matrix_free(A);
  gsl_vector_free(b);
  gsl_vector_free(tau);  
  gsl_vector_free(res);
} /* End GE_FindPoint() */

/*---------------------------------------------------------------------------
  Find the least squares approximation to data "points" of order "nc" using
  the "Normal equations" approach.
        
                        A'Az = A'b
  
  Where: int nr           - The number of points (rows) of the input file
         int nc           - The number of columns (order) of the solution
         DArray *points   - Pointer to the x,y data
         gsl_vector *x_ls - The solution is returned here
         int verbose      - Verbose flag

  Returns: nothing
  Errors: Assumes the standard GSL error handler
---------------------------------------------------------------------------*/
void Norm_FindPoint(int nr, int nc, const DArray *points, gsl_vector *x_ls, int verbose) {
   double x;
   int i, j, k;         /* counters                 */
   int flip = 0;
   double exponent;
   int signum;
   gsl_matrix *A;    /* coefficient matrix A     */
   gsl_matrix *AT;   /* coefficient matrix A'    */
   gsl_matrix *ATA;  /* coefficient matrix A'A   */
   gsl_vector *b;    /* coefficient vector b     */
   gsl_vector *ATB;  /* coefficient vector A'b   */
   gsl_vector *tau;  /* Householder coefficients */
   gsl_vector *res;  /* vector of residuals      */

   /* Allocate space for Matrices and vectors */
   ATA  = gsl_matrix_alloc(nc, nc); /* Data matrix */
   AT   = gsl_matrix_alloc(nc, nr); /* Data matrix */
   A    = gsl_matrix_alloc(nr, nc); /* Data matrix */
   b    = gsl_vector_alloc(nr);     /* Data vector */
   ATB  = gsl_vector_alloc(nc);     /* Data vector */
   tau  = gsl_vector_alloc(nc);     /* required place holder for GSL */
   res  = gsl_vector_alloc(nc);     /* Contains the residual */

  
   
  /* your code here  */


	for(i = 0; i < nr*2; i++){
		if(flip == 0){
			for(j = 0; j< nc; j++){
				exponent = 1;
				for(k = 0; k < j; k++){
					
					exponent = exponent * points->Payload[i].X;
				}
	   			gsl_matrix_set(A, i/2, j, exponent);

			}
			flip = 1;
		} else {
			gsl_vector_set(b, i/2, points->Payload[i].X);
			/*gsl_vector_set(b, i/2, i/2);*/
			flip = 0;
		}
	}

	gsl_matrix_transpose_memcpy(AT,A);


	gsl_blas_dgemv(CblasNoTrans, 1.0, AT, b, 0.0, ATB);

	gsl_blas_dgemm(CblasNoTrans, CblasNoTrans, 1.0, AT, A, 0.0, ATA);

if (verbose == 1){

	printf("\n\nA(%d x %d)\n", nr, nc);
	for(i = 0; i < nr; i++){
		if(i < 3 || i > nr - 4){
			printf("  %d:  ", i);
			for(j = 0; j< nc; j++){
				printf(" %f ", gsl_matrix_get(A,i,j));
			}
		printf("\n");
		}
		if(i == 5){
			printf("  ...\n");
		}
	}

	printf("\n\nb(%d x %d)\n", nr, 1);
	for(i = 0; i < nr; i++){

		if(i < 3 || i > nr - 4){
		printf("  %d:  ", i);

		printf(" %f ", gsl_vector_get(b,i));
		
		printf("\n");

		}
		if(i == 5){
			printf("  ...\n");
		}
		
	}


	printf("\n\nAT(%d x %d)\n", nc, nr);
	for(i = 0; i < nc; i++){
			
			printf("  %d:  ", i);
			for(j = 0; j< nr; j++){
				if(j < 3){
			 	printf(" %f ", gsl_matrix_get(AT,i,j));
				}
				if(j == 4){
				printf(" ... \n");
				}
			}
		

	}

	printf("\n\nATA(%d x %d)\n", nc, nc);
	for(i = 0; i < nc; i++){
		printf("  %d:  ", i);
		for(j = 0; j< nc; j++){
			printf(" %f ", gsl_matrix_get(ATA,i,j));
		}
		printf("\n");
		
	}


	printf("\n\nATB(%d x %d)\n", nc, 1);
	for(i = 0; i < nc; i++){
		printf("  %d:  ", i);

		printf(" %f ", gsl_vector_get(ATB,i));
		
		printf("\n");
		
	}

}

 
    gsl_linalg_QR_decomp(ATA, tau);
   gsl_linalg_QR_lssolve(ATA, tau, ATB, x_ls, res);

  /* Free memory  */
  gsl_matrix_free(A);
  gsl_matrix_free(AT);
  gsl_matrix_free(ATA);
  gsl_vector_free(b);
  gsl_vector_free(ATB);
  gsl_vector_free(tau); 
  gsl_vector_free(res);
} /* end Norm_FindPoint() */



/****************************************************************************
  This calculate the norm of residuals given the points and the solution
  
                   normR = squareRoot [sum ( yi - f(x)i}**2 ]

  Where: int nr           - The number of points (rows) of the input file
         int nc           - The number of columns (order) of the solution
         DArray *points   - Pointer to the x,y data
         gsl_vector *x_ls - The solution vector, small power first

  Errors: Assumes the standard GSL error handler
  
  Returns: double norm of residuals
****************************************************************************/
double normOfResiduals(int nr, int nc, const DArray *points, const gsl_vector *x_ls) {
	double result, temp, funcVal, funcMul = 1;
	int i, j, k;

	temp = 0;
	result = 0;
	for(i = 0; i < nr; i++){
		funcVal = 0;
		for(j = 0; j< nc; j++){
			funcMul = 1;
			for(k = 0; k < j; k++){
				funcMul = funcMul* points->Payload[i*2].X;
			}
		
			funcVal += gsl_vector_get(x_ls,j) * funcMul;
		
	
		}

		/*printf("funcVal: %f\n", funcVal);
		printf("payload: %f\n",  points->Payload[i*2+1].X);*/
		temp = funcVal - points->Payload[i*2+1].X;
		result += (temp * temp);
	}

	result = sqrt(result);


return (result);
  
} /* normOfResiduals */


/****************************************************************************
  This calculate t
he R2 coefficient of Determination error between the points  
  and the solution
                   
  Where: int nr           - The number of points (rows) of the input file
         int nc           - The number of columns (order) of the solution
         DArray *points   - Pointer to the x,y data
         gsl_vector *x_ls - The solution vector, small power first
 
  Errors: Assumes the standard GSL error handler
  
  Returns: R squared error
****************************************************************************/
double RSquareError(int nr, int nc, const DArray *points, const gsl_vector *x_ls) {
	double result, so_YmF, so_F, so_YmFS, so_Y, so_Yn, funcVal;
	double funcMul = 1;
	double temp, temp2;
	int i, j, k;
	double n = (double)(nr);


	temp = 0;
	temp2 =0;
	result = 0;
	so_YmF = 0;
	so_F = 0;
	so_YmFS = 0;
	so_Y = 0;
	so_Yn = 0;
	for(i = 0; i < nr; i++){
		funcVal = 0;
		for(j = 0; j< nc; j++){
			funcMul = 1;
			for(k = 0; k < j; k++){
				funcMul = funcMul* points->Payload[i*2].X;
			}
		
			funcVal += gsl_vector_get(x_ls,j) * funcMul;
		
	
		}

		temp2 = points->Payload[i*2+1].X - funcVal;
		so_YmFS += temp2 * temp2;


		so_Y += points->Payload[i*2+1].X;
		
		
	}
	so_Y = so_Y * (1/n);
	for(i = 0; i < nr; i++){
		temp = points->Payload[i*2+1].X - so_Y;
		so_Yn += temp*temp;
	}
	result = 1 - (so_YmFS / so_Yn);




return (result);  




} /* End RSquareError */


/*****************************************************************************
 This calculates the Pearson's Correlation, or the excel function correl()
                    
  Where: int nr           - The number of points (rows) of the input file
         int nc           - The number of columns (order) of the solution
          DArray *points   - Pointer to the x,y data
         gsl_vector *x_ls - The solution vector, small power first

  Errors: Assumes the standard GSL error handler       
       
 Returns: double pearson_srq 
*****************************************************************************/
double pearson_correl(int nr, int nc, const DArray *points,
                                              const gsl_vector *x_ls) {




	double result, temp, funcVal, funcMul = 1;
	int i, j, k;
	double n = (double)(nr);
	double so_YxF, so_Y, so_F, so_YS, so_FS, top, bottom1, bottom2;

	temp = 0;
	result = 0;
	so_YxF = 0;
	so_F = 0;
	so_FS = 0;
	so_Y = 0;
	so_YS = 0;
	top = 0;
	bottom1 = 0;
	bottom2 = 0;

	for(i = 0; i < nr; i++){
		funcVal = 0;
		for(j = 0; j< nc; j++){
			funcMul = 1;
			for(k = 0; k < j; k++){
				funcMul = funcMul* points->Payload[i*2].X;
			}
		
			funcVal += gsl_vector_get(x_ls,j) * funcMul;
		
	
		}

		/*printf("funcVal: %f\n", funcVal);
		printf("payload: %f\n",  points->Payload[i*2+1].X);*/
		so_YxF += funcVal * points->Payload[i*2+1].X;

		so_Y += points->Payload[i*2+1].X;
		so_F += funcVal;

		temp = points->Payload[i*2+1].X;
		so_YS += temp * temp;

		temp = funcVal;
		so_FS += temp * temp;

	}



		/*printf("so_YxF  : %f\n", so_YxF);
		printf("so_Y    : %f\n", so_Y);
		printf("so_F    : %f\n", so_F);
		printf("so_YS   : %f\n", so_YS);
		printf("so_FS   : %f\n", so_FS);*/



	top = (n*so_YxF) - (so_Y * so_F);
	bottom1 = n*so_YS - (so_Y * so_Y);
	bottom2 = n*so_FS - (so_F * so_F);

		/*printf("top       : %f\n", top);
		printf("bottom1   : %f\n", bottom1);
		printf("bottom2   : %f\n", bottom2);*/


	result = top/sqrt(bottom1 * bottom2);


return (result);

 
} /* End pearson_correl */




/***************************************************************************************
 Evaluates a polynomial at a point, assumes low order term first.  Must use Horner's 
 factorization 
 
 Where: int nc           - The number of columns in the solution
        double x         - Point at which splines should be evaluated
        gsl_vector *x_ls - The solution vector, small power first
          
 Returns: double - The value at the desired point
 Errors:  none
*****************************************************************************************/
double evalPoly(int nc, double x, const gsl_vector *x_ls) {
  
   
  
} /* End evalPoly */


/***************************************************************************************
 Reads the points data from file and returns it in a Darray
 
 Where: FILE *file     - open handle to read from
                         of the form:     22.0      6.7
                                          23.4      18.8
        DArray *DArrayPtr - Pointer to a dynamic array to store the data
  Returns: nothing
  Errors:  none
*****************************************************************************************/
void readPoints(FILE *file, DArray *DArrayPtr) {


	int flip, size, lcv = 0;
	int buff_size = 256, len, trigger = 0;
	int result;
	char *b;
	char *line = (char *)malloc(256*sizeof(char));

	Data TempData;
	

	
	

	if (NULL != file)
	{



		while ( fgets (line, buff_size, file) != NULL){

			/*Splicing Lines*/
			b = strtok(line, " ");
			
			/*
			 * CHARACTER LOOP
			 *
			 * Loop that seperates lines into characters and places
			 * them into the A and the B matrix
			 */
			
			while(b != NULL){

				TempData.Num = lcv++;
				TempData.X = atof(b);
				PushToDArray(DArrayPtr, &TempData);

				/*printf("-----------------------------------\n");
				printf("Read in		: %d\n",atoi(b));
				printf("TempData.X	: %f\n", TempData.X);
				printf("DArray->X	: %f\n", DArrayPtr->Payload[count].X);*/
				count++;
				b = strtok(NULL, " ");
				
			}

		}
	}


	
free(line);

 
     
    
  return;
} /* readPoints */
