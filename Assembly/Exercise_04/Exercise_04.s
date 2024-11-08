            TTL Program Title for Listing Header Goes Here
;****************************************************************
;Descriptive comment header goes here.
;(What does the program do?)
;Name:  Joel Yuhas
;Date:  2/25/2016
;Class:  CMPE-250
;Section:  Lab 4, thursday, 2:00-3:50
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
MAX_DATA		EQU		25
	

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

			
									
			LDR		R0,=P			;Instantiating the initial variables
			LDR		R3,[R0,#0]
			LDR		R0,=Q
			LDR		R4,[R0,#0]
			
			BL		InitData		;initdata load
			
FLAG_DONE							;the lable that is used to jump back to 
									;beggining of loop after completion of 
									;TestDAta			
			
			BL		LoadData		;load data load
			
			
			BCS		DONE			;called when the program is finished and
									;jumps to final lable
			
			
									;initialzing P and Q, P to R1, and Q to R0
			LDR		R0,=P
			LDR		R1,[R0,#0]
			LDR		R2,=Q
			LDR		R0,[R2,#0]
			
			
			
			BL		DIVU			;Calling DIVU

			
			BCS		FLAG_SET		;checking if C flag is set, if it is, set 
									;P and Q as 0xFFFFFFFF
			
			
SET_DONE							;the lable that FLAG_SET uses to jump back 
									;to main code after complete

									
			LDR		R2,=P			;reinitializing P and Q, this time, P is R0 
			STR		R0,[R2,#0]		;and Q is R1, which is the way the provided 
			LDR		R2,=Q			;code needs it to be
			STR		R1,[R2,#0]

			
			BL		TestData		;Calls test data
			
			B		FLAG_DONE		;Goes back to FLAG_DONE and restart the cycle
			
		
DONE



;>>>>>   end main program code <<<<<
;Stay here
            B       .
			
FLAG_SET	LDR		R0,=0xFFFFFFFF	;FLAG_SET is called when the C flag is set after
			LDR		R1,=0xFFFFFFFF	;DIVU has been run and manually sets P and Q values
			B 		SET_DONE		;as 0xFFFFFFFF
			

			
;----------------Start DIVU---------------------------		
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
			
;****************************************************************
;Machine code provided for Exercise Four
;R. W. Melton 9/14/2015
;Place at the end of your MyCode AREA
            AREA    |.ARM.__at_0x4000|,CODE,READONLY
InitData    DCI.W   0x26002700
            DCI     0x4770
LoadData    DCI.W   0xB40FA316
            DCI.W   0x19DBA13D
            DCI.W   0x428BD209
            DCI.W   0xCB034A10
            DCI.W   0x4B116010
            DCI.W   0x60193708
            DCI.W   0x20000840
            DCI.W   0xBC0F4770
            DCI.W   0x20010840
            DCI     0xE7FA
TestData    DCI.W   0xB40F480C
            DCI.W   0xA13419C0
            DCI.W   0x19C93808
            DCI.W   0x39084A07
            DCI.W   0x4B076812
            DCI.W   0x681BC00C
            DCI.W   0x68084290
            DCI.W   0xD1046848
            DCI.W   0x4298D101
            DCI.W   0xBC0F4770
            DCI.W   0x1C76E7FB
            ALIGN
PPtr        DCD     P
QPtr        DCD     Q
ResultsPtr  DCD     Results
            DCQ     0x0000000000000000,0x0000000000000001
            DCQ     0x0000000100000000,0x0000000100000010
            DCQ     0x0000000200000010,0x0000000400000010
            DCQ     0x0000000800000010,0x0000001000000010
            DCQ     0x0000002000000010,0x0000000100000007
            DCQ     0x0000000200000007,0x0000000300000007
            DCQ     0x0000000400000007,0x0000000500000007
            DCQ     0x0000000600000007,0x0000000700000007
            DCQ     0x0000000800000007,0x8000000080000000
            DCQ     0x8000000180000000,0x000F0000FFFFFFFF
            DCQ     0xFFFFFFFFFFFFFFFF,0xFFFFFFFFFFFFFFFF
            DCQ     0x0000000000000000,0x0000000000000010
            DCQ     0x0000000000000008,0x0000000000000004
            DCQ     0x0000000000000002,0x0000000000000001
            DCQ     0x0000001000000000,0x0000000000000007
            DCQ     0x0000000100000003,0x0000000100000002
            DCQ     0x0000000300000001,0x0000000200000001
            DCQ     0x0000000100000001,0x0000000000000001
            DCQ     0x0000000700000000,0x0000000000000001
            DCQ     0x8000000000000000,0x0000FFFF00001111
            ALIGN
;****************************************************************
			
			
	
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

P			SPACE	4
Q			SPACE	4
Results		SPACE	8 * MAX_DATA
;>>>>>   end variables here <<<<<
            END