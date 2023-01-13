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

	ldr	r1,	=(1 << ROW1_PORT | 1 << ROW2_PORT | 1 << ROW3_PORT | 1 << ROW4_PORT | 1 << ROW5_PORT | 1 << ROW6_PORT | 1 << ROW7_PORT | 1 << ROW8_PORT)
	str	r1,	[r0, #GPSET0]

	ldr	r2,	=T
	ldr	r3,	=TIMER_BASE
	ldr	r4,	[r3, #GPFSEL1]

	ldr	r5,	=waite
	ldr	r6,	=frame_buffer
	mov 	r7,	#0x80
	mov 	r8,	#0

loop0:
	ldr	r9, 	[r3, #GPFSEL1]
loop1:
	ldr	r12,	[r5, r8, lsl #2]
	add	r9,	r9,	r12
	cmp	r4, 	r9
	
	strcc	r7,	[r6]
	addcc	r9, 	r9,	r2
	strcc	r9,	[r5, r8, lsl #2]
	
	bl	display
	
	add	r8,	#1
	cmp	r8, 	#9
	ldrne	r4,	[r5, r8, lsl #2]
	lsrne	r10,	r7,	r8
	eorne	r7,	r7,	r10
	moveq	r8, 	#0
	beq	loop0
	b	loop1

loop:	b	loop
	
	

	.section	.data
	.global		frame_buffer
frame_buffer:
	.byte 0x00,	0x00,	0x00,	0x00,	0x00,	0x00,	0x00,	0x00

waite:
	.word	0x00, 0x3e80, 0x13880, 0x2ee00,	0x55f00, 0x88b80, 0xc7380, 0x1117000,0x2625a0, 0x25e720, 0x24ed20, 0x2337a0, 0x20c6a0, 0x1d9a20, 0x19b220, 0x150ea0
	
	
