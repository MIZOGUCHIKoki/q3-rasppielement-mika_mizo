	.include	"common.s"
	.section	.init
	.global		_start
_start:
	mov 	sp,	#STACK

	bl	settings

	ldr	r0,	=TIMER_BASE
	ldr	r1,	[r0, #GPFSEL1]
	ldr	r2,	=soundData
	ldr	r3,	=sound_longData
	ldr	r4,	=sound
	ldr	r5,	=sound_long

	mov	r6,	#0

	ldr	r12,	=PWM_BASE

loop0:
	ldrb	r7,	[r4, r6]
	ldrb	r8,	[r5, r6]		
	ldr	r9,	[r2, r7, lsl #2]	@sound
	ldr	r10,	[r3, r8, lsl #2]	@sound_long
	add	r1,	r1,	r10

	cmp	r9, 	#0
	streq	r9,	[r12, #PWM_DAT2]

	strne	r9,	[r12, #PWM_RNG2]
	lsrne	r9,	r9, 	#1
	strne	r9,	[r12, #PWM_DAT2]

loop1:
	ldr	r7,	=100000
	ldr	r11,	[r0, #GPFSEL1]
	add	r8,	r1,	r7
	cmp	r1,	r11

	movcc	r7,	#0
	strcc	r7,	[r12, #PWM_DAT2]

	cmp	r8,	r11
	bcs	loop1

	add	r6,	r6,	#1
	cmp	r6,	#13
	moveq	r6,	#0
	b	loop0

loop:	b	loop
	
	


	.section	.data
soundData:
	.word	18355, 16354, 14567, 13753, 12244, 10909, 0

sound_longData:
	.word	500000, 250000

sound:
	.byte	0,6, 0,6, 4,6, 4,6, 5,6, 5,6, 4
sound_long:
	.byte	1,1, 1,1, 1,1, 1,1, 1,1, 1,1, 0
	
