	incbin "adlib.bin", $, 0x0444-$
	out     dx, al
        in      al, dx ; OPL3 delays not needed in DOSBOX
        in      al, dx
	inc     dx
	mov     al, ah
	out     dx, al
        in      al, dx
        in      al, dx
        in      al, dx
	dec     dx
	retn
	
	incbin "adlib.bin", $, 5354
