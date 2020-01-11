; nasm -fbin supaplex.asm -o supaplex.com

	org     100h

	mov     dx, 0x226              ; reset sound blaster
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
	mov     dx, 0x22c              ; enable sound blaster dac
wait2:
	in      al, dx
	and     al, 0x80
	jnz     wait2
	mov     al, 0xd1
	out     dx, al

	mov     ax, cs
	add     ax, 0x58d4             ; initial ss
	add     ax, (512+0x0100)/16    ; skip org and loader
	mov     ss, ax
	mov     sp, 0x0080             ; initial sp

	mov     ax, cs
	add     ax, 0x0aff             ; initial cs
	add     ax, (512+0x0100)/16    ; skip org and loader
	push    ax
	mov     ax, 0x0010             ; initial ip
	push    ax
	retf                           ; jumps to start

	times 512-($-$$) nop

	incbin "sp_org\supaplex.exe", $, 0x0530-$      ; remove unused inp
	nop

	incbin "sp_org\supaplex.exe", $, 0x55a5-$      ; remove mouse
	retn

	incbin "sp_org\supaplex.exe", $, 0x5632-$      ; use menu with backspace
	db 0x80, 0x3e, 0x7b, 0x16, 0x01

	incbin "sp_org\supaplex.exe", $, 0x56E2-$
	in al, dx
	test al, 0x8
	db 0x74, 0xed
	mov dx, 0x03c0
	mov al, 0x33
	out dx, al
	db 0xA0, 0x96, 0x0D
	out dx, al
	pop ax
	pop dx
	ret

	incbin "sp_org\supaplex.exe", $, 0x5b47-$      ; blaster.snd filesize
	mov     cx, 36123

	incbin "sp_org\supaplex.exe", $, 0x5b7a-$      ; blaster.snd filesize
	mov     cx, 36123

	incbin "sp_org\supaplex.exe", $, 0x8970-$      ; crack
	db      0

	incbin "sp_org\supaplex.exe", $, 45948-$
