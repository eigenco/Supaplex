	incbin "roland.bin", $, 0x0085-$
	retn

	incbin "roland.bin", $, 0x0098-$
	mov     dx, 330h
	mov     al, ah
	out     dx, al
	retn

	incbin "roland.bin", $, 0x0189-$   ; remove volume (causes clipping)
	times 3 nop

	incbin "roland.bin", $, 0x018e-$   ; remove volume (causes clipping)
	times 3 nop

	incbin "roland.bin", $, 0x0193-$   ; remove volume (causes clipping)
	times 3 nop

	incbin "roland.bin", $, 3968
