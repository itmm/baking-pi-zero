.section .text

.globl get_gpio_addr
get_gpio_addr:
	ldr r0,=0x20200000
	mov pc,lr

.globl set_gpio_fn
set_gpio_fn:
	pin_nr .req r0
	f_val .req r1
	cmp pin_nr,#53
	cmpls f_val,#7
	movhi pc,lr
	push {lr}
	mov r2,pin_nr
	.unreq pin_nr
	pin_nr .req r2
	bl get_gpio_addr
	gpio_addr .req r0
sgf_loop$:
	cmp pin_nr,#9
	subhi pin_nr,#10
	addhi gpio_addr,#4
	bhi sgf_loop$

	add pin_nr, pin_nr,lsl #1
	lsl f_val,pin_nr
	str f_val,[gpio_addr]
	.unreq gpio_addr
	.unreq pin_nr
	.unreq f_val
	pop {pc}

.globl set_gpio
set_gpio:
	pin_nr .req r0
	pin_val .req r1
	cmp pin_nr,#53
	movhi pc,lr
	push {lr}
	mov r2,pin_nr
	.unreq pin_nr
	pin_nr .req r2
	bl get_gpio_addr
	gpio_addr .req r0
	pin_bank .req r3
	lsr pin_bank, pin_nr,#5
	lsl pin_bank,#2
	add gpio_addr, pin_bank
	.unreq pin_bank
	and pin_nr,#31
	set_bit .req r3
	mov set_bit,#1
	lsl set_bit,pin_nr
	.unreq pin_nr
	teq pin_val,#0
	.unreq pin_val
	streq set_bit,[gpio_addr,#40]
	strne set_bit,[gpio_addr,#28]
	.unreq set_bit
	.unreq gpio_addr
	pop {pc}

