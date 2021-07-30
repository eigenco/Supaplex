	org     0x0100

; ---- load code ----

	mov     ax, cs
	mov     ds, ax

	mov     ax, 0x3d00             ; open file
	mov     dx, code
	int     0x21

	mov     bx, ax                 ; file handle in ax after open
	mov     ax, cs
	add     ax, 0x36c2             ; initial CS
	mov     ds, ax
	mov     ax, 0x3f00             ; read file
	mov     cx, 35286              ; number of bytes to read
	mov     dx, 0                  ; initial IP
	int     0x21

	mov     ax, 0x3e00             ; close file
	int     0x21

; ---- load data ----

	mov     ax, cs
	mov     ds, ax

	mov     ax, 0x3d00             ; open file
	mov     dx, data
	int     0x21

	mov     bx, ax                 ; file handle in ax after open
	mov     ax, cs
	add     ax, 0x3f60             ; data seg
	mov     ds, ax
	mov     ax, 0x3f00             ; read file
	mov     cx, 56920              ; number of bytes to read
	mov     dx, 0
	int     0x21

	mov     ax, 0x3e00             ; close file
	int     0x21

; ---- perform relocations ----

	mov     bx, cs
	mov     ds, bx
	mov     si, reloc

	mov     cx, 29
relocate:
	lodsw
	mov     di, ax

	lodsw
	mov     bx, cs
	add     ax, bx
	mov     es, ax

	mov     ax, cs
	db      0x26
	add     [di], ax                ; add     [es:di], ax ; nasm only
	loop    relocate

; ---- prepare stack ----

	mov     ax, cs
	add     ax, 0x587b              ; initial SS
	mov     ss, ax
	mov     sp, 0x0400              ; initial SP

; ---- execute the code ----

	mov     ax, cs
	add     ax, 0x36c2              ; initial CS
	push    ax
	mov     ax, 0x0000              ; initial IP
	push    ax
	retf

code:
	db      "code.new", 0
data:
	db      "data.new", 0
reloc:
	dw      0x6c21, 0x3000, 0x6eb6, 0x3000, 0x6edd, 0x3000, 0x6f2e, 0x3000
	dw      0x6fc9, 0x3000, 0x7017, 0x3000, 0x71ad, 0x3000, 0x75da, 0x3000
	dw      0x7788, 0x3000, 0x77cf, 0x3000, 0x8374, 0x3000, 0x89a8, 0x3000
	dw      0x9a36, 0x3000, 0x9ffa, 0x3000, 0xa060, 0x3000, 0xb2cc, 0x3000
	dw      0xb33b, 0x3000, 0xb3aa, 0x3000, 0xb40f, 0x3000, 0xc44b, 0x3000
	dw      0xc458, 0x3000, 0xc5ea, 0x3000, 0xc61f, 0x3000, 0xef44, 0x3000
	dw      0xefd1, 0x3000, 0xf012, 0x3000, 0xf066, 0x3000, 0xf094, 0x3000
	dw      0xf130, 0x3000
