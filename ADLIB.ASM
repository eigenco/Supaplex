; OPL3 delays only (won't work with OPL2)

incbin  "adlib.snd", 0, 1092

	out     dx, al
	times 2 in al, dx
	inc     dx
	mov     al, ah
	out     dx, al
	times 3 in al, dx
	dec     dx
	ret

incbin  "adlib.snd", $
