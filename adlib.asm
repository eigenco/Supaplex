	incbin "adlib.snd", $, 0x0444-$          ; OPL3 delays
	out     dx, al
	in      al, dx
	inc     dx
	mov     al, ah
	out     dx, al
	in      al, dx
	in      al, dx
	in      al, dx
	dec     dx
	retn
	
	incbin "adlib.snd", $, 5354
