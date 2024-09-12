;Exercise 06
;****************************************************************
;Exercies 5 which is usesd to demonstrate chrypotographic
;and decifering techniques
;Name:  Joel Yuhas
;Date:  3/10/2016
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
;NVIC_ICER
;31-00:CLRENA=masks for HW IRQ sources;
;             read:   0 = unmasked;   1 = masked
;             write:  0 = no effect;  1 = mask
;12:UART0 IRQ mask
NVIC_ICER_UART0_MASK  EQU  UART0_IRQ_MASK
;---------------------------------------------------------------
;NVIC_ICPR
;31-00:CLRPEND=pending status for HW IRQ sources;
;             read:   0 = not pending;  1 = pending
;             write:  0 = no effect;
;                     1 = change status to not pending
;12:UART0 IRQ pending status
NVIC_ICPR_UART0_MASK  EQU  UART0_IRQ_MASK
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
UART0_C2_T_R    EQU  (UART0_C2_TE_MASK :OR: UART0_C2_RE_MASK)
UART0_C2_T_RI   EQU  (UART0_C2_RIE_MASK :OR: UART0_C2_T_R)
UART0_C2_TI_RI  EQU  (UART0_C2_TIE_MASK :OR: UART0_C2_T_RI)
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
;---------------------------------------------------------------






;---------------------------------------------------------------
;NVIC_ICPR
;31-00:CLRPEND=pending status for HW IRQ sources;
;             read:   0 = not pending;  1 = pending
;             write:  0 = no effect;
;                     1 = change status to not pending
;22:PIT IRQ pending status
;12:UART0 IRQ pending status
NVIC_ICPR_PIT_MASK    EQU  PIT_IRQ_MASK
;---------------------------------------------------------------
;NVIC_IPR0-NVIC_IPR7
;2-bit priority:  00 = highest; 11 = lowest
;--PIT
PIT_IRQ_PRIORITY    EQU  0
NVIC_IPR_PIT_MASK   EQU  (3 << PIT_PRI_POS)
NVIC_IPR_PIT_PRI_0  EQU  (PIT_IRQ_PRIORITY << UART0_PRI_POS)
;--UART0
UART0_IRQ_PRIORITY    EQU  3
NVIC_IPR_UART0_MASK   EQU  (3 << UART0_PRI_POS)
NVIC_IPR_UART0_PRI_3  EQU  (UART0_IRQ_PRIORITY << UART0_PRI_POS)
;---------------------------------------------------------------
;NVIC_ISER
;31-00:SETENA=masks for HW IRQ sources;
;             read:   0 = masked;     1 = unmasked
;             write:  0 = no effect;  1 = unmask
;22:PIT IRQ mask
;12:UART0 IRQ mask
NVIC_ISER_PIT_MASK    EQU  PIT_IRQ_MASK
NVIC_ISER_UART0_MASK  EQU  UART0_IRQ_MASK
;---------------------------------------------------------------
;PIT_LDVALn:  PIT load value register n
;31-00:TSV=timer start value (period in clock cycles - 1)
;Clock ticks for 0.01 s at 24 MHz count rate
;0.01 s * 24,000,000 Hz = 240,000
;TSV = 240,000 - 1
PIT_LDVAL_10ms  EQU  239999
;---------------------------------------------------------------
;PIT_MCR:  PIT module control register
;1-->    0:FRZ=freeze (continue'/stop in debug mode)
;0-->    1:MDIS=module disable (PIT section)
;               RTI timer not affected
;               must be enabled before any other PIT setup
PIT_MCR_EN_FRZ  EQU  PIT_MCR_FRZ_MASK
;---------------------------------------------------------------
;PIT_TCTRLn:  PIT timer control register n
;0-->   2:CHN=chain mode (enable)
;1-->   1:TIE=timer interrupt enable
;1-->   0:TEN=timer enable
PIT_TCTRL_CH_IE  EQU  (PIT_TCTRL_TEN_MASK :OR: PIT_TCTRL_TIE_MASK)
;---------------------------------------------------------------
;Port D
PTD5_MUX_GPIO EQU (1 << PORT_PCR_MUX_SHIFT)
SET_PTD5_GPIO EQU (PORT_PCR_ISF_MASK :OR: \
PTD5_MUX_GPIO)
;Port E
PTE29_MUX_GPIO EQU (1 << PORT_PCR_MUX_SHIFT)
SET_PTE29_GPIO EQU (PORT_PCR_ISF_MASK :OR: \
PTE29_MUX_GPIO)
POS_RED EQU 29
POS_GREEN EQU 5
LED_RED_MASK EQU (1 << POS_RED)
LED_GREEN_MASK EQU (1 << POS_GREEN)
LED_PORTD_MASK EQU LED_GREEN_MASK
LED_PORTE_MASK EQU LED_RED_MASK



One_Thousand_One_Hundred	EQU	1100
One_Hundred					EQU	100


CR			EQU			0x0D
LF			EQU			0x0A
SPECIAL		EQU			0x0F

MAX_STRING	EQU			79
	
LargeNumber	EQU		753
	
IN_PTR 		EQU		0
OUT_PTR		EQU		4
BUF_STRT	EQU		8
BUF_PAST	EQU		12
BUF_SIZE	EQU		16
NUM_ENQD	EQU		17
	
	
Q_BUF_SZ	EQU		4	
TRxQ_BUF_SZ	EQU		80
Q_REC_SZ	EQU		18
	

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
0            CPSID   I
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


;-----**NEW**----
;----------UART0_ISR
;----------Init_UART_IRQ
;----------PutNumSB
;
;the program also used a number of other subroutines that allowed it
;to read in the input of the useer


;>>>>> begin main program code <<<<<	
;-------------------------------------------------------------
		;UART Initilization and LEd intiilzation
			BL		Init_UART0_IRQ			
			BL		LED_INIT				
START
;-------------------------------------------------------------
		;Stop Watch Initilization
			LDR   	R0,=RunStopWatch		
			MOVS	R1,#0
			STRB	R1,[R0,#0]
			
			LDR		R0,=Count
			MOVS	R1,#0
			STR		R1,[R0,#0]
			MOVS	R6,#0
			
;-------------------------------------------------------------	
		;random number initialization
			LDR		R0,=Random				
			MOVS	R1,#0
			STR 	R1,[R0,#0]
			
;-------------------------------------------------------------		
		;round number intitlization
			LDR		R0,=Round_Number		
			MOVS	R1,#1
			STR 	R1,[R0,#0]

;-------------------------------------------------------------	
		;scroe itnitialization
			LDR		R0,=Score				;initializing score with 0
			MOVS	R1,#0
			STRB	R1,[R0,#0]

;-------------------------------------------------------------	
		;initialzing time requirment
			LDR		R0,=Time_Requirment		
			LDR		R1,=One_Thousand_One_Hundred
			STR		R1,[R0,#0]
			
;-------------------------------------------------------------	
		;printing out initial stamtnets
			MOVS	R1,#MAX_STRING			
			LDR		R0,=InitString1
			BL		PutStringSB
			
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			LDR		R0,=InitString2
			BL		PutStringSB
			
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar

			LDR		R0,=THEGAME1
			BL		PutStringSB
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			LDR		R0,=THEGAME2
			BL		PutStringSB
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			LDR		R0,=THEGAME3
			BL		PutStringSB
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			LDR		R0,=THEGAME4
			BL		PutStringSB
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			LDR		R0,=THEGAME5
			BL		PutStringSB
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			LDR		R0,=THEGAME6
			BL		PutStringSB
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar

;-------------------------------------------------------------		
		;waiting fro user input
			BL		GetChar					
			
			LDR		R0,=GO
			BL		PutStringSB
			
			MOVS	R0,#CR					;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
User_Has_Inputed	

;-------------------------------------------------------------	
		;begin
			BL		Init_PIT_IRQ
			CPSIE   I
			
;-------------------------------------------------------------				
Loop										;infinite loop 
			
			LDR		R0,=Round_Number		;printing round number
			LDRB	R1,[R0,#0]	
			
			CMP		R1,#11					;if 10 then we done
			BEQ		ALLDONE1
		
			BL		RandomLED				;getting random LED number putting it in LED_Color

;-------------------------------------------------------------	
		;printing out the round number
			MOVS	R1,#MAX_STRING					
			LDR		R0,=LoopString			;loading the loop string "round"
			BL		PutStringSB
		
			LDR		R0,=Round_Number		;printing round number
			LDRB	R1,[R0,#0]
			
			CMP		R1,#9
			BLS		BelowNine				;branching if above nine because special case
			MOVS	R0,#49
			BL		PutChar	
			MOVS	R0,#48
			BL		PutChar	
			B		AboveNine		 		;skipping over old
BelowNine
			MOVS	R0,#'0'
			BL		PutChar	
			ADDS	R1,R1,#48
			MOVS	R0,R1
			BL		PutChar
AboveNine			
			CMP		R1,#11					;if 10 then we done
			BEQ		ALLDONE1
	
			LDR		R0,=Round_Number		;printing round number		
			LDRB	R1,[R0,#0]				;checking if wrong number or round redo
			LDR		R0,=Round_Number_Prev	;printing round number
			LDRB	R2,[R0,#0]	
	
			CMP		R1,R2
			BEQ		SuperSkip				;skips if the round number same as last	
			
			
			LDR		R0,=Count				;reseting the timer count value
			MOVS	R1,#0
			STR		R1,[R0,#0]
	
SuperSkip

			MOVS	R0,#'>'					;printing a '>'
			BL		PutChar

			LDR 	R0,=RunStopWatch		;starting the stop watch
			MOVS	R1,#1
			STRB	R1,[R0,#0]
			
;-------------------------------------------------------------	
			MOVS	R6,#0					;initialzing R6 which is used by PIT_ISR
Loop_Wait									;the loop that waits for the user to input a value
			CMP		R6,#2
			BEQ		TIME_EXPIRED
			CMP		R6,#1					;R6, will be modified by PIT_ISR
			BNE		Loop_Wait				;PIT_ISR will also return user inptu through R7
			
			B		Skip_Time
			
TIME_EXPIRED
			MOVS	R0,#'x'
			BL		PutChar
			MOVS	R0,#':'
			BL		PutChar

			MOVS	R1,#MAX_STRING	
			LDR		R0,=OutOfTime 			;printing "out of time, color was: "
			BL		PutStringSB
		
			BL		PrintColor				;printing the name of the color
		
			BL		EndofRoundCalc
			BL		ScoreCalc
			MOVS	R0,#CR					;New Line
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			B		Loop					;going back to round			
ALLDONE1
			B		ALLDONE					;done because too long
START1
			B		START
		
Skip_Time		
			
	;after this point, the program has recived user input
			MOVS	R0,R7				; moving user input into R0, value still in R7 tho
			BL		PutChar
			
	;converting the user input into a value 0-3
			CMP		R0,#'g'				
			BEQ		Green
			CMP		R0,#'r'
			BEQ		Red
			CMP		R0,#'b'
			BEQ		Both
			CMP		R0,#'n'
			BEQ		None
			B		BitchMessedUp
;-------------------------------------------------------------	
	;reqirments for the LED choice
	;			none = 0 
	;			green = 1
	;			red = 2
	; 			both = 3
None
			MOVS	R1,#0
			LDR		R0,=LED_Choice
			STRB	R1,[R0,#0]
			B		Done_Color
Green
			MOVS	R1,#1
			LDR		R0,=LED_Choice
			STRB	R1,[R0,#0]
			B		Done_Color
Red
			MOVS	R1,#2
			LDR		R0,=LED_Choice
			STRB	R1,[R0,#0]
			B		Done_Color
Both
			MOVS	R1,#3
			LDR		R0,=LED_Choice
			STRB	R1,[R0,#0]
			B		Done_Color

BitchMessedUp
			MOVS	R1,#5
			LDR		R0,=LED_Choice
			STRB	R1,[R0,#0]
			B		Done_Color


Done_Color
;-------------------------------------------------------------	
		;R7 now has the user inputed value	
		;printing the value and amount of time it took for user to input a number	
		
		;getting the color of the LED and comparing it with the inputed value
			LDR		R0,=LED_Color
			LDRB	R1,[R0,#0]
			
			LDR		R0,=LED_Choice
			LDRB	R7,[R0,#0]
			
			CMP		R7,R1		;checking if the two are equal
			BEQ		Correct

;-------------------------------------------------------------
		;if at this point, then they were the wrong color
Incorrect
			MOVS	R0,#':'
			BL		PutChar
			
			MOVS	R1,#MAX_STRING	
			LDR		R0,=Wrong					;printing that you were wrong
			BL		PutStringSB
		
			MOVS	R0,#1
			BL		ScoreCalc
			
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			LDR		R0,=Round_Number		;printing round number
			LDRB	R2,[R0,#0]
			
			LDR		R0,=Round_Number_Prev		;printing round number
			STRB	R2,[R0,#0]
			
			B		Loop

Correct
	;up to this point, the user color input and the color match, and since the time has not expired,
			MOVS	R0,#':'
			BL		PutChar
			
			MOVS	R1,#MAX_STRING	
			LDR		R0,=CorrectColor 			;printing "correct--color was: "
			BL		PutStringSB
			
			BL		PrintColor
			
			BL		EndofRoundCalc
			
			MOVS	R0,#0
			BL		ScoreCalc
			
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			B		Loop
			
	;if at this point, then the game has finished
ALLDONE
			MOVS	R1,#MAX_STRING
			LDR		R0,=Congradulations			;printing "congradulations!"
			BL		PutStringSB
			
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			MOVS	R1,#MAX_STRING
			LDR		R0,=FinishedWith			;printing "you finished with: "
			BL		PutStringSB
			
			LDR		R0,=Score
			LDR		R0,[R0,#0]					;loading value of score
			BL		PutNumU
			
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			MOVS	R1,#MAX_STRING				;"play again? [y/n]"
			LDR		R0,=PlayAgain
			BL		PutStringSB
			
			BL		GetChar
			CMP		R0,#'y'						;if the user enters 'y; then restart
			BEQ		START2
			
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			MOVS	R1,#MAX_STRING
			LDR		R0,=Quiting
			BL		PutStringSB
			
			LDR		R0,=Count
			MOVS	R1,#0
			STR		R1,[R0,#0]
			MOVS	R6,#0
			
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			B       .
			
;----------------------------------------------
		;used if want to restart
START2
			MOVS	R0,#CR						;Moves to the new line, all the way to the left
			BL		PutChar
			MOVS	R0,#LF
			BL		PutChar
			
			B		START1

			ALIGN
			LTORG


;>>>>> begin subroutine code <<<<<
;Inputs		Time_Requirment varibale and Score varibale
;Outputs	modifies score variable
;Description
EndofRoundCalc
			PUSH	{R0-R6,LR}
			LDR		R0,=Time_Requirment			;Loading Time Requirment
			LDR		R1,[R0,#0]
			
			LDR		R2,=One_Hundred				
						
			CMP		R2,R1						;Checkign time requirment and the time decrementor
			BEQ		NoMoreRounds				;if they are the same, then have reached maximum number of rounds
;-------------------------------------------------------------
		;decrementing the new amonunt of time and the new round number
			SUBS	R1,R1,R2					;decrements Time Reqirment
			STR		R1,[R0,#0]
			
			LDR		R0,=Round_Number			;loads round number
			LDRB	R1,[R0,#0]
			ADDS	R1,R1,#1					;intecrementing Round Number
			STRB	R1,[R0,#0]
	
NoMoreRounds	
;-------------------------------------------------------------						;calculating score
		;printing the goods
			MOVS	R1,#MAX_STRING	
			LDR		R0,=Entered						;printing ("time of")
			BL		PutStringSB

			LDR		R0,=Count
			LDR		R0,[R0,#0]
			BL		PutNumU
			
			LDR		R0,=TimeUnit					;printing ("ms" for the seconds units)
			MOVS	R1,#MAX_STRING	
			BL		PutStringSB
			
			
			POP{R0-R6,PC}
;------------------------------------------------------------
;takes in R0
;if R0 = 1 then subtracts 200 from score
;if R0 = 0 then adds to the score
;changes the score variable in memory
ScoreCalc
			PUSH	{R1-R5,LR}
			
			LDR		R1,=Count					;loading time
			LDR		R1,[R1,#0]
			
			LDR		R2,=Round_Number			;loading round number
			LDR		R2,[R2,#0]
			
			LDR		R3,=One_Hundred
			
			CMP		R0,#1						;if 1 then subtract
			BEQ		SubtractMotherFucker
			
			MULS	R2,R3,R2					;round number = round number * 100
			MULS	R2,R3,R2					;round number = round number * 100	
				
			MOVS	R0,R1						;Divisor = Count
			MOVS	R1,R2						;Dividen = Round
			BL		DIVU						;round/time
		
			MOVS	R1,R0
			MOVS	R0,#3
			BL		DIVU
			
			MOVS	R1,R0
			
			LDR		R0,=Score
			LDR		R2,[R0,#0]					;loading value of score
			ADDS	R2,R2,R1					;Score = Score + (round/time)*100
			STR		R2,[R0,#0]					;storing value back
			
			B		DoneSub
			
;------------------------------------------------------------
SubtractMotherFucker
			MOVS	R2,#200						;subtracts by 200 if wrong
			
			LDR		R0,=Score
			LDR		R3,[R0,#0]					;loading value of score
			
			CMP		R3,R2						;if Score < subtracting then special
			BLO		LowerSub
			SUBS	R3,R3,R2
			STR		R3,[R0,#0]	
			
			B		DoneSub
			
LowerSub	
			MOVS 	R2,#0
			STR		R2,[R0,#0]	
			
;------------------------------------------------------------
DoneSub	
			MOVS	R1,#MAX_STRING
			LDR		R0,=ScoreIs					;printing "score is: "
			BL		PutStringSB
			
			LDR		R0,=Score
			LDR		R2,[R0,#0]					;loading value of score
			
			MOVS	R0,R2						;printing score
			BL		PutNumU
			
;------------------------------------------------------------
			POP		{R1-R5,PC}

			ALIGN
			LTORG
;-----------------------------------PIT-ISR---------------------------------
;the interrupt handler that is called by the vector table
;Address for RxQueue
;returns the entered value in R7
;if there has been sucessful input, R6 will be 1
PIT_ISR	
		PUSH	{R0-R5,LR}
		LDR		R0,=RunStopWatch
		LDRB	R1,[R0,#0]
		
IF_PIT
		CMP		R1,#0
		BEQ		Done_PIT
		
	;need to get RXQueue
	;if num enqued = 1 then somethign has been psuhed
	;if so, stop the stop watch, call get char
		
		LDR		R5,=RxQRecord		
		LDRB	R6,[R5,#NUM_ENQD]		;getting number enqued of the goods
		CMP		R6,#1
		BGE		PIT_ENQ					;branching if there is someting in the queue
		
		
		LDR		R0,=Count
		LDR		R2,[R0,#0]
	
		
		LDR		R1,=Time_Requirment		;loading the amount of time each round can take
		LDR		R3,[R1,#0]
		
		CMP 	R3,R2					;checking if there is enough round time 
		BEQ		TimeExp
		
		ADDS	R2,R2,#1
		STR		R2,[R0,#0]
		
Done_PIT
	;Clearing interrupt
		LDR		R0,=PIT_CH0_BASE
		LDR		R1,=PIT_TFLG_TIF_MASK
		STR		R1,[R0,#PIT_TFLG_OFFSET]
		
		POP		{R0-R5,PC}

PIT_ENQ
		LDR  	R2,=RunStopWatch	;stopping the stop watch
		MOVS	R1,#0
		STRB	R1,[R2,#0]
		BL		GetChar
		MOVS	R7,R0
		MOVS	R6,#1
		
		B		Done_PIT			;finishing up
		

TimeExp
	;print out if time experied
	;here have the restart and goods,
	;now will just go back to beggining
		LDR  	R2,=RunStopWatch	;stopping the stop watch
		MOVS	R1,#0
		STRB	R1,[R2,#0]
		
		MOVS	R6,#2				;R6 gets 2 if failure
		
		B		Done_PIT			;finishing up

		POP		{R0-R5,PC}
		
		ALIGN
		LTORG
		
;--------------------------------RandomLED--------------------
RandomLED
	;selects random number 0 - 3
	;returns changes the variable LED_Color
	;none is 0
	;green is 1
	;red is 2
	;both is 3
		PUSH	{R1-R5,LR}
	
		LDR		R0,=Random
		LDR		R1,[R0,#0]
		MOVS	R7,R1
		
		ADDS	R1,R1,#7			;(seed + 7)
		
		MOVS	R2,#34				;(seed + 7)*34
		MULS	R1,R2,R1
		
		MOVS	R0,#5				
		BL		DIVU				;((seed + 7)*34)/5
		
		LDR		R2,=LargeNumber		;(((seed + 7)*34)/5)*753
		MULS	R0,R2,R0
		
		ADDS	R0,R0,#13			;(((seed + 7)*34)/5)*753)+13
		
		LSRS	R0,R0,#2			;((((seed + 7)*34)/5)+13)*753)>>2
		MOVS	R2,R0
		
		MOVS	R1,#0x0000000F		;((((((seed + 7)*34)/5)+13)>>2) EORS 0x00f0F0F) AND 0x0000000F
		ANDS	R3,R1
		MOVS	R1,#0x000000F0		;((((((seed + 7)*34)/5)+13)>>2) EORS 0x00f0F0F) AND 0x0000000F
		ANDS	R2,R1
		LSRS	R2,R1,#1
		ADDS	R3,R2,R3
			
		MOVS	R1,R3
		MOVS	R0,#2	

		BL		DIVU				;taking all and dividing by 4
		MOVS	R1,R0
		
		MOVS	R1,#0x0000000F		;((((((seed + 7)*34)/5)+13)>>2) EORS 0x00f0F0F) AND 0x0000000F
		ANDS	R0,R1

		LDR		R5,=Count
		LDR		R5,[R5,#0]
		
		ADDS	R0,R5,R0
		
		MOVS	R1,#0x0000000F		;((((((seed + 7)*34)/5)+13)>>2) EORS 0x00f0F0F) AND 0x0000000F
		ANDS	R0,R1
		
		CMP		R0,#3
		BLS		DUBILDBYDONE
			
GOBACK		
			
		SUBS	R0,R0,#4	
		
		CMP		R0,#4
		BGT		GOBACK


DUBILDBYDONE

		MOVS	R1,R0

		LDR		R0,=Random			;storing back
		STR 	R1,[R0,#0]
		
		LDR		R0,=LED_Color		;storing in color
		STRB	R1,[R0,#0]	
		
		CMP	R1,#0
		BEQ	None_Rand
		CMP	R1,#1
		BEQ	Green_Rand
		CMP R1,#2
		BEQ	Red_Rand
		CMP R1,#3
		BEQ	Both_Rand
		
None_Rand
	;Turn off red LED
		LDR R0,=FGPIOE_BASE
		LDR R1,=LED_RED_MASK
		STR R1,[R0,#GPIO_PSOR_OFFSET]

	;Turn off green LED
		LDR R0,=FGPIOD_BASE
		LDR R1,=LED_GREEN_MASK
		STR R1,[R0,#GPIO_PSOR_OFFSET]
		
		B	Done_Rand
		
Green_Rand
	;Turn off red LED
		LDR R0,=FGPIOE_BASE
		LDR R1,=LED_RED_MASK
		STR R1,[R0,#GPIO_PSOR_OFFSET]
		
	;Turn on green LED
		LDR R0,=FGPIOD_BASE
		LDR R1,=LED_GREEN_MASK
		STR R1,[R0,#GPIO_PCOR_OFFSET]

		B	Done_Rand
Red_Rand
	;Turn off green LED
		LDR R0,=FGPIOD_BASE
		LDR R1,=LED_GREEN_MASK
		STR R1,[R0,#GPIO_PSOR_OFFSET]
		
	;Turn on red LED
		LDR R0,=FGPIOE_BASE
		LDR R1,=LED_RED_MASK
		STR R1,[R0,#GPIO_PCOR_OFFSET]
		
		B	Done_Rand

Both_Rand

	;Turn on red LED
		LDR R0,=FGPIOE_BASE
		LDR R1,=LED_RED_MASK
		STR R1,[R0,#GPIO_PCOR_OFFSET]
		
	;Turn on green LED
		LDR R0,=FGPIOD_BASE
		LDR R1,=LED_GREEN_MASK
		STR R1,[R0,#GPIO_PCOR_OFFSET]		
		
		B	Done_Rand
		
Done_Rand

		POP		{R1-R5,PC}


		ALIGN
		LTORG
;-----------------------------PrintColor------------------
PrintColor
			PUSH	{R0-R5,LR}
			LDR		R0,=LED_Color
			LDRB	R0,[R0,#0]		;number of color now in R0
			
			CMP		R0,#1				
			BEQ		GreenP
			CMP		R0,#2
			BEQ		RedP
			CMP		R0,#3
			BEQ		BothP
			CMP		R0,#0
			BEQ		NoneP

NoneP
			LDR		R0,=None_Word
			BL		PutStringSB
			B		Done_ColorP
GreenP
			LDR		R0,=Green_Word
			BL		PutStringSB
			B		Done_ColorP
RedP
			LDR		R0,=Red_Word
			BL		PutStringSB
			B		Done_ColorP
BothP
			LDR		R0,=Both_Word
			BL		PutStringSB
			B		Done_ColorP

Done_ColorP

			POP		{R0-R5,PC}

;-----------------------------LEDINIT------------------
LED_INIT
			PUSH	{R0-R6,LR}
		;Enable clock for PORT D and E modules
			LDR R0,=SIM_SCGC5
			LDR R1,=(SIM_SCGC5_PORTD_MASK)
			LDR R2,[R0,#0]
			ORRS R2,R2,R1
			STR R2,[R0,#0]
		;Enable clock for PORT D and E modules
			LDR R0,=SIM_SCGC5
			LDR R1,=(SIM_SCGC5_PORTE_MASK)
			LDR R2,[R0,#0]
			ORRS R2,R2,R1
			STR R2,[R0,#0]
		;Select PORT E Pin 29 for GPIO to red LED
			LDR R0,=PORTE_BASE
			LDR R1,=SET_PTE29_GPIO
			STR R1,[R0,#PORTE_PCR29_OFFSET]
		;Select PORT D Pin 5 for GPIO to green LED
			LDR R0,=PORTD_BASE
			LDR R1,=SET_PTD5_GPIO
			STR R1,[R0,#PORTD_PCR5_OFFSET]
			LDR R0,=FGPIOD_BASE
			LDR R1,=LED_PORTD_MASK
			STR R1,[R0,#GPIO_PDDR_OFFSET]
			LDR R0,=FGPIOE_BASE
			LDR R1,=LED_PORTE_MASK
			STR R1,[R0,#GPIO_PDDR_OFFSET]
			POP		{R0-R6,PC}


;-----------------------------------------------------------------
;#################################################################
;--------------------------------ALL OLD CODE---------------------
;#################################################################
;-----------------------------------------------------------------

;--------------------------------CompareString--------------------
;recives R0 and R1
;compares the strings

CompareString
			PUSH{R2-R7,LR}
			MOVS	R4,#0
			MOVS	R6,R0
			MOVS	R5,R1
			
			BL		LengthStringSB
			
			MOVS	R7,R2				;R7 now has length of string in R0
			MOVS	R0,R1
			
			BL		LengthStringSB
			MOVS	R5,R2				;R5 now has length of string in R1
			
			MOVS	R0,R6				;R0 has R0 again
										;R1 always has R1
										
			CMP		R5,R7				;checking if the lengths of the two are equal
			BNE		Fail_CS				;if not equal then fail
			
Loop_CS

			LDRB	R2,[R0,R4]	
			LDRB	R3,[R1,R4]	
			
			
			CMP		R2,R3				;compare the things loaded
			BNE		Fail_CS				;if not eual then fail
				
			CMP		R2,#0				;checking to see if null terminate
			BEQ		Success_CS
				
			ADDS	R4,R4,#1			;increments counter
			
			B	Loop_CS

Fail_CS	
			MOVS	R2,R1				;preserving R1
			MRS		R0,APSR				;manually sets C flag to set
			MOVS	R1,#0x20
			LSLS	R1,R1,#24
			ORRS	R0,R0,R1
			MSR		APSR,R0
			
			MOVS	R0,R6				;converting back
			MOVS	R1,R2
			
			B		Done_CS

Success_CS
			MRS		R0,APSR				; sets C flag to clear
			MOVS	R0,#0x20
			LSLS	R1,R1,#24
			BICS	R0,R0,R1
			MSR		APSR,R0
			
			MOVS	R0,R6				;converting back
Done_CS
			POP{R2-R7,PC}
		
;-------------------------------- InitQueue ------------------------------
;initilizes the queue, R1 must be queue record, can be used for multiple
;queues
InitQueue
		PUSH	{R0,LR}

		STR		R0,[R1,#IN_PTR]
		STR		R0,[R1,#OUT_PTR]
		STR		R0,[R1,#BUF_STRT]
		ADDS	R0,R0,R2
		STR		R0,[R1,#BUF_PAST]
		STRB	R2,[R1,#BUF_SIZE]
		MOVS	R0,#0
		STRB	R0,[R1,#NUM_ENQD]

		POP		{R0,PC}
		
;-------------------------------- DeQueue --------------------------------
;R1	Address of Queue record structure
;C flag succes(0)
;the deuque subrotine, dequeus and advances the pointer
DeQueue
		PUSH	{R1-R7,LR}
		
		LDRB	R4,[R1,#NUM_ENQD]			;loading values
		LDR		R5,[R1,#IN_PTR]
		LDR		R6,[R1,#BUF_STRT]
		LDR		R7,[R1,#OUT_PTR]
		LDR		R3,[R1,#BUF_PAST]
		
		CMP		R4,#0						;checks if size is zero
		BEQ		Failed_Dequeue
		LDRB	R2,[R7,#0]
		
		ADDS	R7,R7,#1
		SUBS	R4,R4,#1
		
		STRB	R4,[R1,#NUM_ENQD]			;storing back into loacation
		STR		R7,[R1,#OUT_PTR]
		
		CMP		R7,R3
		BEQ		InPointer_Bigger2			;if pointer procgressing past buffer limit,
											;then advacne back
Done_Success		
		MRS		R0,APSR						; sets C flag to clear
		MOVS	R0,#0x20
		LSLS	R1,R1,#24
		BICS	R0,R0,R1
		MSR		APSR,R0
		MOVS	R0,R2
			
DoneD1
		POP		{R1-R7,PC}
		
Failed_Dequeue
	;Unsuccesfull
		MRS		R0,APSR						;manually sets C flag to set
		MOVS	R1,#0x20
		LSLS	R1,R1,#24
		ORRS	R0,R0,R1
		MSR		APSR,R0
		B 		DoneD1

InPointer_Bigger2
		MOVS	R7,R6						;manually moving the pointer back to start
		STR		R7,[R1,#OUT_PTR]
		B Done_Success
		

;--------------------------------- EnQueue ------------------------------------
;R0	Character to enqueue
;R1	Address of Queue record structure
;C flag succes(0)
;Enqueues the recived value and advances
Enqueue
		
		PUSH	{R0-R6,LR}
		
		LDRB	R3,[R1,#BUF_SIZE]			;initializing the queue structure
		LDRB	R4,[R1,#NUM_ENQD]
		LDR		R5,[R1,#IN_PTR]
		LDR		R6,[R1,#BUF_STRT]
		LDR		R7,[R1,#BUF_PAST]
		
		
		CMP		R4,R3
		BEQ		Failed_Enqueue				;fails if the queue is full
		STRB	R0,[R5,#0]					;stores value
		ADDS	R5,R5,#1					;advances counters
		ADDS	R4,R4,#1
			
		STR		R5,[R1,#IN_PTR]				;stores back
		STRB	R4,[R1,#NUM_ENQD]
		
		CMP		R5,R7
		BEQ		InPointer_Bigger1			;if inpointer reaches end of the queue, go back
		
Done
		MRS		R0,APSR						; sets C flag to clear
		MOVS	R0,#0x20
		LSLS	R1,R1,#24
		BICS	R0,R0,R1
		MSR		APSR,R0
		MOVS	R0,#0
			

		POP		{R0-R6,PC}

InPointer_Bigger1							;if the inpointer is bigger, manually set it back
		MOVS	R5,R6
		STR		R5,[R1,#IN_PTR]
		B Done
		
Failed_Enqueue
		MRS		R0,APSR			; manually sets C flag to set
		MOVS	R1,#0x20
		LSLS	R1,R1,#24
		ORRS	R0,R0,R1
		MSR		APSR,R0
		POP		{R0-R6,PC}
		
;---------------------------- PutNumHex----------------------
;takes in value at R0
;doesnt output any values
;converts address into hex value, prints to terminal
PutNumHex				
		PUSH 	{R0-R5,LR}
	
		MOVS	R2,#28				;defining constants that will need to be added
		MOVS	R3,#0x0000000F			
		MOVS	R4,R0
		MOVS	R5,#8
		
Loop_PNH
		
		LSRS	R0,R0,R2			;shifiting by how much we need
		ANDS	R0,R3
		CMP		R0,#9
		BLS		Number_PNH			;checks if number
		ADDS	R0,R0,#55			;if not assume its letter
		BL		PutChar
		MOVS 	R0,R4
		
		SUBS	R2,R2,#4			;incrementing 
		SUBS	R5,R5,#1
		CMP		R5,#0
		BEQ		Done_PNH
		B	Loop_PNH
		
Number_PNH
		ADDS	R0,R0,#0x00000030	;speical case for number 
		BL		PutChar
		MOVS 	R0,R4
		
		SUBS	R2,R2,#4
		SUBS	R5,R5,#1
		CMP		R5,#0
		BEQ		Done_PNH
		B	Loop_PNH		
		
Done_PNH		
		POP {R0-R5,PC}

;---------------------------------PUTNUMSB----------------------------
;takes value from R0
;doesnt output any values except for PSVR
;prints to the terminal the least significant bit
PutNumSB
		PUSH	{R0-R1,LR}
		MOVS	R1,#0x0000000F
		ANDS	R0,R1
		BL		PutNumU
		BL		PutChar
		POP		{R0-R1,PC}

;------------------------------- GETSTRINGSB --------------------------	
;Recieves address in R0,
;Outputs string to R0
;takes a string that is typed in and then puts into R0
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
		
		
;------------------------------ LENGTHSTRINGSB -------------------------		
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
		
;---------------------------------- PUTNUMU ------------------------------
;prints the number in decimal form in R0
;does not output any registers
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

;--------------------------------- PUTSTRINGSB -----------------------------
;prints the string stored in R0 to terminal
;does not output any registers
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
		
;------------------------------------- DIVU --------------------------------
;takes in Diveded (R1) and Divisor (R0)
;returns the dividen amount
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
		
;------------------------------------- INIT --------------------------------
;initializes the UART_IRQ
;code taken from lecture
;shown in chunks
Init_PIT_IRQ										
		;enabling pit clock
		PUSH	{R0-R3,LR}
		LDR		R0,=SIM_SCGC6
		LDR		R1,=SIM_SCGC6_PIT_MASK
		LDR		R2,[R0,#0]
		ORRS	R2,R2,R1
		STR		R2,[R0,#0]
		
		;disabling timer
		LDR		R0,=PIT_CH0_BASE
		LDR		R1,=PIT_TCTRL_TEN_MASK
		LDR		R2,[R0,#PIT_TCTRL_OFFSET]
		BICS	R2,R2,R1
		STR		R2,[R0,#PIT_TCTRL_OFFSET]
		
		
		;setting pit interrupt priority
		LDR		R0,=PIT_IPR
		LDR		R1,=NVIC_IPR_PIT_MASK
		LDR		R3,[R0,#0]
		BICS	R3,R3,R1
		STR		R3,[R0,#0]
		LDR		R0,=NVIC_ICPR
		LDR		R1,=NVIC_ICPR_PIT_MASK
		STR		R1,[R0,#0]
		
		;clearing any pending PIT interrupts
		LDR		R0,=NVIC_ICPR
		LDR		R1,=NVIC_ICPR_PIT_MASK
		STR		R1,[R0,#0]
		
		;unmaksing PIt interrupts
		LDR		R0,=NVIC_ISER
		LDR		R1,=NVIC_ISER_PIT_MASK
		STR		R1,[R0,#0]
		
		;enabling pit modual
		LDR		R0,=PIT_BASE
		LDR		R1,=PIT_MCR_EN_FRZ
		STR		R1,[R0,#PIT_MCR_OFFSET]
		
		;setting interrupt for every 0.001s
		LDR		R0,=PIT_CH0_BASE
		LDR		R1,=PIT_LDVAL_10ms
		STR		R1,[R0,#PIT_LDVAL_OFFSET]
		
		;enabling PIt timer to channel 0 for interrupts
		LDR		R1,=PIT_TCTRL_CH_IE
		STR		R1,[R0,#PIT_TCTRL_OFFSET]
		
		POP		{R0-R3,PC}
	
;------------------------------------- INIT --------------------------------
;initializes the UART_IRQ
;code taken from lecture
;shown in chunks
Init_UART0_IRQ										
		PUSH { R1, R2, R3, LR}
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
		MOVS R1,#UART0_C2_T_RI
		STRB R1,[R0,#UART0_C2_OFFSET] 
		
		LDR		R0,=RxQBuffer
		LDR		R1,=RxQRecord
		MOVS	R2,#TRxQ_BUF_SZ
		BL		InitQueue
		
		LDR		R0,=TxQBuffer
		LDR		R1,=TxQRecord
		MOVS	R2,#TRxQ_BUF_SZ
		BL		InitQueue
		
		;added for prelab 9
		;Set UART IRQ Priority
		LDR		R0,=UART0_IPR
		LDR		R2,=NVIC_IPR_UART0_PRI_3
		LDR		R3,[R0,#0]
		ORRS	R3,R3,R2
		STR		R3,[R0,#0]
		
		;clearing pending uart0Interrupts
		LDR		R0,=NVIC_ICPR
		LDR		R1,=NVIC_ICPR_UART0_MASK
		STR		R1,[R0,#0]
		
		;unmaks UART0 interrupts
		LDR		R0,=NVIC_ISER
		LDR		R1,=NVIC_ISER_UART0_MASK
		STR		R1,[R0,#0]

		POP { R1, R2, R3, PC}
		
;-----------------------------------UART0-ISR---------------------------------
;the interrupt handler that is called by the vector table
UART0_ISR	
		CPSID	I
		PUSH	{R5-R7, LR}
		
		LDR		R2,=UART0_BASE					;recives the base
		LDRB	R1,[R2,#UART0_C2_OFFSET]
		MOVS	R0,#UART0_C2_TIE_MASK			;masking
		
		TST		R0,R1							;testing the value in the offset verses the 
												;tie mask
		BEQ		RxInterrupt						;if they equal, then its confimed a Rx interrupt and brankes
		LDRB	R1,[R2,#UART0_S1_OFFSET]
		MOVS	R0,#UART0_S1_TDRE_MASK			;TDRE mask
		
		TST		R0,R1							;checks again

		BEQ		RxInterrupt						;if they equal, then its confimed a Rx interrupt and brankes
		
		LDR		R1,=TxQRecord					;if code has lasted this far, then TxQRecord is loaded

		BL		DeQueue							;dequeues
		
		BCS		Else_01							;if it fails, initiate else
		
		STRB	R0,[R2,#UART0_D_OFFSET]
		B		RxInterrupt						;goes to RxInterrupt since it has failed
			
Else_01											;else loop that branches
		MOVS R1,#UART0_C2_T_RI
		STRB R1,[R2,#UART0_C2_OFFSET] 
		
RxInterrupt										;Rxinterupt, which is called if it is confimred to be a Rx case
		
		LDRB	R1,[R2,#UART0_S1_OFFSET]
		MOVS	R0,#UART0_S1_RDRF_MASK			;masking and so forth
	
		TST		R0,R1
		
		BEQ		Over_ISR

		LDRB	R0,[R2,#UART0_D_OFFSET]	
		LDR		R1,=RxQRecord					;loading RxQrecord and then enquing
		BL		Enqueue
		
Over_ISR
		
		CPSIE	I								;stop masking
		POP		{R5-R7,PC}

;--------------------------- PUTCHAR -----------------------
;Recives R0
;Places it onto termianl screen
;does not modify registers
PutChar									
		PUSH { R0, R1, R2, R3, LR }
		LDR	R1,=TxQRecord						;loading TxQBuffer
PC_Loop
		CPSID I
		BL	Enqueue								;enquing item in R0
		CPSIE I
		BCS	PC_Loop
		
		LDR	R0,=UART0_BASE
		MOVS R1,#UART0_C2_TI_RI
		STRB R1,[R0,#UART0_C2_OFFSET] 
		
		POP { R0, R1, R2, R3, PC }
		
;--------------------------- GETCHAR -----------------------
;takes terminal off of screen that has been entered
;places value into R0 register
GetChar											;copy and paste code of Getchar
		PUSH { R1, R2, R3, LR }
		LDR	R1,=RxQRecord						;loading RxQBuff
GC_Loop
		CPSID I	
		BL		DeQueue							;dequeuing from the queue
		CPSIE I
		
		BCS GC_Loop 
		
		POP { R1, R2, R3, PC }
			

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
            DCD    UART0_ISR		  ;28:UART0 (status; error)
            DCD    Dummy_Handler      ;29:UART1 (status; error)
            DCD    Dummy_Handler      ;30:UART2 (status; error)
            DCD    Dummy_Handler      ;31:ADC0
            DCD    Dummy_Handler      ;32:CMP0
            DCD    Dummy_Handler      ;33:TPM0
            DCD    Dummy_Handler      ;34:TPM1
            DCD    Dummy_Handler      ;35:TPM2
            DCD    Dummy_Handler      ;36:RTC (alarm)
            DCD    Dummy_Handler      ;37:RTC (seconds)
            DCD    PIT_ISR		      ;38:PIT (all IRQ sources)
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
LoopString				DCB	"Round ",0

Entered					DCB	" 			Time of : ",0
ScoreIs					DCB	"				Score is: ",0	
TimeUnit				DCB	"ms",0
Wrong					DCB	" Wrong        -Subtracting 200 from score-        ",0
OutOfTime				DCB	" Out of time--color was : ",0
CorrectColor	   		DCB " Correct--color was     : ",0

None_Word				DCB	"None ",0
Green_Word				DCB	"Green",0
Red_Word				DCB	"Red  ",0
Both_Word				DCB "Both ",0

Congradulations			DCB	"-----------------Congradulations!------------------",0
FinishedWith			DCB	"           You finished with a score of: ",0
PlayAgain				DCB	"                Play again [y/n]?",0
Quiting					DCB	" Quiting",0

RestartRound			DCB	"Press any key to restart the round",0

InitString1				DCB	"---------------Welcome to the Game!----------------",0
InitString2				DCB	"Score points by pushing the key that corresponds to",0            
THEGAME1				DCB "     the correct color outputed on the KL46:",0
THEGAME2				DCB "                     NONE = n",0
THEGAME3				DCB "                    GREEN = g",0
THEGAME4				DCB "                      RED = r" ,0
THEGAME5				DCB "                     BOTH = b",0 
THEGAME6				DCB "            --Press any key to begin--",0
GO						DCB "GO!",0
                                                                                                    
;>>>>>   end constants here <<<<<
            ALIGN
;****************************************************************
;Variables
            AREA    MyData,DATA,READWRITE
;>>>>> begin variables here <<<<<

LED_Color		SPACE	4
				ALIGN
				
Score			SPACE	4
				ALIGN
					
Time_Requirment	SPACE	4
				ALIGN
					

Random			SPACE	16
				ALIGN
					
QBuffer			SPACE	Q_BUF_SZ
				ALIGN
QRecord			SPACE	Q_REC_SZ
				ALIGN
				
	
RxQBuffer		SPACE	TRxQ_BUF_SZ
				ALIGN
RxQRecord		SPACE	Q_REC_SZ
				ALIGN
				
				
TxQBuffer		SPACE	TRxQ_BUF_SZ
				ALIGN
TxQRecord		SPACE	Q_REC_SZ
				ALIGN
					
Round_Time		SPACE	4				
				ALIGN	
Round_Number	SPACE	4				
				ALIGN	
					
Round_Number_Prev	SPACE	4				
				ALIGN	
LED_Choice		SPACE	4
				ALIGN
Count			SPACE  	4 
				ALIGN
				
RunStopWatch 	SPACE 	1
				ALIGN

String			SPACE	79
;>>>>>   end variables here <<<<<
            ALIGN
            END