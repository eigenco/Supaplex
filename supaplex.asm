        org     100h

; ---- initialize roland and sound blaster ----

        mov     dx, 0x331
        mov     al, 0x3f
        out     dx, al  
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

; ---- move code to intended address ----

        mov     ax, cs
        mov     ds, ax
        mov     si, start
        add     ax, (512+224288)/16
        mov     es, ax
        mov     di, 0
        mov     cx, 35286
        rep     movsb

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
        add     [ds:1], ax
        add     [ds:662], ax
        add     [ds:701], ax
        add     [ds:782], ax
        add     [ds:937], ax
        add     [ds:1015], ax
        add     [ds:1421], ax
        add     [ds:2490], ax
        add     [ds:2920], ax
        add     [ds:2991], ax
        add     [ds:5972], ax
        add     [ds:7560], ax
        add     [ds:11798], ax
        add     [ds:13274], ax
        add     [ds:13376], ax
        add     [ds:18092], ax
        add     [ds:18203], ax
        add     [ds:18314], ax
        add     [ds:18415], ax
        add     [ds:22571], ax
        add     [ds:22584], ax
        add     [ds:22986], ax
        add     [ds:23039], ax
        add     [ds:33572], ax
        add     [ds:33713], ax
        add     [ds:33778], ax
        add     [ds:33862], ax
        add     [ds:33908], ax
        add     [ds:34064], ax

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
