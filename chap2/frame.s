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
	
	mov	sp,	#STACK					@ clear stack pointer
	ldr	r6,	=frame_buffer		@ Read frame_buffer's address
	mov	r3,	#0x1

@ 	a b c d e f g h i	
@	1|			COL:列
@	2|			RAW:行
@	3|			r行c列<=> (r,c)
@	4|			
@	5|			r == 0 && c == 1 -> 点灯
@	6|
@	7|
@	8|


rowRead:
	bl	clear
	ldr		r6,	=frame_buffer		@ Read frame_buffer's address
	ldrb	r5,	[r6]	@ 1byteだけ読み込み
	1:
		and	r2,	r5,	r3,	lsl	#7
		cmp	r2,	#0
		beq	2f
		mov	r1,	#(1 << COL1_PORT)
		str	r1,	[r0,	#GPSET0]
	2:
		and	r2,	r5, r3,	lsl #6
		cmp	r2,	#0
		beq	3f
		mov	r1,	#(1 << COL2_PORT)
		str	r1,	[r0,	#GPSET0]
	3:
		and	r2,	r5, r3,	lsl #5
		cmp	r2,	#0
		beq	4f
		mov	r1,	#(1 << COL3_PORT)
		str	r1,	[r0,	#GPSET0]
	4:
		and	r2,	r5, r3,	lsl #4
		cmp	r2,	#0
		beq	5f
		mov	r1,	#(1 << COL4_PORT)
		str	r1,	[r0,	#GPSET0]
	5:
		and	r2,	r5, r3,	lsl #3
		cmp	r2,	#0
		beq	6f
		mov	r1,	#(1 << COL5_PORT)
		str	r1,	[r0,	#GPSET0]
	6:
		and	r2,	r5,	r3,	lsl	#2
		cmp	r2,	#0
		beq	7f
		mov	r1,	#(1 << COL6_PORT)
		str	r1,	[r0,	#GPSET0]
	7:
		and	r2,	r5, r3,	lsl #1
		cmp	r2,	#0
		beq	8f
		mov	r1,	#(1 << COL7_PORT)
		str	r1,	[r0,	#GPSET0]
	8:
		and	r2,	r5, r3
		cmp	r2,	#0
		beq	9f
		mov	r1,	#(1 << COL8_PORT)
		str	r1,	[r0,	#GPSET0]
	9:
		mov	r1,	#(1 << ROW1_PORT)
		str	r1,	[r0,	#GPCLR0]		@	set "0" to COL
	bl	waite
	@ update buffer address
	bl	clear
	add	r6,	r6,	#1	@ 1Byteごとに動きたいなら，+1
	ldrb	r5,	[r6]
	1:
		and	r2,	r5,	r3,	lsl	#7
		cmp	r2,	#0
		beq	2f
		mov	r1,	#(1 << COL1_PORT)
		str	r1,	[r0,	#GPSET0]
	2:
		and	r2,	r5, r3,	lsl #6
		cmp	r2,	#0
		beq	3f
		mov	r1,	#(1 << COL2_PORT)
		str	r1,	[r0,	#GPSET0]
	3:
		and	r2,	r5, r3,	lsl #5
		cmp	r2,	#0
		beq	4f
		mov	r1,	#(1 << COL3_PORT)
		str	r1,	[r0,	#GPSET0]
	4:
		and	r2,	r5, r3,	lsl #4
		cmp	r2,	#0
		beq	5f
		mov	r1,	#(1 << COL4_PORT)
		str	r1,	[r0,	#GPSET0]
	5:
		and	r2,	r5, r3,	lsl #3
		cmp	r2,	#0
		beq	6f
		mov	r1,	#(1 << COL5_PORT)
		str	r1,	[r0,	#GPSET0]
	6:
		and	r2,	r5,	r3,	lsl	#2
		cmp	r2,	#0
		beq	7f
		mov	r1,	#(1 << COL6_PORT)
		str	r1,	[r0,	#GPSET0]
	7:
		and	r2,	r5, r3,	lsl #1
		cmp	r2,	#0
		beq	8f
		mov	r1,	#(1 << COL7_PORT)
		str	r1,	[r0,	#GPSET0]
	8:
		and	r2,	r5, r3
		cmp	r2,	#0
		beq	9f
		mov	r1,	#(1 << COL8_PORT)
		str	r1,	[r0,	#GPSET0]
	9:
		mov	r1,	#(1 << ROW2_PORT)
		str	r1,	[r0,	#GPCLR0]		@	set "0" to COL
		bl	waite
		b		rowRead
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
waite:
	ldr	r5,	=0xfff
	1:
		subs	r5,	r5,	#1
		bne		1b
	bx	r14
