	.equ 	GPIO_BASE,	0x3f200000
	.equ	GPFSEL1,	0x00
	.equ	GPFSEL2,	0x04
	.equ	GPFSEL3,	0x08

	.equ	GPSET0,		0x1c
	.equ	GPCLR0,		0x28

	.equ	LED_PORT,	10
	.equ	GPFSEL_VEC1,	0x00000001

	.equ	COUNT,		0x1fd000



	.section .text
	.global _start

_start:
	ldr	r0,	=GPIO_BASE

	ldr	r1, 	=GPFSEL_VEC1
	str	r1,	[r0, #GPFSEL2]

	mov	r1,	#(1 << LED_PORT)

	ldr	r3,	=COUNT

loop:
	ldr	r2, 	[r0, -r3]

	tst	r2,	#(1 << 19)
	strne	r1, 	[r0, #GPSET0]
	streq	r1,	[r0, #GPCLR0]

	b 	loop

	
