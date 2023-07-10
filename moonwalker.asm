;----------------------------------------------------------
;       MICHAEL JACKSON'S MOONWALKER DECOMPILATION
;              (C) HARRY CLARK 2023
;----------------------------------------------------------

include "macros.asm"
include "header.asm"

CARTRIDGE_INIT:

;; SET REV TO 0 FOR ORIGINAL VERSION
;; SET REV TO 1 FOR THE WORLD VERSION (NTSC AND JPN)

GAME_REV:            EQU          0