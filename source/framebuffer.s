.section .data
.align 4
.globl framebuffer_info
framebuffer_info:
	.int 1024 /* #0 physical width */
	.int 768 /* #4 physical height */
	.int 1024 /* #8 virtual width */
	.int 768 /* #12 virtual height */
	.int 16 /* #16 bit depth */
	.int 0 /* #20 x */
	.int 0 /* #24 y */
	.int 0 /* #28 gpu pointer */
	.int 0 /* #32 gpu screen size */
	.int 0 /* #36 gpu pitch */

.section .text
.globl init_framebuffer
init_framebuffer:
	width .req r0
	height .req r1
	bit_depth .req r2
	cmp width,#4096
	cmpls height,#4096
	cmpls bit_depth,#32
	result .req r0
	movhi result,#0
	movhi pc,lr

	fb_info_addr .req r3
	push {lr}
	ldr fb_info_addr,=framebuffer_info
	str width,[fb_info_addr, #0]
	str height,[fb_info_addr, #4]
	str width,[fb_info_addr, #8]
	str height,[fb_info_addr, #12]
	str bit_depth,[fb_info_addr, #16]
	.unreq width
	.unreq height
	.unreq bit_depth

	mov r0, fb_info_addr
	add r0, #0x40000000
	mov r1, #1
	bl mailbox_write

	mov r0, #1
	bl mailbox_read

	teq result,#0
	movne result,#0
	popne {pc}

	mov result,fb_info_addr
	pop {pc}
	.unreq result
	.unreq fb_info_addr

