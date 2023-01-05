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
	bl		clear		@ clear
	ldr		r6,	=frame_buffer		@ Read frame_buffer's address
	ldrb	r5,	[r6]	@ 1byteだけ読み込み

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
