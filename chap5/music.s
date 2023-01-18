	.include	"common.s"
	.section	.init
	.global		_start

_start:
	mov	sp,	#STACK
	mov	r5, 	#0
	ldr	r6,	=soundData
	ldr	r7,	=onp

loop0:
	ldr	r8,	[r7, r5, lsl #2]
	ldr	r2,	[r6, r8, lsl #2]

	bl	sound

	add	r5,	r5,	#1
	cmp	r5,	#7
	bne 	loop0

loop:	b	loop


	.section	.data
soundData:
	.word	18355, 16354, 14567, 13753, 12244, 10909
onp:
	.word 	0, 0, 4, 4, 5, 5, 4

	.global		sound_buffer
sound_buffer:
	

