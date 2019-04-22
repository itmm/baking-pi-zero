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
loop$:
	mov pin_nr,#47
	mov pin_val,#0
	bl set_gpio

	ldr delay,=300000
	bl wait

	mov pin_nr,#47
	mov pin_val,#1
	bl set_gpio

	ldr delay,=700000
	bl wait

	.unreq pin_val
	.unreq pin_nr
	.unreq delay

	b loop$

