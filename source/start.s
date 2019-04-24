.section .init
.globl _start
.globl main
_start:
	mov sp, #0x8000
	b main
