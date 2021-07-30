	org     0x100

; ---- initialized sound blaster ----

	mov     dx, 0x226
	mov     al, 1
	out     dx, al
	sub     al, al
delay:
	dec     al
	jnz     delay
	out     dx, al
	sub     cx, cx
empty:
	mov     dx, 0x22e
	in      al, dx
	or      al, al
	jns     next
	sub     dl, 4
	in      al, dx
	cmp     al, 0xaa
	je      reset
next:
	loop    empty
reset:
	mov     dx, 0x22c
wt:
	in      al, dx
	and     al, 0x80
	jnz     wt
	mov     al, 0xd1
	out     dx, al

; ---- return to dos ----

	mov     ax, 0x4c00
	int     0x21
