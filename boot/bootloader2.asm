;\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;  bootloader2.asm                                                  |
;   By MetalPipeLover                                              |
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
	ORG 0x7E00

	jmp 0x0000:bootloader2_start
Kernel_Address equ 0x200

GDT: ;define gdt
	GDT_start:
	GDT_null:
		dd 0x0
		dd 0x0
	GDT_code:
		dw 0xffff
		dw 0x0
		dw 0x0
		db 10011010b
		db 11001111b
		db 0x0
	GDT_data:
		dw 0xffff
		dw 0x0
		db 0x0
		db 10010010b
		db  11001111b
		db 0x0
	GDT_end:
	Des:
		dw GDT_end-GDT_start-1
		dd GDT_start
	code_seg equ GDT_code-GDT_start
	data_seg equ GDT_data-GDT_start

bootloader2_start:
	xor ax, ax
	mov ds, ax
	mov ss, ax
	
	cli ;disable int
	mov bp, 0x7c00
	mov sp, bp
	mov ss, ax
	sti
	call check_mem
	mov [drive], dl
	mov bx, Kernel_Address
	mov dh, sector
	mov dl, [drive]
	push dx
	mov ah, 0x02
	mov al, dh
	mov ch, 0
	mov dh, 0
	mov cl, 3
	int 13h
	jc .diskerror
	pop dx
	cmp dh, dl
	jne .loaderror
	jmp protect_mode
.diskerror:
	mov bx, diskerrormsg
	call println
	call halt
	mov ah, 0
	int 16h
.loaderror:
    mov bx, loaderrormsg;;;;;;
    call println;;;;;;
	call halt
	mov ah, 0
	int 16h
protect_mode:
	cli
	lgdt [Des]	

	mov eax, cr0
	or eax, 0x1
	mov cr0, eax
	
	in al, 92h ;enable A20 data line
	or al, 00000010b
	out 92h, al
	
	mov ax, data_seg
	mov ds, ax
	mov ss, ax
    mov es, ax
	mov fs, ax
	mov gs, ax
	mov ebp, 0x90000
	mov esp, ebp
	jmp Kernel_Address
	jmp $
	
	

[bits 16]    
check_mem:
	xor ax, ax
	int 12h
	 jc .mem_error
    ; ax now contains the # of kB from zero of continuous memory
    mov bx, ax
    call printint
    mov bx, MSG_KB
    call println
    mov ah, 0
     int 16h
    ret
 .mem_error:
	mov bx, memerror
	call println
	call halt
halt:
	mov bx, haltmsg
	call println
	jmp $
println:
	call print
	mov al, 0x0D		; LF CR
	int 0x10
	mov al, 0x0A
	int 0x10
	ret
print:
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
	
printint:
	push dx
	push bx
	push ax
	xor dx, dx
	mov ax, bx
	mov bx, 100
	div bx		;divide dx:ax by bx, store in ax, remainder in dx
	mov [NUM_BUFFER], al
	add [NUM_BUFFER], byte '0'
	mov ax, dx
	xor dx, dx
	mov bx, 10
	div bx
	mov [NUM_BUFFER+1], al
	add [NUM_BUFFER+1], byte '0'
	mov [NUM_BUFFER+2], dx
	add [NUM_BUFFER+2], byte '0'
	mov bx, NUM_BUFFER
	call print
	pop ax
	pop bx
	pop dx
    ret
memerror db 'mem error', 0
haltmsg db 'Got error , Halt.' , 0	
drive db 0
sector equ 55
NUM_BUFFER		db '000', 0
MSG_KB db ' is availble', 0

diskerrormsg db 'Error: Disk error', 0
loaderrormsg db 'Error: cant load kernel', 0
times 510-($-$$) db 0
dw 0xAA55
