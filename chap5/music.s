	.include	"common.s"
	.section	.init
	.global		_start

_start:
	mov	sp,	#STACK
	
	bl	settings
	
	ldr	r0,	=TIMER_BASE
	ldr	r1,	[r0, #GPFSEL1]
	ldr	r2,	=soundData
	ldr	r3,	=doremi
	ldr	r4,	=sound_long
	mov	r5,	#0

	ldr	r10,	=PWM_BASE
	mov	r11,	#0

	

loop0:
	ldrb	r6,	[r3, r5]
	ldr	r7,	[r2, r6, lsl #2]	@doremi
	ldr	r8,	[r4, r5, lsl #2]	@sound_long
	add	r1,	r1,	r8

	
	str	r7,	[r10, #PWM_RNG2]
	lsr	r7,	r7,	#1
	str	r7,	[r10, #PWM_DAT2]
loop1:	
	ldr	r9, 	[r0, #GPFSEL1]
	cmp	r1,	r9
	bcs	loop1

	str	r11, 	[r10, #PWM_DAT2]
	ldr	r12,	=0xffff
1:
	subs	r12,	r12,	#1
	bne	1b
	
	add	r5,	r5,	#1
	cmp	r5,	#42
	bne	loop0

loop:	b	loop


	.section	.data
soundData:
	.word	18355, 16354, 14567, 13753, 12244, 10909
sound_long:
	.word	500000, 500000, 500000, 500000, 500000, 500000, 1000000
	.word	500000, 500000, 500000, 500000, 500000, 500000, 1000000
	.word	500000, 500000, 500000, 500000, 500000, 500000, 1000000
	.word	500000, 500000, 500000, 500000, 500000, 500000, 1000000
	.word	500000, 500000, 500000, 500000, 500000, 500000, 1000000
	.word	500000, 500000, 500000, 500000, 500000, 500000, 1000000
doremi:
	.byte 	0, 0, 4, 4, 5, 5, 4
	.byte	3, 3, 2, 2, 1, 1, 0
	.byte	4, 4, 3, 3, 2, 2, 1
	.byte	4, 4, 3, 3, 2, 2, 1
	.byte 	0, 0, 4, 4, 5, 5, 4
	.byte	3, 3, 2, 2, 1, 1, 0
	

