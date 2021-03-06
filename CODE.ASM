	mov     dx, 0x3f60             ; data segment
	mov     ds, dx
	mov     ax, 0xa000
	mov     es, ax
	call    0x254f
	call    0x5340
	call    0x537f
	call    0x53a9
	mov     byte [0x630], 1
	call    0x1cee
	call    0x0395                 ; setup_PIT_interrupt
	times 3 nop                    ; was: install_error_handler at 0x3e3
	call    0x0282                 ; setup_keyboard_interrupt
	call    0x5820
	call    0x55b9
	call    0x5586
	mov     si, 0x605b
	call    0x566c

incbin "org/code.bin",$,0x004e-$
	times 3 nop ; copy protection

incbin "org/code.bin",$,0x00b3-$
	call    0x0584
	call    0x48f2
	cmp     word [0x166a], byte 0
	jz      short 0x0075
	mov     si, 0x605b
	call    0x566c
	call    0x02a4                 ; restore_keyboard_interrupt
	call    0x540f
	call    0x53a1
	times 3 nop                    ; was: restore_error_handler at 0x404
	call    0x03c3                 ; restore_PIT_interrupt
	call    0x584e
	mov     ax, 0x4c00
	int     0x21                   ; return to DOS

incbin "org/code.bin",$,0x00dd-$
	push    ax
	call    0x02a4                 ; restore_keyboard_interrupt
	call    0x53a1
	call    0x03c3                 ; restore_PIT_interrupt
	pop     ax
	call    0x1750
	mov     ah, 0x4c
	int     0x21
	mov     si, 0x5f1b
	call    0x566c
	mov     ax, 0x3d00
	mov     dx, 0x36ed             ; TITLE2.DAT
	int     0x21

incbin "org/code.bin",$,0x0192-$
	out     dx, al
	call    vsync
	mov     byte [0xd96], 0
	mov     si, 0x5edb
	call    0x566c
	ret

incbin "org/code.bin",$,0x0277-$
	call    vsync

incbin "org/code.bin",$,0x058b-$
	push    es
	mov     ax, 0x2720             ; relocation

incbin "org/code.bin",$,0x05fa-$
	mov     ax, 0x3d00
	mov     dx, 0x3776             ; PALETTES.DAT
	int     0x21

incbin "org/code.bin",$,0x067c-$
	call    vsync

incbin "org/code.bin",$,0x06f7-$
	call    vsync

incbin "org/code.bin",$,0x0725-$
	mov     ax, 0x3d00
	mov     dx, 0x36e2             ; TITLE1.DAT
	int     0x21

incbin "org/code.bin",$,0x07cf-$
	call    vsync

incbin "org/code.bin",$,0x07dd-$
	mov     ax, 0x3d00
	mov     dx, 0x36ed             ; TITLE2.DAT
	int     0x21

incbin "org/code.bin",$,0x085f-$
	mov     ax, 0x3d00
	mov     dx, 0x36b0             ; MOVING.DAT
	int     0x21

incbin "org/code.bin",$,0x091d-$
	mov     ax, 0x3d00
	mov     dx, 0x36bb             ; FIXED.DAT
	int     0x21

incbin "org/code.bin",$,0x0960-$
	mov     dx, 0x36c5             ; PANEL.DAT

incbin "org/code.bin",$,0x099f-$
	mov     dx, 0x36f8             ; BACK.DAT

incbin "org/code.bin",$,0x09b9-$
	mov     ax, 0x1f50             ; relocation

incbin "org/code.bin",$,0x09e6-$
	mov     dx, 0x3709             ; CHARS6.DAT

incbin "org/code.bin",$,0x0a24-$
	mov     dx, 0x3714             ; CHARS8.DAT

incbin "org/code.bin",$,0x0a6f-$
	call    vsync

incbin "org/code.bin",$,0x0b0a-$
	mov     dx, 0x371f             ; LEVEL.LST

incbin "org/code.bin",$,0x0b49-$
	mov     dx, 0x3701             ; GFX.DAT

incbin "org/code.bin",$,0x0b67-$
	mov     ax, 0x0fb0             ; relocation

incbin "org/code.bin",$,0x0b90-$
	mov     dx, 0x3729             ; CONTROLS.DAT

incbin "org/code.bin",$,0x0bae-$
	mov     ax, 0x1780             ; relocation

incbin "org/code.bin",$,0x0bd7-$
	mov     dx, 0x376b             ; PLAYER.LST

incbin "org/code.bin",$,0x190f-$
	call    vsync

incbin "org/code.bin",$,0x1926-$
	call    vsync

incbin "org/code.bin",$,0x1d87-$
	mov     ax, 0x2720             ; relocation

incbin "org/code.bin",$,0x1f4e-$
	db      0x60                   ; linecomp, pc: 0x5f, ao486: 0x60

incbin "org/code.bin",$,0x2e03-$
	mov     dx, 0x36cf             ; MENU.DAT

incbin "org/code.bin",$,0x3086-$
	call    vsync

incbin "org/code.bin",$,0x31a5-$
	call    vsync

incbin "org/code.bin",$,0x442c-$
	call    vsync

incbin "org/code.bin",$,0x44cb-$
	call    vsync

incbin "org/code.bin",$,0x44d6-$
	call    vsync

incbin "org/code.bin",$,0x4505-$
	call    vsync

incbin "org/code.bin",$,0x45ba-$
	call    vsync

incbin "org/code.bin",$,0x45f3-$
	call    vsync

incbin "org/code.bin",$,0x45fe-$
	call    vsync

incbin "org/code.bin",$,0x462d-$
	call    vsync

incbin "org/code.bin",$,0x4636-$
	call    vsync

incbin "org/code.bin",$,0x466c-$
	call    vsync

incbin "org/code.bin",$,0x4677-$
	call    vsync

incbin "org/code.bin",$,0x46a6-$
	call    vsync

incbin "org/code.bin",$,0x4929-$
	call    vsync

incbin "org/code.bin",$,0x4963-$
	call    vsync

incbin "org/code.bin",$,0x4b41-$
	call    vsync

incbin "org/code.bin",$,0x53a1-$       ; switch back to text mode upon exit
	mov     ah, 0
	mov     al, 3
	int     0x10
	ret

incbin "org/code.bin",$,0x53a9-$       ; eliminate mouse routines
	ret

incbin "org/code.bin",$,0x53aa-$
resync:
	push    ax
	mov     ah, [cs:cnt]
	inc     ah
	cmp     ah, 69
	jne     pass
	mov     al, 0x36
	out     0x43, al
	mov     al, 0x38
	out     0x40, al
	mov     al, 0x5d
	out     0x40, al
	xor     ah, ah
pass:
	mov     [cs:cnt], ah
	pop     ax
	ret
cnt:
	db      0

incbin "org/code.bin",$,0x5433-$
	mov     bx, 2
	cmp     byte [0x167b], 1       ; use menu with backspace
	jnz     short 0x5440
	mov     bx, 1

incbin "org/code.bin",$,0x54d9-$
vsync:
	push    dx
	push    ax
	mov     dx, 0x03da
A54de:
	in      al, dx
	test    al, 8
	je      short A54de
	mov     dx, 0x03c0
	mov     al, 0x33
	out     dx, al
	mov     al, [0x0d96]
	out     dx, al
	pop     ax
	pop     dx
	call    resync
	ret

incbin "org/code.bin",$,0x554c-$
	db      0x60                   ; linecomp, pc: 0x5f, ao486: 0x60

incbin "org/code.bin",$,0x5784-$
	call    vsync

incbin "org/code.bin",$,0x5918-$
	mov     dx, 0x375f             ; BLASTER.SND

incbin "org/code.bin",$,0x594e-$
	mov     cx, 36123              ; size of BLASTER.SND

incbin "org/code.bin",$,0x5981-$
	mov     cx, 36123              ; size of BLASTER.SND

incbin "org/code.bin",$,0x59fe-$
	mov     ax, 0x4eb6             ; segment address for BLASTER.SND
	mov     ds, ax
	mov     ax, 0x3f00

incbin "org/code.bin",$,0x84f6-$
	cmp     byte [0x379a], 1
	jnz     short 0x84fe
	ret

incbin "org/code.bin",$,0x8813-$
	times 5 nop

incbin "org/code.bin",$,0x89cf-$
	mov     ax, 5
	jmp     0x00dd
	ret

	times 10 db 0
