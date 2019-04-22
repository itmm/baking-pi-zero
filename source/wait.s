.section .text

.globl wait
wait:
	mov r2,#0x3f0000
wait_loop$:
	sub r2,#1
	cmp r2,#0
	bne wait_loop$
	mov pc,lr
