	.include	"common.s"
	.section	.init
	.global		_start
_start:
	mov	sp,	#STACK
	ldr	r0,	=TIMER_BASE
	ldr	r1,	[r0, #GPFSEL1]
	ldr	r9,	=time
	str	r1,	[r9]
	ldr	r8,	[r0, #GPFSEL1]
	ldr	r5,	[r0, #GPFSEL1]
	ldr	r2,	=100000
	ldr	r4,	=700000
	add	r8,	r8,	r2
	add	r5,	r5,	r4
	add	r1, 	r1,	r4
	mov	r6,	#0

loop00:
	ldr	r3,	[r0, #GPFSEL1]

	cmp	r8,	r3
	addcc	r8,	r8,	r2
	bcc	jumpsound
	
	cmp	r1,	r3
	bl	led_on
	addcc	r5,	r5,	r4

	cmp	r5,	r3
	bl	led_off
	addcc	r1,	r1,	r2

	b	loop00

jumpsound:
	bl	sound
	b	loop00
