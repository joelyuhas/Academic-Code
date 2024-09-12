/* 
Title:  Lab 1
Purpose:   
Name:   Joel Yuhas
Date:   1/17/18
*/
#include "MK64F12.h"                    // Device header

void LED_Init(void){
	// Enable clocks on Ports B and E for LED timing
     SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; // Enables Clock on Port B
     SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; // Enables Clock on Port E	 
	
    // Configure the Signal Multiplexer for GPIO
        PORTB_PCR21=PORT_PCR_MUX(1); //Enabling Port B pin 21
        PORTB_PCR22=PORT_PCR_MUX(1); //Enabling Port B pin 22
        PORTE_PCR26=PORT_PCR_MUX(1); //Enabling Port E pin 26
    
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

void Button_Init(void){
	// Enable clock for Port C PTC6 button
    SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK;

    // Configure the Mux for the button
    PORTC_PCR6=PORT_PCR_MUX(1); //Enabling Port C pin 6
    
	// Set the push button as an input
    GPIOC_PDDR = (0 << 6); // setting to input mode
	 
}

int main(void){
	//Initialize any supporting variables
	 int i = 1;
     long w = 1;
     int x = 1;
     int count;
	
	// Initialize buttons and LEDs
	LED_Init();
    Button_Init();

    //for(count = 0; count < i; --count){
    while(0<1){
		//Turn on an LED configuration when button is held
        w = 0;
		if((GPIOC_PDIR & (1 << 6)) == 0){
            switch(x){
            
                case 1:             
                    GPIOB_PDOR = (01 << 21); //red
                    while( w < 2000000 ){ ++w; } w = 0;
                    GPIOB_PSOR = (1UL << 21) | (1UL << 22);
                    GPIOE_PSOR = 1UL << 26;
            
                    GPIOE_PDOR = (0 << 26); //green
                    while( w < 2000000 ){ ++w; } w = 0;
                    GPIOB_PSOR = (1UL << 21) | (1UL << 22);
                    GPIOE_PSOR = 1UL << 26;
            
                    GPIOB_PDOR = (10 << 21); //blue
                    while( w < 2000000 ){ ++w; } w = 0;
                    GPIOB_PSOR = (1UL << 21) | (1UL << 22);
                    GPIOE_PSOR = 1UL << 26;
                    
                    x = 2;
                    break;
                
                case 2:
                    //cyan
                    GPIOE_PDOR = (0 << 26); //green
                    GPIOB_PDOR = (10 << 21); //blue
                    while( w < 2000000 ){ ++w; } w = 0;
                    GPIOB_PSOR = (1UL << 21) | (1UL << 22);
                    GPIOE_PSOR = 1UL << 26;
            
                    //magenta
                    GPIOB_PDOR = (00 << 21); //red
                    while( w < 2000000 ){ ++w; } w = 0;
                    GPIOB_PSOR = (1UL << 21) | (1UL << 22);
                    GPIOE_PSOR = 1UL << 26;
            
                    //yellow
                    GPIOE_PDOR = (0 << 26); //green
                    GPIOB_PDOR = (01 << 21); //red
                    while( w < 2000000 ){ ++w; } w = 0;
                    GPIOB_PSOR = (1UL << 21) | (1UL << 22);
                    GPIOE_PSOR = 1UL << 26;
                    
                    x = 3;
                    break;     

                case 3:
                    GPIOB_PDOR = (00 << 21); //red blue
                    GPIOE_PDOR = (0 << 26); //green
                    while( w < 2000000 ){ ++w; } w = 0;
                    x = 1;
                    break;
            
            
            
            }

            

           
           
		// Turn off LEDs on release of button
       }
		else{
			GPIOB_PSOR = (1UL << 21) | (1UL << 22);
			GPIOE_PSOR = 1UL << 26;
		}
	}
	

}
