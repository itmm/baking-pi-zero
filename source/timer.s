.section .text

.globl get_systimer_base
get_systimer_base:
	ldr r0,=0x20003000
	mov pc,lr

.globl get_systime
get_systime:
	push {lr}
	bl get_systimer_base
	ldrd r0,r1,[r0,#4]
	pop {pc}


.globl wait
wait:
	delay .req r2
	mov delay,r0
	push {lr}
	bl get_systime
	start .req r3
	mov start, r0
wait_loop$:
	bl get_systime
	elapsed .req r1
	sub elapsed,r0,start
	cmp elapsed,delay
	.unreq elapsed
	bls wait_loop$
	.unreq delay
	.unreq start
	pop {pc}
