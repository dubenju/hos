/* 割り込み関係 */
/* 8259A */

#include "bootpack.h"
#include <stdio.h>

/* PICの初期化 */
void init_pic(void) {
  io_out8(PIC0_IMR,  0xff  ); /* 0x0021:全ての割り込みを受け付けない */
  io_out8(PIC1_IMR,  0xff  ); /* 0x00a1:全ての割り込みを受け付けない */

  io_out8(PIC0_ICW1, 0x11  ); /* 0x0020:エッジトリガモード */
  io_out8(PIC0_ICW2, 0x20  ); /* 0x0021:IRQ0-7は、INT20-27で受ける */
  io_out8(PIC0_ICW3, 1 << 2); /* 0x0021:PIC1はIRQ2にて接続 */
  io_out8(PIC0_ICW4, 0x01  ); /* 0x0021:ノンバッファモード */

  io_out8(PIC1_ICW1, 0x11  ); /* 0x00a0:エッジトリガモード */
  io_out8(PIC1_ICW2, 0x28  ); /* 0x00a1:IRQ8-15は、INT28-2fで受ける */
  io_out8(PIC1_ICW3, 2     ); /* 0x00a1:PIC1はIRQ2にて接続 */
  io_out8(PIC1_ICW4, 0x01  ); /* 0x00a1:ノンバッファモード */

  io_out8(PIC0_IMR,  0xfb  ); /* 0x0021:11111011 PIC1以外は全て禁止 */
  io_out8(PIC1_IMR,  0xff  ); /* 0x00a1:11111111 全ての割り込みを受け付けない */

  return;
}
