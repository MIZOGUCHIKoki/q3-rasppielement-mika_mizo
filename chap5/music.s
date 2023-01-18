	.include	"common.s"
	.section	.init
	.global		_start

_start:
	mov	sp,	#STACK
	mov	r5, 	#0
	ldr	r6,	=level
	ldr	r7,	=on
	ldr	r8,	=off

loop0:	
	ldr	r2,	[r6, r5, lsl #2]
	ldr	r3,	[r7, r5, lsl #2]
	ldr	r4,	[r8, r5, lsl #2]

	bl	sound

	add	r5,	r5,	#1
	cmp	r5,	#7
	bne 	loop0

loop:	b	loop

	.section	.data
level:
	.word	13753, 13753, 13753, 13753, 15434, 12244, 13753

on:
	.word 	0xaefff, 0xaefff, 0xaefff, 0xaefff, 0xaefff, 0xaefff, 0xfffff
off:
	.word	0xffaf, 0xffaf, 0xffaf, 0xffaf, 0xaffff, 0xfffff, 0xfffff
	
