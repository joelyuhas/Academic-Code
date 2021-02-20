/*
 * Main Method for testing the PWM Code for the K64F
 * PWM signal can be connected to output pins are PC3 and PC4
 *
 * Author:
 * Created:
 * Modified:
 */

#include "MK64F12.h"
#include "uart.h"
#include "PWM.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>



 // Default System clock value
 // period = 1/20485760  = 4.8814395e-8
#define DEFAULT_SYSTEM_CLOCK 20485760u 
// Integration time (seconds)
// Determines how high the camera values are
// Don't exceed 100ms or the caps will saturate
// Must be above 1.25 ms based on camera clk 
//	(camera clk is the mod value set in FTM2)
//#define INTEGRATION_TIME .00075f // currently set faster (default was .0075f)
#define INTEGRATION_TIME .0075f // currently set faster (default was .0075f)

void initialize(void);
//void en_interrupts(void);
void delay(int del);
char str[100];

// Camera
void init_FTM2(void);
void init_GPIO(void);
void init_PIT(void);
void init_ADC0(void);
void FTM2_IRQHandler(void);
void PIT1_IRQHandler(void);
void ADC0_IRQHandler(void);
void Button_Init(void);
void LED_Init(void);
void servo_Test(void);
void matLab_Print(void);
void value_Print(void);
void change_LED_Color(int color);


// Camera
int pixcnt = -2;
int clkval = 0;
uint16_t line[128];
uint16_t bintrace[128];
uint16_t smoothtrace[128];
int derivative[128];
int capcnt = 0;
uint16_t ADC0VAL;




int start = 0;
int edge1;
int d_temp, temp;
int edge2, ed_diff, serv_int;
int flip;
int middle = 65;
int edges[128];
double m_diff, servo_val;
int speed = 0;
int max = 0;
int min = 100;
double kp = 0.1, ki = 0.01, kd = 0.45, prev_servo_val = 7.5;
int error = 0, prev_error = 0, prev_prev_error = 0;


int t = 65;			//the middle value 60

int braking = 0;	// 1 for braking, anythign else for no
int duty_c = 55;    // desired duty cycle
int duty_min = 40;
int backwards_duty = 0;

int mode = 0;
int brake_time = 60;
int brake_speed = 0;
double left_servo = 6.4;   //6.9;
double right_servo = 9.0;   //9.5;
double s = 8.0;		// the default servo value
int duty_percent = 100;
int backup_duty = 50;
int backup_min_duty = 40;
// left turn  54
// right turn 75




int main(void) {
	int i = 0;
	int j = 0;
	int k = 0;
	int line_break = 0;
	int temp_max = 0;
	max = 300;
	uint16_t dir = 0;
	uint16_t freq = 10000;
	uint16_t servo_freq = 50;

	initialize();

	NVIC_EnableIRQ(PIT0_IRQn);
	NVIC_EnableIRQ(FTM2_IRQn);

	/* --------------------- SERVO DEBUG PRINTING SECTION  --------------------*/
	//servo_Test();

	for (;;) {
		max = 220;
		min = 100;
		flip = 0;
		
		int edge3 = 0;
		int edge4 = 0;
		double j1;
		int k1;

		/*
		 * BUTTON ON/OFF IMPLEMENTATION
		 * SW2 - set mode: red=mode 0, green=mode 1, blue=mode 2
		 * SW3 - start/stop the car
		 */
		if ((GPIOC_PDIR & (1 << 6)) == 0) {
			if (mode == 0) {
				//Set max and min speed, the delay time for braking, and ki, kp for mode 0 
				duty_min = 45; //45
				duty_c = 50; //55
				backup_duty = duty_c;
				brake_time = 50;
		  	ki = 0.01;
				kp = 0.062;
				brake_speed = 0;
				braking = 1;
				duty_percent = 100;
				change_LED_Color(0);
				mode = 1;
			}
			else if (mode == 1){
				//Set max and min speed, the delay time for braking, and ki, kp for mode 1
				duty_min = 50;
				duty_c = 55;
				brake_time = 60; // 80
				ki = 0.01;
				kp = 0.062;
				brake_speed = 0;
				backup_duty = duty_c;
				braking = 1;
				change_LED_Color(1);
				duty_percent = 80;
				mode = 2;
				
			/*					duty_min = 55;
				duty_c = 60;
				brake_time = 80;
				ki = 0.01;
				kp = 0.062;
				brake_speed = 0;
				braking = 1;
				backup_duty = duty_c;
				change_LED_Color(2);
				mode = 0;
				duty_percent = 80;*/
			}
			else if (mode == 2) {
				//Set max and min speed, the delay time for braking, and ki, kp for mode 2
				// Test 1
		/*		duty_min = 55;
				duty_c = 60;
				brake_time = 80;
				ki = 0.01;
				kp = 0.062;
				brake_speed = 0;
				braking = 1;
				backup_duty = duty_c;
				change_LED_Color(2);
				mode = 0;
				duty_percent = 80;*/
				
				
				duty_min = 53;
				duty_c = 63;
				brake_time = 50; // 60
				ki = 0.01;
				kp = 0.062;
				brake_speed = 30; // 30
				braking = 1;
				backup_duty = duty_c;
				change_LED_Color(2);
				mode = 0;
				duty_percent = 60;
				
				/*duty_min = 55;
				duty_c = 67;
				brake_time = 40;
				ki = 0.01;
				kp = 0.062;
				brake_speed = 20;
				braking = 1;
				backup_duty = duty_c;
				change_LED_Color(2);
				mode = 0;
				duty_percent = 80;*/
			}
		}
		else if ((GPIOA_PDIR & (1 << 4)) == 0) {
			if (start == 0){
				start = 1;
				change_LED_Color(0);
				delay(200);
				change_LED_Color(1);
				delay(200);
				change_LED_Color(2);
				delay(200);
			}
			else {
				start = 0;
			}
		}

		
		if (start) {
			//for (j1 = 0.05; j1 < 1.2; j1 = j1 + 0.002){
				//kp = j1;
				//sprintf(str, "Kp Value: %f\n\r", j1);
				//put(str);
				//for (k1 = 0; k1 < 4000000; k1++){
				
			// Every 2 seconds ******************************************************************************************8
			if (capcnt >= (1 / (INTEGRATION_TIME))) {
				j = 0;
				temp_max = 0;
				for (i = 5; i < 123; i++) {
					temp = (line[i - 2] + line[i - 1] + line[i] + line[i + 1] + line[i + 2]) / 5;
					if(temp_max < temp){
						temp_max = temp;
					}

					/*
					 * ---------------------- THRESHOLD METHOD --------------------------
					 * This method checks for values above a specific point. This
					 * Method can also detect multiple edges if there are more than 2.
					 */
					if ((temp > 300)) {
						if (flip == 0){
								edge1 = i;
								flip = 2;
						}
						j++;
					}
					
				}
				max = temp_max * (1/3);
				edge2 = edge1 + j;
			if(temp_max < 220){
					if (k > 10){
						duty_c = 0;
						duty_min = 0;
					}
					k++;
				}
			else { 
					k = 0;
					duty_c = backup_duty;
					//duty_min = backup_min_duty;
				}
				 
				
	
				
				middle = (edge2 + edge1) / 2;

				
				
	//sprintf(str, "%i\n\r", middle); // start value
//put(str);
	//			delay (100);
				
				
				
				/* --------------------- DEBUG PRINTING SECTION  --------------------*/
				  //matLab_Print();
			    //value_Print();
					// servo_Test();

				//unused
				ed_diff = edge2 - edge1;
				m_diff = middle - t;

				//kp = 0.07;
				//kp = j1;
				kd = 0.0;
				//ki = 0.01;
				
				//serv_int = fabs(servo_val);
				
				//set the error value
				error = t - middle;

				//Determine the servo value to turn
				servo_val = s -
					        kp * error -
					        ki * (error + prev_error) / 2 +
					        kd * (error + 2 * prev_error + prev_prev_error);

				prev_error = error;
				prev_prev_error = prev_error;
				prev_servo_val = servo_val;

				/*
				 * ---------------------- SERVO IMPLEMENTATION ---------------------
				 * Caps the servo value if it is too large
				 * This value is used when the car is turning
				 * very far to the RIGHT. Sets duty cycle to min
				 */
				if (servo_val > right_servo) {
					prev_servo_val = right_servo;
					/*
					 * BRAKING MECHANISM
					 * Speed is incremented everytime that the car is not turning
					 * sharply, after the speed gets above a certain amount, the car
				     * will either stop the wheels or spin them backwards to slow
				     * the car down.
					 */
					
					if (braking == 1) {
						if (speed > 100) { //20
							//SetDervoDutyCycle(8.2, servo_freq);
							//SetDervoDutyCycle(s+0.2, servo_freq);
							SetDutyCycle(brake_speed, freq, 1, 100, 100);
							delay(brake_time);
						}
					}
					speed = 0;
					
					//Set servo to the most right value and decrease speed
					SetDervoDutyCycle(right_servo, servo_freq);
					SetDutyCycle(duty_min, freq, 0, duty_percent, 100);

				}
				else if (servo_val < left_servo) {
					prev_servo_val = left_servo;

					if (braking == 1) {
						if (speed > 100) {
							//change_LED_Color(0);
							//SetDervoDutyCycle(s-0.2, servo_freq);
							SetDutyCycle(brake_speed, freq, 1, 100, 100);
							delay(brake_time);
						}
					}
					speed = 0;

					//Set servo to the most left value and decrease speed
					SetDervoDutyCycle(left_servo, servo_freq);
					SetDutyCycle(duty_min, freq, dir, 100, duty_percent);

				}
				else {
						prev_servo_val = servo_val;
						SetDervoDutyCycle(servo_val, servo_freq);
						SetDutyCycle(duty_c, freq, dir, 100, 100);
				}

				speed += 1;
				capcnt = 0;
			}
		//}}
		}

	}// for
	//return 0;
} //main





/*
 * CHANGE LED_COLOR
 * used to change the led color
 *
 * Decided to use int instead of enumeation because
 * it is easier to update
 * RGB 123
 * 0 = RED
 * 1 = GREEN
 * 2 = BLUE
 */
void change_LED_Color(int color) {
	GPIOB_PSOR = (1UL << 21) | (1UL << 22);
	GPIOE_PSOR = 1UL << 26;

	if (color == 0) {
		GPIOB_PDOR = (01 << 21); // red
	}
	else if (color == 1) {
		GPIOE_PDOR = (0 << 26); //green
	}
	else if (color == 2) {
		GPIOB_PDOR = (10 << 21);  // blue
	}



}


/*
 * Waits for a delay (in milliseconds)
 * del - The delay in milliseconds
 */
void delay(int del) {
	int i;
	for (i = 0; i < del * 5000; i++) {
		// Do nothing
	}
}


/*
 * Mechanizm for printing the mat_lab values
 * printing for debugging purposes.
 */
void matLab_Print(void) {
	sprintf(str, "%i\n\r", -1); // start value
	put(str);
	for (int i = 0; i < 127; i++) {
		sprintf(str, "%i\n", (line[i]));
		put(str);
	}
	sprintf(str, "%i\n\r", -2); // end value
	put(str);
	delay(200);

}



/*
 * value_Print
 * Used to print out edge, middile, and speed values
 * for debugging purposes
 */
void value_Print(void) {

	sprintf(str, "edge1: %i\n\r", edge1); // end value
	put(str);
	sprintf(str, "edge2: %i\n\r", edge2); // end value
	put(str);
	sprintf(str, "middle: %i\n\r", middle); // end value
	put(str);
	sprintf(str, "speed: %i\n\r", speed); // end value
	put(str);
	//sprintf(str, "Line Break: %i\n\r", line_break); // end value
	//put(str);
	delay(200);
}


/*
 * Function to test the servo alignmentand print out
 * The servo values
 */
void servo_Test(void) {

	double j = 0.0;
	for (;;) {
		if ((GPIOC_PDIR & (1 << 6)) == 0) {
			start = !(start);
		}

		if (start) {
			for (j = 5.6; j < 9.5; j = j + 0.1) {
				SetDervoDutyCycle(j, 50);
				sprintf(str, "%f\n", j);
				put(str);
				delay(200);
			}
		}
	}

}













void initialize(void)
{
	// Initialize UART
	uart_init();

	// Initialize the FlexTimer
	InitPWM();

	init_GPIO(); // For CLK and SI output on GPIO
	init_FTM2(); // To generate CLK, SI, and trigger ADC
	init_ADC0();
	init_PIT();	// To trigger camera read based on integration time
	Button_Init();
	LED_Init();
}


void Button_Init(void) {
	// Enable clock for Port C PTC6 button
	SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK;
	SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;

	// Configure the Mux for the button
	PORTC_PCR6 = PORT_PCR_MUX(1);
	PORTA_PCR4 = PORT_PCR_MUX(1);


	// Set the push button as an input
	GPIOC_PDOR |= (1 << 6);
	GPIOA_PDOR |= (1 << 4);
}

void LED_Init(void) {
	// Enable clocks on Ports B and E for LED timing
	SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; // Enables Clock on Port B
	SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; // Enables Clock on Port E	 

   // Configure the Signal Multiplexer for GPIO
	PORTB_PCR21 = PORT_PCR_MUX(1); //Enabling Port B pin 21
	PORTB_PCR22 = PORT_PCR_MUX(1); //Enabling Port B pin 22
	PORTE_PCR26 = PORT_PCR_MUX(1); //Enabling Port E pin 26

// PTB 21, 22, (PTE)26 =led bases
// PTC 6 = button


// Switch the GPIO pins to output mode
//(chapter 55)
	GPIOB_PDDR |= (1 << 21); // sets pin 21 to output
	GPIOB_PDDR |= (1 << 22); // sets pin 22 to output
	GPIOE_PDDR |= (1 << 26); // sets pin 26 to output

   // Turn off the LEDs
	GPIOB_PDOR |= (1 << 21);
	GPIOB_PDOR |= (1 << 22);
	GPIOE_PDOR |= (1 << 26);

	// GPIOx_PDOR=<value> sets entire reguster to value
	// GPIOx_PSOR=<value> sets all bits in the register for which value has a 1 bit in binary
	// GPIOx_PCOR=<value> clears all bits in the register for whcih value has a 1 bit in binary
	// GPIOx+PTOR=<value> toggles all bits in the register for which value has a 1 bit
	// if(GPIOx_PDIR==<value>) us to test input regierter



}


/*CAMERA GOODS*/

/*?DC0?onversion?omplete?SR?*/
void ADC0_IRQHandler(void) {
	// Reading ADC0_RA clears the conversion complete flag
	ADC0VAL = ADC0_RA >> 4;
}

/*
* FTM2 handles the camera driving logic
*	This ISR gets called once every integration period
*		by the periodic interrupt timer 0 (PIT0)
*	When it is triggered it gives the SI pulse,
*		toggles clk for 128 cycles, and stores the line
*		data from the ADC into the line variable
*/
void FTM2_IRQHandler(void) { //For FTM timer
	// Clear interrupt
	FTM2_SC &= ~(FTM_SC_TOF_MASK);


	// Toggle clk
	clkval = !clkval;
	GPIOB_PTOR = (1 << 9);

	// Line capture logic
	if ((pixcnt >= 2) && (pixcnt < 256)) {
		if (!clkval) {	// check for falling edge
			// ADC read (note that integer division is 
			//  occurring here for indexing the array)
			line[pixcnt / 2] = ADC0VAL;
		}
		pixcnt += 1;
	}
	else if (pixcnt < 2) {
		if (pixcnt == -1) {
			GPIOB_PSOR |= (1 << 23); // SI = 1
		}
		else if (pixcnt == 1) {
			GPIOB_PCOR |= (1 << 23); // SI = 0
			// ADC read
			line[0] = ADC0VAL;
		}
		pixcnt += 1;
	}
	else {
		GPIOB_PCOR |= (1 << 9); // CLK = 0
		clkval = 0; // make sure clock variable = 0
		pixcnt = -2; // reset counter
		// Disable FTM2 interrupts (until PIT0 overflows
		//   again and triggers another line capture)
		FTM2_SC &= ~(FTM_SC_TOIE_MASK);

	}


	return;
}

/* PIT0 determines the integration period
*		When it overflows, it triggers the clock logic from
*		FTM2. Note the requirement to set the MOD register
* 	to reset the FTM counter because the FTM counter is
*		always counting, I am just enabling/disabling FTM2
*		interrupts to control when the line capture occurs
*/
void PIT0_IRQHandler(void) {
	// Increment capture counter so that we can only 
	//	send line data once every ~2 seconds
	capcnt += 1;

	// Clear interrupt
	PIT_TFLG0 |= PIT_TFLG_TIF_MASK;

	// Setting mod resets the FTM counter
	FTM2_MOD = (0.00001 * DEFAULT_SYSTEM_CLOCK);

	// Enable FTM2 interrupts (camera)
	FTM2_SC |= FTM_SC_TOIE_MASK;

	return;
}


/* Initialization of FTM2 for camera */
void init_FTM2() {
	// Enable clock
	SIM_SCGC6 |= SIM_SCGC6_FTM2_MASK;

	// Disable Write Protection
	FTM2_MODE |= FTM_MODE_WPDIS_MASK;

	// Set output to '1' on init
	FTM2_MODE |= FTM_MODE_INIT_MASK;


	// Initialize the CNT to 0 before writing to MOD
	FTM2_CNT = 0;

	// Set the Counter Initial Value to 0
	FTM2_CNTIN = 0;

	// Set the +period (~10us)
	FTM2_MOD = (0.00001 * DEFAULT_SYSTEM_CLOCK);

	// Set edge-aligned mode
	FTM2_C0SC |= FTM_CnSC_MSB_MASK;

	// Enable High-true pulses
	// ELSB = 1, ELSA = 0
	FTM2_C0SC |= FTM_CnSC_ELSB_MASK;
	FTM2_C0SC &= ~(FTM_CnSC_ELSA_MASK);

	//?nable?ardware?rigger?rom?TM2
	FTM2_EXTTRIG |= FTM_EXTTRIG_INITTRIGEN_MASK;


	// Don't enable interrupts yet (disable)
	FTM2_SC &= ~(FTM_SC_TOIE_MASK);

	// No prescalar, system clock
	FTM2_SC |= FTM_SC_PS(0);
	FTM2_SC |= FTM_SC_CLKS(1);

	// Set up interrupt
	FTM2_MODE |= FTM_MODE_FTMEN_MASK;

	return;
}

/* Initialization of PIT timer to control
* 		integration period
*/
void init_PIT(void) {
	// Setup periodic interrupt timer (PIT)

	// Enable clock for timers
	SIM_SCGC6 |= SIM_SCGC6_PIT_MASK;

	// Enable timers to continue in debug mode
	// In case you need to debug
	PIT_MCR &= ~(PIT_MCR_FRZ_MASK);
	PIT_MCR &= ~PIT_MCR_MDIS_MASK;

	// PIT clock frequency is the system clock
	// Load the value that the timer will count down from
	//PIT_LDVAL0 = (0.05*INTEGRATION_TIME * DEFAULT_SYSTEM_CLOCK);
	//PIT_LDVAL0 = (0.001*INTEGRATION_TIME * DEFAULT_SYSTEM_CLOCK);
	PIT_LDVAL0 = (0.01*INTEGRATION_TIME * DEFAULT_SYSTEM_CLOCK);

	// Enable timer interrupts
	PIT_TCTRL0 |= PIT_TCTRL_TIE_MASK;

	// Enable the timer
	PIT_TCTRL0 |= PIT_TCTRL_TEN_MASK;

	// Clear interrupt flag
	PIT_TFLG0 |= PIT_TFLG_TIF_MASK;

	// Enable PIT interrupt in the interrupt controller
	NVIC_EnableIRQ(PIT0_IRQn);


	return;
}


/* Set up pins for GPIO
* 	PTB9 		- camera clk
*		PTB23		- camera SI
*		PTB22		- red LED
*/
void init_GPIO(void) {
	// Enable LED and GPIO so we can see results
	SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK;

	PORTB_PCR9 |= PORT_PCR_MUX(1);
	PORTB_PCR23 |= PORT_PCR_MUX(1);
	PORTB_PCR22 |= PORT_PCR_MUX(1);

	GPIOB_PDOR |= (1 << 9);
	GPIOB_PDDR |= (1 << 9);
	GPIOB_PDOR |= (1 << 23);
	GPIOB_PDDR |= (1 << 23);
	GPIOB_PDOR |= (1 << 22);
	GPIOB_PDDR |= (1 << 22);

	return;
}

/* Set up ADC for capturing camera data */
void init_ADC0(void) {
	unsigned int calib;
	// Turn on ADC0
	SIM_SCGC6 |= SIM_SCGC6_ADC0_MASK;


	// Single ended 16 bit conversion, no clock divider
	ADC0_CFG1 |= ADC_CFG1_MODE(3);
	ADC0_CFG1 |= ADC_CFG1_ADIV(0);
	ADC0_SC1A = ADC_SC1_ADCH(0);

	// Do ADC Calibration for Singled Ended ADC. Do not touch.
	ADC0_SC3 = ADC_SC3_CAL_MASK;
	while ((ADC0_SC3 & ADC_SC3_CAL_MASK) != 0);
	calib = ADC0_CLP0; calib += ADC0_CLP1; calib += ADC0_CLP2;
	calib += ADC0_CLP3; calib += ADC0_CLP4; calib += ADC0_CLPS;
	calib = calib >> 1; calib |= 0x8000;
	ADC0_PG = calib;

	// Select hardware trigger.
	ADC0_SC2 |= ADC_SC2_ADTRG_MASK;

	// Set to single ended mode	
	ADC0_SC1A &= ~(ADC_SC1_DIFF_MASK);

	// Set up FTM2 trigger on ADC0
	SIM_SOPT7 = SIM_SOPT7_ADC0TRGSEL(10);     			// FTM2 select
	SIM_SOPT7 |= SIM_SOPT7_ADC0ALTTRGEN_MASK;       // Alternative trigger en.
	SIM_SOPT7 &= ~SIM_SOPT7_ADC0PRETRGSEL_MASK;			// Pretrigger A

	  // Enable NVIC interrupt
	NVIC_EnableIRQ(ADC0_IRQn);
	ADC0_SC1A |= ADC_SC1_AIEN_MASK;
}
