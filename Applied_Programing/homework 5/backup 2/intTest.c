/**************************************************************************
  intTest.c - for students
  This program demonstrates the speed advantages of integer versus floating
  point math.
 12/28/2015 - R. Repka  Initial version
 10/12/2016 - R. Repka  Switched to PRINT_RTIMER() macro
**************************************************************************/
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "ClassErrors.h"
#include "rootfinding.h"
#include "Timers.h"

/****************************************************************************
  Use this to define the number of iterations in your performance measurements
****************************************************************************/
#define ITERATIONS 

/****************************************************************************
  Remember to set the QN value in rootfinding.h
****************************************************************************/

/************************************************************************
   Simple code to test Qn performance vs floating point  
************************************************************************/
int main(int argc, char* argv[])
    {
    double Result;          /* The result from floating point calculation   */
    long  iResult;          /* The result from floating point calculation   */
    int   counter;          /* Loop counter for performance calculations    */
    
    /* The bisection guesses and tolerance value                        */
    double a = -25.0;
    double b = 25.0;
    double tol= 0.000001;

    DECLARE_TIMER(timer);

    /************************************************************************
     Run the Qn format test 
    ************************************************************************/
    START_TIMER(timer);
    for(counter=0; counter < ITERATIONS; counter++)
        {
         iResult = ibisection(&iline, ..your code here ...);
        }
    STOP_TIMER(timer);

    if(iNAN == iResult)
        {
        fprintf(stdout, "Qn %d bisection couldn't find a root. \n", QN);
        exit(99);
        }
    else
        {
        fprintf(stdout, "Found the root %f using Qn %d bisection.\n",
                        FIX_TO_FLOAT(iResult ), QN);
        }      
    PRINT_TIMER(timer);
    PRINT_RTIMER(timer, ITERATIONS);

    /************************************************************************
     Run the floating point format test 
    ************************************************************************/
    START_TIMER(timer);
    for(counter=0; counter < ITERATIONS; counter++)
        {
        Result = bisection(&rline, ... your code here .....);
        }
    STOP_TIMER(timer);

    if(NAN == Result)
        {
        fprintf(stdout, "Float bisection couldn't find a root. \n");
        exit(99);
        }
    else
        {
        fprintf(stdout, "Found the root %f using float bisection.\n",
                        Result);
        }

    PRINT_TIMER(timer);
    PRINT_RTIMER(timer, ITERATIONS);
    
    /* Display the percentage error */
    Result = ... your code here ...
    fprintf(stdout, "Qn %d error= %f\n", QN, Result);
    return 0;
    } /* End main */   
    
    

/******************************************************************************
 Purpose: Finds a root of scalar, non-linear function f using the integer 
 bisection  method. a and b make up the initial bracket to start bisecting from.
 Only implement this after you have the floating point function implemented
 
 Where: ifunc1arg f - INTEGER function whose root is to be determined
                      must take a single argument of type double and return
        long a      - initial Qn root bracket guess
        long b      - initial Qn root bracket guess
        long atol   - absolute Qn error termination tolerance,
        int verb    - verbose flag, 1 = TRUE, 0 = FALSE
        
Returns: double - the root refined to the desired tolerance or NAN
Errors:  prints a message and returns with NAN                 
******************************************************************************/
long ibisection(ifunc1arg f, long a, long b, long atol, int verb)
{

}    
    
/*---------------------------------------------------------------------------
  This function implements the real line equation to be solved.  
  
  Where:   double x - the value to evaluate
  Returns: double - the value of the function at the point
  Errors:  none
---------------------------------------------------------------------------*/
double rline(double x){
    return(0.5*x-.3);
}


/*---------------------------------------------------------------------------
  This function implements the integer line equation to be solved.  
  
  Where:    long x - the value to evaluate
  Returns: long - the value of the function at the point
  Errors:  none
---------------------------------------------------------------------------*/
long iline(long x){
    /* Implement return(0.5*x-.3) as Qn code */
    return(... your code here ...); 
}

