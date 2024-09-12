;Exercise 06
;****************************************************************
;Exercies 8
;String Modification Techniques
;Name:  Joel Yuhas
;Date:  4/7/2016
;Class:  CMPE-250
;Section:  Lab section 2 2:00pm to 3:50pm
;---------------------------------------------------------------
;Keil Template for KL46
;R. W. Melton
;April 3, 2015
;****************************************************************
;Assembler directives
            THUMB
            OPT    64  ;Turn on listing macro expansions
;****************************************************************
;Include files
            GET  MKL46Z4.s     ;Included by start.s
            OPT  1   ;Turn on listing
;****************************************************************
;EQUates
;---------------------------------------------------------------
;PORTx_PCRn (Port x pin control register n [for pin n])
;___->10-08:Pin mux control (select 0 to 8)
;Use provided PORT_PCR_MUX_SELECT_2_MASK
;---------------------------------------------------------------
;Port A
PORT_PCR_SET_PTA1_UART0_RX  EQU  (PORT_PCR_ISF_MASK :OR: \
                                  PORT_PCR_MUX_SELECT_2_MASK)
PORT_PCR_SET_PTA2_UART0_TX  EQU  (PORT_PCR_ISF_MASK :OR: \
                                  PORT_PCR_MUX_SELECT_2_MASK)
;---------------------------------------------------------------
;SIM_SCGC4
;1->10:UART0 clock gate control (enabled)
;Use provided SIM_SCGC4_UART0_MASK
;---------------------------------------------------------------
;SIM_SCGC5
;1->09:Port A clock gate control (enabled)
;Use provided SIM_SCGC5_PORTA_MASK
;---------------------------------------------------------------
;SIM_SOPT2
;01=27-26:UART0SRC=UART0 clock source select
;         (PLLFLLSEL determines MCGFLLCLK' or MCGPLLCLK/2)
; 1=   16:PLLFLLSEL=PLL/FLL clock select (MCGPLLCLK/2)
SIM_SOPT2_UART0SRC_MCGPLLCLK  EQU  \
                                 (1 << SIM_SOPT2_UART0SRC_SHIFT)
SIM_SOPT2_UART0_MCGPLLCLK_DIV2 EQU \
    (SIM_SOPT2_UART0SRC_MCGPLLCLK :OR: SIM_SOPT2_PLLFLLSEL_MASK)
;---------------------------------------------------------------
;SIM_SOPT5
; 0->   16:UART0 open drain enable (disabled)
; 0->   02:UART0 receive data select (UART0_RX)
;00->01-00:UART0 transmit data select source (UART0_TX)
SIM_SOPT5_UART0_EXTERN_MASK_CLEAR  EQU  \
                               (SIM_SOPT5_UART0ODE_MASK :OR: \
                                SIM_SOPT5_UART0RXSRC_MASK :OR: \
                                SIM_SOPT5_UART0TXSRC_MASK)
;---------------------------------------------------------------
;UART0_BDH
;    0->  7:LIN break detect IE (disabled)
;    0->  6:RxD input active edge IE (disabled)
;    0->  5:Stop bit number select (1)
;00001->4-0:SBR[12:0] (UART0CLK / [9600 * (OSR + 1)]) 
;UART0CLK is MCGPLLCLK/2
;MCGPLLCLK is 96 MHz
;MCGPLLCLK/2 is 48 MHz
;SBR = 48 MHz / (9600 * 16) = 312.5 --> 312 = 0x138
UART0_BDH_9600  EQU  0x01
;---------------------------------------------------------------
;UART0_BDL
;26->7-0:SBR[7:0] (UART0CLK / [9600 * (OSR + 1)])
;UART0CLK is MCGPLLCLK/2
;MCGPLLCLK is 96 MHz
;MCGPLLCLK/2 is 48 MHz
;SBR = 48 MHz / (9600 * 16) = 312.5 --> 312 = 0x138
UART0_BDL_9600  EQU  0x38
;---------------------------------------------------------------
;UART0_C1
;0-->7:LOOPS=loops select (normal)
;0-->6:DOZEEN=doze enable (disabled)
;0-->5:RSRC=receiver source select (internal--no effect LOOPS=0)
;0-->4:M=9- or 8-bit mode select 
;        (1 start, 8 data [lsb first], 1 stop)
;0-->3:WAKE=receiver wakeup method select (idle)
;0-->2:IDLE=idle line type select (idle begins after start bit)
;0-->1:PE=parity enable (disabled)
;0-->0:PT=parity type (even parity--no effect PE=0)
UART0_C1_8N1  EQU  0x00
;---------------------------------------------------------------
;UART0_C2
;0-->7:TIE=transmit IE for TDRE (disabled)
;0-->6:TCIE=transmission complete IE for TC (disabled)
;0-->5:RIE=receiver IE for RDRF (disabled)
;0-->4:ILIE=idle line IE for IDLE (disabled)
;1-->3:TE=transmitter enable (enabled)
;1-->2:RE=receiver enable (enabled)
;0-->1:RWU=receiver wakeup control (normal)
;0-->0:SBK=send break (disabled, normal)
UART0_C2_T_R  EQU  (UART0_C2_TE_MASK :OR: UART0_C2_RE_MASK)
;---------------------------------------------------------------
;UART0_C3
;0-->7:R8T9=9th data bit for receiver (not used M=0)
;           10th data bit for transmitter (not used M10=0)
;0-->6:R9T8=9th data bit for transmitter (not used M=0)
;           10th data bit for receiver (not used M10=0)
;0-->5:TXDIR=UART_TX pin direction in single-wire mode
;            (no effect LOOPS=0)
;0-->4:TXINV=transmit data inversion (not inverted)
;0-->3:ORIE=overrun IE for OR (disabled)
;0-->2:NEIE=noise error IE for NF (disabled)
;0-->1:FEIE=framing error IE for FE (disabled)
;0-->0:PEIE=parity error IE for PF (disabled)
UART0_C3_NO_TXINV  EQU  0x00
;---------------------------------------------------------------
;UART0_C4
;    0-->  7:MAEN1=match address mode enable 1 (disabled)
;    0-->  6:MAEN2=match address mode enable 2 (disabled)
;    0-->  5:M10=10-bit mode select (not selected)
;01111-->4-0:OSR=over sampling ratio (16)
;               = 1 + OSR for 3 <= OSR <= 31
;               = 16 for 0 <= OSR <= 2 (invalid values)
UART0_C4_OSR_16           EQU  0x0F
UART0_C4_NO_MATCH_OSR_16  EQU  UART0_C4_OSR_16
;---------------------------------------------------------------
;UART0_C5
;  0-->  7:TDMAE=transmitter DMA enable (disabled)
;  0-->  6:Reserved; read-only; always 0
;  0-->  5:RDMAE=receiver full DMA enable (disabled)
;000-->4-2:Reserved; read-only; always 0
;  0-->  1:BOTHEDGE=both edge sampling (rising edge only)
;  0-->  0:RESYNCDIS=resynchronization disable (enabled)
UART0_C5_NO_DMA_SSR_SYNC  EQU  0x00
;---------------------------------------------------------------
;UART0_S1
;0-->7:TDRE=transmit data register empty flag; read-only
;0-->6:TC=transmission complete flag; read-only
;0-->5:RDRF=receive data register full flag; read-only
;1-->4:IDLE=idle line flag; write 1 to clear (clear)
;1-->3:OR=receiver overrun flag; write 1 to clear (clear)
;1-->2:NF=noise flag; write 1 to clear (clear)
;1-->1:FE=framing error flag; write 1 to clear (clear)
;1-->0:PF=parity error flag; write 1 to clear (clear)
UART0_S1_CLEAR_FLAGS  EQU  0x1F
;---------------------------------------------------------------
;UART0_S2
;1-->7:LBKDIF=LIN break detect interrupt flag (clear)
;             write 1 to clear
;1-->6:RXEDGIF=RxD pin active edge interrupt flag (clear)
;              write 1 to clear
;0-->5:(reserved); read-only; always 0
;0-->4:RXINV=receive data inversion (disabled)
;0-->3:RWUID=receive wake-up idle detect
;0-->2:BRK13=break character generation length (10)
;0-->1:LBKDE=LIN break detect enable (disabled)
;0-->0:RAF=receiver active flag; read-only
UART0_S2_NO_RXINV_BRK10_NO_LBKDETECT_CLEAR_FLAGS  EQU  0xC0
;--------------------------------------------------------------
CR			EQU			0x0D
LF			EQU			0x0A
MAX_STRING	EQU			79
;****************************************************************
;Program
;Linker requires Reset_Handler
            AREA    MyCode,CODE,READONLY
            ENTRY
            EXPORT  Reset_Handler
            IMPORT  Startup
Reset_Handler
main
;---------------------------------------------------------------
;Mask interrupts
			CPSID   I
;KL46 system startup with 48-MHz system clock
            BL      Startup
;---------------------------------------------------------------
;---------------------- HEADER -------------------------
;Program creates a Queue and has EnQueue and Dequeue functonality
;as well as being able to display help and status tables
;
;these subroutines include but are not limited to
;----------InitQueue
;----------Enqueue
;----------Dequeue
;----------PutNumHex
;----------GetStringSB
;----------PutStringSB
;----------PutNumU
;----------PutChar
;----------GetChar
;
;the program also used a number of other subroutines that allowed it
;to read in the input of the useer


;>>>>> begin main program code <<<<<
			
			BL		Init					;initializing UART0
Loop										;infinite loop 
			LDR		R1,=InitialC			;loading "inital string"
			LDR		R0,=String				;loading the initial output of "Type a string command (g,i,l,p):"
			BL		CopyString				;copying "initial string" into string address

LoopInit
			LDR		R0,=InitString			;printing initial string
			BL		PutStringSB
			
			BL 		GetChar					;getting the first user input
			CMP		R0, #'Z'				;checking to see if upper case
			MOV		R7,R0					;saving the original value for later
			BLS		UpperCase				;if it is uppercase, branch and fix it
			
Back										;back from uppercase fix
			CMP		R0,	#'g'				;checking if 'd'
			BEQ		CorrectG				
			CMP		R0, #'h'				;checking if 'e'
			BEQ		CorrectH
			CMP		R0, #'m'				;checking if 'h'
			BEQ		CorrectM
			CMP		R0, #'p'				;checking if 'p'
			BEQ		CorrectP
			CMP		R0, #'r'				;checking if 's'
			BEQ		CorrectR
			CMP		R0, #CR					;checking if 'ENTER'
			BEQ		Enter_01
		
			B		InvalidLoop					;looping forever


;---------Enter_01--------
;prints new line if enter is hit
Enter_01
		MOVS	R0,#CR				;printing new line
		BL		PutChar
		MOVS	R0,#LF
		BL		PutChar
		
		B		LoopInit
		
;------ InvalidLoop -------
;prints "invalid command" if no correct inputs were inputed
InvalidLoop	
		LDR		R0,=InvalidC
		MOVS	R1,#MAX_STRING			;loading buffer capacity
		BL		PutStringSB
		
		MOVS	R0,#CR				;printing new line
		BL		PutChar
		MOVS	R0,#LF
		BL		PutChar
	
		B		LoopInit

;----------------------- UpperCase ----------------------------
;Inputs:
;		R0, the value which will be converted to lower case
;
;Outputs:
;		R7, original value, donesnt nessesarily need to be used
;
;Description:
;		Takes in uppercase value and converts it to lower case
UpperCase
			CMP		R0, #'A'
			BLO		Back
			MOVS	R7,R0					;saves initial value in R7
			ADDS	R0,R0,#32				;converts to lower case
			BL		Back
			
Correct
			PUSH	{R0, LR}
			MOVS	R0,R7					;printing original value
			BL		PutChar
			
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			POP		{R0, PC}


;----------------------- G ----------------------------
;CorrectG is triggered if G is inputed.
;
;CorrectG loads the string into R0, and then takes the user inputed string
;from the terminal window and stores it in said string
CorrectG
			LDR		R0,=String
			PUSH	{R1,R2}
			BL		Correct					;Base correct subroutine that sets up subroutines
			LDR		R1,=MAX_STRING
			BL		GetStringSB
			
			POP		{R1,R2}
			
			B		LoopInit
			
			

;----------------------- H ----------------------------
;CorrectH is triggered if H is inputed.
;
;CorrectH loads the Help string which contains a list of all commands
;and prints them to the terminal window
CorrectH
			PUSH 	{R0,R1}
			BL		Correct					;Base correct subroutine that sets up subroutines
			LDR		R0,=Help
			MOVS	R1,#MAX_STRING			;loading buffer capacity
			BL		PutStringSB
			
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			POP 	{R0,R1}
			
			B		LoopInit					;no status, so loop


;----------------------- M ---------------------------
;CorrectM is triggered if M is inputed
;
;CorrectM is responsible for setting up the enviornment to call
;String_Modify Subroutine, which
;			-Replace uppercase letters with lowercase
;			-Replace spaces with underscores
;			-Replace numbers with hashtags
CorrectM
			
			LDR		R0,=String
			BL		Correct					;Base correct subroutine that sets up subroutines
			MOVS	R1,R0					;perserves address
			MOVS	R5,#0					;counter
			
			BL		String_Modify			;calls string modify
			
			B		CorrectP_01

;----------------------- P ----------------------------
;CorrectP is triggered if P is inputed
;
;CorrectP is responsible for printing the string located in at the address
;which is pererves in the "String" variable
CorrectP
			
			BL		Correct					;Base correct subroutine that sets up subroutines
			
CorrectP_01			
			LDR		R0,=String
			MOVS	R1,#MAX_STRING			;loading buffer capacity
			BL		PutStringSB
			
			MOVS	R3,R0					;Perserves address
			
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			MOVS	R0,R3
			
			B		LoopInit
			

;----------------------- R ----------------------------
;CorrectR is triggered if R is inputed
;
;CorrectR is responsible for setting up the enviornment to call the
;String_Reversal Subroutine
CorrectR
			PUSH	{R1-R6}
			LDR		R0,=String
			BL		String_Reversal
			POP 	{R1-R6}
			B		CorrectP


;>>>>>   end main program code <<<<<
;Stay here
            B       .
			
;>>>>> begin subroutine code <<<<<


;---------------------- CopyString--------------------------
;Inputs:
;		R0, Address of string to copy to
;		R1, Address of string to copy from
;
;Outputs:
;		none
;
;Description:
;		Copies a string at address into another address
CopyString
		PUSH	{R0-R5,LR}
		MOVS	R5,#0				;counter

		
C_Loop_01
		LDRB	R3,[R1,R5]			;takes character from the given string
		
		CMP		R3,#0
		BEQ		C_DONE
		
		
		STRB	R3,[R0,R5]			;Puts characther into new, copied string
		ADDS	R5,R5,#1		


		B		C_Loop_01

C_DONE
		MOVS	R3,#0				;placing in the null terminate
		ADDS	R5,R5,#1
		STRB	R3,[R0,R5]			;Puts characther into new, 

		POP		{R0-R5,PC}


;-------------------- String Modify -----------------------------
;Inputs:
;		R0, the address of the string which is to be modified
;
;Outputs:
;		none
;
;Description:
;		Does the following operations on the string:
;			-Replace uppercase letters with lowercase
;			-Replace spaces with underscores
;			-Replace numbers with hashtags

String_Modify
			PUSH	{R0-R5,LR}
M_Loop_01
			LDRB	R2,[R0,R5]
			CMP		R2,#0
			BEQ		M_Done
			
			CMP		R2,#' '					;checking for space
			BEQ		M_SPACE
			
			CMP		R2,#'Z'					;checking for capital
			BLS		MAYBE_CAPITAL			;checks if below Z
MAYBE_NOPE
			
			CMP		R2,#'9'					;checking for decimal
			BLS		MAYBE_DECMIAL
			
			
			ADDS	R5,R5,#1
			B		M_Loop_01
			
M_Done

			MOVS	R0,R1					;reputting address apropriatly
			POP		{R0-R5,PC}
			
			
;------------M_SPACE------------
M_SPACE
			MOVS	R4,#'_'
			STRB	R4,[R0,R5]				;storing
			ADDS	R5,R5,#1
			LDRB	R2,[R0,R4]

			B		M_Loop_01

;-------MAYBE_CAPITAL-----------
MAYBE_CAPITAL
			CMP		R2,#'A'					;checks to see if not capital
			BLO		MAYBE_NOPE	
			
			;if it makes it to this point, it is a capital
			
			ADDS	R2,R2,#32				;converting to lowercase
			STRB	R2,[R0,R5]				;storing
			ADDS	R5,R5,#1
			B		M_Loop_01
;-------MAYBE_DECMIAL----------
MAYBE_DECMIAL
			CMP		R2,#'0'
			BLO		ABORT
			
			;if it makes it to this point, it is a decimal
			
			MOVS	R4,#'#'
			STRB	R4,[R0,R5]
			ADDS	R5,R5,#1
			B		M_Loop_01

;-------------ABORT-------------
ABORT
			ADDS	R5,R5,#1
			B		M_Loop_01



;--------------------- String Reversal -----------------------------
;Inputs:
;		R0, Address of string to reverse
;
;Outputs:
;		none
;
;Description:
;		Takes a string at an address and reverses it
String_Reversal
			PUSH	{R0-R5,LR}
			BL		LengthStringSB			;getting length (in R2)
			MOVS	R3,#0					;counter
			SUBS	R2,R2,#1
R_Loop_01
			CMP		R3,R2
			BGE		M_DONE
			
			LDRB	R4,[R0,R3]				;gets closest to front
			LDRB	R5,[R0,R2]				;gets closest to end
			
			STRB	R5,[R0,R3]				;storing these values back together
			STRB	R4,[R0,R2]

			ADDS	R3,R3,#1
			SUBS	R2,R2,#1

			B		R_Loop_01

M_DONE
			POP		{R0-R5,PC}



;--------------------------- INIT -----------------------
Init										;copy and paste code initializing UART0
		PUSH { R1, R2, R3}
;Select MCGPLLCLK / 2 as UART0 clock source
		LDR R0,=SIM_SOPT2
		LDR R1,=SIM_SOPT2_UART0SRC_MASK
		LDR R2,[R0,#0]
		BICS R2,R2,R1
		LDR R1,=SIM_SOPT2_UART0_MCGPLLCLK_DIV2
		ORRS R2,R2,R1
		STR R2,[R0,#0]
;Enable external connection for UART0
		LDR R0,=SIM_SOPT5
		LDR R1,= SIM_SOPT5_UART0_EXTERN_MASK_CLEAR
		LDR R2,[R0,#0]
		BICS R2,R2,R1
		STR R2,[R0,#0]
;Enable clock for UART0 module
		LDR R0,=SIM_SCGC4
		LDR R1,= SIM_SCGC4_UART0_MASK
		LDR R2,[R0,#0]
		ORRS R2,R2,R1
		STR R2,[R0,#0]
;Enable clock for Port A module
		LDR R0,=SIM_SCGC5
		LDR R1,= SIM_SCGC5_PORTA_MASK
		LDR R2,[R0,#0]
		ORRS R2,R2,R1
		STR R2,[R0,#0]
;Connect PORT A Pin 1 (PTA1) to UART0 Rx (J1 Pin 02)
		LDR R0,=PORTA_PCR1
		LDR R1,=PORT_PCR_SET_PTA1_UART0_RX
		STR R1,[R0,#0]
;Connect PORT A Pin 2 (PTA2) to UART0 Tx (J1 Pin 04)
		LDR R0,=PORTA_PCR2
		LDR R1,=PORT_PCR_SET_PTA2_UART0_TX
		STR R1,[R0,#0]




;Disable UART0 receiver and transmitter
		LDR R0,=UART0_BASE
		MOVS R1,#UART0_C2_T_R
		LDRB R2,[R0,#UART0_C2_OFFSET]
		BICS R2,R2,R1
		STRB R2,[R0,#UART0_C2_OFFSET]
;Set UART0 for 9600 baud, 8N1 protocol
		MOVS R1,#UART0_BDH_9600
		STRB R1,[R0,#UART0_BDH_OFFSET]
		MOVS R1,#UART0_BDL_9600
		STRB R1,[R0,#UART0_BDL_OFFSET]  ;Somethign on here
		MOVS R1,#UART0_C1_8N1
		STRB R1,[R0,#UART0_C1_OFFSET]
		MOVS R1,#UART0_C3_NO_TXINV
		STRB R1,[R0,#UART0_C3_OFFSET]
		MOVS R1,#UART0_C4_NO_MATCH_OSR_16
		STRB R1,[R0,#UART0_C4_OFFSET]
		MOVS R1,#UART0_C5_NO_DMA_SSR_SYNC
		STRB R1,[R0,#UART0_C5_OFFSET]
		MOVS R1,#UART0_S1_CLEAR_FLAGS
		STRB R1,[R0,#UART0_S1_OFFSET]
		MOVS R1, \
		#UART0_S2_NO_RXINV_BRK10_NO_LBKDETECT_CLEAR_FLAGS
		STRB R1,[R0,#UART0_S2_OFFSET] 
		;Enable UART0 receiver and transmitter
		MOVS R1,#UART0_C2_T_R
		STRB R1,[R0,#UART0_C2_OFFSET] 
		
		POP { R1, R2, R3}
		
		BX	LR

;--------------------------- PUTCHAR -----------------------
PutChar									;copy and paste code of Putchar
		PUSH { R1, R2, R3 }
;Poll TDRE until UART0 ready to transmit
		LDR R1,=UART0_BASE
		MOVS R2,#UART0_S1_TDRE_MASK
PollTx 	LDRB R3,[R1,#UART0_S1_OFFSET]
		ANDS R3,R3,R2
		BEQ PollTx
;Transmit character stored in Ri
		STRB R0,[R1,#UART0_D_OFFSET] 

		POP { R1, R2, R3 }
		
		BX	LR

;--------------------------- GETCHAR -----------------------
GetChar									;copy and paste code of Getchar
		PUSH { R1, R2, R3 }
;Poll RDRF until UART0 ready to receive
		LDR R1,=UART0_BASE
		MOVS R2,#UART0_S1_RDRF_MASK
PollRx 	LDRB R3,[R1,#UART0_S1_OFFSET]
		ANDS R3,R3,R2
		BEQ PollRx
;Receive character and store in Ri
		LDRB R0,[R1,#UART0_D_OFFSET] 	
		POP { R1, R2, R3 }
		
		BX	LR		
		
	
		
;--------------------------- GETSTRINGSB -----------------------
GetStringSB		
		PUSH { R0 - R4, LR }
		MOVS	R3,#0				;initializing counter
		MOVS	R4,R0				;storing adress
		SUBS	R1,R1,#1			;subtracting buffer capacity
		
Loop1A								;super loop
		BL		GetChar				;checking if input is "enter"
		CMP 	R0, #CR
		BEQ		Enter				;branching if it is
		
		
		CMP		R1,R3				;checking if index = buffer cpacity
		BEQ		Skip				;if it is, skip
		STRB	R0,[R4,R3]			;otherwise store in adress with value (R0) at address (R4) offset of increment (R3)
		ADDS	R3,R3,#1			;incrementing counter


		BL		PutChar				;printing it
		B		Loop1A				;looping almost forever
		
Skip
		BL		GetChar				;triggered if buffercapacity over limit and ignores everything until enter is hit
		CMP 	R0, #CR
		BEQ		Enter
		B 		Skip
Enter								;if enter was hit
		MOVS	R0,#0				;storing '0' at end
		STRB	R0,[R4,R3]
		MOVS	R0,#CR				;printing new line
		BL		PutChar
		MOVS	R0,#LF
		BL		PutChar
		POP { R0 - R4, PC }
		
;--------------------------- LENGTHSTRINGSB -----------------------		
LengthStringSB
		PUSH { R1, R3, LR }

		MOVS	R2,#0				;initializing counter
		
Loop2
		LDRB	R3,[R0,R2]			;loading value in string
		CMP		R3,#0				;checking if '0', if it is, run away
		BEQ		Ende
		CMP		R2, R1				;checking if counter = buffercapacity, if it does, run away
		BEQ		Ende
		ADDS 	R2,R2, #1
	
		B		Loop2				;looping almost forver
Ende
		
		POP { R1, R3, PC }
		
;--------------------------- PUTNUMU -----------------------
;prints the number in decimal form in R0
PutNumU	
		PUSH { R0 - R2, LR }
		MOVS	R2,#0				;initializng counter
Loop3
		MOVS	R1, R0				;setting up for DIVU (R1 divedend, R0 divider)
		MOVS	R0, #10
		BL		DIVU				;calling DIVU
		PUSH 	{R1}				;storing in stack because it gets values in revers order
		ADDS	R2,R2,#1
		CMP		R0, #0				;checking done
		BEQ		Out					;if it is, end
		B		Loop3
		
Out
		POP		{R0}				;finishing up
		SUBS	R2,R2,#1
		ADDS	R0,R0,#'0'
		BL		PutChar
		CMP		R2,#0
		BEQ		Done4
		B		Out
		
Done4
		POP { R0 - R2, PC }
		

;--------------------------- PUTSTRINGSB -----------------------
;puts the string stored in R0
PutStringSB
		PUSH { R0, R1, R2, R3, LR }

		MOVS	R3,#0				;counter
		MOVS	R2,R0				;R2 gets adress
		
Loop4
		CMP		R3,R1				;compares counter with MAX SIZE
		BEQ		Ende2
		
		LDRB	R0,[R2,R3]			;loads value at R2 offset R3 into R0
		CMP		R0,#0				;checks if null terminator
		BEQ		Ende2
		
		BL		PutChar				;prints
		ADDS 	R3,R3, #1			;adds to counter
		
		B		Loop4
Ende2
		
		POP { R0, R1, R2, R3, PC }
		
		
;--------------------------- DIVU -----------------------
;takes in Diveded (R1) and Divisor (R0)

DIVU
			
			PUSH	{R2}			;Pushing R2 to save
			MOVS	R2,#0
			CMP		R0,#0			;checks if Divide by zero
			BEQ		DIV_BY_ZERO		
			
			
			
			CMP		R1,#0			;checks if Dividend is zero
			BEQ		EndIFF
			
While		CMP		R1,R0	 		;the main loop where Dividen is conitunually subtracted
			BLO		Endwhile		;by the Divider until Dividen is either 0 or less than
									;the Divider... R2 is used as the quotient
			SUBS	R1,R1,R0
			ADDS	R2,R2,#1
			
			B 		While
Endwhile
			MOVS	R0,R2
			
			

			
			
DIVU_DONE	POP		{R2}			;DIVU_DONE used when needed to return out of DIVU subroutine
			
			BX 		LR
			
				
DIV_BY_ZERO	MRS		R0,APSR			;Divide by zeros manually sets C flag to set
			MOVS	R1,#0x20
			LSLS	R1,R1,#24
			ORRS	R0,R0,R1
			MSR		APSR,R0
			B		DIVU_DONE
			
	
EndIFF		MRS		R0,APSR			;EndIFF manually sets C flag to clear if dividend is 0
			MOVS	R0,#0x20
			LSLS	R1,R1,#24
			BICS	R0,R0,R1
			MSR		APSR,R0
			MOVS	R0,#0
			
			B		DIVU_DONE
		

;>>>>>   end subroutine code <<<<<
            ALIGN
;****************************************************************
;Vector Table Mapped to Address 0 at Reset
;Linker requires __Vectors to be exported
            AREA    RESET, DATA, READONLY
            EXPORT  __Vectors
            EXPORT  __Vectors_End
            EXPORT  __Vectors_Size
            IMPORT  __initial_sp
            IMPORT  Dummy_Handler
__Vectors 
                                      ;ARM core vectors
            DCD    __initial_sp       ;00:end of stack
            DCD    Reset_Handler      ;01:reset vector
            DCD    Dummy_Handler      ;02:NMI
            DCD    Dummy_Handler      ;03:hard fault
            DCD    Dummy_Handler      ;04:(reserved)
            DCD    Dummy_Handler      ;05:(reserved)
            DCD    Dummy_Handler      ;06:(reserved)
            DCD    Dummy_Handler      ;07:(reserved)
            DCD    Dummy_Handler      ;08:(reserved)
            DCD    Dummy_Handler      ;09:(reserved)
            DCD    Dummy_Handler      ;10:(reserved)
            DCD    Dummy_Handler      ;11:SVCall (supervisor call)
            DCD    Dummy_Handler      ;12:(reserved)
            DCD    Dummy_Handler      ;13:(reserved)
            DCD    Dummy_Handler      ;14:PendableSrvReq (pendable request 
                                      ;   for system service)
            DCD    Dummy_Handler      ;15:SysTick (system tick timer)
            DCD    Dummy_Handler      ;16:DMA channel 0 xfer complete/error
            DCD    Dummy_Handler      ;17:DMA channel 1 xfer complete/error
            DCD    Dummy_Handler      ;18:DMA channel 2 xfer complete/error
            DCD    Dummy_Handler      ;19:DMA channel 3 xfer complete/error
            DCD    Dummy_Handler      ;20:(reserved)
            DCD    Dummy_Handler      ;21:command complete; read collision
            DCD    Dummy_Handler      ;22:low-voltage detect;
                                      ;   low-voltage warning
            DCD    Dummy_Handler      ;23:low leakage wakeup
            DCD    Dummy_Handler      ;24:I2C0
            DCD    Dummy_Handler      ;25:I2C1
            DCD    Dummy_Handler      ;26:SPI0 (all IRQ sources)
            DCD    Dummy_Handler      ;27:SPI1 (all IRQ sources)
            DCD    Dummy_Handler      ;28:UART0 (status; error)
            DCD    Dummy_Handler      ;29:UART1 (status; error)
            DCD    Dummy_Handler      ;30:UART2 (status; error)
            DCD    Dummy_Handler      ;31:ADC0
            DCD    Dummy_Handler      ;32:CMP0
            DCD    Dummy_Handler      ;33:TPM0
            DCD    Dummy_Handler      ;34:TPM1
            DCD    Dummy_Handler      ;35:TPM2
            DCD    Dummy_Handler      ;36:RTC (alarm)
            DCD    Dummy_Handler      ;37:RTC (seconds)
            DCD    Dummy_Handler      ;38:PIT (all IRQ sources)
            DCD    Dummy_Handler      ;39:I2S0
            DCD    Dummy_Handler      ;40:USB0
            DCD    Dummy_Handler      ;41:DAC0
            DCD    Dummy_Handler      ;42:TSI0
            DCD    Dummy_Handler      ;43:MCG
            DCD    Dummy_Handler      ;44:LPTMR0
            DCD    Dummy_Handler      ;45:Segment LCD
            DCD    Dummy_Handler      ;46:PORTA pin detect
            DCD    Dummy_Handler      ;47:PORTC and PORTD pin detect
				
				
		
__Vectors_End
__Vectors_Size  EQU     __Vectors_End - __Vectors
            ALIGN
;****************************************************************
;Constants
            AREA    MyConst,DATA,READONLY
;>>>>> begin constants here <<<<<
InitString	DCB	 "Enter a string command (g,h,m,p,r): ",0

InvalidC	DCB	 ":Invalid command",0

InitialC	DCB  "Initial String",0

Failure		DCB	"Failure: ",0

Success		DCB	"Success: ",0

Ln			DCB	"In=0x",0

Status		DCB	"Status:",0

Help		DCB "g (get), h (help), m (modify), p (print), r (reverse)",0

OUT			DCB	" Out=0x",0

Length		DCB "Length:",0

Num			DCB	" Num=",0

CTE			DCB	"Character to enqueue:",0

DQGDS		DCB	":        ",0
;>>>>>   end constants here <<<<<


          



            ALIGN
;****************************************************************
;Variables
            AREA    MyData,DATA,READWRITE
;>>>>> begin variables here <<<<<


String			SPACE	79
Initial_String	SPACE	79
;>>>>>   end variables here <<<<<
            ALIGN
            END