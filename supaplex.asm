	cpu     8086

exe_header:

	db "MZ"
	dw 64                ; number of bytes in the last 512-byte page
	dw 711               ; total number of 512-byte pages
	dw 29                ; number of relocations
	dw 9                 ; (exe_header + reloc_table in bytes) / 16
	dw 32                ; minimum memory paragraphs in addition to file size
	dw 65535             ; maximum paragraphs
	dw 0x587B            ; initial SS
	dw 0x0400            ; initial SP
	dw 0
	dw 0x0000            ; initial IP
	dw 224288/16         ; initial CS
	dw reloc_table       ; relocation table offset
	dw 0

reloc_table:

	dw 0x6C21
	dw 0x3000

	dw 0x6EB6
	dw 0x3000

	dw 0x6EDD
	dw 0x3000

	dw 0x6F2E
	dw 0x3000

	dw 0x6FC9
	dw 0x3000

	dw 0x7017
	dw 0x3000

	dw 0x71AD
	dw 0x3000

	dw 0x75DA
	dw 0x3000

	dw 0x7788
	dw 0x3000

	dw 0x77CF
	dw 0x3000

	dw 0x8374
	dw 0x3000

	dw 0x89A8
	dw 0x3000

	dw 0x9A36
	dw 0x3000

	dw 0x9FFA
	dw 0x3000

	dw 0xA060
	dw 0x3000

	dw 0xB2CC
	dw 0x3000

	dw 0xB33B
	dw 0x3000

	dw 0xB3AA
	dw 0x3000

	dw 0xB40F
	dw 0x3000

	dw 0xC44B
	dw 0x3000

	dw 0xC458
	dw 0x3000

	dw 0xC5EA
	dw 0x3000

	dw 0xC61F
	dw 0x3000

	dw 0xEF44
	dw 0x3000

	dw 0xEFD1
	dw 0x3000

	dw 0xF012
	dw 0x3000

	dw 0xF066
	dw 0x3000

	dw 0xF094
	dw 0x3000

	dw 0xF130
	dw 0x3000

before:
	resb 224288

code:
	incbin "code.bin"

	times 0x3f690 - ($-$$) db 0

data:
	incbin "data.bin"

after:
	resb 45912

stack:
	resb 400h
