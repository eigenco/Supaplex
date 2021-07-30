%define PC        

%ifndef PC
        incbin  "roland.snd", $, 0x0084-$
        ret

        incbin  "roland.snd", $, 0x0098-$
        mov     dx, 0x330
        mov     al, ah
        out     dx, al
        ret
%endif

        ; eliminate clipping due to too excessive volume

        incbin  "roland.snd", $, 0x0189-$
        nop
        nop
        nop

        incbin  "roland.snd", $, 0x018E-$
        nop
        nop
        nop

        incbin  "roland.snd", $, 0x0193-$
        nop
        nop
        nop

        incbin  "roland.snd", $
