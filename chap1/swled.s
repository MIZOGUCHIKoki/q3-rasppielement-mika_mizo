	.equ	GPIO_BASE,	0x3f200000	
	.equ	GPFSEL1,0x00
	.equ	GPFSEL2,0x04
	.equ	GPFSEL3,0x08
	.equ	GPSET0,	0x1c	
	.equ	GPSET1,	0x28	

	
	.equ	GPFSEL_VEC1,	0x00000001	
	
	.equ	LED_PORT,	10
	.equ	SW1_PORT,	13

	.section	.init
	.global		_start

_start:
	ldr	r0,		=GPIO_BASE

	
	ldr	r1,	=GPFSEL_VEC1
	str     r1,	[r0,	#GPFSEL2]
	mov r3, #(1 << 13)
	mov r4, #(1 << 26)
	mov r5, #(1 << 5)
	mov r6, #(1 << 6)
	
	
loop0:
	ldr r10, [r0, #0x0034]
	mov r9, r10

	and r9, r10, r3
	cmp r9, #0
	bne SW1

	and r9, r10, r4
	cmp r9, #0
	bne SW2

	and r9, r10, r5
	cmp r9, #0
	bne SW3	

	and r9, r10, r6
	cmp r9, #0
	bne SW4	
	b OFF
SW1:
	mov r1, #(1 << LED_PORT)
	str r1, [r0, #GPSET0]
	mov r2, #0x1f0000
1:
	subs r2, r2, #1
	bne 1b

	mov r1, #(1 << 10)
	str r1, [r0, #GPSET0]
	mov r2, #0x1f0000

2:
	subs r2, r2, #1
	bne 2b
	b	loop0
SW2:
	mov r1, #(1 << LED_PORT)
	str r1, [r0, #GPSET0]
	mov r2, #0xc0000
1:
	subs r2, r2, #1
	bne 1b

	mov r1, #(1 << 10)
	str r1, [r0, #GPSET0]
	mov r2, #0xc0000

2:
	subs r2, r2, #1
	bne 2b
	b	loop0
SW3:
	mov r1, #(1 << LED_PORT)
	str r1, [r0, #GPSET0]
	mov r2, #0x1f0000
1:
	subs r2, r2, #1
	bne 1b

	mov r1, #(1 << 10)
	str r1, [r0, #GPSET0]
	mov r2, #0xc0000

2:
	subs r2, r2, #1
	bne 2b
	b	loop0

SW4:
	mov r1, #(1 << LED_PORT)
	str r1, [r0, #GPSET0]
	mov r2, #0x1f0000
	b	loop0

OFF:
	mov	r1,	#(1 << LED_PORT)
	str	r1,	[r0,	#GPSET1]	
	b loop0
	
loop:	b loop		@ 故障防止
