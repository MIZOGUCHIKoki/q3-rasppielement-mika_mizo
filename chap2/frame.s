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
	@bl	clear				@ turn all LEDs off 

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
	ldrb	r5,	[r6]	@ 1byteだけ読み込み
	l1a:
		and	r2,	r5,	r3,	lsl	#7
		cmp	r2,	#0
		beq	l1b
		mov	r1,	#(1 << COL1_PORT)
		str	r1,	[r0,	#GPSET0]
	l1b:
		and	r2,	r5, r3,	lsl #6
		cmp	r2,	#0
		beq	l1c
		mov	r1,	#(1 << COL2_PORT)
		str	r1,	[r0,	#GPSET0]
	l1c:
		and	r2,	r5, r3,	lsl #5
		cmp	r2,	#0
		beq	l1d
		mov	r1,	#(1 << COL3_PORT)
		str	r1,	[r0,	#GPSET0]
	l1d:
		and	r2,	r5, r3,	lsl #4
		cmp	r2,	#0
		beq	l1e
		mov	r1,	#(1 << COL4_PORT)
		str	r1,	[r0,	#GPSET0]
	l1e:
		and	r2,	r5, r3,	lsl #3
		cmp	r2,	#0
		beq	l1f
		mov	r1,	#(1 << COL5_PORT)
		str	r1,	[r0,	#GPSET0]
	l1f:
		and	r2,	r5,	r3,	lsl	#2
		cmp	r2,	#0
		beq	l1g
		mov	r1,	#(1 << COL6_PORT)
		str	r1,	[r0,	#GPSET0]
	l1g:
		and	r2,	r5, r3,	lsl #1
		cmp	r2,	#0
		beq	l1h
		mov	r1,	#(1 << COL7_PORT)
		str	r1,	[r0,	#GPSET0]
	l1h:
		and	r2,	r5, r3
		cmp	r2,	#0
		beq	colP
		mov	r1,	#(1 << COL8_PORT)
		str	r1,	[r0,	#GPSET0]
	colP:
		mov	r1,	#(1 << ROW1_PORT)
		str	r1,	[r0,	#GPCLR0]		@	set "0" to COL
	@ update buffer address
	@add	r6,	r6,	#1	@ 1Byteごとに動きたいなら，+1
	@ldr	r5,	[r6]
	@row12:
	@	and	r2,	r5,	r3
	@	cmp	r2,	#0
	@	beq	row22
	@	mov	r1,	#(1 << ROW1_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@row22:
	@	and	r2,	r5, r3,	lsl #1
	@	cmp	r2,	#0
	@	beq	row32
	@	mov	r1,	#(1 << ROW2_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@row32:
	@	and	r2,	r5, r3,	lsl #2
	@	cmp	r2,	#0
	@	beq	row42
	@	mov	r1,	#(1 << ROW3_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@row42:
	@	and	r2,	r5, r3,	lsl #3
	@	cmp	r2,	#0
	@	beq	row52
	@	mov	r1,	#(1 << ROW4_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@row52:
	@	and	r2,	r5, r3,	lsl #4
	@	cmp	r2,	#0
	@	beq	row62
	@	mov	r1,	#(1 << ROW5_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@row62:
	@	and	r2,	r5,	r3,	lsl	#5
	@	cmp	r2,	#0
	@	beq	row72
	@	mov	r1,	#(1 << ROW6_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@row72:
	@	and	r2,	r5, r3,	lsl #6
	@	cmp	r2,	#0
	@	beq	row82
	@	mov	r1,	#(1 << ROW7_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@row82:
	@	and	r2,	r5, r3,	lsl #7
	@	cmp	r2,	#0
	@	beq	colP2
	@	mov	r1,	#(1 << ROW8_PORT)
	@	str	r1,	[r0,	#GPSET0]
	@colP2:
	@	mov	r1,	#(1 << COL2_PORT)
	@	str	r1,	[r0,	#GPCLR0]		@	set "0" to COL
loop:
	b	loop
@;clear:
@;	mov     r1, #(1 << COL1_PORT)
@;	str     r1, [r0, #GPCLR0]
@;	mov     r1, #(1 << COL2_PORT)
@;	str     r1, [r0, #GPCLR0]
@;	mov     r1, #(1 << COL3_PORT)
@;	str     r1, [r0, #GPCLR0]
@;	mov     r1, #(1 << COL4_PORT)
@;	str     r1, [r0, #GPCLR0]
@;	mov     r1, #(1 << COL5_PORT)
@;	str     r1, [r0, #GPCLR0]
@;	mov     r1, #(1 << COL6_PORT)
@;	str     r1, [r0, #GPCLR0]
@;	mov     r1, #(1 << COL7_PORT)
@;	str     r1, [r0, #GPCLR0]
@;	mov     r1, #(1 << COL8_PORT)
@;	str     r1, [r0, #GPCLR0]
@;
@;	mov     r1, #(1 << ROW1_PORT)
@;	str     r1, [r0, #GPSET0]
@;	mov     r1, #(1 << ROW2_PORT)
@;	str     r1, [r0, #GPSET0]
@;	mov     r1, #(1 << ROW3_PORT)
@;	str     r1, [r0, #GPSET0]
@;	mov     r1, #(1 << ROW4_PORT)
@;	str     r1, [r0, #GPSET0]
@;	mov     r1, #(1 << ROW5_PORT)
@;	str     r1, [r0, #GPSET0]
@;	mov     r1, #(1 << ROW6_PORT)
@;	str     r1, [r0, #GPSET0]
@;	mov     r1, #(1 << ROW7_PORT)
@;	str     r1, [r0, #GPSET0]
@;	mov     r1, #(1 << ROW8_PORT)
@;	str     r1, [r0, #GPSET0]
@;	bx			r14
