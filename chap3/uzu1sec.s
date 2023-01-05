	.include	"common.s"
	.start		.init
	.globsl		_start

_start:
	ldr		r0,		=GPIP_BASE
	ldr		r13,	=TIMER_BASE

	ldr		r1, =GPFSEL_VEC0
	str		r1, [r0, #GPFSEL0 + 0]
	ldr		r1, =GPFSEL_VEC1
	str		r1, [r0, #GPFSEL0 + 4]
	ldr		r1, =GPFSEL_VEC2
	str		r1, [r0, #GPFSEL0 + 8]

	mov		sp,	#STACK					@ clear stack pointer

loop:
	b	loop
