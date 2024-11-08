/*---------------------------------------------------------------------------
  05/08/2017    R. Repka    Make derivative clearer
---------------------------------------------------------------------------*/


/*---------------------------------------------------------------------------
  Student framework equations to be solved to help with the root finder 
---------------------------------------------------------------------------*/
#include "rootfinding.h"
#include <math.h>

/*---------------------------------------------------------------------------
  This function implements the equation to be solved.  
  
  Where: double x - the value to evaluate
  Returns: double - the value of the function at the point
  Errors:  none
---------------------------------------------------------------------------*/
double func1(double x){
double value = (0.76*x*sin((30.0/52.0)*x)*tan((10.0/47.0)*x)+2.9*cos(x+2.5)*sin(0.39*(1.5+x)));
return value;

}


/*---------------------------------------------------------------------------
  This function implements the first derivative equation, which is calculated
  via any off-line process you wish (e.g  Wolfram Alpha)
  There is NO requirement to programmatically generate the derivative.
  
  Where: double x - the value to evaluate
  Returns: double - the value of the function at the point
  Errors:  none
---------------------------------------------------------------------------*/
double func1Deriv(double x){
double value = (-2.9*sin(0.39*(x+1.5))*sin(x+2.5)) + (1.131*cos(0.39*(x+1.5))*cos(x+2.5)) + (0.76*sin(0.576923*x)*tan(0.212766*x)) + (0.438362*x*cos(0.576923*x)*tan(0.212766*x)) + ((0.161702*x*sin(0.576923*x)*(2.0-(2.0*tan(0.212766*x))/(tan(2.0*0.212766*x)))));
return value;

}
