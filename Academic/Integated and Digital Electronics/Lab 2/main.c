/*
Title:
Description:
Authors: 
Date: 

Some of the contents are obtained by the courtesy of the material provided by Freescale Semiconductor, Inc.
Copyright (c) 2014, Freescale Semiconductor, Inc.
All rights reserved.
*/

#include<stdio.h>
#include "MK64F12.h"
#define BAUD_RATE 9600      //default baud rate 
#define SYS_CLOCK 20485760 //default system clock (see DEFAULT_SYSTEM_CLOCK  in system_MK64F12.c)
#define CHAR_COUNT 10      //change this to modify the max. permissible length of a sentence

void put(char *ptr_str);
void uart_init(void);
uint8_t uart_getchar(void);
void uart_putchar(char ch);

uint8_t temp;


int main()
{
	
	uart_init();
    int x = 0;
    int y = 1;
	
    while (y){
        put("\r\nType Something Please: ");    /*Transmit this through UART*/
    
        int x = 0;
        while (x < CHAR_COUNT){
            temp = uart_getchar();
            uart_putchar(temp);
            if (temp == '\r'){
                x = 10;
            }
            x++; 
        }
        while (x == CHAR_COUNT){
            temp = uart_getchar();
            if (temp == '\r'){
                x = 0;
            }
        
    }

}
		
}  

void put(char *ptr_str)
{
	while(*ptr_str)
		uart_putchar(*ptr_str++);
}
