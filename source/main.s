.section .init
.globl _start
_start:
	mov sp, #0x8000
	b main

.section .text
main:
	mov r0, #1024
	mov r1, #768
	mov r2, #16
	bl init_framebuffer
	teq r0,#0
	bne no_error$

	mov r0, #47
	mov r1, #1
	bl set_gpio_fn

error$:
	mov r0, #47
	mov r1, #1
	bl set_gpio

	ldr r0, =250000
	bl wait

	mov r0, #47
	mov r1, #0
	bl set_gpio

	ldr r0, =250000
	bl wait

	b error$

no_error$:
	fb_info_addr .req r4
	mov fb_info_addr, r0

render$:
	fb_addr .req r3
	ldr fb_addr,[fb_info_addr,#16]

	color .req r0
	y .req r1
	mov y, #768
	
	draw_row$:
		x .req r2
		mov x,#1024
		draw_pixel$:
			strh color,[fb_addr]
			add fb_addr,#2
			sub x,#1
			teq x,#0
			bne draw_pixel$

		sub y, #1
		add color,#1
		teq y, #0
		bne draw_row$

/*
	mov r0, #47
	mov r1, #1
	bl set_gpio_fn

render2$:
	mov r0, #47
	mov r1, #1
	bl set_gpio

	ldr r0, =250000
	bl wait

	mov r0, #47
	mov r1, #0
	bl set_gpio

	ldr r0, =750000
	bl wait

	b render2$
*/

	b render$

	.unreq fb_addr
	.unreq fb_info_addr

