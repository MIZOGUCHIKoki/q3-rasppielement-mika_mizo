	.include	"common.h"
	.section 	.init
	.global 	_start
_start:
	@ LEDとディスプレイ用のIOポートを出力に設定する
	ldr	r0, =GPIO_BASE
	ldr	r1, =GPFSEL_VEC0
	str	r1, [r0, #GPFSEL0 + 0]
	ldr	r1, =GPFSEL_VEC1
	str	r1, [r0, #GPFSEL0 + 4]
	ldr	r1, =GPFSEL_VEC2
	str	r1, [r0, #GPFSEL0 + 8]
	
	ldr	r5,	=frame_buffer		@ Read frame_buffer address
	mov	r3,	#0x1
	bl	clear				@ turn all LEDs off 
rowRead:
	row1:
		and	r2,	r5,	r3
		cmp	r2,	#0
		beq	row2
		mov	r1,	#(1 << ROW1_PORT)
		str	r1,	[r0,	#GPSET0]
	row2:
		and	r2,	r5, r3,	lsl #1
		cmp	r2,	#0
		beq	row3
		mov	r1,	#(1 << ROW2_PORT)
		str	r1,	[r0,	#GPSET0]
	row3:
		and	r2,	r5, r3,	lsl #2
		cmp	r2,	#0
		beq	row4
		mov	r1,	#(1 << ROW3_PORT)
		str	r1,	[r0,	#GPSET0]
	row4:
		and	r2,	r5, r3,	lsl #3
		cmp	r2,	#0
		beq	row5
		mov	r1,	#(1 << ROW4_PORT)
		str	r1,	[r0,	#GPSET0]
	row5:
		and	r2,	r5, r3,	lsl #4
		cmp	r2,	#0
		beq	row6
		mov	r1,	#(1 << ROW5_PORT)
		str	r1,	[r0,	#GPSET0]
	row6:
		and	r2,	r5,	r3,	lsl	#5
		cmp	r2,	#0
		beq	row7
		mov	r1,	#(1 << ROW6_PORT)
		str	r1,	[r0,	#GPSET0]
	row7:
		and	r2,	r5, r3,	lsl #6
		cmp	r2,	#0
		beq	row8
		mov	r1,	#(1 << ROW7_PORT)
		str	r1,	[r0,	#GPSET0]
	row8:
		and	r2,	r5, r3,	lsl #7
		cmp	r2,	#0
		beq	colP
		mov	r1,	#(1 << ROW8_PORT)
		str	r1,	[r0,	#GPSET0]
	colP:
		mov	r1,	#(1 << COL1_PORT)
		str	r1,	[r0,	#GPCLR0]		@	set "0" to COL
loop:
	b	loop
clear:
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
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL8_PORT)
	str     r1, [r0, #GPCLR0]

	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]
	bx			r14
