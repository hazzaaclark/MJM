/* Copyright (C) Harry Clark 2023 */

/* Michael Jackson Moonwalker Disassembly */

/* THIS FILE PERTAINS TO THE MAIN EXECUTION OF THE GAME */

/* SYSTEM INCLUDES */

#include <stdio.h>
#include <stdlib.h>

#define INVALID_OPCODE                  0x10

/* CHECKS FOR ILLEGAL INSTRUCTION EXECUTION BEFORE INITIALISATION OF CARTRIDGE */

void ILLEGAL_INSTR_CHECK(void)
{
    int* VECTOR_TABLE = (int*)malloc((INVALID_OPCODE + 3));
}