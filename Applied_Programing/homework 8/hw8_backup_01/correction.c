/******************************************************************
 * Program to correct the data for the sensor
 * Note: Each student gets unique data, so this exact equation will
 * differ for each students solution
 * Be sure to use Honer's factorization  
 * ***************************************************************/

#include <stdio.h>
#include <stdlib.h>

/* Runs the data through the fitting line */

int main(int argc, char *argv[])
{
    int res, real, ideal;
    double x, y;
    while(scanf("%d %d", &ideal, &real) != EOF)
    {

     /* Insert your polynomial here, be sure to round properly (real - output of polynomial) */
	x = (double)real;
	/*printf("%g\n", x);*/
      y = -64.9382 
	+ 0.89407 * x
	- 0.00267285 * x * x 
	+ 4.51323e-06 * x * x * x
	- 4.08132e-09 * x * x * x * x
	+ 2.09127e-12 * x * x * x * x * x
	- 6.08197e-16 * x * x * x * x * x * x
	+ 9.34332e-20 * x * x * x * x * x * x * x
	- 5.88246e-24 * x * x * x * x * x * x * x * x;

   /*   y = (-64.9382 
	+ (0.89407 
	+ (-0.00267285 
	+ (4.51323e-06
	+ (-4.08132e-09 
	+ (2.09127e-12
	+ (-6.08197e-16 
	+ (9.34332e-20 
	+ (-5.88246e-24 * x) * x) * x) * x) * x) * x) * x) * x));*/

 y = x - y;
res = (int)(y+0.5);
/*printf("%g\n", y);*/
        printf("%d %d\n", ideal, res);
    }
    return 0;
}
