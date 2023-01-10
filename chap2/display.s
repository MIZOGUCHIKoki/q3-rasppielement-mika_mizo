	.include	"common.h"
	.section 	.text
	.global 	display
display:
@push
	str	r0, [sp, #-4]!  
	str	r1, [sp, #-4]! 
	str	r2, [sp, #-4]! 
	str	r3, [sp, #-4]!  
	str	r5, [sp, #-4]! 
	str	r6, [sp, #-4]! 
	str	r14, [sp, #-4]! 

	ldr	r0, =GPIO_BASE
	ldr	r1, =GPFSEL_VEC0
	str	r1, [r0, #GPFSEL0 + 0]
	ldr	r1, =GPFSEL_VEC1
	str	r1, [r0, #GPFSEL0 + 4]
	ldr	r1, =GPFSEL_VEC2
	str	r1, [r0, #GPFSEL0 + 8]
	mov	r3,	#0x1

@ COL:列	RAW:行
@ r行c列<=> (r,c)
@ r == 0 && c == 1 -> 点灯
	ldr	r3,	=row		@ row port number
	mov	r4,	#0			@ rowLoopVar::i
rowLoop:
	bl		clear		@ clear
	ldr		r5,	=frame_buffer		@ Read frame_buffer's address
	add		r5,	r5,	r4		@ r6+=i
	add		r3,	r3,	r4		@	r3+=i
	ldrb	r6,	[r5]	@ Read only 1byte form frame_buffer
	ldrb	r7,	[r3]	@ Read only 1byte	form Row_Port
	mov		r8,	#0		@ colLoopVar::j0
	mov		r9,	#7		@ colLoopVar::j1
	ldr		r2,	=col		@ col port number 
colLoop:
	and		r2,	r2,	r8
	ldrb	r10,	[r2]	@ Read only 1byte form Col_Port
	and		r1,	r6,	r3,	lsl	r9
	cmp		r1,	#0
	movne	r1,	#(1 << r8)
	strne	r1,	[r0, #(GPSET0)]
	add		r8,	r8,	#1
	sub		r9,	r9,	#1
	cmp		r8,	#8
	b			colLoop
rowLoopE:
	mov		r1,	#(1 << r4)
	str		r1,	[r0,	#GPCLR0]
	add		r4,	r4,	#1
	cmp		r4,	#8
	bne		rowLoop

@pop
	ldr		r14, [sp], #4 
	ldr		r6,  [sp], #4 
	ldr		r5,  [sp], #4 
	ldr		r3,  [sp], #4 
	ldr		r2,  [sp], #4 
	ldr		r1,	 [sp], #4 
	ldr		r0,	 [sp], #4 
	bx		r14

@ Port number
col:
	.byte	27,	8, 25, 23, 24, 22, 17, 4
row:
	.byte	14,	15,	21,	18,	12,	20,	7, 16

@ initialize
clear:
	ldr	r5, =(1 << ROW1_PORT | 1 << ROW2_PORT | 1 << ROW3_PORT | 1 << ROW4_PORT | 1 << ROW5_PORT | 1 << ROW6_PORT | 1 << ROW7_PORT | 1 << ROW8_PORT)
	str	r5, [r0, #GPSET0]
	bx	r14

@ waite method
waite:
	ldr	r5,	=0xff
	1:
		subs	r5,	r5,	#1
		bne		1b
	bx	r14
