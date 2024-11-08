#include "stm32l476xx.h"
#include "SysClock.h"
#include "LED.h"
#include "UART.h"

#include <string.h>
#include <stdio.h>

char RxComByte = 0;
uint8_t buffer[BufferSize];
char str[] = "Give Red LED control input (Y = On, N = off):\r\n";
int edges[1001];
int low = 950;
int high = 1050;

/*********************************************************
* POST_Test()
*
* This funciton is used to run the POST test, which checks
* to see if an edge can be detected within 100
* milliseconds, otherwise it proeeds to the FAIL_Test()
**********************************************************/

int POST_Test( void){
	int n = 0;
	int beginTime = 0;

	TIM2->CR1 = TIM_CR1_CEN; // start timer
	beginTime = TIM2->CCR1;
	
	n = sprintf((char *)buffer, "Starting POST Test\r\n");
	USART_Write(USART2, buffer, n);	
	
	while(1){
		if (TIM2->SR & 0x2){
		
			if( TIM2->CCR1 - beginTime <= 100000){
				n = sprintf((char *)buffer, "POST Test Passed!\r\n");
				USART_Write(USART2, buffer, n);	
							
				TIM2->CR1 &= ~(TIM_CR1_CEN);		// stop timer
				return 1;
			}
			else{
				n = sprintf((char *)buffer, "POST Test Failed!\r\n");
				USART_Write(USART2, buffer, n);	
				TIM2->CR1 &= ~(TIM_CR1_CEN);
				FAIL_Test();
			}
		}
		if((TIM2->CCR1 - beginTime) > 100000){
			n = sprintf((char *)buffer, "POST Test Failed!\r\n");
			USART_Write(USART2, buffer, n);	
				
			TIM2->CR1 &= ~(TIM_CR1_CEN);	// stop timer
			FAIL_Test();
		}
  }
}


/*********************************************************
* FAIL_Test()
*
* This funciton is used to handle the fail cases of the
* POST test by allowingthe user to either re-run the POST
* test or terminate
**********************************************************/
int FAIL_Test (void){
	int n = 0;
	char rxByte;
	n = sprintf((char *)buffer, "Re-run POST test?\r\n");
	USART_Write(USART2, buffer, n);
	
	rxByte = USART_Read(USART2);
	if(rxByte == 'n' || rxByte == 'N'){
		return 1;
	}
	else if(rxByte == 'y' || rxByte == 'Y'){
		n = sprintf((char *)buffer, "Restarting\r\n");
		USART_Write(USART2, buffer, n);
		return POST_Test();
	}
	else{
		n = sprintf((char *)buffer, "Improper input\r\n");
		USART_Write(USART2, buffer, n);
		return FAIL_Test();
	}
}


/*********************************************************
* MAIN_Test()
*
* After the POST test has been completed, the main test
* executes. The Main test is responsible for counting the
* number of edges in a 1 milisecond time span, 1000 times
**********************************************************/
int MAIN_Test(void){
	int n = 0;
	char rxByte;
	int sampleNum = 0;
	int beginTime = 0;
	char newbound[5];
	int w = 0;
	
	n = sprintf((char *)buffer, "Current range %d - %d\r\n", low, high);
	USART_Write(USART2, buffer, n);	
	n = sprintf((char *)buffer, "[Y] to accept values [N] to set new ones\r\n");
	USART_Write(USART2, buffer, n);		
	
	rxByte = USART_Read(USART2);	// Reading User input
	
	if( rxByte == 'y' || rxByte == 'Y'){
		// YES CASE: proceed with test
		USART_Write(USART2, (uint8_t *) "Bounds: 950 - 1050 \r\n", 21);		
	}
  else if( rxByte == 'n' || rxByte == 'N'){
		// NO CASE: get new bounds from user
		n = sprintf((char *)buffer, "Enter new lower bound (50-9950): \r\n");
	  USART_Write(USART2, buffer, n);	
		
		rxByte = USART_Read(USART2);
		
		while(rxByte != 0xD){
			newbound[w] = rxByte;
			w++;
			rxByte = USART_Read(USART2);
		}
		
		sscanf(newbound, "%d", &low); // concatinating user input
		
		if(low < 50 || low > 9950){
			// Out of Bound Scenario
			n = sprintf((char *)buffer, "Out of bounds \r\n");
			USART_Write(USART2, buffer, n);	
			return 1;		
		} else {
			// In bounds scenario, create new bounds
			high = low + 100;
			n = sprintf((char *)buffer, "New range %d - %d\r\n", low, high);
			USART_Write(USART2, buffer, n);	
		}
		
		
	}
	
	n = sprintf((char *)buffer, "Running\r\n");
	USART_Write(USART2, buffer, n);	
	
	for( sampleNum = 0; sampleNum < 1001; sampleNum++){
		TIM2->CR1 |= TIM_CR1_CEN;
		beginTime = TIM2->CCR1;
		while(1){
			if (TIM2->SR & 0x2){
				edges[sampleNum] = (TIM2->CCR1 - beginTime);
				TIM2->CR1 &= ~(TIM_CR1_CEN); 	// End timer
				break;
			}
		}
	}	
	return (1);
}

/*********************************************************
* FINAL_Print()
*
* FINAL Print is responsible for printing out the data 
* that was gathered from the MAIN test. FINAL Print will
* orginize the data, place it into its "buckets", remove
* all non zero numbers, and print the fina results
**********************************************************/
int FINAL_Print(void){
	int i = 0;
	int j = 0;
	int q = 0;
	int w = 0;
	int n = 0;
	int flag = 0;

	/* 
	 * Final 2D array, 1st index is for number of edges counted 
	 * in single run 2nd index is for number of times that number 
	 * was counted in the 1000 interations
	 */
	int results[9][2] = {{0,0},{0,0}, {0,0}, {0,0},{0,0}, {0,0}, {0,0},{0,0}, {0,0}};
	
	/*
	 * 'i' iteration goes through the 1000 test
	 * 'j' iteration goes through the final results array
	 * to check if the gathered result form edges[i] has
	 * been recorded
	 */
	for (i = 0; i < 1000; i++){
		for(j = 0; j < 9; j++){
			if(edges[i] == results[j][0]){
				// matching edge has bene found, increment
				results[j][1] += 1;
				flag = 1;
			}
		}
		if(flag == 0){
			// edge has not been found in results, add it
			results[w][0] = edges[i];
			results[w][1] = 1;
			w++;
			flag = 0;
		}
		flag = 0;
	}
	
	/*
	 * Final loop to print values. Also checks
	 * if the value is within the bounds, otherwise it
	 * wont display it.
	 */
	for(i = 0; i < 9; i++){
		if (results[i][0] >= low && results[i][0] <= high){
			if (results[i][0] != 0){
				n = sprintf((char *)buffer, "%d: ", results[i][0]);
				USART_Write(USART2, buffer, n);
		
				q = sprintf((char *)buffer, "%d\r\n", results[i][1]);
				USART_Write(USART2, buffer, q);
	
				n = 0;
				q = 0;
			}
		}
	}
	return (1);
}



/*********************************************************
* main()
*
* The main loop, initializes everything and runs the test.
**********************************************************/
int main(void){
	int q = 0;
	char rxByte;	
	int x = 1;
	
	
	//-------------------------------------------------
	// INITIALIZATION Section
	//-------------------------------------------------
	
		System_Clock_Init(); // Switch System Clock = 80 MHz
		LED_Init();
		UART2_Init();
		
		//Initializing PA0
		RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN ;      
		GPIOA->MODER &= ~3 ;                                
		GPIOA->MODER |= 2 ; 
		 
		// Initializing Timer
		GPIOA->AFR[0] |= 0x1;                   
		RCC->APB1ENR1 |= RCC_APB1ENR1_TIM2EN;   
		TIM2->PSC = 80;                 	
		TIM2->EGR |= TIM_EGR_UG;               
		TIM2->CCER &= ~(0xFFFFFFFF);          
		TIM2->CCMR1 |= 0x1;                  
		TIM2->CCER |= 0x1;                     
	
	
	//-------------------------------------------------
	// EXECUTION Section
	//-------------------------------------------------

		POST_Test();
			
		while (x){
			MAIN_Test();
			FINAL_Print();
			
			q = sprintf((char *)buffer, "Re-run?\r\n");
			USART_Write(USART2, buffer, q);
			
			rxByte = USART_Read(USART2);	// Getting user input
			
			if( rxByte == 'y' || rxByte == 'Y'){
				x = 1;
				
			} else {
				q = sprintf((char *)buffer, "Exiting\r\n");
				USART_Write(USART2, buffer, q);
				x = 0;
				return 1;
			}
		}
		return 1;
}
	
	
