@ Current displayed number {r11}
	.equ			PWM_HZ,		9600*1000
	.equ			KEY_A4,		PWM_HZ/440
	.equ			KEY_A5,		PWM_HZ/880
	.include	"common.s"
	.section	.text
	.global		jiho_sound

jiho_sound:
	push	{r0, r1, r14}
	cmp		r11,	#7
	beq		beap_0
	cmp		r11,	#8
	beq		beap_0
	cmp		r11,	#9
	beq		beap_0
	cmp		r11,	#0
	beq		beap_1
	pop		{r0, r1, r14}
	bx		r14
beap_0:
	ldr		r1,	=KEY_A4
	str		r1,	[r0, #PWM_RNG2]
	lsr		r1,	r1,	#1
	str		r1,	[r0, #PWM_DAT2]
	b			endp
beap_1:
	b			endp
endp:
	pop		{r0, r1, r14}
	bx		r14
