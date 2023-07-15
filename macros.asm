;----------------------------------------------------------
;       MICHAEL JACKSON'S MOONWALKER DECOMPILATION
;              (C) HARRY CLARK 2023
;----------------------------------------------------------

;----------------------------------------------------------
;     THIS FILE DEFINES THE MACROS FOR ARGUMENTS AND
;                  AND THEIR HANDLERS
;----------------------------------------------------------

NULL_ARG:       MACRO
ARG_VALUE:      EQU 1

@LOOP\@         DC.B 1, %ARG_VALUE, 0
                DC.B 1, %ARG_VALUE, \2
				BNE.S @LOOP\@

				ENDM 


ENABLE_VSRAM:         EQU           0
VSRAM_ADDR:           EQU           3

SUPPORT_VSRAM:      MACRO

@LOOP\@             if ENABLE_VSRAM = 1
                    DC.B $2A3F + VSRAM_ADDR << 3, $20                     ;; ASSUME THE LENGTH OF THE
					                                  ;; VSRAM CONSTANT, ACCESS THE ADDRESS IN PROPORTION TO THAT
                    else 

                    DC.L $20202020                    ;; ENABLE THE VSRAM ACCORDINGLY
                    DC.L $20202020                    ;; AND DEFINE WHICH ADDRESS IT SHOULD
                    DC.B "       "                    ;; EXECUTE IT'S RUNTIME AT
                    BNE.S @LOOP\@

	            ENDM

;; DEFINE THE BUS ERROR BRANCH LOOP
;; AS DEMONSTRATED BY THE VECTOR TABLE

BUS_ERROR:          MACRO
ERR_VALUE:          EQU   $0000008
                    NOP 
                    NOP
                    BRA.B ERR_VALUE
                    ENDM

;; DEFINE THE TRAP COROUTINE TO FREEZE THE 68000 FROM PERFROMING ILLEGAL INSTRUCTIONS



;; CREATES AN ADDRESS DIFFERENCE TO DISCERN BETWEEN VALUES ON GPR'S 14 AND 16
;; 

VDP_ADDR_DIF:      VALUE, ADDR,((ADDR &$3FFF) << 16) || ((ADDR $0000) >> 14) 

DMA_VDP:            MACRO SOURCE, DEST, LEN, TYPE
                    LEA $C00004.L, A5   ;; LOAD THE EFFECTIVE ADDRESS OF THE VDP CONTROL IN GPR A5 
                                        ;; SEE https://segaretro.org/Sega_Mega_Drive/VDP_general_usage#Registers

                    LEA $C00000.L, A6
                    MOVE.W $0002, A5                    
                    ENDM

ZERO_OFFSET = 0

;----------------------------------------------------------
;                       END OF FILE
;----------------------------------------------------------
