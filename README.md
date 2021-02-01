# supaplex
Disassembly and bug fixes for Supaplex (MS-DOS game).

Improvements:
- Graphical glitches have been removed from MOVING.DAT
- Added resync routine to eliminate scroll jerking due to timing issues
- Eliminated copy protection
- Disabled mouse that caused a control conflict, menu is now operated with backspace
- Recreated BLASTER.SND for better compatibility
- Converted EXE-file into a COM-file

Removed:
- Mouse routines
- EGA routines
- Joystick routines
- Error handlers

Default:
- Comment from supaplex.asm, "jmp pass" to enable Roland and Sound Blaster
- Command from adlib.asm, "in al, dx" lines according to your hardware configuration

Jerking bug:
The jerking bug is caused by music routine interrupt taking too long for reliable vertial sync. OPL2 requires 6 in al, dx and 35 in al, dx delay to work. These delays are too much so smooth scrolling will only work with OPL3 and fast enough CPU, ao486 or dosbox. OPL3 requires continuous resyncing of the programmable interval timer. Same is true for MIDI. This resync routine has now been built in to the main code (but won't help with OPL2 or OPLxLPT, because of slow port operations).
