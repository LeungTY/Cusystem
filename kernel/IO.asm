
;void IO_STI();
;void IO_CLI();
;void IO_HALT();
;void IO_LOADEFLAG()
;void IO_SAVEEFLAG(int EfFag)
;void PIC_int()
[BITS 32]
GLOBAL _IO_STI
GLOBAL _IO_CLI
GLOBAL _IO_HALT
GLOBAL _IO_LOADEFLAG
GLOBAL _IO_SAVEEFLAG
GLOBAL _PIC_INT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_IO_STI:
	STI
	RET
	
_IO_CLI:
	CLI
	RET
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_IO_HALT:
	HLT
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_LOADEFLAG:
	PUSHFD;PUSH EFLAG
	POP EAX
	RET
	
_SAVEEFLAG:
	MOV EAX, [ESP+4]
	PUSH EAX
	POPFD;POP EFLAG
	RET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_PIC_INT:
	pusha
	call _int_handler
	popa
	iret
