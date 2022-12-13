  .section .init
  .global _start
_start:
  ldr     r0, =0x3f200000     @ GPIO 制御用の番地

  @ GPIO #10 を出力用に，GPIO #11〜#19を入力用に設定
  mov     r1, #0x00000001
  str     r1, [r0, #0x04]

    @ GPIO #10 に 1 を出力
  mov     r1, #(1 << 10)
  str     r1, [r0, #0x1C]

  loop:   b       loop
