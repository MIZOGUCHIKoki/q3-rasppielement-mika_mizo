@ write number bit strings  (00 - 99) to frame buffer.
@ struct number r12 | r11
  .section  .text
  .global   writeProcess

writeProcess:
  push  {r1}
	ldr	  r1,		=frame_buffer
  ldr   r5,   =nb_all
	mov		r2,		#7
	ldr		r0,		=nb_all
	ldr		r3,		[r0,	r11,	lsl	#2] @ r3 = nb_0's address r11*4(byte)
	ldr		r8,		[r0,	r12,	lsl	#2]
	multi:
		ldrb	r6,		[r8,	r2]
		lsl		r6,		#4
		ldrb	r0,		[r3,	r2]			@ r0 = nb_0[r2]		read only 1Byte
		orr		r6,		r0,		r6
		strb	r6,		[r1,	r2]			@ store
		subs	r2,		r2,		#1
		bpl		multi								@ 0以上
	
	add		r11,	r11,	#1	
	cmp		r11,	#10
	moveq	r11,	#0

	addeq	r12,	r12,	#1
	cmp		r12,	#10
	moveq	r12,	#0
  pop   {r1}
  bx    r14
