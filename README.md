# supaplex
Disassembly and bug fixes for Supaplex (MS-DOS game).

Improvements:
- Graphical glitches have been removed from MOVING.DAT
- Added resync routine to eliminate scroll jerking due to timing issues on a real PC (supapc.com)
- Eliminated copy protection
- Disabled mouse that caused a control conflict, menu is now operated with backspace
- Recreated BLASTER.SND for better compatibility
- Gravis Ultrasound (GUS) support for sound effects
- Converted EXE-file into a COM-file
- Limited Roland MT-32/CM-32L/LAPC-I volume so clipping doesn't occur

Jerking bug:

The jerking bug was caused by music routine interrupt taking too long for reliable vertial sync. OPL2 requires 6 in al, dx and 35 in al, dx delay to work. ~These delays are too much so smooth scrolling will only work with OPL3 and fast enough CPU, ao486 (MiSTer FPGA), Next186 (MiST FPGA) or dosbox. OPL3 requires continuous resyncing of the programmable interval timer on a real PC.~

Version in the sync directory now allows smooth scrolling without screwing with the PIT. OPL2 works without dropping frames as well (at least on 386DX 40 MHz). However, there is a CPU dependent timing coefficient that needs to be set.
