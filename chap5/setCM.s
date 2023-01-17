	.include	"common.s"
	.section	.text
	.global		setCM
setCM:
	push	{r0, r1}
	ldr	r0, =CM_BASE
	ldr	r1, =0x5a000021
	str	r1, [r0, #CM_PWMCTL]
1:ldr	r1, [r0, #CM_PWMCTL]
	tst	r1, #0x80
	bne	1b
	ldr	r1, =(0x5a000000 | (2 << 12))
	str	r1, [r0, #CM_PWMDIV]
	ldr	r1, =0x5a000211
	str r1, [r0, #CM_PWMCTL]
	pop	{r0, r1}
	bx	r14
