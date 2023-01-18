	@r2:sound
	@r3:onp

	.equ	sec1,	1000000
	.equ	sec025,	250000

	.include	"common.s"
	.section	.text
	.global		sound
sound:
	push	{r0 - r8, r14}

	@set GPIO
	ldr	r0,	=GPIO_BASE
	ldr	r1, 	=GPFSEL_VEC0
	str	r1,	[r0, #GPFSEL0 + 0]
	ldr	r1,	=GPFSEL_VEC1
	str	r1,	[r0, #GPFSEL0 + 4]
	ldr	r1, 	=GPFSEL_VEC2
	str	r1,	[r0, #GPFSEL0 + 8]

	@set CM
	ldr	r0, =CM_BASE
	ldr	r1, =0x5a000021
	str	r1, [r0, #CM_PWMCTL]
1:
	ldr	r1, [r0, #CM_PWMCTL]
	tst	r1, #0x80
	bne	1b
	ldr	r1, =(0x5a000000 | (2 << 12))
	str	r1, [r0, #CM_PWMDIV]
	ldr	r1, =0x5a000211
	str 	r1, [r0, #CM_PWMCTL]
	
	@set PWM
	ldr	r0,	=PWM_BASE
	ldr	r1,	=(1 << PWM_PWEN2 | 1 << PWM_MSEN2)
	str	r1,	[r0, #PWM_CTL]

	@set time
	ldr	r4,	=TIMER_BASE
	ldr	r5,	[r4, #GPFSEL1] @Start time
	ldr	r6,	=sec025

	ldr	r9,	=sound_buffer
	mov	r10, 	#0

loop00:
	ldr	r7,	[r4, #GPFSEL1]
	cmp	r5,	r7
	addcc	r5,	r5,	r6
	ldrbcc	r8,	[r9, r10]
	
	
	

	




	pop	{r0 - r8, r14}
	bx	r14
