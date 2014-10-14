;\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;  bootloader1.asm                                                    |
;   By MetalPipeLover                                                |
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

	ORG 0x7c00
	jmp 0x0000:bootloader1_start

bootloader1_start:
	mov ax, 0
	mov ds, ax
	mov es, ax 
	cli
	mov bp, 0x7c00
	mov sp, bp
	mov ss, ax
	sti
	mov [drive], dl
.load:
	mov bx, 0x7E00
	mov  dl, [drive]
	
	push dx
	mov ah, 0x02
	mov al, 1
	mov ch, 0
	mov dh, 0
	mov cl, 2
	int 13h
	jc .error
	pop dx
	cmp al, 1
	jne .broke
	jmp .loader2
.error:
	mov bx, errormsg
	call println
	call halt
.broke:
	mov bx, brokemsg
	call println
	call halt
.loader2:
	mov bx, 0x07c0
	mov es, bx
	mov bx, 0x200
	push es
	push bx
	retf
	jmp $

println:
	mov ah, 0x0e
.print_loop:
	mov al, [bx]
	cmp al, 0
	je .over
	int 10h
	inc bx
	jmp .print_loop
.over:
	ret
halt:
	mov bx, haltmsg
	call println
	hlt
drive db 0
errormsg db 'Got error!', 0
brokemsg db 'disk is broken', 0
haltmsg db 'system halt', 0
	
times 510-($-$$) db 0
dw 0xAA55
	
