	.equ	GPIO_BASE,		0x3f200000
	.equ	GPFSEL0,			0x00
	.equ	GPSET0,				0x1c			@	出力値1
	.equ	GPCLR0,				0x28			@ 出力値0

	.equ	GPFSEL_VEC0,	0x01201000
		@	GPIO 4, 7, 8	を出力に設定
	.equ	GPFSEL_VEC1,	0x01249041
		@ GPIO 12, 14, 15, 16, 17, 18 を出力に設定
	.equ	GPFSEL_VEC2,	0x00209249
		@ GPIO 21, 22, 23, 24, 25, 27 を出力に設定
		
	.equ COL1_PORT, 27
	.equ COL2_PORT, 8
	.equ COL3_PORT, 25
	.equ COL4_PORT, 23
	.equ COL5_PORT, 24
	.equ COL6_PORT, 22
	.equ COL7_PORT, 17
	.equ COL8_PORT, 4
	.equ ROW1_PORT, 14
	.equ ROW2_PORT, 15
	.equ ROW3_PORT, 21
	.equ ROW4_PORT, 18
	.equ ROW5_PORT, 12
	.equ ROW6_PORT, 20
	.equ ROW7_PORT, 7
	.equ ROW8_PORT, 16

	.section .init
	.global _start
_start:
	@ set to output device LED , Display
	ldr	r0,	=GPIO_BASE
	@ 0-9 の一部を出力設定
	ldr	r1,	=GPFSEL_VEC0
	str	r1,	[r0,	#GPFSEL0 + 0]	
	@ 10-19 の一部を出力設定
	ldr	r1,	=GPFSEL_VEC1
	str	r1,	[r0,	#GPFSEL0 + 4] 
	@ 20-29 の一部を出力設定
	ldr	r1,	=GPFSEL_VEC2
	str	r1,	[r0,	#GPFSEL0 + 8]

loop0:
	@ col3, row2
	mov     r1, #(1 << COL1_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL2_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL3_PORT)
	str     r1, [r0, #GPSET0]			@	COL3, set "1"
	mov     r1, #(1 << COL4_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL5_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL6_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL7_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL8_PORT)
	str     r1, [r0, #GPCLR0]

	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPCLR0]			@ ROW2,	set "0"
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ col7,	row4
	mov     r1, #(1 << COL1_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL2_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL3_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL4_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL5_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL6_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL7_PORT)
	str     r1, [r0, #GPSET0]		@COL7,	set"1"
	mov     r1, #(1 << COL8_PORT)
	str     r1, [r0, #GPCLR0]

	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPCLR0]		@ROW7,	set"0"
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]
	b loop0
loop:
	b       loop
