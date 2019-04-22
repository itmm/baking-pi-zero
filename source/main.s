.section .init
.globl _start
_start:
	mov sp, #0x8000
	b main

.section .text
main:
	pin_nr .req r0
	delay .req r0
	pin_f .req r1
	mov pin_nr,#47
	mov pin_f,#1
	bl set_gpio_fn
	.unreq pin_f

	pin_val .req r1
	ptrn .req r4
	ldr ptrn,=pattern
	ldr ptrn,[ptrn]
	seq .req r5
	mov seq,#0

loop$:
	mov r1,#1
	lsl r1,seq
	and r1,ptrn
	teq pin_val,#0
	
	moveq pin_val,#0
	movne pin_val,#1
	mov pin_nr,#47
	bl set_gpio

	ldr delay,=300000
	bl wait

	add seq,seq,#1
	and seq,seq,#0x1f

	b loop$

	.unreq ptrn
	.unreq seq
	.unreq pin_val
	.unreq pin_nr
	.unreq delay

.section .data
.align 2
pattern:
	.int 0b11111111101010100010001000101010
