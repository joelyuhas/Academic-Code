/*---------------------------------------------------------------------------
  sleep.c - student file
  01/01/2016    R. Repka    This code is only used to verify your timing macros
  02/202016     R. Repka    Added include file hint
---------------------------------------------------------------------------*/
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include "Timers.h"
/* add other include files as necessary */

DECLARE_TIMER(input);
DECLARE_REPEAT_VAR(repeat);

int main()
   {
   clock_t end_t;
   int delay;
	
 	BEGIN_REPEAT_TIMING(3,repeat);
  	START_TIMER(input);


  
 printf("Start\n");

   /* Your macro stuff here */
   
   /* wait for 60 seconds */
   end_t = clock() + 4 * CLOCKS_PER_SEC;
   while (end_t > clock())
      {
      /* Consume CPU time */
      delay = 1<<19;
      while (delay) 
         {
         delay--;
         }
      }
   
   /* more of your macro stuff */   
   
   printf("End\n");

	STOP_TIMER(input);
	PRINT_TIMER(input);
	PRINT_RTIMER(input, 2);
	RESET_TIMER(input);
	END_REPEAT_TIMING;

   return 0;
}
