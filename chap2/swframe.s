	.include "common.h"
	.equ SW1_PORT, 13
	
	.section .text
	.global _start
_start:
	ldr	r0, =GPIO_BASE
	ldr	r1, =GPFSEL_VEC0
	str	r1, [r0, #GPFSEL0 + 0]
	ldr	r1, =GPFSEL_VEC1
	str	r1, [r0, #GPFSEL0 + 4]
	ldr	r1, =GPFSEL_VEC2
	str	r1, [r0, #GPFSEL0 + 8]
	
	mov 	r1, #(1 << SW1_PORT)
	ldr	r2, =1
	mov	r3, r2
	ldr	r4, =frame_buffer
	ldr	r5, =(1 << ROW1_PORT | 1 << ROW2_PORT | 1 << ROW3_PORT | 1 << ROW4_PORT | 1 << ROW5_PORT | 1 << ROW6_PORT | 1 << ROW7_PORT | 1 << ROW8_PORT)
	str	r5, [r0, #GPSET0]

	mov	sp,	#STACK						
	mov	r3,	#0x1

	

loop0:
	ldr	r10, [r0, #0x0034]
	tst	r10, r1
	beq	hyouji

	mov	r2, #0x80
	strb	r2, [r4]

	@cmp	r2, #0xffffffff
	@streq	r3, [r4, #4]
	@asreq	r3, r3, #1
	@asrne	r2, r2, #1
	
hyouji:	
	bl	display
	ldr	r5, =0xffff

1:
	subs	r5, r5, #1
	bne 1b

	b loop0


loop:	b	loop

	
	.section .data
	.global frame_buffer
frame_buffer:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	

	
	
