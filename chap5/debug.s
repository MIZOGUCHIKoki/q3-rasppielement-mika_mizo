@	debug_on
@ 	Turn LED ON only between 0xff
@ debug_momentarily
@ 	Turn LED ON momentarily
	.include	"common.s"
	.section	.text
	.global		debug_on, debug_momentarily
debug_on:
	push	{r0 - r2, r14}
	ldr		r0,	=GPIO_BASE
	mov		r1,	#(1 << 10)
	ldr		r2,	0xff
	str		r1,	[r0, #GPSET0]
loop:
	subs	r2,	r2,	#1
	bne		loop
	str		r1,	[r0, #GPCLR0]
	pop		{r0 - r2, r14}
	bx		r14

debug_momentarily:
	push	{r0 - r2, r14}
	bl		debug_setting
	mov		r1,	#(1 << 10)
	str		r1,	[r0, #GPSET0]
	pop		{r0 - r2, r14}
	bx		r14

debug_setting:
	ldr		r0,	=GPIO_BASE
	ldr		r1,	=GPFSEL_VEC1
	str		r1,	[r0, #GPFSEL1]
	bx		r14
