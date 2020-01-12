	org     100h

	mov     bx, sync70
	shr     bx, 4
	mov     dx, cs
	add     dx, bx

	mov     ah, 0x25        ; set interrupt vector
	mov     al, 0x70
	mov     ds, dx
	xor     dx, dx
	int     0x21

	mov     ax, 0x3100      ; terminate and stay resident
	mov     dx, end
	shr     dx, 4
	inc     dx
	int     0x21

	int     0x20

align 16
sync70:
	incbin "sync70.int"
end: