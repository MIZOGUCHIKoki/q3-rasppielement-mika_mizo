	.equ	GPIO_BASE,	0x3f200000	@	BASE
	.equ	GPFSEL1,			0x00			@	0 - 9
	.equ	GPFSEL2,			0x04			@	10 - 19
	.equ	GPFSEL3,			0x08			@	20 - 29

	.equ	GPSET0,				0x1c		@ 1 -> LED:ON
	.equ	GPSET1,				0x28		@ 1 -> LED:OFF

	@ Output : LED 
	.equ	GPFSEL_VEC1,	0x00000001	
	@ Input : SW1 (既に)
	@	LED(10)が既に出力
	@ 13,1は自動的に入力になる
	.equ	LED_PORT,	10
	.equ	SW1_PORT,	13

	.section	.init
	.global		_start

_start:
	ldr	r0,		=GPIO_BASE

	@	10番ポートを出力にする設定
	ldr	r1,		=GPFSEL_VEC1
	str r1,		[r0,	#GPFSEL1]

	mov	r11,	--	@ SW1(13) :: ON
loop0:
	
	@ input SW1(13)
	mov	r10,	
	cmp	r10,	r11
	beq	OFF

	ON:
		mov	r1,	#(1 << LED_PORT)
		str	r1,	[r0,	#GPSET0]		@ r0 + 0x1c | 0..01000000000
		b loop0:
	OFF:
		mov	r1,	#(1 << LED_PORT)
		str	r1,	[r0,	#GPSET1]		@ r0 + 0x28 | 0..01000000000
		b loop0
	
loop:	b loop		@ 故障防止
