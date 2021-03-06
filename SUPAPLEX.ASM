	org     0x0100

; ---- adlib only ----

	jmp     pass

; ---- initialize roland ----

	mov     dx, 0x331
	mov     al, 0x3f
	out     dx, al

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

; ---- move code to the intended address ----

pass:
	mov     ax, cs
	mov     ds, ax
	mov     si, start
	add     ax, 14050              ; (512+224288)/16
	mov     es, ax
	mov     di, 0
	mov     cx, 17643
	rep     movsw

; ---- load data.bin ----

	mov     ax, cs
	mov     ds, ax

	mov     ax, 0x3d00             ; open file
	mov     dx, data
	int     0x21
	mov     bx, ax                 ; file handle in ax after open

	mov     ax, cs
	add     ax, 16256              ; 512/16+0x3f60
	mov     ds, ax
	mov     ax, 0x3f00             ; read file
	mov     cx, 56920              ; number of bytes to read
	mov     dx, 0
	int     0x21

	mov     ax, 0x3e00             ; close file
	int     0x21

; ---- perform relocations ----

	mov     bx, cs
	add     bx, 14050              ; (512+224288)/16
	mov     ds, bx

	mov     ax, cs
;        add     ax, 512/16
	add     ax, 32
	add     [0x0001], ax           ; relocations
	add     [0x0296], ax
	add     [0x02bd], ax
	add     [0x030e], ax
	add     [0x03a9], ax
	add     [0x058d], ax
	add     [0x09ba], ax
	add     [0x0b68], ax
	add     [0x0baf], ax
	add     [0x1754], ax
	add     [0x1d88], ax
	add     [0x2e16], ax
	add     [0x33da], ax
	add     [0x3440], ax
	add     [0x46ac], ax
	add     [0x471b], ax
	add     [0x478a], ax
	add     [0x47ef], ax
	add     [0x582b], ax
	add     [0x5838], ax
	add     [0x59ca], ax
	add     [0x59ff], ax
	add     [0x8324], ax
	add     [0x83b1], ax
	add     [0x83f2], ax
	add     [0x8446], ax
	add     [0x8474], ax
	add     [0x8510], ax

; ---- initialize video ---

	mov     ax, 0x000d
	int     0x10

; ---- EGA style palette assignment ----

;        mov     cx, 0x0010
;palloop:
;        push    cx
;        mov     ax, 0x1000
;        mov     bl, cl
;        dec     bl
;        mov     bh, bl
;        int     0x10
;        pop     cx
;        loop    palloop

	mov     cx, 16
	mov     dx, 0x3c0
pal:
	mov     al, cl
	out     dx, al
	dec     al
	out     dx, al
	loop    pal

; ---- 976 pixels wide ----

	mov     dx, 0x3d4
	mov     al, 0x13
	out     dx, al
	inc     dx
	mov     al, 0x3d
	out     dx, al

; ---- prepare stack ----

	mov     ax, cs
;        add     ax, 512/16
	add     ax, 32
	add     ax, 0x587b
	mov     ss, ax
	mov     sp, 0x0400

; ---- execute the code ----

	mov     ax, cs
	add     ax, 14050 ; (512+224288)/16
	push    ax
	mov     ax, 0
	push    ax
	retf

data:
	db      "data.bin", 0

start:
	incbin "code.bin"
