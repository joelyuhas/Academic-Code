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

int main()
{
	
	uart_init();
	
	
	put("\r\n IDE Lab2: UART's are awesome!");    /*Transmit this through UART*/

		
}  

void put(char *ptr_str)
{
	while(*ptr_str)
		uart_putchar(*ptr_str++);
}
