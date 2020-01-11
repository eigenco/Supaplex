; nasm -fbin blaster.asm -o sp_org/blaster.snd

%macro waitdsp 0
%%wait:
	in      al, dx
	or      al, al
	js      %%wait
%endmacro

	push    ax
	push    bx
	push    cx
	push    dx

	cmp     ax, 0
	jne     skip0
	mov     cx, explosion
	mov     di, infotron - explosion - 1
	jmp     short start
skip0:
	cmp     ax, 1
	jne     skip1
	mov     cx, infotron
	mov     di, push - infotron - 1
	jmp     short start
skip1:
	cmp     ax, 2
	jne     skip2
	mov     cx, push
	mov     di, zonk - push - 1
	jmp     short start
skip2:
	cmp     ax, 3
	jne     skip3
	mov     cx, zonk
	mov     di, bug - zonk - 1
	jmp     short start
skip3:
	cmp     ax, 4
	jne     skip4
	mov     cx, bug
	mov     di, base - bug - 1
	jmp     short start
skip4:
	cmp     ax, 5
	jne     skip5
	mov     cx, base
	mov     di, exit - base - 1
	jmp     short start
skip5:
	cmp     ax, 6
	jne     skip6
	mov     cx, exit
	mov     di, end - exit - 1
	jmp     short start
skip6:
	jmp     skip
start:
	mov     dx, 0x0a               ; DMA: write  mask register
	mov     al, 15                 ; channel 1 disabled
	out     dx, al

	mov     dx, 0x0c               ; DMA: clear byte pointer flip-flop
	mov     al, 0
	out     dx, al

	mov     dx, 0x0b
	mov     al, 0x49               ; single-cycle playback on channel 1
	out     dx, al

	mov     bx, cs
	shl     bx, 4
	add     bx, cx                 ; offset

	mov     dx, 0x02               ; DMA: channel 1 address
	mov     al, bl
	out     dx, al
	mov     al, bh
	out     dx, al

	mov     ax, cs
	mov     bx, cx
	shr     bx, 4
	add     bx, ax
	shr     bx, 12                 ; DMA: page in bx

	mov     dx, 0x83               ; DMA: channel 1 page
	mov     al, bl
	out     dx, al

	mov     bx, di
	mov     dx, 0x03               ; DMA channel 1 count
	mov     al, bl
	out     dx, al
	mov     al, bh
	out     dx, al

	mov     dx, 0x0a
	mov     al, 1                  ; DMA 1 channel enabled
	out     dx, al

	mov     dx, 0x22c              ; sound blaster (A220) DSP write data
	waitdsp
	mov     al, 0x40               ; sample rate
	out     dx, al

	waitdsp
	mov     al, 256 - 1000000/8333
	out     dx, al

	waitdsp
	mov     al, 0x14               ; 8-bit PCM output
	out     dx, al

	waitdsp
	mov     al, bl                 ; lo(size)
	out     dx, al

	waitdsp
	mov     al, bh                 ; hi(size)
	out     dx, al
skip:
	pop     dx
	pop     cx
	pop     bx
	pop     ax
	iret
state:
	db      0
explosion:
	incbin "explode.raw"
infotron:
	incbin "infotron.raw"
push:
	incbin "push.raw"
zonk:
	incbin "zonk.raw"
bug:
	incbin "bug.raw"
base:
	incbin "base.raw"
exit:
	incbin "exit.raw"
end:
