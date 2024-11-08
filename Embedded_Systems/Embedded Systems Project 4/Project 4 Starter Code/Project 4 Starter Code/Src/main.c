/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * Copyright (c) 2019 STMicroelectronics International N.V. 
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "stm32l4xx_hal.h"
#include "cmsis_os.h"
#include "i2c.h"
#include "lcd.h"
#include "quadspi.h"
#include "rng.h"
#include "spi.h"
#include "usart.h"
#include "usb_host.h"
#include "gpio.h"


/* USER CODE BEGIN Includes */
#include "string.h"
#include "queue.h"
#include "FreeRTOS.h"
#include "timers.h"
#include "math.h"



// Rtos queue

/* USER CODE END Includes */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/
#define NUM_THREADS (5)
#define NUM_TELLERS (3)
#define QUEUE_LENGTH (100)
#define QUEUE_ITEM_SIZE (10)
#define FINAL_TIME (420)

//TimerHandle_t  xTimer;
TaskHandle_t xHandle [NUM_THREADS];
RNG_HandleTypeDef Rng_Handle;
float randomBank;
float randomTeller;

int id[NUM_THREADS];
char name[NUM_THREADS][10];

unsigned long idle_timer = 0;

int customerCount = 0;


float maxWaitTimeforTeller;
float maxTransactionTimeForTeller;
int maxDepthOfQueue;




struct teller
{
	int tellerNumber;
	int isServing;
	int customersServed;
	float timeSpentWaitingForCust;
	float timeSpentAtTeller;
	float custWaitTimer;
};



struct bank
{
	int totalNumberOfCustomers;
	float timeLeftUntilNextCustomer;
	float timeSpentInQueue;
  float time;
	
};



	struct teller teller1;
	struct teller teller2;
	struct teller teller3;
	struct bank bank1;
	
		int bank11 = 0;
	int tellerNumber1 = 1;
	int tellerNumber2 = 2;
	int tellerNumber3 = 3;


SemaphoreHandle_t HAL_mutex;
QueueHandle_t xQueue;
TimerHandle_t xTimer;
	
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
void MX_FREERTOS_Init(void);

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/
void UART2_Init(void);
void UART2_GPIO_Init(void);

/* USER CODE END PFP */

/* USER CODE BEGIN 0 */




void vApplicationIdleHook( void ) {
	idle_timer++;
}



void thread (void* argument) {
	int arg = *(int*)argument;
	char msg [25];
	sprintf(msg, "Running Thread%d\r\n", arg);
	xSemaphoreTake (HAL_mutex, 1000000000);
	HAL_UART_Transmit(&huart2, (uint8_t *)msg, strlen(msg), 1000000);
	xSemaphoreGive (HAL_mutex);
	vTaskDelete (NULL);
}




void teller (void* arguments) {
	
	int cu;
	int freeSpaces;
	//struct teller xTeller = *(struct teller *) arguments;
	//int tellerNumberA = *(int *) arguments;
	struct teller xTeller = *(struct teller *) arguments;
	

	for(;;){

	if (xTeller.isServing == 1){
			if (xTeller.custWaitTimer <= 0){  // customer is cooked kick them out
				xTeller.isServing = 0;
				xTeller.customersServed++;
			} else{
				xTeller.custWaitTimer--;
			}
		xTeller.timeSpentAtTeller++;
	} else {
		// check if queue is empty and if it is then grab a guy
		freeSpaces = uxQueueSpacesAvailable( xQueue );
		if (freeSpaces >= QUEUE_LENGTH){
			// empty queue
			xTeller.timeSpentWaitingForCust++;
			if (xTeller.timeSpentWaitingForCust > maxWaitTimeforTeller){
				maxWaitTimeforTeller = xTeller.timeSpentWaitingForCust;
			}
			
		} else{ // get a body
			xQueueReceive(xQueue,&cu, 100);
			xTeller.isServing = 1;
			xTeller.timeSpentAtTeller++;
			// generate random number and
			//have the customer stay there 
			//for that time 
			
			// random time

			
			randomTeller = (((HAL_RNG_GetRandomNumber(&Rng_Handle)) % 16) + 1.0)/2.0;

			
			xTeller.custWaitTimer = randomTeller; // .5 - 8 mins == 
			if (maxTransactionTimeForTeller < xTeller.custWaitTimer){
				maxTransactionTimeForTeller = xTeller.custWaitTimer;
			}
			
		}
	}
	
	switch(xTeller.tellerNumber){
		case 1 :
			teller1 = xTeller;
			break;
		
		case 2: 
			teller2 = xTeller;
			break;
		case 3:
			teller3 = xTeller;
			break;
	}
		

	
		osDelay(100);

	
}

	//vTaskDelete (NULL);

}

/*can do OS delay for the things and the stuff*/

void bank (void* arguments) {

	int cu;
	int freeSpaces;
	struct bank xBank = bank1;
	int arg = *(int*)arguments;
	//TickType_t xNextWakeTime;
	
	//xNextWakeTime = xTaskGetTickCount();

	//xSemaphoreTake (HAL_mutex, 1000);
	
	

	// os dealy, specify number of ms 
	for(;;){
	cu = bank1.totalNumberOfCustomers + 1;
	
	//customer creation
  if (bank1.timeLeftUntilNextCustomer <= 0.0){
		if (bank1.time < FINAL_TIME){
		xQueueSendToBack(xQueue, &cu, 10);
			bank1.totalNumberOfCustomers++;
		}
		

			
		
		
		randomBank = (((HAL_RNG_GetRandomNumber(&Rng_Handle)) % 4) + 1.0);
		bank1.timeLeftUntilNextCustomer = randomBank; // 1-4 mins = 1 - 4 ms random
		
	} else {
		bank1.timeLeftUntilNextCustomer--;
	}
	
		//check if queue is empty
	freeSpaces = uxQueueSpacesAvailable( xQueue );
	if (freeSpaces < QUEUE_LENGTH){
		bank1.timeSpentInQueue++; // adds time to how long custs in queue
	}
 if (QUEUE_LENGTH - freeSpaces > maxDepthOfQueue){
	 maxDepthOfQueue = (QUEUE_LENGTH - freeSpaces) ;
	 
 }
//vTaskSuspend(xHandle[0]);
	
	/*char msg [25];
	sprintf(msg, "Bank %d\r\n", bank1.totalNumberOfCustomers);
	xSemaphoreTake (HAL_mutex, 1000000000);
	HAL_UART_Transmit(&huart2, (uint8_t *)msg, strlen(msg), 1000000);
	xSemaphoreGive (HAL_mutex);*/
	
	bank1.time++;
	osDelay(100);
	
	
	
	/*char msgg [25];
	sprintf(msgg, "1 second\r\n");
	xSemaphoreTake (HAL_mutex, 1000000000);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
	xSemaphoreGive (HAL_mutex);*/
	
	
	//end clause
	char msgg [25];
	sprintf(msgg, "Simulated Time: %f\r\n", bank1.time);
	xSemaphoreTake (HAL_mutex, 1000000000);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
	sprintf(msgg, "Number of Customers Waiting %i\r\n", (QUEUE_LENGTH - freeSpaces));
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
	sprintf(msgg, "Teller 1: %i\r\n", teller1.isServing);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);	
	sprintf(msgg, "Teller 2: %i\r\n", teller2.isServing);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);		
	sprintf(msgg, "Teller 3: %i\r\n", teller3.isServing);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);	
	sprintf(msgg, "\033[5A");
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
	xSemaphoreGive (HAL_mutex);
	
	
	if (bank1.time >= FINAL_TIME && freeSpaces == QUEUE_LENGTH && teller1.isServing == 0 && teller2.isServing == 0 && teller3.isServing == 0 ){

		
					char msgg [25];

	xSemaphoreTake (HAL_mutex, 1000000000);
		sprintf(msgg, "\033[5B");
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
		sprintf(msgg, "Bank Total Cust %i\r\n", bank1.totalNumberOfCustomers);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);	
		
				sprintf(msgg, "Teller 1 Cust Served: %i\r\n", teller1.customersServed);	
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);	
		
			sprintf(msgg, "Teller 2 Cust Served: %i\r\n", teller2.customersServed);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);	
		
			sprintf(msgg, "Teller 3 Cust Served: %i\r\n", teller3.customersServed);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);

		sprintf(msgg, "Avg Time In Queue %f\r\n", (bank1.timeSpentInQueue/bank1.totalNumberOfCustomers));
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);

float avgTimeAtTeller = teller1.timeSpentAtTeller + teller2.timeSpentAtTeller + teller2.timeSpentAtTeller;
avgTimeAtTeller = avgTimeAtTeller/bank1.totalNumberOfCustomers;

sprintf(msgg, "Avg Time Cust with Teller: %f\r\n", avgTimeAtTeller);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);


float avgTimeWaitForCust = teller1.timeSpentWaitingForCust + teller2.timeSpentWaitingForCust + teller3.timeSpentWaitingForCust; 
avgTimeWaitForCust = avgTimeWaitForCust/bank1.totalNumberOfCustomers;


	sprintf(msgg, "Avg Time Teller Waits for customer %f\r\n", avgTimeWaitForCust);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);	

		
		
		sprintf(msgg, "Max Wait Time for Teller: %f\r\n", maxWaitTimeforTeller);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);	
		
		sprintf(msgg, "Max Wait Transaction time for Tellers: %f\r\n", maxTransactionTimeForTeller);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);			
		
		
		sprintf(msgg, "Max Depth of QUEUE: %i\r\n", maxDepthOfQueue);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);			
			
		
		sprintf(msgg, "Teller 1 Time Waiting for Cust: %f\r\n", teller1.timeSpentWaitingForCust);
		HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
		
				sprintf(msgg, "Teller 1 Time At Teller: %f\r\n", teller1.timeSpentAtTeller);
		HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
	

				sprintf(msgg, "Teller 2 Time Waiting for Cust: %f\r\n", teller2.timeSpentWaitingForCust);
		HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
		
				sprintf(msgg, "Teller 2 Time At Teller: %f\r\n", teller2.timeSpentAtTeller);
		HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
		

				sprintf(msgg, "Teller 3 Time Waiting for Cust: %f\r\n", teller3.timeSpentWaitingForCust);
		HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
		
				sprintf(msgg, "Teller 3 Time At Teller: %f\r\n", teller3.timeSpentAtTeller);
		HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
		
		

	

	
	
			sprintf(msgg, "Time %f\r\n", bank1.time);
	HAL_UART_Transmit(&huart2, (uint8_t *)msgg, strlen(msgg), 1000000);
	xSemaphoreGive (HAL_mutex);

		vTaskDelete (xHandle[1]);
		vTaskDelete (xHandle[2]);
		vTaskDelete (xHandle[3]);
		vTaskDelete (xHandle[0]);
	}
	
	
}
	//vTaskDelete (NULL);
	}







void thread_init (void) {
	HAL_mutex = xSemaphoreCreateMutex ();
	//xTimer = xTimerCreate("Timer",(100),pdTRUE,(void *) 0, NULL );
	
	xQueue = xQueueCreate(QUEUE_LENGTH, QUEUE_ITEM_SIZE);
	
	//xTimerCreate("timer",pdMS_TO_TICKS(42000), pdTRUE,(void *) 0, NULL);//100ms = 1min
	//xTimerStart(xTimer,0);
	
	char msg [25];
	sprintf(msg,"thread init\r\n");
	HAL_UART_Transmit(&huart2,(uint8_t *)msg, strlen(msg),10);
	
	
						Rng_Handle.Instance = RNG;
			if(HAL_RNG_Init(&Rng_Handle) != HAL_OK){
				Error_Handler();
				
			}

	
	teller1.tellerNumber = 1;
	teller1.isServing = 0;
	teller1.customersServed = 0;
	teller1.timeSpentAtTeller = 0.0;
	teller1.timeSpentWaitingForCust = 0.0;
	teller1.custWaitTimer = 0.0;
	
	teller2.tellerNumber = 2;
	teller2.isServing = 0;
	teller2.customersServed = 0;
	teller2.timeSpentAtTeller = 0.0;
	teller2.timeSpentWaitingForCust = 0.0;
	teller2.custWaitTimer = 0.0;
	
	teller3.tellerNumber = 3;
	teller3.isServing = 0;
	teller3.customersServed = 0;
	teller3.timeSpentAtTeller = 0.0;
	teller3.timeSpentWaitingForCust = 0.0;
	teller3.custWaitTimer = 0.0;
	
	bank1.timeSpentInQueue = 0.0;
	bank1.totalNumberOfCustomers = 0;
	bank1.timeLeftUntilNextCustomer = 0.0;
	bank1.time = 0.0;
	
	


	xTaskCreate (bank,	"Bank", 256, (void * ) &bank11, osPriorityNormal, &xHandle[0]);
	xTaskCreate (teller,	"Teller1", 256, (void * ) &teller1, osPriorityNormal, &xHandle[1]);
	xTaskCreate (teller, "Teller2", 128, (void * ) &teller2, osPriorityNormal,  &xHandle[2]);
	xTaskCreate (teller, "Teller3", 128, (void * ) &teller3, osPriorityNormal, &xHandle[3]);
	

		

//	vTaskStartScheduler();
	
}
/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  *
  * @retval None
  */


int main(void)
{
  HAL_Init();
  SystemClock_Config();
  MX_GPIO_Init();
  MX_I2C1_Init();
  MX_USART2_UART_Init();
  MX_RNG_Init();

	thread_init ();

  MX_FREERTOS_Init();
	

	
	
	//HAL_Delay(100);
	
	
	

  osKernelStart();
	
	



  

  while (1)
  {

  }

}





























/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{

  RCC_OscInitTypeDef RCC_OscInitStruct;
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_PeriphCLKInitTypeDef PeriphClkInit;

    /**Configure LSE Drive Capability 
    */
  __HAL_RCC_LSEDRIVE_CONFIG(RCC_LSEDRIVE_LOW);

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_LSI|RCC_OSCILLATORTYPE_LSE
                              |RCC_OSCILLATORTYPE_MSI;
  RCC_OscInitStruct.LSEState = RCC_LSE_ON;
  RCC_OscInitStruct.LSIState = RCC_LSI_ON;
  RCC_OscInitStruct.MSIState = RCC_MSI_ON;
  RCC_OscInitStruct.MSICalibrationValue = 0;
  RCC_OscInitStruct.MSIClockRange = RCC_MSIRANGE_6;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_MSI;
  RCC_OscInitStruct.PLL.PLLM = 1;
  RCC_OscInitStruct.PLL.PLLN = 20;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV7;
  RCC_OscInitStruct.PLL.PLLQ = RCC_PLLQ_DIV2;
  RCC_OscInitStruct.PLL.PLLR = RCC_PLLR_DIV2;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV2;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_1) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

  PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_RTC|RCC_PERIPHCLK_USART2
                              |RCC_PERIPHCLK_I2C1|RCC_PERIPHCLK_I2C2
                              |RCC_PERIPHCLK_USB|RCC_PERIPHCLK_RNG;
  PeriphClkInit.Usart2ClockSelection = RCC_USART2CLKSOURCE_PCLK1;
  PeriphClkInit.I2c1ClockSelection = RCC_I2C1CLKSOURCE_PCLK1;
  PeriphClkInit.I2c2ClockSelection = RCC_I2C2CLKSOURCE_PCLK1;
  PeriphClkInit.RTCClockSelection = RCC_RTCCLKSOURCE_LSI;
  PeriphClkInit.UsbClockSelection = RCC_USBCLKSOURCE_PLLSAI1;
  PeriphClkInit.RngClockSelection = RCC_RNGCLKSOURCE_PLLSAI1;
  PeriphClkInit.PLLSAI1.PLLSAI1Source = RCC_PLLSOURCE_MSI;
  PeriphClkInit.PLLSAI1.PLLSAI1M = 1;
  PeriphClkInit.PLLSAI1.PLLSAI1N = 24;
  PeriphClkInit.PLLSAI1.PLLSAI1P = RCC_PLLP_DIV7;
  PeriphClkInit.PLLSAI1.PLLSAI1Q = RCC_PLLQ_DIV2;
  PeriphClkInit.PLLSAI1.PLLSAI1R = RCC_PLLR_DIV2;
  PeriphClkInit.PLLSAI1.PLLSAI1ClockOut = RCC_PLLSAI1_48M2CLK;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Configure the main internal regulator output voltage 
    */
  if (HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Configure the Systick interrupt time 
    */
  HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq()/1000);

    /**Configure the Systick 
    */
  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

    /**Enable MSI Auto calibration 
    */
  HAL_RCCEx_EnableMSIPLLMode();

  /* SysTick_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(SysTick_IRQn, 15, 0);
}

/* USER CODE BEGIN 4 */
void UART2_Init(void) {
		// Enable the clock of USART 1 & 2
	RCC->APB1ENR1 |= RCC_APB1ENR1_USART2EN;  // Enable USART 2 clock		
	
	// Select the USART1 clock source
	// 00: PCLK selected as USART2 clock
	// 01: System clock (SYSCLK) selected as USART2 clock
	// 10: HSI16 clock selected as USART2 clock
	// 11: LSE clock selected as USART2 clock
	RCC->CCIPR &= ~RCC_CCIPR_USART2SEL;
	RCC->CCIPR |=  RCC_CCIPR_USART2SEL_0;
	
	UART2_GPIO_Init();
	//USART_Init(USART2);
	
	USART2->CR1 |= USART_CR1_RXNEIE;  			// Received Data Ready to be Read Interrupt  
	NVIC_SetPriority(USART2_IRQn, 0);			// Set Priority to 1
	NVIC_EnableIRQ(USART2_IRQn);					// Enable interrupt of USART peripheral
}

void UART2_GPIO_Init(void) {
	
	// Enable the peripheral clock of GPIO Port
	RCC->AHB2ENR |=   RCC_AHB2ENR_GPIODEN;
	
	// ********************** USART 2 *************************** 
	// PD5 = USART2_TX (AF7)
	// PD6 = USART2_RX (AF7)
	// Alternate function, High Speed, Push pull, Pull up
	// **********************************************************
	// Input(00), Output(01), AlterFunc(10), Analog(11)
	GPIOD->MODER   &= ~(0xF << (2*5));	// Clear bits
	GPIOD->MODER   |=   0xA << (2*5);      		
	GPIOD->AFR[0]  |=   0x77<< (4*5);       	
	// GPIO Speed: Low speed (00), Medium speed (01), Fast speed (10), High speed (11)
	GPIOD->OSPEEDR |=   0xF<<(2*5); 					 	
	// GPIO Push-Pull: No pull-up, pull-down (00), Pull-up (01), Pull-down (10), Reserved (11)
	GPIOD->PUPDR   &= ~(0xF<<(2*5));
	GPIOD->PUPDR   |=   0x5<<(2*5);    				
	// GPIO Output Type: Output push-pull (0, reset), Output open drain (1) 
	GPIOD->OTYPER  &=  ~(0x3<<5) ;       	
}

/* StartDefaultTask function */


/* USER CODE END 4 */

/**
  * @brief  Period elapsed callback in non blocking mode
  * @note   This function is called  when TIM5 interrupt took place, inside
  * HAL_TIM_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  htim : TIM handle
  * @retval None
  */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
  /* USER CODE BEGIN Callback 0 */

  /* USER CODE END Callback 0 */
  if (htim->Instance == TIM5) {
    HAL_IncTick();
  }
  /* USER CODE BEGIN Callback 1 */

  /* USER CODE END Callback 1 */
}

/**
  * @brief  This function is executed in case of error occurrence.
  * @param  file: The file name as string.
  * @param  line: The line in file as a number.
  * @retval None
  */
char err_msg[100];
void _Error_Handler(char *file, int line)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  sprintf(err_msg, "ERROR: %s(%d)\r\n", file, line);
	HAL_UART_Transmit(&huart2, (uint8_t *)err_msg, strlen(err_msg), 1000000);
	while(1)
  {
		
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
