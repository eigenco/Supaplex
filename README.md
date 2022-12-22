# supaplex
Bug fixes for Supaplex (MS-DOS game).

Improvements:
- Graphical glitches have been removed from MOVING.DAT
- Added resync routine to eliminate scroll jerking due to timing issues on a real PC
- Eliminated copy protection
- Disabled mouse that caused a control conflict, menu is now operated with backspace
- Recreated BLASTER.SND for better compatibility
- Gravis Ultrasound (GUS) support for sound effects (separate directory)
- Limited Roland MT-32/CM-32L/LAPC-I volume so clipping doesn't occur

Jerking bug:

The jerking bug was caused by music routine interrupt taking too long for reliable vertial sync. OPL2 requires 6 in al, dx and 35 in al, dx delay to work.

Version in the sync directory now allows smooth scrolling without screwing with the PIT. OPL2 works without dropping frames as well (at least on my 386DX 40 MHz and faster). However, there is a CPU dependent timing coefficient that needs to be set. See sup.asm for adjusting delays accordingly.
