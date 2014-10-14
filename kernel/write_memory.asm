;void write_memory(int address, int data)
[BITS 32]
GLOBAL _write_memory
_write_memory:
	MOV ECX, [ESP+4]
	MOV AL, [ESP+8]
	MOV [ECX], AL
	RET
;VideoMemory: 0xa0000 - 0xaffff
;
;
;
;
;
;
;
;
;
;
;
;
;
