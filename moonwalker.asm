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
CHECKSUM:            DC.W         $96FH

DC.B                 "SEGA MEGA DRIVE "                            ;; CONSOLE NAME
DC.B                 "(C)SEGA 1990.JUL"                            ;; RELEASE DATE
DC.B                 "MICHAEL JACKSON          FS MOONWALKER"      ;; DOMESTIC NAME

if GAME_REV=0

DC.B "GM 00004028-01"                                              ;; GAME VERSION - DOMESTIC
else 

DC.B "GM 00004048-00"                                              ;; GAME VERSION - NON-DOM

endif

SETUP_IO:

DC.B                 "J              "
DC.L                  CARTRIDGE_INIT
DC.L                  END_OF_CARTRIDGE

DC.B          RAM_START             $FFFF0000
DC.B          RAM_END               $FFFFFFFF                  

SETUP_IO:

DC.W                  VDP_INIT              $8000
DC.W                  VDP_RAM               $3FFF
DC.L                  VDP_DATA
DC.L                  VDP_CTRL 
DC.L                  VRAM_ADDR             $0x40000080

END_OF_CARTRIDGE:
