	.equ	PWM_HZ,		9600*1000
	.equ	KEY_A4,		PWM_HZ/440
	
	.equ	PWM_BASE,	0x3f20c000
	.equ	PWM_CTL,	0x00
	.equ	CTL_PWEN2,	15
	.equ	CTL_MSEN2,	8
	.equ	PWM_RNG2,	0x20
	.equ	PWM_DAT2,	0x24


	.include	"common.s"

	.section	.init
	.global		_start

_start:
	@set GPIO
	ldr	r0,	=GPIO_BASE
	ldr	r1, 	=GPFSEL_VEC0
	str	r1,	[r0, #GPFSEL0 + 0]
	ldr	r1,	=GPFSEL_VEC1
	str	r1,	[r0, #GPFSEL0 + 4]
	ldr	r1, 	=GPFSEL_VEC2
	str	r1,	[r0, #GPFSEL0 + 8]

	@set CM
	ldr     r0, =CM_BASE
	ldr     r1, =0x5a000021                     @  src = osc, enable=false
	str     r1, [r0, #CM_PWMCTL]

1:    @ wait for busy bit to be cleared
	ldr     r1, [r0, #CM_PWMCTL]
	tst     r1, #0x80
	bne     1b

	ldr     r1, =(0x5a000000 | (2 << 12))  @ div = 2.0
	str     r1, [r0, #CM_PWMDIV]
	ldr     r1, =0x5a000211                   @ src = osc, enable=true
	str     r1, [r0, #CM_PWMCTL]

	@set PWM
	ldr	r0,	=PWM_BASE
	ldr	r1,	=(1 << CTL_PWEN2 | 1 << CTL_MSEN2)
	str	r1,	[r0, #PWM_CTL]

	@ra
	ldr	r1,	=KEY_A4
	str	r1,	[r0, #PWM_RNG2]
	lsr	r1,	r1,	#1
	str	r1,	[r0, #PWM_DAT2]

loop:	b 	loop
	
