# supaplex
Disassembly and bug fixes for Supaplex (MS-DOS game)

Improvements:
- Graphical glitches have been removed from MOVING.DAT
- Added resync routine to eliminate scroll jerking due to timing issues
- Eliminated copy protection (code = 000)
- Disabled mouse that caused a control conflict, menu is now operated with backspace
- Recreated BLASTER.SND for better compatibility
- Converted EXE-file into a COM-file

Removed:
- Mouse routines
- EGA routines
- Joystick routines
- Error handlers
