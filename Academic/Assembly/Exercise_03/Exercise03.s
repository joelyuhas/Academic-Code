            TTL Program Title for Listing Header Goes Here
;****************************************************************
;Descriptive comment header goes here.
;(What does the program do?)
;Name:  Joel Yuhas
;Date:  2/4/2016
;Class:  CMPE-250
;Section:  Lab 2, thursday, 2:00-3:50
;---------------------------------------------------------------
;Keil Simulator Template for KL46
;R. W. Melton
;January 23, 2015
;****************************************************************
;Assembler directives
            THUMB
            OPT    64  ;Turn on listing macro expansions
;****************************************************************
;EQUates
DIV4			EQU	2
MULT2			EQU	1
MULT4			EQU	2
MULT8			EQU	3
LEFT_SHIFT		EQU	24		

;Vectors
VECTOR_TABLE_SIZE EQU 0x000000C0
VECTOR_SIZE       EQU 4           ;Bytes per vector
;Stack
SSTACK_SIZE EQU  0x00000100
;****************************************************************
;Program
;Linker requires Reset_Handler
            AREA    MyCode,CODE,READONLY
            ENTRY
            EXPORT  Reset_Handler
Reset_Handler
main
;---------------------------------------------------------------
;>>>>> begin main program code <<<<<

			LDR		R0,=P
			LDR		R1,[R0,#0]
			
			LDR		R0,=Q
			LDR		R2,[R0,#0]
			
			LDR		R0,=R
			LDR		R3,[R0,#0]
			
			
			
			
			MOVS	R4,#128
			
			
;PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP			
			
		
			LSLS	R5,R1,#MULT2		;	2P
			
			CMP		R5,#127			;	check above
			BGT		F_OVER	
			CMN		R5,R4			;	check below
			BLT		F_OVER
			
			
			
			
			LSLS	R6,R2,#MULT2		;	2Q
			ADDS	R6,R6,R2			;	3Q
			
			CMP		R6,#127			;	check above
			BGT		F_OVER	
			CMN		R6,R4			;	check below
			BLT		F_OVER
			
			
			
			
			SUBS	R5,R5,R6		;	2P-3Q
			
			CMP		R5,#127			;	check above
			BGT		F_OVER
			CMN		R5,R4			;	check below
			BLT		F_OVER
			
			

			ADDS	R5,R5,R3		;	2P-3Q+R	
			
			CMP		R5,#127			;	check above
			BGT		F_OVER	
			CMN		R5,R4			;	check below
			BLT		F_OVER
			
			
			LDR		R0,=const_F
			LDR		R0,[R0,#0]
			
			ADDS	R5,R5,R0	;	2P-3Q+R+const_F
			
			CMP		R5,#127			;	check above
			BGT		F_OVER
			CMN		R5,R4			;	check below
			BLT		F_OVER

		
			
F_TO_MEMORY			LDR		R0,=F
					STR		R5,[R0,#0]

;GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG

			LSLS	R1,R1,#LEFT_SHIFT
			LSLS	R2,R2,#LEFT_SHIFT
			LSLS	R3,R3,#LEFT_SHIFT
			
			
			
			LSLS	R6,R1,#MULT4			;	4P
			ASRS	R6,R6,#LEFT_SHIFT	;	Shifing back 
			CMP		R6,#127				;	check above
			BGT		G_OVER
			CMN		R6,R4				;	check below
			BLT		G_OVER
			LSLS	R6,R6,#LEFT_SHIFT	;	Shifting back agian, check over
			
			
			ADDS	R6,R6,R1			;	5P	
			BVS		G_OVER				;	Checks if over
			
			
			
			
			LSLS	R7,R2,#MULT4			;	4Q
			ASRS	R7,R7,#LEFT_SHIFT	;	Shifing back 
			CMP		R7,#127				;	check above
			BGT		G_OVER
			CMN		R7,R4				;	check below
			BLT		G_OVER
			LSLS	R7,R7,#LEFT_SHIFT	;	Shifting back agian, check over
		
		
			SUBS	R6,R6,R7			;	5P-4Q
			BVS		G_OVER				;	Checks if over
			
			
			
			
			LSLS	R7,R3,#MULT2			;	2R
			ASRS	R7,R7,#LEFT_SHIFT	;	Shifing back 
			CMP		R7,#127				;	check above
			BGT		G_OVER
			CMN		R7,R4				;	check below
			BLT		G_OVER
			LSLS	R7,R7,#LEFT_SHIFT	;	Shifting back agian
			
			SUBS	R6,R6,R7			;	5P-4Q-2R
			BVS		G_OVER				;	Checks if over
		
		
			LDR		R0,=const_G
			LDR		R0,[R0,#0]
			
			LSLS	R0,R0,#LEFT_SHIFT
			ADDS	R6,R6,R0			;	5P-4Q-2R + const_G
			BVS		G_OVER				;	Checks if over
			ASRS	R0,R0,#LEFT_SHIFT
			
			
			
G_TO_MEMORY		
					
			ASRS	R1,R1,#LEFT_SHIFT
			ASRS	R2,R2,#LEFT_SHIFT
			ASRS	R3,R3,#LEFT_SHIFT
			
			
			ASRS	R6,R6,#LEFT_SHIFT
			ASRS	R7,R7,#LEFT_SHIFT
			;ASRS	R5,R5,#LEFT_SHIFT
			
						
			LDR		R0,=G
					STR		R6,[R0,#0]
		
;HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

			MOVS	R7,R1				;	P
			
			
			LSLS	R1,R2,#MULT2		;	2Q
			CMP		R1,#127			;	check above
			BGT		H_OVER	
			CMN		R1,R4			;	check below
			BLT		H_OVER
			
			
			SUBS	R7,R7,R1			;	P-2Q
			CMP		R7,#127			;	check above
			BGT		H_OVER	
			CMN		R7,R4			;	check below
			BLT		H_OVER
			
			
			ADDS	R7,R7,R3			;	P-2Q+R
			CMP		R7,#127			;	check above
			BGT		H_OVER	
			CMN		R7,R4			;	check below
			BLT		H_OVER
			
			
			LDR		R0,=const_H
			LDR		R0,[R0,#0]
			
			ADDS	R7,R7,R0		;	P-2Q+R-91
			CMP		R7,#127			;	check above
			BGT		H_OVER	
			CMN		R7,R4			;	check below
			BLT		H_OVER
			
			
H_TO_MEMORY			LDR		R0,=H
					STR		R7,[R0,#0]			
			
;RESULTRESULTRESULTRESULTRESULTRESULTRESULTRESULTRESULTRESULTRESULT
			
			ADDS	R2,R5,R6			;	F+G
			CMP		R2,#127			;	check above
			BGT		RES_OVER	
			CMN		R2,R4			;	check below
			BLT		RES_OVER		
			
			ADDS	R2,R2,R7			;	F+G+H
			CMP		R2,#127			;	check above
			BGT		RES_OVER	
			CMN		R2,R4			;	check below
			BLT		RES_OVER
			
			
			
			
			
			
		
		

RES_TO_MEMORY		LDR		R0,=Result
					STR		R2,[R0,#0]	








;>>>>>   end main program code <<<<<
;Stay here
            B       .
			
F_OVER			MOVS 	R5,#0	
				B		F_TO_MEMORY	

G_OVER			MOVS 	R6,#0
				B		G_TO_MEMORY	

H_OVER			MOVS 	R7,#0
				B		H_TO_MEMORY	

RES_OVER		MOVS 	R2,#0
				B		RES_TO_MEMORY	
;---------------------------------------------------------------
;>>>>> begin subroutine code <<<<<
;>>>>>   end subroutine code <<<<<
            ALIGN
;****************************************************************
;Vector Table Mapped to Address 0 at Reset
;Linker requires __Vectors to be exported
            AREA    RESET, DATA, READONLY
            EXPORT  __Vectors
            EXPORT  __Vectors_End
            EXPORT  __Vectors_Size
__Vectors 
                                      ;ARM core vectors
            DCD    __initial_sp       ;00:end of stack
            DCD    Reset_Handler      ;reset vector
            SPACE  (VECTOR_TABLE_SIZE - (2 * VECTOR_SIZE))
__Vectors_End
__Vectors_Size  EQU     __Vectors_End - __Vectors
            ALIGN
;****************************************************************
;Constants
		
            AREA    MyConst,DATA,READONLY
;>>>>> begin constants here <<<<<
const_F		DCD		51
const_G		DCD		7
const_H	  	DCD		-91
;>>>>>   end constants here <<<<<
;****************************************************************
            AREA    |.ARM.__at_0x1FFFE000|,DATA,READWRITE,ALIGN=3
            EXPORT  __initial_sp
;Allocate system stack
            IF      :LNOT::DEF:SSTACK_SIZE
SSTACK_SIZE EQU     0x00000100
            ENDIF
Stack_Mem   SPACE   SSTACK_SIZE
__initial_sp
;****************************************************************
;Variables
            AREA    MyData,DATA,READWRITE
;>>>>> begin variables here <<<<<
F			SPACE	4
G			SPACE	4
H			SPACE	4
P			SPACE	4
Q			SPACE	4
R			SPACE	4
Result		SPACE	4
;>>>>>   end variables here <<<<<
            END