cpu     8086
org     0x100

start:
	mov     dx, 0x331 ; initialize roland MPU-401
	mov     al, 0x3f
	out     dx, al	
	mov     dx, 0x226 ; reset sound blaster dsp
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
	jns     nextattempt
	sub     dl, 4
	in      al, dx
	cmp     al, 0xaa
	je      resetok
nextattempt:
	loop    empty
resetok:
	mov     dx, 0x22c ; enable sound blaster dac
wait2:
	in      al, dx
	and     al, 0x80
	jnz     wait2
	mov     al, 0xd1
	out     dx, al
return:
	int	0x20 ; return to DOS