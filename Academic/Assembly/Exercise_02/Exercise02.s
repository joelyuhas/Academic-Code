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
MULT8			EQU	3
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
			MOVS	R0,#0			;	0
			SUBS	R0,R0,5			;	-5
			MOVS	R1,#62			;	62
			ADDS	R0,R0,R1		;	R0 = -5 + 62
			
			MOVS 	R1,#9			;	9
			ASRS	R1,R1,#DIV4		;	9 /	4
			SUBS	R0,R0,R1		;	(-5 + 62) - (9/4)
			
			MOVS	R1,#7			;	7
			LSLS	R1,R1,#MULT8	;	7 x 8
			ADDS	R1,R1,#7		;	7 + 7 (so 7 * 9)
			SUBS	R0,R0,R1		;	((-5 + 62) - (9/4)) - (7 x 9)
			
			MOVS	R1,#58			;	58
			ADDS	R0,R0,R1		;	(((-5 + 62) - (9/4)) - (7 x 9)) +58
		
			
			MOVS	R1,#17			;	17
			ADDS	R0,R0,R1		;	((((-5 + 62) - (9/4)) - (7 x 9)) +58) + 17
			
		
			
			








;>>>>>   end main program code <<<<<
;Stay here
            B       .
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
;>>>>>   end variables here <<<<<
            END