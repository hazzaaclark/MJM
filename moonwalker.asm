;----------------------------------------------------------
;       MICHAEL JACKSON'S MOONWALKER DECOMPILATION
;              (C) HARRY CLARK 2023
;----------------------------------------------------------

include "macros.asm"
include "header.asm"

SRAM:

ENABLE_SRAM         EQU          0
BACKUP_SRAM         EQU          1
SRAM_ADDR           EQU          2

CARTRIDGE_INIT:

;; SET REV TO 0 FOR ORIGINAL VERSION
;; SET REV TO 1 FOR THE WORLD VERSION (NTSC AND JPN)

GAME_REV:            EQU          0

DC.B                 "SEGA MEGA DRIVE "                            ;; CONSOLE NAME
DC.B                 "(C)SEGA 1990.JUL"                            ;; RELEASE DATE
DC.B                 "MICHAEL JACKSON          FS MOONWALKER"      ;; DOMESTIC NAME

if GAME_REV=0

DC.B "GM 00004028-01"                                              ;; GAME VERSION - DOMESTIC
else 

DC.B "GM 00004048-00"                                              ;; GAME VERSION - NON-DOM

endif

SETUP_IO:

DC.B                 "J              "                             ;; IO SUPPORT 
DC.L                  CARTRIDGE_INIT
DC.L                  END_OF_CARTRIDGE-1

DC.B                  RAM_START             $FF0000
DC.B                  RAM_END               $FFFFFF

CHECKSUM:

if GAME_REV=0
    DC.W        $96FH
else
    DC.W        $AFC7
endif

ROM_SRAM:
        DC.B    "       "                           ;; SRAM CODE (SEEMS TO BE UNUSED)
        DC.L    $20202020                           ;; SRAM START
        DC.L    $20202020                           ;; SRAM END

Z80_LOOKUP:

TST.L                   (Z80_CTRL).L                            ;; TEST THE LONG LENGTH OF THE Z80'S REGISTERS (A, B)
BNE.W                   Z80_INIT                                ;; Z80 INITILISATION FUNCTION USING CHECK ZERO OR NON-ZERO
TST.W                   (Z80_EXT_CTRL).L                        ;; TEST THE LONG LENGTH OF THE Z80'S REGISTERS (C)

Z80_INIT:                                                       ;; THIS IS ALSO REFERRED TO AS THE RESET COROUTINE - CALLED WHEN THE Z80 IS RE-INITIALISED ON BOOT

BNE.B                   VDP_PORT_SKIP                           ;; SKIPS THE COROUTINE CHECK TO INITIALISE CONTROL REGISTERS
LEA                     VDP_SETUP(0x88, PC), A5                 ;; LOAD EFFECTIVE ADDRESS INTO THE VDP VALUE SETUP MACRO - LOADING FROM THE ARRAY STRUCTURE
                                                                ;; SEE ADDRESSING CAPABILITIES - FIGURE 2.4 https://www.nxp.com/docs/en/reference-manual/M68000PRM.pdf

MOVEM.L                 (A5)+,D5-D7                             ;; PERFROM A MULTI-REG PUSH ARGUMENT FROM THE ARRAY STRUCT INTO D5 THROUGH TO D7
MOVE.W                  (-0x1100, A1)=>Z80_PCB_VER, D0          ;; ALLOCATE THE Z80 PCB INTO THE CORRESPONDING ADDRESS AND DATA REGSITERS 
                                                                ;; ACCORDING TO THE MEMORY MAP, THE Z80 IS CALLED AT THE PROVIDED ADDRESS REGISTER, WITH A DEDICATED
                                                                ;; SIZE ALLOCATED ONTO THE ROM https://wiki.megadrive.org/index.php?title=Main_68k_memory_map

ANDI.W                  #$0F00, D0                                  ;; DISCERN AN AND LOGICAL OPERATIONS BETWEEN THE SOURCE ADDRESS AND THE NEW DESTINATION OF THE VALUE 
BEQ.B                   VDP_RESET                                   ;; COUROUTINE TO CHECK IF THE CART CORRESPONDS WITH THE DESTINATION OPERAND LOCATED IN THE CCR , OTHERWISE THE VDP WILL RESET 
MOVE.L                  #$053454741, ($02F00, A1)=>IO_TMSS          ;; IF THE CCR IS FOUND, CHECK FOR TMSS


END_OF_CARTRIDGE:

        END
