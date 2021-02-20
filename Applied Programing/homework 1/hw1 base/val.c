/*---------------------------------------------------------------------------
  val.c - This program demonstrats VALGRIND returning programming errors
  Student copy
---------------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>

#define NUM_ELEMS (5)

int main(){

    int *num;
    int i;
    
    num = malloc(sizeof(int)*NUM_ELEMS);
    num [0] = 0;


    printf("The first numbers are %d\n", num[0]);

    /* Init the number */
    for (i = 2; i < NUM_ELEMS; i++) {
       num[i] = i;
    }
    
    
    printf("The next numbers are %d %d\n", num[2], num[3]);
    free(num);
    


return(0);
}
