.include "common.h"
	.equ SW1_PORT, 13
	
	.section .text
	.global _start
_start:
	ldr 	r2, =frame_buffer
	ldr	r9, =frame_buffer
	mov 	r3, #(1 << SW1_PORT)

	mov	r4, #128

loop0:
	ldr	r10, [r0, #0x0034]
	and 	r10, r10, r3
	lsr 	r10, r10, #SW1_PORT
	cmp 	r10, #0
	beq	frame

	

	ldr 	r5, [r2]
	cmp	r5, #0
	streq	r4, [r2]

	bl 	frame

	asr	r4, r4, #1
	str	r4, [r2]
	cmp	r5, #255
	addeq 	r2, r2, #4
	addeq 	r7, r7, #1
	cmp 	r7, #8
	beq	next
	b 	loop0

next:
	mov 	r2, r9
	ldr	r5, [r2]

	bl 	frame
	
	cmp	r5, #0
	lsrne	r5, r5, #1
	strne	r5, [r2]
	bne	next
	b 	loop0

loop:	b	loop
	
	
	

	
	
