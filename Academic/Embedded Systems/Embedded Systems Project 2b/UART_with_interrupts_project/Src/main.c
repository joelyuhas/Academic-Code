/* USER CODE BEGIN Header */
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
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "cmsis_os.h"


RNG_HandleTypeDef hrng;
TIM_HandleTypeDef htim4;
TIM_HandleTypeDef htim5;
UART_HandleTypeDef huart2;
osThreadId defaultTaskHandle;


/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_USART2_UART_Init(void);
static void MX_RNG_Init(void);
static void MX_TIM5_Init(void);
static void MX_TIM4_Init(void);
void StartDefaultTask(void const * argument);


#include "string.h"

uint8_t rx_buffer[20];  // Shared buffer between foreground and UART RX
uint8_t rx_byte;        // the currently received byte
uint8_t rx_index = 0;   // pointer into the rx_buffer
SemaphoreHandle_t  transmit_mutex;  // protects UART transmitter resource
SemaphoreHandle_t  receive_mutex;   // protects UART receiveer resource


/* Define Statments ------------------------------------------------------------*/
#define MOV (0x20)
#define WAIT (0x30)
#define RECIPE_END (0)
#define LOOP (0x40)
#define END_LOOP (0x50)
#define WAVE ((0x60))
	
	
	
/* Structs ---------------------------------------------------------------------*/	
	
enum status 						// used for mov commands
{
	status_running,
	status_paused,
	status_command_error,
	status_nested_error 
} ;

enum servo_states 			// initializes the state of each servo
{
	state_at_position,		// use a separate integer to record the current position (0 through 5) for each servo.
	state_paused,
	state_stop,
	state_moving,
	state_recipe_ended,
	state_user_input,
	state_wave
} ;

enum events 						// used for user I/O
{
	user_entered_left,
	recipe_ended
} ;


static enum servo_states current_servo_state = state_paused ;
static enum servo_states current_servo_state1 = state_paused ;
static enum status current_status = status_paused;
static enum status current_status1 = status_paused;


/* Receipie declarations ------------------------------------------*/
unsigned char recipe3[] = { MOV, 0, MOV, 5, MOV, 0, MOV, 3, LOOP, 0, MOV, 1, MOV, 4, END_LOOP, MOV, 0,MOV, 2,WAIT, 0, MOV, 2, MOV, 3,WAIT, 31,WAIT, 31,WAIT, 31,MOV,4, RECIPE_END } ;
unsigned char recipe4[] = { MOV, 1, MOV, 0, LOOP, 3, MOV, 5, MOV, 4, END_LOOP, RECIPE_END } ;
unsigned char recipe5[] = { LOOP, 1, MOV, 0, LOOP, 3, MOV, 5, MOV, 4, END_LOOP, END_LOOP, RECIPE_END } ;
unsigned char recipe6[] = { MOV,1, WAVE, MOV, 2,MOV, 3,MOV, 0,RECIPE_END } ;
	
	
uint8_t buffer1[1];
uint8_t buffer2[1];

// Servo 1 valriable delcarations
int counter = 0;
int wait_counter = 0;
int recipie_count = 0;
int loop_count = 0;			// loop hanlde
int loop_position = 0; 	// loop position
int position= 0;				// global variable for the position
	
// Servo 2 variable declarations
int position1=0;				// position for servo 2
int counter1 = 0;
int wait_counter1 = 0;
int recipie_count1 = 0;
int loop_count1 = 0;		// loop hanlde
int loop_position1 = 0; // loop position
int wave_counter = 0;
uint8_t prev_command;
uint8_t buffer1[1];
	
uint8_t command[4];	  	// contains user input
uint8_t buffer4[1];

void test_task_init (void);
void test_task(void* argument);
void uart_handle_1(void* argument);
void servo_handle_1 (void* argument);
void servo_handle_2 (void* argument);
void LED_handle (void* argument);

/*
 * prints the string, blocks if UART busy, thus safe from multiple threads
 */
void vPrintString(char *message) {
  xSemaphoreTake(transmit_mutex, ~0);         // Wait forever until the USART is free, then take mutex
  HAL_UART_Transmit_IT(&huart2, (uint8_t *)message, strlen(message));
  xSemaphoreGive(transmit_mutex);             // Give up mutex after printing
}

/*
 * overrides _weak HAL receiver callback, called when byte received
 */
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart) {
  BaseType_t xTaskWoken = pdFALSE;
  static BaseType_t i_have_receive_mutex = pdFALSE;
  if(huart->Instance == USART2) {

    // if received byte is a newline, give the received buffer to the forground
    if(rx_byte == '\r') {
      xSemaphoreGiveFromISR(receive_mutex, &xTaskWoken);
      i_have_receive_mutex = pdFALSE;     // We don't have the mutex anymore
      rx_index = 0;                       // Next time around, queue data from start of buffer
    }
    
    // buffer all characters
    else {
      // acquire receive_mutex once
      if(!i_have_receive_mutex) {
        xSemaphoreTakeFromISR(receive_mutex,  &xTaskWoken);
        i_have_receive_mutex = pdTRUE;    // don't need to ask to Take again
      }
      
      // buffer all other characters
      rx_buffer[rx_index++] = rx_byte;    // buffer the byte
      rx_buffer[rx_index] = 0;            // keep string NULL terminated
      if(rx_index >= sizeof(rx_buffer))
        rx_index = 0;
    }
    HAL_UART_Receive_IT(&huart2, &rx_byte, 1);  // one time, kick off receive interrupt (repeated from within callback)
  }
}


/***************************************************
 * move0()
 ***************************************************
 *
 * responsible for moving the servo based on position
 *
 ***************************************************/
static void move0()
{
	int final_pos = 0;
	if(position == 0){
		final_pos = 320; // 250

	} else if (position == 1){
		final_pos = 500;

	}
	else if (position == 2){
		final_pos = 700;

	}
	else if (position == 3){
		final_pos = 900;

	}
	else if (position == 4){
		final_pos = 1050;

	}
	else if (position == 5){
		final_pos = 1250;

	}
	
	// Used to change pulse size	
	TIM_OC_InitTypeDef sConfigOC = {0};
	sConfigOC.OCMode = TIM_OCMODE_PWM1;
	sConfigOC.Pulse = final_pos;																		// 1250 = 2 ms, * by position 1-6
	sConfigOC.OCPolarity = TIM_OCPOLARITY_HIGH;
	sConfigOC.OCFastMode = TIM_OCFAST_DISABLE;
	
	HAL_TIM_PWM_ConfigChannel(&htim4, &sConfigOC, TIM_CHANNEL_1);		// configure the new pulse
	
	HAL_TIM_PWM_Start(&htim4, TIM_CHANNEL_1);												// restart the timer
}


/***************************************************
 * move1()
 ***************************************************
 *
 * move0 for servo 2
 *
 ***************************************************/
static void move1()
{
	int final_pos = 0;
	if(position1 == 0){
		final_pos = 320; // 250

	} else if (position1 == 1){
		final_pos = 500;

	}
	else if (position1 == 2){
		final_pos = 700;

	}
	else if (position1 == 3){
		final_pos = 900;

	}
	else if (position1 == 4){
		final_pos = 1050;

	}
	else if (position1 == 5){
		final_pos = 1250;

	}
	
	// Used to change pulse size	
	TIM_OC_InitTypeDef sConfigOC = {0};
	
	sConfigOC.OCMode = TIM_OCMODE_PWM1;
  sConfigOC.Pulse = final_pos;
  sConfigOC.OCPolarity = TIM_OCPOLARITY_HIGH;
  sConfigOC.OCFastMode = TIM_OCFAST_DISABLE;
  HAL_TIM_PWM_ConfigChannel(&htim5, &sConfigOC, TIM_CHANNEL_1);
	
	HAL_TIM_PWM_Start(&htim5, TIM_CHANNEL_1);												// restart the timer
}


/***************************************************
 * test_task_init()
 ***************************************************
 *
 * Initalizes all of the task required
 *
 ***************************************************/
char task_names[3][20] = {"1", "2", "3" };
void test_task_init (void) {
  transmit_mutex = xSemaphoreCreateMutex();     // create mutex to protect UART transmitter resource
  receive_mutex = xSemaphoreCreateMutex();      // create mutex to protect UART receiver resource
  
  HAL_UART_Receive_IT(&huart2, &rx_byte, 1);    // one time, kick off receive interrupt (repeated from within rx callback)

	xTaskCreate (uart_handle_1,	"test", 256, (void *)&task_names[1], osPriorityNormal, NULL);
	xTaskCreate (servo_handle_1,	"test1", 256, (void *)&task_names[2], osPriorityNormal, NULL);
	xTaskCreate (servo_handle_2,	"test2", 256, (void *)&task_names[3], osPriorityNormal, NULL);
	xTaskCreate (LED_handle,	"test3", 256, (void *)&task_names[3], osPriorityNormal, NULL);
	
	
}

void servo_handle_1(void* argument) {
  while(1) {
		switch ( current_servo_state )
		{
		 /********************************
			* STATE_AT_POSITON
			*
			* Servo stationary at known position
			* wait for a new command
			*
			********************************/
			case state_at_position :		

				// MOV command received
		
				if (recipe3[recipie_count] == 0x20){
					position = recipe3[recipie_count + 1];
					buffer4[0] = (char)position;
					recipie_count += 2; 
					move0();
					current_servo_state = state_moving;			
					current_status = status_running;
				}
				
				// RECIPE_END command received
				
				if (recipe3[recipie_count] == 0x0){
					recipie_count = 0;				
				}
				
				// WAIT command received
				
				if (recipe3[recipie_count] == 0x30){
					wait_counter = recipe3[recipie_count + 1];
					recipie_count += 2;
					current_servo_state = state_paused;
				}
				
				// LOOP command received
				
				if (recipe3[recipie_count] == 0x40){
					if (loop_count == 0) {											// if it equals 0 then that means there 
						loop_count = recipe3[recipie_count + 1];	// has been no index from another loop so 
						loop_position = recipie_count + 2;				// there is no loop issue
						recipie_count += 2;
					} else {
						// loop issue
							current_status  = status_nested_error; 
							current_servo_state = state_stop;
					}
				}
				
				// END_LOOP command received
				
				if (recipe3[recipie_count] == 0x50){
					if (loop_count <= 0){
						recipie_count += 1;
						loop_count = 0;
					} else {
						recipie_count = loop_position;
						loop_count--;
					}
				}
				
				// WAVE_COMMAND
				
				if (recipe3[recipie_count] == 0x60){
					if(current_servo_state != state_moving){	// so the movement key doesnt get cut off
					current_servo_state = state_wave;
					}
				}
				break;

			/********************************
			* STATE_WAVING
			*
			* Servo is moving
			* wait 1000ms for move0 to end
			*
			********************************/
			case state_wave :
				if (wave_counter <= 25){
					if (wave_counter == 0 || wave_counter == 5 || wave_counter == 11 || wave_counter == 17 || wave_counter == 23){
						position = 5;
						move0();
					}
					if (wave_counter == 2 ||wave_counter == 8 || wave_counter == 14 || wave_counter == 20){
						position = 4;
						move0();
					}
					wave_counter++;
				} else {
						recipie_count += 1; 
						current_servo_state = state_moving;			
						current_status = status_running;
						wave_counter = 0;
					
				}
			
			/********************************
			* STATE_MOVING
			*
			* Servo is moving
			* wait 1000ms for move0 to end
			*
			********************************/
			case state_moving : 
				if( counter < 10){
					counter++;
				} else {
					current_servo_state = state_at_position;
					counter = 0;
				}
				break ;
					
			/********************************
			* STATE_PAUSED
			*
			* Servo is in a waiting state
			* wait 100ms for each tick on the counter
			*
			********************************/
			case state_paused :
				if( counter <= wait_counter){
					counter++;
				} else{
					current_servo_state = state_at_position;
					counter = 0;
				}
				break ;
		
				
			/********************************
			* STATE_RECIPE_ENDED
			*
			* Servo is moving
			* wait 1000ms for move0 to end
			*
			********************************/
			case state_recipe_ended :
				break ;
			
			
			/********************************
			* STATE_STOP
			*
			* Servo is stopped
			* dont do anything
			*
			********************************/
			case state_stop :
				break ;
			
			/********************************
			* STATE_USER_INPUT
			*
			* User has inputed a command
			* execute based on command
			*
			********************************/
			case state_user_input:
				if (command[3] == 'p' || command[3]== 'P'){
					current_servo_state = state_stop;
					current_status  = status_paused; 
				}
				else if (command[3] == 'c' || command[3]== 'C'){
					current_servo_state = state_at_position;
					current_status  = status_running; 
				}
				else if (command[3] == 'r' || command[3]== 'R'){		
					if (position != 0){
						position = position - 1;
						move0();
						current_servo_state = state_stop;
					}
				}
				else if (command[3] == 'l' || command[3]== 'L'){
					if (position != 5){
						position = position + 1;
						move0();
						current_servo_state = state_stop;
					}	
				}		
				else if (command[3] == 'n' || command[3]== 'N'){
					//current_servo_state = state_at_position;
				}
				else if (command[3] == 'b' || command[3]== 'B'){
					recipie_count = 0;
					current_servo_state = state_at_position;
					current_status  = status_running; 
				} else {
					current_status  = status_command_error; 
					current_servo_state = state_stop;
				}
				break;
		}
		osDelay(100);
	}
	
}

void servo_handle_2(void* argument) {
  while(1) {	
		switch ( current_servo_state1 )
		{
		 /********************************
			* STATE_AT_POSITON
			*
			* Servo stationary at known position
			* wait for a new command
			*
			********************************/
			case state_at_position :		

				// MOV command received
		
				if (recipe4[recipie_count1] == 0x20){
					position1 = recipe4[recipie_count1 + 1];
					recipie_count1 += 2; 
					move1();
					current_servo_state1 = state_moving;	
					current_status1 = status_running;
				}
				
				// RECIPE_END command received
				
				if (recipe4[recipie_count1] == 0x0){
					recipie_count1 = 0;				
				}
				
				// WAIT command received
				
				if (recipe4[recipie_count1] == 0x30){
					wait_counter1 = recipe4[recipie_count1 + 1];
					recipie_count1 += 2;
					current_servo_state1 = state_paused;
				}
				
				// LOOP command received
				
				if (recipe4[recipie_count1] == 0x40){
					if (loop_count1 == 0) {											// if it equals 0 then that means there 
						loop_count1 = recipe4[recipie_count1 + 1];	// has been no index from another loop so 
						loop_position1 = recipie_count1 + 2;				// there is no loop issue
						recipie_count1 += 2;
					} else {
						current_status1  = status_nested_error; 
						current_servo_state1 = state_stop;
					}
				}
				
				// END_LOOP command received
				
				if (recipe4[recipie_count1] == 0x50){
					if (loop_count1 <= 0){
						recipie_count1 += 1;
						loop_count1 = 0;
					} else {
						recipie_count1 = loop_position1;
						loop_count1--;
					}
				}
				
				// WAVE_COMMAND
				
				if (recipe4[recipie_count1] == 0x60){
					if(current_servo_state1 != state_moving){	// so the movement key doesnt get cut off
						current_servo_state1 = state_wave;
					}
				}
				break;
			
			/********************************
			* STATE_WAVING
			*
			* Servo is moving
			* wait 1000ms for move0 to end
			*
			********************************/
			case state_wave :
				if (wave_counter <= 25){
					if (wave_counter == 0 || wave_counter == 5 || wave_counter == 11 || wave_counter == 17 || wave_counter == 23){
						position1 = 5;
						move1();
					}
					if (wave_counter == 2 ||wave_counter == 8 || wave_counter == 14 || wave_counter == 20){
						position1 = 4;
						move1();
					}
					wave_counter++;
				} else {
						recipie_count1 += 1; 
						current_servo_state1 = state_moving;			
						current_status1 = status_running;
					 wave_counter = 0;
					
				}
				
			/********************************
			* STATE_MOVING
			*
			* Servo is moving
			* wait 1000ms for move0 to end
			*
			********************************/
			case state_moving : 
				if( counter1 < 10){
					counter1++;
				} else {
					current_servo_state1 = state_at_position;
					counter1 = 0;	
				}
				break ;
			
			/********************************
			* STATE_PAUSED
			*
			* Servo is in a waiting state
			* wait 100ms for each tick on the counter
			*
			********************************/
			case state_paused :
				if( counter1 <= wait_counter1){
					counter1++;
				} else{
					current_servo_state1 = state_at_position;
					counter1 = 0;
				}
				break ;
				
			/********************************
			* STATE_RECIPE_ENDED
			*
			* Servo is moving
			* wait 1000ms for move0 to end
			*
			********************************/
			case state_recipe_ended :
				break ;
			
			/********************************
			* STATE_STOP
			*
			* Servo is stopped
			* dont do anything
			*
			********************************/
			case state_stop :
				break ;
			
			/********************************
			* STATE_USER_INPUT
			*
			* User has inputed a command
			* execute based on command
			*
			********************************/
			case state_user_input:
				if (command[2] == 'p' || command[2]== 'P'){
					current_servo_state1 = state_stop;
					current_status1  = status_paused; 
				}
				else if (command[2] == 'c' || command[2]== 'C'){
					current_servo_state1 = state_at_position;
					current_status1  = status_running;
				}
				else if (command[2] == 'r' || command[2]== 'R'){		
					if (position1 != 0){
						position1 = position1 - 1;
						move1();
						current_servo_state1 = state_stop;
					}
				}
				else if (command[2] == 'l' || command[2]== 'L'){
					if (position1 != 5){
						position1 = position1 + 1;
						move1();
						current_servo_state1 = state_stop;
					}	
				}		
				else if (command[2] == 'n' || command[2]== 'N'){
					//current_servo_state1 = state_at_position;
				}
				else if (command[2] == 'b' || command[2]== 'B'){
					recipie_count1 = 0;
					current_servo_state1 = state_at_position;
					current_status1  = status_running;
				} else {
					current_status1  = status_command_error; 
					current_servo_state1 = state_stop;
				}
				break;
		}
		osDelay(100);
	}
	
}

void LED_handle(void* argument) {
  while(1) {
   	if (current_status  == status_running && current_status1 == status_running){
		HAL_GPIO_WritePin(RED_LED_GPIO_Port,RED_LED_Pin,GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GREEN_LED_GPIO_Port,GREEN_LED_Pin,GPIO_PIN_SET);
	} else if (current_status  == status_paused || current_status1 == status_paused){
		HAL_GPIO_WritePin(RED_LED_GPIO_Port,RED_LED_Pin,GPIO_PIN_RESET);
		HAL_GPIO_WritePin(GREEN_LED_GPIO_Port,GREEN_LED_Pin,GPIO_PIN_RESET);
	} else if (current_status  == status_command_error || current_status1 == status_command_error){
		HAL_GPIO_WritePin(RED_LED_GPIO_Port,RED_LED_Pin,GPIO_PIN_SET);
		HAL_GPIO_WritePin(GREEN_LED_GPIO_Port,GREEN_LED_Pin,GPIO_PIN_RESET);
	} else if (current_status  == status_nested_error || current_status1 == status_nested_error){
		HAL_GPIO_WritePin(RED_LED_GPIO_Port,RED_LED_Pin,GPIO_PIN_SET);
		HAL_GPIO_WritePin(GREEN_LED_GPIO_Port,GREEN_LED_Pin,GPIO_PIN_SET);
	}
  osDelay(100);		
	}
}


void uart_handle_1(void* argument) {
	command[0] = 10;		// LF
	command[1] = 13;		// CR
  while(1) {
		
		// check to see if something has arrived over UART (e.g. a user command)
    if(rx_buffer[0] && (pdTRUE == xSemaphoreTake(receive_mutex, 0))) {  // if we Take mutex, ISR stops receiving chars
      
			command[2] = rx_buffer[0];
			command[3] = rx_buffer[1];
			vPrintString((char *)command);   // something arrived, stop receiving chars, print what we have.
			current_servo_state = state_user_input;
			current_servo_state1 = state_user_input;     

			rx_buffer[0] = 0;  // flag ourself to NOT try to Take mutex until after ISR has received a new char (and owns mutex)
      
			xSemaphoreGive(receive_mutex);
    } 
    else {
			;
    }
    osDelay(100);
	}
	
}

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  HAL_Init();

  SystemClock_Config();

  MX_GPIO_Init();
  MX_USART2_UART_Init();
  MX_RNG_Init();
  MX_TIM5_Init();
  MX_TIM4_Init();

  osThreadDef(defaultTask, StartDefaultTask, osPriorityNormal, 0, 128);
  defaultTaskHandle = osThreadCreate(osThread(defaultTask), NULL);

  test_task_init();

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
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
  RCC_PeriphCLKInitTypeDef PeriphClkInit = {0};

  /**Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;
  RCC_OscInitStruct.PLL.PLLM = 1;
  RCC_OscInitStruct.PLL.PLLN = 20;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV7;
  RCC_OscInitStruct.PLL.PLLQ = RCC_PLLQ_DIV2;
  RCC_OscInitStruct.PLL.PLLR = RCC_PLLR_DIV4;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /**Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_4) != HAL_OK)
  {
    Error_Handler();
  }
  PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_USART2|RCC_PERIPHCLK_RNG;
  PeriphClkInit.Usart2ClockSelection = RCC_USART2CLKSOURCE_PCLK1;
  PeriphClkInit.RngClockSelection = RCC_RNGCLKSOURCE_PLLSAI1;
  PeriphClkInit.PLLSAI1.PLLSAI1Source = RCC_PLLSOURCE_HSI;
  PeriphClkInit.PLLSAI1.PLLSAI1M = 1;
  PeriphClkInit.PLLSAI1.PLLSAI1N = 12;
  PeriphClkInit.PLLSAI1.PLLSAI1P = RCC_PLLP_DIV7;
  PeriphClkInit.PLLSAI1.PLLSAI1Q = RCC_PLLQ_DIV4;
  PeriphClkInit.PLLSAI1.PLLSAI1R = RCC_PLLR_DIV2;
  PeriphClkInit.PLLSAI1.PLLSAI1ClockOut = RCC_PLLSAI1_48M2CLK;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
  {
    Error_Handler();
  }
  /**Configure the main internal regulator output voltage 
  */
  if (HAL_PWREx_ControlVoltageScaling(PWR_REGULATOR_VOLTAGE_SCALE1) != HAL_OK)
  {
    Error_Handler();
  }
}

/**
  * @brief RNG Initialization Function
  * @param None
  * @retval None
  */
static void MX_RNG_Init(void)
{

  /* USER CODE BEGIN RNG_Init 0 */

  /* USER CODE END RNG_Init 0 */

  /* USER CODE BEGIN RNG_Init 1 */

  /* USER CODE END RNG_Init 1 */
  hrng.Instance = RNG;
  if (HAL_RNG_Init(&hrng) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN RNG_Init 2 */

  /* USER CODE END RNG_Init 2 */

}

/**
  * @brief TIM4 Initialization Function
  * @param None
  * @retval None
  */
static void MX_TIM4_Init(void)
{

  /* USER CODE BEGIN TIM4_Init 0 */

  /* USER CODE END TIM4_Init 0 */

  TIM_ClockConfigTypeDef sClockSourceConfig = {0};
  TIM_MasterConfigTypeDef sMasterConfig = {0};
  TIM_OC_InitTypeDef sConfigOC = {0};

  /* USER CODE BEGIN TIM4_Init 1 */

  /* USER CODE END TIM4_Init 1 */
  htim4.Instance = TIM4;
  htim4.Init.Prescaler = 127;
  htim4.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim4.Init.Period = 12499;
  htim4.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  htim4.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
  if (HAL_TIM_Base_Init(&htim4) != HAL_OK)
  {
    Error_Handler();
  }
  sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
  if (HAL_TIM_ConfigClockSource(&htim4, &sClockSourceConfig) != HAL_OK)
  {
    Error_Handler();
  }
  if (HAL_TIM_PWM_Init(&htim4) != HAL_OK)
  {
    Error_Handler();
  }
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_OC1;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  if (HAL_TIMEx_MasterConfigSynchronization(&htim4, &sMasterConfig) != HAL_OK)
  {
    Error_Handler();
  }
  sConfigOC.OCMode = TIM_OCMODE_PWM1;
  sConfigOC.Pulse = 1250;
  sConfigOC.OCPolarity = TIM_OCPOLARITY_HIGH;
  sConfigOC.OCFastMode = TIM_OCFAST_DISABLE;
  if (HAL_TIM_PWM_ConfigChannel(&htim4, &sConfigOC, TIM_CHANNEL_1) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN TIM4_Init 2 */

  /* USER CODE END TIM4_Init 2 */
  HAL_TIM_MspPostInit(&htim4);

}

/**
  * @brief TIM5 Initialization Function
  * @param None
  * @retval None
  */
static void MX_TIM5_Init(void)
{

  /* USER CODE BEGIN TIM5_Init 0 */

  /* USER CODE END TIM5_Init 0 */

  TIM_MasterConfigTypeDef sMasterConfig = {0};
  TIM_OC_InitTypeDef sConfigOC = {0};

  /* USER CODE BEGIN TIM5_Init 1 */

  /* USER CODE END TIM5_Init 1 */
  htim5.Instance = TIM5;
  htim5.Init.Prescaler = 127;
  htim5.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim5.Init.Period = 12499;
  htim5.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  htim5.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_DISABLE;
  if (HAL_TIM_PWM_Init(&htim5) != HAL_OK)
  {
    Error_Handler();
  }
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_OC1;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  if (HAL_TIMEx_MasterConfigSynchronization(&htim5, &sMasterConfig) != HAL_OK)
  {
    Error_Handler();
  }
  sConfigOC.OCMode = TIM_OCMODE_PWM1;
  sConfigOC.Pulse = 1250;
  sConfigOC.OCPolarity = TIM_OCPOLARITY_HIGH;
  sConfigOC.OCFastMode = TIM_OCFAST_DISABLE;
  if (HAL_TIM_PWM_ConfigChannel(&htim5, &sConfigOC, TIM_CHANNEL_1) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN TIM5_Init 2 */

  /* USER CODE END TIM5_Init 2 */
  HAL_TIM_MspPostInit(&htim5);

}

/**
  * @brief USART2 Initialization Function
  * @param None
  * @retval None
  */
static void MX_USART2_UART_Init(void)
{

  /* USER CODE BEGIN USART2_Init 0 */

  /* USER CODE END USART2_Init 0 */

  /* USER CODE BEGIN USART2_Init 1 */

  /* USER CODE END USART2_Init 1 */
  huart2.Instance = USART2;
  huart2.Init.BaudRate = 115200;
  huart2.Init.WordLength = UART_WORDLENGTH_8B;
  huart2.Init.StopBits = UART_STOPBITS_1;
  huart2.Init.Parity = UART_PARITY_NONE;
  huart2.Init.Mode = UART_MODE_TX_RX;
  huart2.Init.HwFlowCtl = UART_HWCONTROL_NONE;
  huart2.Init.OverSampling = UART_OVERSAMPLING_16;
  huart2.Init.OneBitSampling = UART_ONE_BIT_SAMPLE_DISABLE;
  huart2.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
  if (HAL_UART_Init(&huart2) != HAL_OK)
  {
    Error_Handler();
  }
  /* USER CODE BEGIN USART2_Init 2 */

  /* USER CODE END USART2_Init 2 */

}

/**
  * @brief GPIO Initialization Function
  * @param None
  * @retval None
  */
static void MX_GPIO_Init(void)
{
  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();
  __HAL_RCC_GPIOE_CLK_ENABLE();
  __HAL_RCC_GPIOD_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(RED_LED_GPIO_Port, RED_LED_Pin, GPIO_PIN_RESET);

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GREEN_LED_GPIO_Port, GREEN_LED_Pin, GPIO_PIN_RESET);

  /*Configure GPIO pin : RED_LED_Pin */
  GPIO_InitStruct.Pin = RED_LED_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(RED_LED_GPIO_Port, &GPIO_InitStruct);

  /*Configure GPIO pin : GREEN_LED_Pin */
  GPIO_InitStruct.Pin = GREEN_LED_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GREEN_LED_GPIO_Port, &GPIO_InitStruct);

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/* USER CODE BEGIN Header_StartDefaultTask */
/**
  * @brief  Function implementing the defaultTask thread.
  * @param  argument: Not used 
  * @retval None
  */
/* USER CODE END Header_StartDefaultTask */
void StartDefaultTask(void const * argument)
{

  /* USER CODE BEGIN 5 */
  /* Infinite loop */
  for(;;)
  {
    osDelay(1);
  }
  /* USER CODE END 5 */ 
}

/**
  * @brief  Period elapsed callback in non blocking mode
  * @note   This function is called  when TIM2 interrupt took place, inside
  * HAL_TIM_IRQHandler(). It makes a direct call to HAL_IncTick() to increment
  * a global variable "uwTick" used as application time base.
  * @param  htim : TIM handle
  * @retval None
  */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
  /* USER CODE BEGIN Callback 0 */

  /* USER CODE END Callback 0 */
  if (htim->Instance == TIM2) {
    HAL_IncTick();
  }
  /* USER CODE BEGIN Callback 1 */

  /* USER CODE END Callback 1 */
}

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */

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
void assert_failed(char *file, uint32_t line)
{ 
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
