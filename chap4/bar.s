	.include	"common.s"

	.equ	T,	3000000

	.section	.init
	.global		_start

_start:
	ldr	r0,	=GPIO_BASE
	ldr	r1, 	=GPFSEL_VEC0
	str	r1,	[r0, #GPFSEL0 + 0]
	ldr	r1,	=GPFSEL_VEC1
	str	r1,	[r0, #GPFSEL0 + 4]
	ldr	r1, 	=GPFSEL_VEC2
	str	r1,	[r0, #GPFSEL0 + 8]

	ldr	r1,	=(1 << ROW2_PORT | 1 << ROW3_PORT | 1 << ROW4_PORT | 1 << ROW5_PORT | 1 << ROW6_PORT | 1 << ROW7_PORT | 1 << ROW8_PORT)
	str	r1,	[r0, #GPSET0]
	ldr	r1,	=(1 << ROW1_PORT)
	str	r1,	[r0, #GPCLR0]

	ldr	r2,	=T
	ldr	r3,	=TIMER_BASE
	ldr	r4,	[r3, #GPFSEL1]

	ldr	r5,	=waite
	ldr	r7,	=port
	ldr	r1,	=on
	mov 	r8,	#0
	
loop0:
	ldr	r9, 	[r3, #GPFSEL1]
loop1:
	ldr	r5,	=waite
	ldr	r12,	[r5, r8, lsl #2]
	add	r10,	r4,	r12
	
	cmp	r10,	r9
	addcs	r6, 	r12,	r2
	strcs	r6,	[r5, r8, lsl #2]
	
	bcs	cmp
	b	next
	
cmp:
	mov	r10,	#1
	ldr	r5,	[r7, r8]
	lsl	r10,	r10,	r5
	ldr	r11,	[r1, r8]
	cmp	r11,	#0
	strne	r10,	[r0, #GPSET0]
	streq	r10,	[r0, #GPCLR0]

next:	
	add	r8,	r8,	#1
	cmp	r8, 	#16
	bne	loop1
	moveq	r8, 	#0
	ldreq	r4,	[r3, #GPFSEL1]
	beq	loop0
	
loop:	b	loop
	
	

	.section	.data

waite:
	.word	0x00, 0x3e80, 0x13880, 0x2ee00,	0x55f00, 0x88b80, 0xc7380, 0x1117000,0x2625a0, 0x25e720, 0x24ed20, 0x2337a0, 0x20c6a0, 0x1d9a20, 0x19b220, 0x150ea0

port:
	.byte 	27, 8, 25, 23, 24, 22, 17, 4, 27, 8, 25, 23, 24, 22, 17, 4
on:
	.byte	1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0
	
