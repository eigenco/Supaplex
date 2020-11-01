        org     100h

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

        mov     ax, cs
        mov     ds, ax
        mov     si, start
        add     ax, (512+224288)/16
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
        add     ax, 512/16+0x3f60
        mov     ds, ax
        mov     ax, 0x3f00             ; read file
        mov     cx, 56920              ; number of bytes to read
        mov     dx, 0
        int     0x21

        mov     ax, 0x3e00             ; close file
        int     0x21

; ---- perform relocations ----

        mov     bx, cs
        add     bx, (512+224288)/16
        mov     ds, bx

        mov     ax, cs
        add     ax, 512/16
        add     [ds:0x0001], ax ; relocation  #1
        add     [ds:0x0296], ax ; relocation  #2
        add     [ds:0x02bd], ax ; relocation  #3
        add     [ds:0x030e], ax ; relocation  #4
        add     [ds:0x03a9], ax ; relocation  #5
        add     [ds:0x058d], ax ; relocation  #7
        add     [ds:0x09ba], ax ; relocation  #8
        add     [ds:0x0b68], ax ; relocation  #9
        add     [ds:0x0baf], ax ; relocation #10
        add     [ds:0x1754], ax ; relocation #11
        add     [ds:0x1d88], ax ; relocation #12
        add     [ds:0x2e16], ax ; relocation #13
        add     [ds:0x33da], ax ; relocation #14
        add     [ds:0x3440], ax ; relocation #15
        add     [ds:0x46ac], ax ; relocation #16
        add     [ds:0x471b], ax ; relocation #17
        add     [ds:0x478a], ax ; relocation #18
        add     [ds:0x47ef], ax ; relocation #19
        add     [ds:0x582b], ax ; relocation #20
        add     [ds:0x5838], ax ; relocation #21
        add     [ds:0x59ca], ax ; relocation #22
        add     [ds:0x59ff], ax ; relocation #23
        add     [ds:0x8324], ax ; relocation #24
        add     [ds:0x83b1], ax ; relocation #25
        add     [ds:0x83f2], ax ; relocation #26
        add     [ds:0x8446], ax ; relocation #27
        add     [ds:0x8474], ax ; relocation #28
        add     [ds:0x8510], ax ; relocation #29

; ---- initialize video ---
        
        mov     ax, 0x000d
        int     0x10

; ---- EGA style palette assignment ----

        mov     cx, 0x0010
palloop:
        push    cx
        mov     ax, 0x1000
        mov     bl, cl
        dec     bl
        mov     bh, bl
        int     0x10
        pop     cx
        loop    palloop

;        mov     cx, 16
;        mov     dx, 0x3c0
;pal:        
;        mov     al, cl
;        out     dx, al
;        dec     al
;        out     dx, al
;        loop    pal

; ---- 976 pixels wide ----

        mov     dx, 0x3d4
        mov     al, 0x13
        out     dx, al
        inc     dx
        mov     al, 0x3d
        out     dx, al

; ---- prepare stack ----

        mov     ax, cs
        add     ax, 512/16
        add     ax, 0x587b
        mov     ss, ax
        mov     sp, 0x0400

; ---- execute the code ----

        mov     ax, cs
        add     ax, (512+224288)/16
        push    ax
        mov     ax, 0
        push    ax
        retf

data:
        db      "data.bin", 0

start:
        incbin  "code.bin"
