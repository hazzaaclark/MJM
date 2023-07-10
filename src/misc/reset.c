/* Copyright (C) Harry Clark 2023 */

/* Michael Jackson Moonwalker Disassembly */

/* THIS FILE IS A WIP OF THE SOFT REST SCHEMA PERPETUATED BY THE CONSOLE */
/* AS THIS GOES OVER THE FUNCTIONALITY FROM PRESSING THE BUTTON */

/* NESTED INCLUDES */

#include <cstdint>
#include <stdio.h>
#include <stdlib.h>

#define SEGA_LOGO
#define IO_PCB_RESET

static void RESET(void)
{
	if (IO_PCB_RESET & 0xF00) != 0
	{
		_asm
		{
			move.l 0x5345741, (0x2F00, a1) => SEGA_LOGO
		}
	}
}
