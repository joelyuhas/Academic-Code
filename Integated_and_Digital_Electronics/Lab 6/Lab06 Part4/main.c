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



// Default System clock value
// period = 1/20485760  = 4.8814395e-8
#define DEFAULT_SYSTEM_CLOCK 20485760u 
// Integration time (seconds)
// Determines how high the camera values are
// Don't exceed 100ms or the caps will saturate
// Must be above 1.25 ms based on camera clk 
//	(camera clk is the mod value set in FTM2)
#define INTEGRATION_TIME .00075f // currently set faster (default was .0075f)

void initialize();
void en_interrupts();
void delay();
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


// Camera
int pixcnt = -2;
int clkval = 0;
uint16_t line[128];
int debugcamdata = 1;
int capcnt = 0;
uint16_t ADC0VAL;
int start = 0;


int main(void)
{
  int i = 0;
	// Initialize UART and PWM
	initialize();
    
    
   NVIC_EnableIRQ(PIT0_IRQn);
	NVIC_EnableIRQ(FTM2_IRQn);
	
	for(;;) {

		if (debugcamdata) {
			// Every 2 seconds
			if (capcnt >= (2/INTEGRATION_TIME)) {
			//if (capcnt >= (500)) {
				GPIOB_PCOR |= (1 << 22);
				// send the array over uart
				sprintf(str,"%i\n\r",-1); // start value
				put(str);
				for (i = 0; i < 127; i++) {
					sprintf(str,"%i\n", line[i]);
					put(str);
				}
				sprintf(str,"%i\n\r",-2); // end value
				put(str);
				capcnt = 0;
				GPIOB_PSOR |= (1 << 22);
			}
		}

	} //for
   

	// Print welcome over serial
	put("Running... \n\r");
  
	
	//Step 3
	//Generate 20% duty cycle at 10kHz

	//SetDervoDutyCycle(, 50);
	//SetDutyCycle(50, 10000, 0);
	//for(;;) ;  //then loop forever
	//Step 9
	for(;;)  //loop forever
	{
    
    uint16_t dc = 0;
		uint16_t freq = 10000; /* Frequency = 10 kHz */
		uint16_t dir = 0;
		char c = 48;
		int i=0;
    
    if((GPIOC_PDIR & (1 << 6)) == 0){
       start = !(start);
    }
    
    if(start){
      SetDutyCycle(30, freq, 1);
      SetDervoDutyCycle(4, 50);
      delay(200);
      
      SetDervoDutyCycle(5, 50);
      delay(200);
      
      SetDervoDutyCycle(6, 50);
      delay(200);
    
      SetDervoDutyCycle(7, 50);
      delay(200);
    
      SetDervoDutyCycle(8, 50);
      delay(200);
      
      SetDervoDutyCycle(9, 50);
      delay(200);
      
      SetDervoDutyCycle(10, 50);
      delay(200);
    }

    
        //for (i=4; i<9; i++){
          //SetDervoDutyCycle(i, 50); // 8 is the the middile
          //sprintf(str,"%i\n\r",i); // start value
          //put(str);
          //delay(300);
        //}
    
        
        //SetDervoDutyCycle(8, 50); // 8 is the the middile
        // sprintf(str,"%i\n\r",i); // start value
				//put(str);
        //delay(100);
        
        //SetDervoDutyCycle(4, 50);// 0 - 16
        //delay(100);


  /*      
      
		// 0 to 100% duty cycle in forward direction
		for (i=0; i<100; i++){
      put("for loop 1 \n\r");
			SetDutyCycle(i, freq, 0);
			delay(10);
		}
		
		// 100% down to 0% duty cycle in the forward direction
		for (i=100; i>=0; i--){
      put("for loop 2 \n\r");
			SetDutyCycle(i, freq, 0);
			delay(10);
		}
        
     */
		
/*		// 0 to 100% duty cycle in reverse direction
		for (i=0; i<100; i++){
      put("for loop 3 \n\r");
			SetDutyCycle(i, freq, 1);
			delay(10);
		}
		
		// 100% down to 0% duty cycle in the reverse direction
		for (i=100; i>=0; i--){
       put("for loop 4 \n\r");
			SetDutyCycle(i, freq, 1);
			delay(10);
		}*/

	}
	return 0;
}


/**
 * Waits for a delay (in milliseconds)
 * 
 * del - The delay in milliseconds
 */
void delay(int del){
	int i;
	for (i=0; i<del*50000; i++){
		// Do nothing
	}
}

void initialize()
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
}


void Button_Init(void){
	// Enable clock for Port C PTC6 button
	SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK;
	
	// Configure the Mux for the button
	PORTC_PCR6 = PORT_PCR_MUX(1);

	// Set the push button as an input
	GPIOC_PDOR |= (1 << 6);
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
void FTM2_IRQHandler(void){ //For FTM timer
	// Clear interrupt
	FTM2_SC &= ~(FTM_SC_TOF_MASK);
	
	
	// Toggle clk
	clkval = !clkval;
	GPIOB_PTOR = (1<<9);
	
	// Line capture logic
	if ((pixcnt >= 2) && (pixcnt < 256)) {
		if (!clkval) {	// check for falling edge
			// ADC read (note that integer division is 
			//  occurring here for indexing the array)
			line[pixcnt/2] = ADC0VAL;
		}
		pixcnt += 1;
	} else if (pixcnt < 2) {
		if (pixcnt == -1) {
			GPIOB_PSOR |= (1 << 23); // SI = 1
		} else if (pixcnt == 1) {
			GPIOB_PCOR |= (1 << 23); // SI = 0
			// ADC read
			line[0] = ADC0VAL;
		} 
		pixcnt += 1;
	} else {
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
void PIT0_IRQHandler(void){
	if (debugcamdata) {
		// Increment capture counter so that we can only 
		//	send line data once every ~2 seconds
		capcnt += 1;
	}
	
	// Clear interrupt
  PIT_TFLG0 |= PIT_TFLG_TIF_MASK;
	
	// Setting mod resets the FTM counter
  FTM2_MOD = (0.00001 * DEFAULT_SYSTEM_CLOCK);
  
	// Enable FTM2 interrupts (camera)
	FTM2_SC |= FTM_SC_TOIE_MASK;
	
	return;
}


/* Initialization of FTM2 for camera */
void init_FTM2(){
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
void init_PIT(void){
	// Setup periodic interrupt timer (PIT)
	
	// Enable clock for timers
	SIM_SCGC6 |= SIM_SCGC6_PIT_MASK;
	
	// Enable timers to continue in debug mode
	// In case you need to debug
	PIT_MCR &= ~(PIT_MCR_FRZ_MASK);
  PIT_MCR &= ~PIT_MCR_MDIS_MASK;
	
	// PIT clock frequency is the system clock
	// Load the value that the timer will count down from
  PIT_LDVAL0 = (INTEGRATION_TIME * DEFAULT_SYSTEM_CLOCK);
	
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
void init_GPIO(void){
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
    while ( (ADC0_SC3 & ADC_SC3_CAL_MASK) != 0 );
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
