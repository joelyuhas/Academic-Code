/*********************************************************************/
/* Lab Exercise Eleven                                               */
/* Descriptive comment header goes here.                             */
/* Name:  <Your name here>                                           */
/* Date:  <Date completed here>                                      */
/* Class:  CMPE 250                                                  */
/* Section:  <Your lab section, day, and time here>                  */
/*********************************************************************/
#include "Exercise11_C.h"  

#define FALSE      (0)
#define TRUE       (1)
#define MAX_HEX_STRING ((sizeof(UInt128) << 1) + 1)
#define MAX_STRING (79)
#define NUMBER_BITS (128)

int GetHexIntMulti (UInt32 *Number, int NumWords) {
/*********************************************************************/
/* Gets user string input of hex representation of an multiword      */
/* unsigned number of NumWords words, and converts it to a binary    */
/* unsigned NumWords-word number.                                    */
/* If user input is invalid, returns 1; otherwise returns 0.         */  
/* Calls:  GetStringSB                                               */
/*********************************************************************/
	int i;
	int t;
	int j;
	char hex1;
	char hex2;
	int maybeOver;
	UInt8 *Number1;
	char temp_char1;
	char temp_char2;
	char String1[MAX_HEX_STRING];
	
	Number1 = (UInt8*)Number;
	GetStringSB(String1,MAX_HEX_STRING);
	
	

maybeOver = 0;
	
i = 0;
j = 0;
	/*placing the string*/
while(i <= 3){
	j = 0;
	while(j <= 3){
		temp_char1 = String1[(i*8) + (2*j)];
		temp_char2 = String1[(i*8) + (2*j)+1];
		hex1 = temp_char1;
		hex2 = temp_char2;
		
	
		/*checks for the extra credit case of having too few*/
		if((hex1 == 0) || (hex2 == 0)){
			if(hex1 == 0){
						if(hex2 < 58  & hex2 > 47){
								hex2 = hex2 - '0';
						}
						else if(hex2 < 103 & hex2 > 96){
								hex2 = hex2 - 87;
						}
						else if(hex2 < 71 & hex2 > 64){
								hex2 = hex2 - 55;
						}
						else{
								hex2 = 0;
						}
						
						hex1 = 0;
						hex1 = (hex1 << 4);
		
						/*combining the two*/
						hex1 = (hex2 + hex1);
						Number1[((i*4)+(3-j))] = hex1;
			}
			
			else if(hex2 == 0){
						if(hex1 < 58  & hex1 > 47){
								hex1 = hex1 - '0';
						}
						else if(hex1 < 103 & hex1 > 96){
								hex1 = hex1 - 87;
						}
						else if(hex1 < 71 & hex1 > 64){
								hex1 = hex1 - 55;
						}
						else{
								return (1);
						}
						
						hex2 = 0;
						hex1 = (hex1 << 4);
		
						/*combining the two*/
						hex1 = (hex2 + hex1);
						Number1[((i*4)+(3-j))] = hex1;
			}
			
			while(i <= 3){
				while (j <= 3){
					hex1 = 0;
					hex2 = 0;
					hex1 = (hex1 << 4);
		
					hex1 = (hex2 + hex1);
					Number1[((i*4)+(3-j))] = hex1;
					j++;
				}
				j = 0;
			i++;
		}
			return(0);
	}
	
		
		/*converting to none ascii*/
	
		if(hex1 < 58  & hex1 > 47){
			hex1 = hex1 - '0';
		}
		else if(hex1 < 103 & hex1 > 96){
			hex1 = hex1 - 87;
		}
		else if(hex1 < 71 & hex1 > 64){
			hex1 = hex1 - 55;
		}
		else if(hex1 == 0){
			maybeOver = 1;
		}
		else{
			return (1);
		}
		
		/*logical shifting*/
		
		
		/*converting second one to none ascii*/
		if(hex2 < 58  & hex2 > 47){
			hex2 = hex2 - '0';
		}
		else if(hex2 < 103 & hex2 > 96){
			hex2 = hex2 - 87;
		}
		else if(hex2 < 71 & hex2 > 64){
			hex2 = hex2 - 55;
		}
		else if(hex2 == 0){
			maybeOver = 1;
		}
		else{
			return (1);
		}
		
		hex1 = (hex1 << 4);
		
		/*combining the two*/
		hex1 = (hex2 + hex1);
		
		
		Number1[(i*4)+(3-j)] = hex1;
		j++;
	}
	i++;
	}
	return(0);
	
} /* GetHexIntMulti */

void PutHexIntMulti (UInt32 *Number, int NumWords) {
/*********************************************************************/
/* Prints hex representation of an unsigned multi-word number of     */
/* NumWords words.                                                   */
/* Calls:  PutStringSB                                               */
/*********************************************************************/
	int i;
	int t;
	int j;
	char hex1;
	char hex2;
	int maybeOver;
	UInt8 *Number1;
	char temp_char1;
	char temp_char2;
	char String1[MAX_HEX_STRING];
	
	Number1 = (UInt8*)Number;
	maybeOver = 0;
	
i = 0;
j = 0;
	/*placing the string*/
while(i <= 3){
	j = 0;
	while(j <= 3){
		hex1 = Number1[(i*4)+(3-j)];
		hex2 = (hex1 & 0x0F);
		hex1 = (hex1 >> 4);
	
		if(hex1 <= 9  & hex1 >= 0){
			hex1 = hex1 + '0';
		}
		else if(hex1 <= 15 & hex1 >= 10){
			hex1 = hex1 + 'A'-10;
		}
		else if(hex1 == 0){
			maybeOver = 1;
		}
			
		/*converting second one to the goods*/
		if(hex2 <= 9  & hex2 >= 0){
			hex2 = hex2 + '0';
		}
		else if(hex2 <= 15 & hex2 >= 10){
			hex2 = hex2 + 'A' - 10;
		}
		else if(hex2 == 0){
			maybeOver = 1;
		}
		
		String1[(i*8) + (2*j)] = hex1;
		String1[(i*8) + (2*j)+1] = hex2;

		j++;
	}
	i++;
	}
	PutStringSB(String1,MAX_STRING);
} /* PutHexIntMulti */


 
int main (void) {
  /* >>>>> Variable declarations here <<<<< */  
	UInt128 One;
	UInt128 Two;
	UInt128	Sum;
	char* endline;
	
	int pass;
	int passSum;
  __asm("CPSID   I");  /* mask interrupts */
  Startup ();
  Init_UART0_IRQ ();
  __asm("CPSIE   I");  /* unmask interrupts */

  /* >>>>> Remaining program code here <<<<< */

while(1){	
	pass = 1;
	
	/*First print out*/
	PutStringSB(" Enter First 128 bit hex numebr: ", MAX_STRING);
	
	while(pass == 1){
		pass = GetHexIntMulti(One.Word,4);
		if(pass == 1){
			PutStringSB("      Invalid number--try again: ", MAX_STRING);
		}
	}
	
	pass = 1;
	
	PutStringSB("Enter 128-bit hex number to add: ", MAX_STRING);
	
	/*second print out*/
	while(pass == 1){
		pass = GetHexIntMulti(Two.Word,4);
		if(pass == 1){
			PutStringSB("      Invalid number--try again: ", MAX_STRING);
		}
	}
	
	
		/*getting the summation*/
	passSum = AddIntMultiU(Sum.Word,Two.Word,One.Word,4);
	
	if(passSum == 0){
		PutStringSB("                            Sum: ", MAX_STRING);
		PutHexIntMulti(Sum.Word, 4);
	}
	else{
		PutStringSB("                            Sum: 0xOVERFLOW", MAX_STRING);
	}

	PutStringSB("\n\r",MAX_STRING);
}
  return (0);
} /* main */
