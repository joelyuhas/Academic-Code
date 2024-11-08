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


/*****************************************************************************
 This program uses least squares to generate approximate functions
    usage: hw8 (-ge | -norm) -order  num   -points  file  [-verbose] \n");
 
 Returns: 0 for success, non-zero for errors
 *****************************************************************************/
int main(int argc, char *argv[])
{
  DArray points;
  FILE *pointsFile;
  gsl_vector *x_ls; /* least squares solution   */
  
 
   /* your code here  */
  
 
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
   int i, j;

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
   
   
   
   
   /*  Solve Ax=b directly via QR factorization */
   /*  Find QR decomposition: (note that gls_linalg_QR_decomp overwrites A )
    *  On return, the vector tau and the columns of the lower triangular part of
    *  the matrix A have the Householder coefficients and vectors */
   gsl_linalg_QR_decomp(A, tau);

   /* Solve R x_ls = Q^T b, R is upper triangular */
   /* Note that we pass the "overwritten A", tau and b as input arguments
    * On return x_ls has the least square solution and res the residual vector Ax-b  */
   gsl_linalg_QR_lssolve(A, tau, b, x_ls, res);

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
   int i, j;         /* counters                 */
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
  
} /* normOfResiduals */


/****************************************************************************
  This calculate the R2 coefficient of Determination error between the points  
  and the solution
                   
  Where: int nr           - The number of points (rows) of the input file
         int nc           - The number of columns (order) of the solution
         DArray *points   - Pointer to the x,y data
         gsl_vector *x_ls - The solution vector, small power first
 
  Errors: Assumes the standard GSL error handler
  
  Returns: R squared error
****************************************************************************/
double RSquareError(int nr, int nc, const DArray *points, const gsl_vector *x_ls) {
  
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
void readPoints(FILE *file, DArray *DArrayPtr)
{
 
     
    
  return;
} /* readPoints */
