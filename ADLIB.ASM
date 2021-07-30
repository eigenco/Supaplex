%define OPL3
; %define OPL2

incbin  "adlib.snd", 0, 1092

	out     dx, al

%ifdef OPL3
	times 2 in al, dx
%endif
%ifdef OPL2
	times 6 in al, dx
%endif

	inc     dx
	mov     al, ah
	out     dx, al

%ifdef OPL3
	times 3 in al, dx
%endif
%ifdef OPL2
	times 35 in al, dx
%endif

	dec     dx
	ret

incbin  "adlib.snd", $
