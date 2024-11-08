// Programming Examination for SWEN 563 / CMPE 663 / EEEE 663
// Uses the STM32L476VG Discovery board.
// L. Kiser
// September 23, 2018

#include "stm32l476xx.h"

//*************************************  32L476GDISCOVERY ***************************************************************************
// STM32L4:  STM32L476VGT6 MCU = ARM Cortex-M4 + FPU + DSP, 
//           LQFP100, 1 MB of Flash, 128 KB of SRAM
//           Instruction cache = 32 lines of 4x64 bits (1KB)
//           Data cache = 8 lines of 4x64 bits (256 B)
//
// User LEDs: 
//           LD4 Red   = PB2    LD5 Green = PE8
//   
//****************************************************************************************************************

// Enable system clock at 16 MHz.
//
// DO NOT CHANGE this function.
void setup_system_clock()
{
	// Enable High Speed Internal Clock (HSI = 16 MHz)
	RCC->CR |= ((uint32_t)RCC_CR_HSION);
	
	// wait until HSI is ready
	while ( (RCC->CR & (uint32_t) RCC_CR_HSIRDY) == 0 )
		;
	
	// Select HSI as system clock source 
	RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_SW));
	RCC->CFGR |= (uint32_t)RCC_CFGR_SW_HSI;     // 01: HSI16 oscillator used as system clock

	// Wait till HSI is used as system clock source 
	while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS) == 0 )
		;
}

// Enable GPIOB and GPIOE for the two LEDs and set up the I/O configuraiton.
// Also enable GPIOA for the joystick.
//
// DO NOT CHANGE this function.
void setup_gpio_for_leds()
{
	// Enable the clock to GPIO Ports A, B, and E	
	RCC->AHB2ENR |= RCC_AHB2ENR_GPIOAEN;
	RCC->AHB2ENR |= RCC_AHB2ENR_GPIOBEN;
	RCC->AHB2ENR |= RCC_AHB2ENR_GPIOEEN;

	// Set PB2 (red led) as output
	GPIOB->MODER &= ~(0x03<<(2*2)) ;
	GPIOB->MODER |= (1<<4);
		
	// Set PE8 (green led) as output
	GPIOE->MODER &= ~(0x03<<(2*8));		 
	GPIOE->MODER |= (1<<16);
		
	// Set PE8 and PB2 output type as push-pull
	GPIOE->OTYPER &= ~(0x100);
	GPIOB->OTYPER &= ~(0x4);
	
	// PE8 and PB2 output type as No pull-up no pull-down
	GPIOE->PUPDR &= ~(0x30000);
	GPIOB->PUPDR &= ~(0x30);
}

// The joystick is connected to 3 volts as the common so pins need to be pull down.
// PA0: center; PA1: left; PA2: right; PA3: up; PA5: down
//
// DO NOT CHANGE this function.
void setup_joystick_as_input()
{
	// Set PA0, PA1, PA2, PA3, and PA5 as input
	GPIOA->MODER &= ~0xCFF;

	// Configure PA0, PA1, PA2, PA3, PA5 as pull-down
	GPIOA->PUPDR &= ~0xCFF;
	GPIOA->PUPDR |= 0x8AA;
}

// Turns on red LED if "on" parameter is non-zero, turns off if zero.
//
// DO NOT CHANGE this function.
void set_red_led( uint32_t on )
{
	if ( on )
		GPIOB->ODR |= GPIO_ODR_ODR_2 ;
	else
		GPIOB->ODR &= ~GPIO_ODR_ODR_2 ;
}

// Turns on green LED if "on" parameter is non-zero, turns off if zero.
//
// DO NOT CHANGE this function.
void set_green_led( uint32_t on )
{
	if ( on )
		GPIOE->ODR |= GPIO_ODR_ODR_8 ;
	else
		GPIOE->ODR &= ~GPIO_ODR_ODR_8 ;
}

// Changes red LED state between on and off by first reading
// current state and setting to the opposite.
// DO NOT CHANGE this function.
void toggle_red_led()
{
	set_red_led( ( GPIOB->ODR & GPIO_ODR_ODR_2 ) == 0 ) ;
}

// Changes green LED state between on and off by first reading
// current state and setting to the opposite.
//
// DO NOT CHANGE this function.
void toggle_green_led()
{
	set_green_led( ( GPIOE->ODR & GPIO_ODR_ODR_8 ) == 0 ) ;
}

// Starts timer 2 running at 1 KHz assuming main clock is 16 KHz.
//
// DO NOT CHANGE this function.
void start_timer2()
{
	RCC->APB1ENR1 |= RCC_APB1ENR1_TIM2EN;	// enable clock for this timer in the clock control
	TIM2->PSC = 15999;										// load the prescaler value -- divide 16 MHz clock down to 1 KHz
	TIM2->EGR |= TIM_EGR_UG ;							// force an update event to make the prescaler load take effect
	TIM2->CR1 |= TIM_CR1_CEN ;						// now start the timer
}

// Returns the current count value from timer 2.
//
// DO NOT CHANGE this function.
uint32_t get_timer2_count()
{
	return TIM2->CNT ;
}

// function prototypes for programming examination functions -- do not change
void function_one( void ) ;
void function_two( void ) ;
void function_three( void ) ;

// Checks for joystick key presses
// Toggles the red LED when the left button is pushed.
// Toggles the green LED when the right button is pushed.
// Calls function_one when the up button is pressed.
// Calls function_two when the down button is pressed.
// 
// DO NOT CHANGE this function.
void check_joystick_buttons()
{
	// Toggle both LEDs when middle button is pushed (PA0)
	if((GPIOA->IDR & 0x1) != 0x00){
		toggle_red_led() ;
		toggle_green_led() ;
		while((GPIOA->IDR & 0x1) != 0x00);
	}
	
	// Toggle red LED when left button is pushed (PA1)
	if((GPIOA->IDR & 0x2) != 0x00){
		toggle_red_led() ;
		while((GPIOA->IDR & 0x2) != 0x00);
	}
	
	// Toggle green LED when right button is pushed (PA2)
	if((GPIOA->IDR & 0x4) != 0x00){
		toggle_green_led() ;
		while((GPIOA->IDR & 0x4) != 0x00);
	}
	
	// Set both LEDs to on when up button is pushed (PA3)
	if((GPIOA->IDR & 0x8) != 0x00){
		function_one() ;
		while((GPIOA->IDR & 0x8) != 0x00);
	}
	
	// Set both LEDs to off when down button is pushed (PA5)
	if((GPIOA->IDR & 0x20) != 0x00){
		function_two() ;
		while((GPIOA->IDR & 0x20) != 0x00);
	}
}

// Initializes system and then does an infinite loop
// that checks the joystick buttons and always calls
// function_three after checking the buttons.
//
// DO NOT CHANGE this function.
int main(void)
{
	
	setup_system_clock() ;		// enable system clock
	setup_gpio_for_leds() ;		// enables GPIO for ports A, B, E
	setup_joystick_as_input() ;
	start_timer2() ;
		
	// begin main loop
	while(1){
    check_joystick_buttons() ;
		function_three() ;
  }
}

///////////////////////////////////////////////////////////////////////////////
// Implement the three functions described below. You are allowed to         //
// add data declarations outside the functions if you find that helpful.     //
// Only enter your code below this comment block. Do not change any code     //
// above this comment block. However, you can call any of the functions      //
// that are provided above.                                                  //
///////////////////////////////////////////////////////////////////////////////

uint32_t is_running = 0 ;		// boolean flag to control whether or not we are running.

// This function is called when the joystick up button is pressed.
//
// The purpose of this function is to enable the red and green LED flashing
// in function_three. An appropriate name for this function would be "start".
// Tip -- Do NOT change the LEDs in this function. Your code in this function
//        should be very simple!

uint32_t begin_time = 0;

void function_one()
{
	is_running = 1;
	begin_time = get_timer2_count();
	
}

// This function is called when the joystick down button is pressed.
//
// The purpose of this function is to disable the red and green LED flashing
// in function_three. An appropriate name for this function would be "stop".
// Tip -- Do NOT change the LEDs in this function. Your code in this function
//        should be very simple!
void function_two()
{
	is_running = 0;
}

// This function is called from the infinite loop in main
// right after the joystick buttons are checked.
//
// This function must implement a simple two bit counter display using the red and green LEDs
// that changes state every 1.024 seconds. This interval was chosen to simplfy your code!
// NOTE -- This two bit counter only runs when it is enabled by function_one.
//         It stops when disabled by function_two.
//
// The red LED turns on for exactly 1.024 seconds and off for exactly 1.024 seconds. This represents bit 0.
// The green LED turns on for exactly 2.048 seconds when the red LED turns off. This represents bit 1.
// For full credit these LEDs must be turn on and off exactly as described in this 4.096 second cycle:
//
// 1. at 0.000 seconds -- both LEDs are off.
// 2. at 1.024 seconds -- the red LED turns on.
// 3. at 2.048 seconds -- the red LED turns off and the green LED turns on.
// 4. at 3.072 seconds -- the red LED turns on (green stays on).
// 5. at 4.096 seconds go back to Step 1.
// Keep repeating this cycle forever.
//
// NOTE -- your code will be inspected to confirm this exact timing.
// Tip -- used the functions provided above!
uint32_t counter = 0;

int flag = 0;
void function_three()
{
	if(is_running == 1){
		if(((get_timer2_count() - begin_time) < 1024) && flag == 0){
			set_green_led(0);
			set_red_led(0);
			flag++;
			begin_time = get_timer2_count();
		}
		if (((get_timer2_count() - begin_time) >= 1024) && flag == 1){
			toggle_red_led();
			flag++;
			begin_time = get_timer2_count();
		}
		else if(((get_timer2_count() - begin_time) >= 1024) && flag == 2){
			toggle_red_led();
			toggle_green_led();
			flag++;
			begin_time = get_timer2_count();
		}
		else if(((get_timer2_count() - begin_time) >= 1024) && flag == 3){
			toggle_red_led();
			flag++;
			begin_time = get_timer2_count();
		}
		else if(((get_timer2_count() - begin_time) >= 1024) && flag == 4){
			toggle_red_led();
			flag = 0;
			begin_time = get_timer2_count();
		
		}
	}

}

