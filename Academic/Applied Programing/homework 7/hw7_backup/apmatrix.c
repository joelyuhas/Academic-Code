 /*********************************************************
 * APMATRIX Module - student file
 *
 * 10/24/2013,  Juan C. Cockburn               
 * 09/13/2015,  R. Repka - added error checking
 * 11/15/2015   R. Repka - changed Real to double
 * 04/10/2016   R. Repka - Minor change to headers
 * 05/25/2016   R. Repka - Added feature to m_free to 
 *                         detect pointer rearrangement. 
 * 11/01/2016   R. Repka - Removed m_ident(), and made
 *                         minor comment changes
 * 04/06/2017   R. Repka    Minor commend modification G to A
 *********************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "ClassErrors.h"
#include "apmatrix.h"
#include "Timers.h"


DECLARE_TIMER(timerElimination);
DECLARE_TIMER(timerSolution);
    

/*---------------------------------------------------------------------------
  Implements in place Gaussian elimination.  
  PLU_Factor takes an A matrix (not G, no b included) and does a Gaussian 
  factorization in place.  It returns the factorized A matrix 
  (made of L&U in place) and a 'p' vector which recorded the row swaps for 
  future 'b' manipulations.

  
  Where: Matrix  *A - Pointers to the matrix to solve
         iVector *p - Pointer to the permutation vector
  Errors: none
  Returns: int - 0 = success
               - 3 = No pivot point found, not solvable
---------------------------------------------------------------------------*/
int PLU_factor(Matrix *A, iVector *p)
{
int k, i, j, i_max, i_temp;
double pivot, c;
double v_max, temp;
START_TIMER(timerElimination);


/*
 * INITIALIZING I VECTOR
 */
for(i = 0; i<p->n ; i++){
	p->ivec[i] = i;
}


/*
 * FACTORIZATION PORTION
 */
for(i=0; i< A->nr; i++){
	
	i_max = i;
	v_max = A->mat[i_max][i];

	/*
	 * CHECKING FOR LARGEST PIVOT
 	 */
	for(j = i+1; j < A->nr; j++){
		if(fabs(A->mat[j][i]) > fabs(v_max)){
			v_max = A->mat[j][i];
			i_max = j;
		}
	}

	/*
	 * CHECKS IF ZERO (NO FACTORIZATION POSSIBLE)
	 */
	if(A->mat[i][i_max] == 0){
		return 3;
	}	

	/*
	 * SWAPPING VALUES AND GENERATING P
	 */
	if(i_max != i){
		for(k = 0; k < A->nr; k++){

			temp = A->mat[i][k];
			A->mat[i][k] = A->mat[i_max][k];
			A->mat[i_max][k] = temp;	
		}
		/* Swapping i vec values */
		i_temp = p->ivec[i];
		p->ivec[i] = p->ivec[i_max];
		p->ivec[i_max] = i_temp;	
	}

	/*
	 * PERFORMING FACTORIZATION
	 */
	for(j = i+1; j < A->nr; j++){

		c = A->mat[j][i]/A->mat[i][i];
		for(k = i+1; k<= A->nr-1; k++){
			A->mat[j][k] -= c*A->mat[i][k];

		}	
		A->mat[j][i] = c;

	}
}

STOP_TIMER(timerElimination);
PRINT_TIMER(timerElimination);
return 0;

}


/*---------------------------------------------------------------------------
  Solves Ax=b using PLU factorization
  
  Where: Matrix  *A - Pointer to the PLU factored matrix
         iVector *p - Pointer to the permutation vector 
         rVector *b - Pointer to the b matrix
         rVector *x - Pointer to the vector to hold the answer
  Errors: none
  Returns: nothing
---------------------------------------------------------------------------*/
void PLU_solve(Matrix *GA, iVector *p, rVector *b, rVector *x)
{
  	 int i, j;
  	 int result;
	 double **bigboi = (double **)malloc(GA->nr*sizeof(double));
 	 if (NULL == bigboi)
 	 {
      		printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      		exit(MALLOC_ERROR);
  	}
	for(i=0;i<GA->nr;i++){
		bigboi[i] = (double *)malloc(GA->nc*sizeof(double));
  		if (NULL == bigboi[i])
  		{
      			printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      			exit(MALLOC_ERROR);
  		}
	}
   	/*double bigboi[GA->nr][GA->nr+1];
  	 double solution[GA->nr], tempArray[b->n]; */

	double * tempArray = (double *)malloc(b->n*sizeof(double));
 	 if (NULL == tempArray)
 	 {
     	 	printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
	     	exit(MALLOC_ERROR);
	  }
   	double sum = 1;


	/*
	 * CALLING FACTORIZATION
	 */
	result = PLU_factor(GA,p);

	START_TIMER(timerSolution);

	for(i=0; i<GA->nr;i++){
		for(j=0; j<GA->nr;j++){
			bigboi[i][j]=GA->mat[i][j];
			/*memcpy(bigboi[i][j], GA->mat[i][j], sizeof(GA->mat[i][j]));*/
		}
	}

	/*
	 * PREPARING B VECTOR IN PROPER ORDER
	 */
	for(i=0; i < b->n; i++){
		tempArray[i] = b->vec[p->ivec[i]];
		/*memcpy(tempArray[i], b->vec[p->ivec[i]], sizeof(double));*/
	}
	for(i = 0;i < b->n; i++){
		b->vec[i] = tempArray[i];
		bigboi[i][GA->nr] = tempArray[i];
	}
	

	for(i=1;i < GA->nr; i++){
		sum = 1;
		for(j =0; j < GA->nr-(GA->nr-i);j++ ){
			
			sum = sum*GA->mat[i][j];
			bigboi[i][GA->nr] = bigboi[i][GA->nr]-(GA->mat[i][j]*bigboi[j][GA->nr]);

		}

	}


	/*
	 * FACTORIZATION SUCCESSFUL
	 *
	 * PERFORM BACK SUBSITUTION
	 */

	if(result == 0){
		for(i = GA->nr-1; i>=0; i--){

			sum = 0;
			for(j = i+1; j < GA->nr; j++){
				
				sum += bigboi[i][j]*x->vec[j];
				
			}
			x->vec[i] =(bigboi[i][GA->nr]-sum)/bigboi[i][i];
		}

	/* 
	 * FACTORISATION UNSUCCESSFUL
	 */
	}else{
		printf("\n\n **** WARNING **** \n");
		printf("\n Given matrix has no solutions!\n");
		printf(" Matrix has either been entered incorrectly or\n");
		printf(" the given values cannot produce a solution.\n\n");


	}


STOP_TIMER(timerSolution);
PRINT_TIMER(timerSolution);
	
}

/*---------------------------------------------------------------------------
  Allocate memory space for matrix, initialized to zero.  
  Note: This allocates one big block of RAM and then adjusts the pointer table
  
  Where: int nr - The number of rows and columns in the matrix
         int nc -
  Errors: exits
  Returns Matrix * - Pointer to the resulting matrix space
---------------------------------------------------------------------------*/
Matrix* m_alloc(int nr, int nc) {
  int i;
  double* ptr; /* pointer to head memory */
  Matrix* M;
  
  /* Allocate memory for matrix "header" structure */
  M = malloc(sizeof(Matrix));
  if (NULL == M)
  {
      printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      exit(MALLOC_ERROR);
  }
  M->nr = nr;
  M->nc = nc;
  
  /* Allocate space for matrix data */
  M->mat = malloc( nr * sizeof(double *)); /* row pointers */
  if (NULL == M->mat)
  {
      printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      exit(MALLOC_ERROR);
  }
  
  /* The data needs to be set to zero */
  ptr = calloc( nr*nc, sizeof(double) );   /* matrix data   */
  if (NULL == ptr)
  {
      printf("Error: calloc() failed at line %d of %s\n", __LINE__, __FILE__);
      exit(MALLOC_ERROR);
  }
  
  for (i=0; i<nr; i++)                /* set row pointers */
    M->mat[i] = ptr + nc*i;
  return M;
}


/*---------------------------------------------------------------------------
  Release memory space used by a matrix  
  
  Where: Matrix *m - The matrix to free
  Errors: none
  Returns nothing
---------------------------------------------------------------------------*/
void m_free(Matrix* M) {

  int i;
  void *smallP;

  /* The pointer might have been rearranged, so find the smallest */
  smallP = (void *)M->mat[0];
  for (i=1; i<M->nr; i++) {
     if (smallP > (void *)M->mat[i]) { smallP = (void *)M->mat[i];}
  }

  free(smallP);    /* free data */
  free(M->mat);    /* free row pointers */
  free(M);         /* free matrix header */
 

}

 
 
/*---------------------------------------------------------------------------
  Print the matrix elements 
          e.g  m_print(mat, " %8.4f ");

  Where: Matrix *m - The matrix to print
         char *fs  - pointer to a printf format string
  Errors: none
  Returns nothing
---------------------------------------------------------------------------*/
void m_print(const Matrix* M, const char* fs) {
  int i,j;
  for (i=0; i<M->nr; ++i) 
  { 
    for (j=0; j<M->nc; ++j)
    {        
        printf(fs, M->mat[i][j]);
    }
    putchar('\n');
  }
  putchar('\n');
}


/*---------------------------------------------------------------------------
  Allocates a real vector of size n, uninitialized
  
  Where: int n - The size of the vector to create
  Errors: none
  Returns rVector * - Pointer to the resulting reals vector
---------------------------------------------------------------------------*/
rVector* rv_alloc(int n)
{
rVector * w;
double* ptr;

w = malloc(sizeof(rVector));
  if (NULL == w)
  {
      printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      exit(MALLOC_ERROR);
  }

w->n = n;
w->vec = (double *)malloc(n * sizeof(double));
  if (NULL == w->vec)
  {
      printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      exit(MALLOC_ERROR);
  }





return w;

}


/*---------------------------------------------------------------------------
  Allocates an integer vector of size n
  
  Where: int n - The size of the integer vector to create
  Errors: exits
  Returns iVector * - Pointer to the resulting integer vector
---------------------------------------------------------------------------*/
iVector* iv_alloc(int n)
{
iVector * w;

w = malloc(sizeof(iVector));
  if (NULL == w)
  {
      printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      exit(MALLOC_ERROR);
  }

w->n = n;
w->ivec = (int *)malloc(n * sizeof(int));
  if (NULL == w->ivec)
  {
      printf("Error: Malloc() failed at line %d of %s\n", __LINE__, __FILE__);
      exit(MALLOC_ERROR);
  }

return w;
}


/*---------------------------------------------------------------------------
  Frees a reals vector 
  
  Where: rVector *V - The real vector to release
  Errors: none
  Returns: nothing
---------------------------------------------------------------------------*/
void rv_free(rVector* V)
{
free(V->vec);
free(V);

}


/*---------------------------------------------------------------------------
  Frees an integer vector 
  
  Where: iVector *V - The integer vector to release
  Errors: none
  Returns: nothing
---------------------------------------------------------------------------*/
void iv_free(iVector* V)
{

free(V->ivec);
free(V);	

}


/*---------------------------------------------------------------------------
  Prints a real vector 
        e.g rv_print(b, "   %8.4f \n");
  
  Where: rVector *V - The reals vector to print
         char *fs  - Pointer to a printf format string
  Errors: none
  Returns: nothing
---------------------------------------------------------------------------*/
void rv_print(const rVector* V, const char* fs)
{
int i = 0;
	for(i = 0; i < V->n; i++){
		printf(fs, V->vec[i]);
	}

}

/*---------------------------------------------------------------------------
  Prints an integer vector 
  
  Where: iVector *V - The integer vector to print
         char *fs  - Pointer to a printf format string
  Errors: none
  Returns: nothing
---------------------------------------------------------------------------*/
/* Prints an ivector */
void iv_print(const iVector* V, const char* fs)
{
int i = 0;
	for(i = 0; i < V->n; i++){
		printf(fs, V->ivec[i]);
	}

}



/*---------------------------------------------------------------------------
  Multiplies a matrix by a vector.  May not be needed
  
  Where: Matrix *M - Pointers to the matrix to multiply
         rVector *V - Pointers to the vector to multiply
  Errors: none
  Returns: rVector * - Pointer to the resulting vector
---------------------------------------------------------------------------*/
rVector* MtimesV(Matrix* M, rVector* V)
{
rVector * w;
return w;

}
