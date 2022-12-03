incbin "supaplex.exe",$,0x36cfe-$ ; disable copy protection
   times 3 nop

incbin "supaplex.exe",$,0x39098-$ ; PIT_
   nop

incbin "supaplex.exe",$,0x3c059-$ ; disable mouse (related bug)
   ret

incbin "supaplex.exe",$,0x3c0e6-$ ; use menu with backspace (related bug)
   db 0x80, 0x3e, 0x7b, 0x16, 0x01 ; cmp [0x0167B],1

incbin "supaplex.exe",$,0x3c189-$ ; 70 Hz issue
   push dx
   push bx
   push ax
   mov dx,0x3da
   xor bx, bx
j1:
   cmp bx, 10000 ; 386DX40 = 1000, PII266 = 10000
   ja j2
   sti
   inc bx
   cli
j2:
   in al,dx
   and al,8
   je j1
   mov dx,0x3c0
   mov al,0x33
   out dx,al
   db 0xa0, 0x96, 0x0d ; mov al,[d96]
   out dx,al
   sti
   pop ax
   pop bx
   pop dx
   retn

incbin "supaplex.exe",$,0x3c21c-$ ; fix MiST/Next186 resolution issue
   mov al,0x31

incbin "supaplex.exe",$,0x42d40-$
   db "MOVING.NEW"
incbin "supaplex.exe",$,0x42de4-$
   db "ROLAND.NEW"
incbin "supaplex.exe",$
