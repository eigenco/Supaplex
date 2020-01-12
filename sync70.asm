        push    ax
        mov     ah, [cnt]
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
        mov     [cnt], ah
        pop     ax
        iret
cnt:
        db      0
