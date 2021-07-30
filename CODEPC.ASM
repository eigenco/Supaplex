%define PC     ; for dosbox and normal hardware
%define PIT    ; utilize programmable interval timer
%define RESYNC ; use resynchronization of PIT with VSYNC

%ifndef PIT
incbin "code.bin", $,0x001e-$
	times 3 nop

incbin "code.bin", $,0x00d2-$
	times 3 nop

incbin "code.bin", $,0x00e4-$
	times 3 nop
%endif

incbin "code.bin", $,0x0192-$
	out     dx, al
	call    vsync
	mov     byte [0xd96], 0
	mov     si, 0x5edb
	call    0x566c
	ret

incbin "code.bin", $,0x0277-$
	call    vsync

%ifndef PIT
incbin "code.bin", $,0x038d-$
	times 4 nop

incbin "code.bin", $,0x0394-$
	ret
%endif

incbin "code.bin", $,0x067c-$
	call    vsync

incbin "code.bin", $,0x06f7-$
	call    vsync

incbin "code.bin", $,0x07cf-$
	call    vsync

incbin "code.bin", $,0x0a6f-$
	call    vsync

incbin "code.bin", $,0x190f-$
	call    vsync

incbin "code.bin", $,0x1926-$
	call    vsync

incbin "code.bin", $,0x1f4e-$
%ifdef PC
	db      0x5f
%else
	db      0x60
%endif

incbin "code.bin", $,0x3086-$
	call    vsync

incbin "code.bin", $,0x31a5-$
	call    vsync

incbin "code.bin", $,0x442c-$
	call    vsync

incbin "code.bin", $,0x44cb-$
	call    vsync

incbin "code.bin", $,0x44d6-$
	call    vsync

incbin "code.bin", $,0x4505-$
	call    vsync

incbin "code.bin", $,0x45ba-$
	call    vsync

incbin "code.bin", $,0x45f3-$
	call    vsync

incbin "code.bin", $,0x45fe-$
	call    vsync

incbin "code.bin", $,0x462d-$
	call    vsync

incbin "code.bin", $,0x4636-$
	call    vsync

incbin "code.bin", $,0x466c-$
	call    vsync

incbin "code.bin", $,0x4677-$
	call    vsync

incbin "code.bin", $,0x46a6-$
	call    vsync

incbin "code.bin", $,0x4929-$
	call    vsync

incbin "code.bin", $,0x4963-$
	call    vsync

incbin "code.bin", $,0x4b41-$
	call    vsync

incbin "code.bin",$,0x53aa-$
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

incbin "code.bin", $,0x54d9-$
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
%ifndef PIT
	call    0x30a
%endif
%ifdef RESYNC
	call    resync
%endif
	pop     ax
	pop     dx
	ret

incbin  "code.bin", $,0x554c-$
%ifdef PC
	db      0x5f
%else
	db      0x60
%endif

incbin "code.bin", $,0x5784-$
	call    vsync

; size of blaster.snd
incbin "code.bin", $,0x594e-$
	mov     cx, 36123

; size of blaster.snd
incbin "code.bin", $,0x5981-$
	mov     cx, 36123

incbin "code.bin", $,0x8813-$
	times 5 nop

incbin "code.bin", $,35286-$
