/* ���荞�݊֌W */
/* 8259A */

#include "bootpack.h"
#include <stdio.h>

/* PIC�̏����� */
void init_pic(void) {
  io_out8(PIC0_IMR,  0xff  ); /* 0x0021:�S�Ă̊��荞�݂��󂯕t���Ȃ� */
  io_out8(PIC1_IMR,  0xff  ); /* 0x00a1:�S�Ă̊��荞�݂��󂯕t���Ȃ� */

  io_out8(PIC0_ICW1, 0x11  ); /* 0x0020:�G�b�W�g���K���[�h */
  io_out8(PIC0_ICW2, 0x20  ); /* 0x0021:IRQ0-7�́AINT20-27�Ŏ󂯂� */
  io_out8(PIC0_ICW3, 1 << 2); /* 0x0021:PIC1��IRQ2�ɂĐڑ� */
  io_out8(PIC0_ICW4, 0x01  ); /* 0x0021:�m���o�b�t�@���[�h */

  io_out8(PIC1_ICW1, 0x11  ); /* 0x00a0:�G�b�W�g���K���[�h */
  io_out8(PIC1_ICW2, 0x28  ); /* 0x00a1:IRQ8-15�́AINT28-2f�Ŏ󂯂� */
  io_out8(PIC1_ICW3, 2     ); /* 0x00a1:PIC1��IRQ2�ɂĐڑ� */
  io_out8(PIC1_ICW4, 0x01  ); /* 0x00a1:�m���o�b�t�@���[�h */

  io_out8(PIC0_IMR,  0xfb  ); /* 0x0021:11111011 PIC1�ȊO�͑S�ċ֎~ */
  io_out8(PIC1_IMR,  0xff  ); /* 0x00a1:11111111 �S�Ă̊��荞�݂��󂯕t���Ȃ� */

  return;
}
