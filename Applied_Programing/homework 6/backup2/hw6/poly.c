/***********************************************************************
 * Student C framework to calculate the roots and evaluate polynomials
 * static functions are not REQURED, you are free to implement they way
 * you wish
 * Course: Applied Programming 
 * Revised: 2015
 *
 * 10/16/2015 R. Repka  - Removed evalPoly, extern
 * 04/03/2015 R. Repka  - Added cpow() and Horner comments, 
 * 10/24/2016 R. Repka  - Updated evalDerivs comments
 * 10/26/2016 R. Repka  - Changed createPoly to initPoly
 ***********************************************************************/ 
#include </usr/include/complex.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "ClassErrors.h"
#include "poly.h"

#define ZERO 0.00000001

/*---------------------------------------------------------------------------
  Define local functions
---------------------------------------------------------------------------*/
static double complex* quadraticRoots( polynomial *p);
static double complex laguerre(polynomial *p, double tol, int verb);
static polynomial* deflPoly(polynomial *p, double complex root);
static double complex* evalDerivs(polynomial *p, double complex point);
static void copyPoly(polynomial *p_dest, polynomial *p_src);
static void printComplex(double complex x);

/*---------------------------------------------------------------------------
  Initializes a polynomial data structure with nterms.  This allocates storage
  for the actual polynomial.
  
  Where: polynomial *p       - Pointer to polynomial data structure to create
         unsigned int nterms - The number of elements to create
  Returns: nothing
  Errors:  prints an error and exits
---------------------------------------------------------------------------*/


static void copyPoly(polynomial *dest, polynomial *src){
  
	initPoly(dest, src->nterms);

  	memcpy(dest->polyCoef, src->polyCoef, sizeof(double complex)*src->nterms);

}


void initPoly(polynomial *p, unsigned int nterms){
	//p = (polynomial *)malloc(sizeof(polynomial));

	//double complex  *NewCoefs;
	p->nterms = nterms;
	p->polyCoef = (complex double*)malloc(sizeof(complex double) * nterms);
	 	if (p->polyCoef == NULL){
			fprintf(stderr, "%s", "Malloc Failed in roots\n");
		}
}


/*---------------------------------------------------------------------------
  Destroys/frees a polynomial
  
  Where: polynomial *p - Pointer to polynomial data structure to destroy
  Returns: nothing
  Errors:  none
---------------------------------------------------------------------------*/
void freePoly(polynomial *p){
p->nterms = 0;
p->polyCoef = NULL;
//free(&p);
}


/*---------------------------------------------------------------------------
  This function evaluates a polynomial at a complex point z.  
  Don't use the cpow() function, it generates round off errors.  You are 
  required to use Horner's factorization 
   
  Were: polynomial *p    - Pointer to the polynomial to evaluate
        double complex z - Point to evaluate 
  Returns: double complex- Complex solution
  Errors:  none
---------------------------------------------------------------------------*/
double complex cevalPoly(polynomial *p, double complex z){


double complex sum = p->polyCoef[p->nterms];
int temp = (p->nterms-1);


	for(int i = 0; i <= temp; i++){
		sum *= z;
		sum += p->polyCoef[i];
	}

	return sum;



}


/*---------------------------------------------------------------------------
 This finds all the roots (real and complex) of a real polynomial.  If there
 is a single root, it solves for it.  If there are two roots then it uses
 the quadratic formula.  If there are more than two roots, it uses Laguerre.
 If a complex root is found then BOTH the + and - roots are deflated from the
 polynomial.
 
 Where: polynomial *poly - Pointer to an array of polynomial coefficients
        double tolerance - Termination tolerance
        int verb         - Verbose flag indicating whether to print intermediate
                           results or not ( 1 = TRUE, 0 = FALSE 
 
 Returns: double complex *roots - A pointer to a complex root array
 Errors:  prints an error and exits
---------------------------------------------------------------------------*/
double complex* roots(polynomial *poly, double tolerance, int verb){
		double complex c, c1;
		double complex *output;
		//polynomial *poly_p;
		double complex *root = malloc(sizeof(double complex)*(poly->nterms-1));
		if (root == NULL){
			fprintf(stderr, "%s", "Malloc Failed in roots\n");
		}
		int i, bound;
		
		//polynomial *outputP;

		/*If the resulting polynomial is of order 1 you should calculate using simple math*/
		/*If polynomial is order 2, then use quadratic equation*/
		/*Greater than two use Laguerre*/
		/*If root is complex, automatically use the conjugate*/

	i = 0;
	bound = poly->nterms-1;
	printPoly(poly);
	while(i < bound){
		
		if(poly->nterms > 3){

			

			c = laguerre(poly, tolerance, verb);
			
			

			poly = deflPoly(poly, c);

			if(verb == 1){
			printf("        Deflated: ");
			printPoly(poly);
			}

			root[i] = c;

			/*Checks if there is an imaginary portion*/
			if(cimagf(c) > ZERO || cimagf(c) < -ZERO){
				c1 = creal(c) - cimag(c)*I;
				poly = deflPoly(poly, c1);

				if(verb == 1){
				printf("        Deflated: ");
				printPoly(poly);
				}

				root[i+1] = c1;
				i++;
			}
			i++;


	
		} else if (poly->nterms == 3) {

			if(verb == 1){
			printf("        Found final two roots through quadratic\n");
			}

			output = quadraticRoots(poly);
			root[i] = output[0];
			root[i+1] = output[1];

			

			i += 2;
		} else if (poly->nterms == 2) {
			
			if(verb == 1){
			printf("        Found final root using quick mafs\n");
			}

			c = -poly->polyCoef[1]/poly->polyCoef[0];
			root[i] = c;
			i++;
		}


	}

//free(poly->polyCoef);
//free(poly);
//free(&c);
//free(output);

return root;


}

/*---------------------------------------------------------------------------
  This function evaluates the polynomial derivatives at a point using the
  compact method or another equivalent method.
     
  If you decide not use the compact all-in-one p,p',p'' evaluation code, 
  you can implement this function:
        As separate p, p' and p'' derivatives
        Then evaluate each function separately
        Still returning 3 values
  OR
  You can choose to create functions of your own and not implement this function
  at all
  
  Where: polynomial *p        - Pointer to a polynomial data to evaluate
         double complex point - The point to evaluate
  Returns: double complex*    - Pointer to an array of evaluated 
                                derivatives d, d' and d'' 
  Errors:  prints an error and exits
---------------------------------------------------------------------------*/
static double complex* evalDerivs(polynomial *p, double complex point){
double complex g, q, r, d0, d1, d2;
int k;
//double complex output[3];
double complex * output = (complex double *)malloc(sizeof(complex double) * 3);
if (output == NULL){
	fprintf(stderr, "%s", "Malloc Failed in evalDerivs\n");
}

//&output = temp;
g = p->polyCoef[0];
q = 0.0;
r = 0.0;


	for(k = 1; crealf(k)< p->nterms; k++){
		r = r*point + q;
		q = q*point + g;
		g = g*point + p->polyCoef[k];
	}
	d0 = g;
	d1 = q;
	d2 = 2*r;
	output[0] = d0;
	output[1] = d1;
	output[2] = d2;


	return output;


}

/*---------------------------------------------------------------------------
  Returns the two roots from a quadratic polynomial
  
  Where: polynomial *p - Pointer to a 2nd order polynomial
  Returns: double complex* - A pointer to a complex root pair.
  Errors:  prints an error and exits
---------------------------------------------------------------------------*/
static double complex* quadraticRoots( polynomial *poly){
double complex a, b, c, deter, r1, r2;
double complex * output = (complex double *)malloc(sizeof(complex double) * 2);
if (output == NULL){
	fprintf(stderr, "%s", "Malloc Failed in quadraticRoots\n");
}

			a = poly->polyCoef[0];
			b = poly->polyCoef[1];	
			c = poly->polyCoef[2];

			deter = (b*b)-(4*a*c);
			if (crealf(deter) > 0){
				r1 = (-b+sqrt(deter))/(2*a);
				r2 = (-b-sqrt(deter))/(2*a);
				output[0] = r1;
				output[1] = r2;


			} else if(crealf(deter) <= ZERO && crealf(deter) >= -ZERO ) {
				r1 = -b/(2*a);
				r2 = r1;
				output[0] = r1;
				output[1] = r2;


			} else {
				r1 = -b/(2*a) - sqrt(-deter)/(2*a)*I;
				r2 = -b/(2*a) + sqrt(-deter)/(2*a)*I;
				output[0] = r1;
				output[1] = r2;

			}

				return output;

}


/*---------------------------------------------------------------------------
  Uses Laguerre's method to compute a root of a real polynomial
  
  Where: polynomial *p - Pointer to a polynomial structure to evaluate
         double tol    - Termination tolerance 
         int verb      - Verbose flag indicating whether to print intermediate
                         results or not ( 1 = TRUE, 0 = FALSE 
 Returns: double complex - The complex root or (NAN + 0.0*I) if  none is found
 Errors:  none
---------------------------------------------------------------------------*/
static double complex laguerre(polynomial *p, double tol, int verb){
double complex g, h, ap, am, a, n;
double complex * derivatives;

double complex guess = 0;
int i = 0;

	if(verb == 1){
	printf("        Laguerre's Algorithm( tol = %g )\n", tol);
	}

	while(i < 100){
		derivatives = evalDerivs(p, guess);
		n = p->nterms -1;



		g = derivatives[1]/derivatives[0];
		h = (g*g) - (derivatives[2]/derivatives[0]);

		ap = (n - 1)*(n*h-g*g);
		ap = csqrt(ap);
		ap = g + ap;

		am = (n - 1)*(n*h-g*g);
		am = csqrt(am);
		am = g - am;


	
		if(fabs(ap) > fabs(am)){

			a = n/ap;

		} else{
			a = n/am;
		}


		if(verb == 1){
		printf("          it: %d x: %f\n", i, crealf(guess));
		printf("             G(x): %9.9f\n",creal(g));
		printf("             H(x): %9.9f\n",creal(h));
		printf("            Alpha: %9.9f\n",creal(a));
		}

		if (fabs(a) > tol){
			guess = guess - a;
			i++;
		} else {
			//printf("this bitch %f\n", ap);
			if(verb == 1){
			printf("        Found Root ");
			printComplex(guess);
			}

			return guess;
		}


	}
return guess;


 
}

/*---------------------------------------------------------------------------
  Deflates a root from the polynomial, returning the new polynomial 
  
  Where: polynomial *p       - Pointer to the polynomial to deflate
         double complex root - The root to use 
  Returns: polynomial *      - Pointer to the deflated polynomial
  Errors:  none
---------------------------------------------------------------------------*/
static polynomial* deflPoly(polynomial *p, double complex root){
int i = 1;
//double complex * output = (complex double *)malloc(sizeof(complex double) * (p->nterms));
//double complex tempArray[p->nterms - 1];
//double complex r;
polynomial * outputP = (polynomial *)malloc(sizeof(polynomial));
if (outputP == NULL){
	fprintf(stderr, "%s", "Malloc Failed in deflPoly\n");
}

	
	copyPoly(outputP, p);
	for(i = 1; i< p->nterms; i++){
		outputP->polyCoef[i] += outputP->polyCoef[i-1]*root;

	}

	//outputP->polyCoef = output;
	outputP->nterms = p->nterms-1;
	return outputP;


}


/*---------------------------------------------------------------------------
  The function prints out complex data
  
  Where: double complex x - the complex data to print out
  returns:  nothing
  errors:   none
---------------------------------------------------------------------------*/
static void printComplex(double complex x){
printf("%f%+fi\n", crealf(x), cimagf(x));
}

/*---------------------------------------------------------------------------
  Prints a polynomial
  Where: polynomial *p - Pointer to polynomial data structure to print
  Errors: none
  Returns: nothing
---------------------------------------------------------------------------*/
void printPoly (polynomial *p){
int c;
printf("P(x) = ");
	for(int i = 0; i < p->nterms; i++){
		printf(" %.3f%+.3fi", crealf(p->polyCoef[i]),cimagf(p->polyCoef[i]));
		if ((p->nterms-i)> 1){
			//printf("test:%d", i-p->nterms);
			c = i+1;
			printf("x^%d", p->nterms-c);

		}
	}
printf("\n");
}

/*---------------------------------------------------------------------------
  Prints the roots of a polynomial from largest (in magnitude) to smallest
  
  Where: polynomial *p - Pointer to polynomial data structure to print
  Returns: nothing
  Errors:  none
---------------------------------------------------------------------------*/
void printRoots (polynomial *p, double tolerance, int verb){

double complex * root;


	root = roots(p, tolerance, verb);
	printf("Roots\n");

	for(int i = 0; i < p->nterms-1; i++){
		//both zero
		//if((cimagf(root[i]) < ZERO || cimagf(root[i]) > -ZERO) && (crealf(root[i]) < ZERO || crealf(root[i]) > -ZERO)) {

		//imag is zero
		 if(cimagf(root[i]) < ZERO && cimagf(root[i]) > -ZERO){

			printf("        %f\n", creal(root[i]));

		//real is zero
		} else if(crealf(root[i]) < ZERO && crealf(root[i]) > -ZERO){

			printf("        %fi\n", cimag(root[i]));

		} else{

			printf("        %f%+fi\n", creal(root[i]), cimag(root[i]));
		}


	}
//free(root);
printf("\n");
printf("\n");
}


/*---------------------------------------------------------------------------
  Optional helper function to print out x and y value from evaluating 
  polynomials, not required
  
  Where: double complex x - data pair to print
         double complex y - 
  Returns: nothing
  Errors:  none
---------------------------------------------------------------------------*/
void printPoint(double complex x, double complex y){
printf("Temp");
}
