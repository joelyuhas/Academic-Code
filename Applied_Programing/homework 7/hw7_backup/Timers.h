/*************************************************************************
* Timers.h - Instrumentation Macros Module  - Student file
*
* The timing instrumentation macros can be globally enabled by setting 
* the variable EN_TIME (ENable TIMErs) in the compiler command line, e.g., 
* use "gcc -DEN_TIME...." to enable the timers when needed.
* A compiler warning will be issued when the timers are enabled.  
* Note: All timing output should be directed to stderr.
*
*  10/08/2016   R. Repka    Fixed C++ struct warnings 
*  12/03/2016   R. Repka    Added semicolon to DECLARE_TIMER
**************************************************************************/


/* Need to implement:
 	PRINT_RTIMER(A,R)
	BEGIN_REPEAT_TIMING(R,V)
	END_REPEAT_TIMING
	DECLARE_REPEAT_VAR(V)*/

#ifndef _TIMERS_H_
#define _TIMERS_H_

#if defined(EN_TIME)
	#include <stdio.h>
	#include <time.h>

    struct timmerDetails {                                                    
      clock_t Start;    /* Start Time   - set when the timer is started */
      clock_t Stop;     /* Stop Time    - set when the timer is stopped */
      clock_t Elapsed;  /* Elapsed Time - Accumulated when the timer is stopped */
      int State;        /* Timer State  - 0=stopped / 1=running */
    }; /* Elapsed Time and State must be initialized to zero */

  #define DECLARE_TIMER(A)                                                    \
    struct timmerDetails                                                      \
     A = /* Elapsed Time and State must be initialized to zero */             \
      {                                                                       \
      /* Start   = */ 0,                                                      \
      /* Stop    = */ 0,                                                      \
      /* Elapsed = */ 0,                                                      \
      /* State   = */ 0,                                                      \
      } /* Timer has been declared and defined,   ;  IS required */
      
/* Write the timing macros here */


	#define START_TIMER(A)							\
	{									\
		if(1 == A.State)						\
			fprintf(stderr, "Error, running timer "#A"/ \n");	\
		A.State = 1;							\
		A.Start = clock();						\
										\
	}/*START_TIMER()*/							

	#define RESET_TIMER(A)							\
	{									\
		A.Elapsed = 0;							\
										\
	}/*RESET_TIMER()*/							

	#define STOP_TIMER(A)							\
	{									\
		A.Stop = clock();						\
		if (0 == A.State)						\
			fprintf(stderr, "Error, stopped timer "#A" stopped agai. \n"); \
		else								\
			A.Elapsed += A.Stop - A.Start;				\
		A.State = 0;							\
										\
	}/*STOP_TIMER()*/							

	#define PRINT_TIMER(A)							\
	{									\
		if (1 == A.State)						\
			STOP_TIMER(A);						\
		fprintf(stderr, "Elapsed CPU time ("#A") = %g sec.\n",	\
				(double)A.Elapsed / (double)CLOCKS_PER_SEC);	\
										\
	}/*PRINT_TIMER()*/


	#define PRINT_RTIMER(A, R)						\
	{									\
		if (1 == A.State) {						\
			STOP_TIMER(A);	}					\
		fprintf(stderr, "Elapsed CPU time ("#A", %d) = %2e sec.\n", R,		\
				(double)A.Elapsed / (double)CLOCKS_PER_SEC / (double)R) ;	\
	}/*PRINT_RTIMER*/

	#define BEGIN_REPEAT_TIMING(R,V)					\
		{							\
		for(V = 0; V<(R); V++) {					\
										\

	#define END_REPEAT_TIMING	}	}				\


	#define DECLARE_REPEAT_VAR(V)						\
		int V = 0							
	/*DECLARE_REPEAT_VAR(V)*/


#else /*No defined*/
	#define DECLARE_TIMER(A)
	#define START_TIMER(A)
	#define RESET_TIMER(A)
	#define STOP_TIMER(A)
	#define PRINT_TIMER(A)
	#define PRINT_RTIMER(A, R)
	#define BEGIN_REPEAT_TIMING(R,V)
	#define END_REPEAT_TIMING
	#define DECLARE_REPEAT_VAR(V)

#endif /*EN_TIMER check*/

#endif /* _TIMERS_H_ */
