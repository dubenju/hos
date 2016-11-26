/* キーボード関係 8042 */
#include "bootpack.h"

struct FIFO32 *keyfifo;
int keydata0; /* 256 */

void inthandler21(int *esp) {
  int data;
  io_out8(PIC0_OCW2, 0x61);	/* IRQ-01受付完了をPICに通知 */
  data = io_in8(PORT_KEYDAT);   /* 0x0060 */
  fifo32_put(keyfifo, data + keydata0); /* data + 256 */
  return;
}

#define PORT_KEYSTA          0x0064
#define KEYSTA_SEND_NOTREADY 0x02
#define KEYCMD_WRITE_MODE    0x60
/* 01000111 */
/* |||||||+-1:Enable KBD Interrupt */
/* ||||||+--1:Enable Mouse Interruput */
/* |||||+---Register status's Bit2 */
/* ||||+----1: Bit4 */
/* |||+-----1: Disable KBD */
/* ||+------1: Disable Mouse */
/* |+-------Sec to first */
/* +--------Resave:0 */
 
#define KBC_MODE             0x47

void wait_KBC_sendready(void) {
  /* キーボードコントローラがデータ送信可能になるのを待つ */
  for (;;) {
    if ((io_in8(PORT_KEYSTA) & KEYSTA_SEND_NOTREADY) == 0) {
      /* 0x0064, 0x02 */
      break;
    }
  }
  return;
}

void init_keyboard(struct FIFO32 *fifo, int data0) {
  /* 書き込み先のFIFOバッファを記憶 */
  keyfifo = fifo;
  keydata0 = data0; /* keydata0=data0=256 */

  /* キーボードコントローラの初期化 */
  wait_KBC_sendready();
  /* 60h:Next writen 60h port data is command */
  io_out8(PORT_KEYCMD, KEYCMD_WRITE_MODE); /* 0x0064:0x60 */
  wait_KBC_sendready();
  io_out8(PORT_KEYDAT, KBC_MODE); /* 0x0060:0x47 */
  return;
}

/*
 60h:20h:Read i8042's Command to Output Register
 60h:60h:Will Write i8042's Command
 60h:A4h:Test keyboard's  Password is setup, Result save Output Register Read by 60h:FAh=have pwd,F1h=no pwd.
 60h:A5h:Setup pwd
 60h:A6h:Active pwd
 60h:AAh:test,Result save Output Register,Read by 60h, 55h=OK.
 60h:ADh:Disable KBD,Cmd's Bit4=1
 60h:AEh:Open KBD,Cmd's Bit4=0
 60h:C0h:Ready Read Input Port by 60h
 60h:D0h:Ready Read Output Port by 60h
 60h:D1h:Ready Write Output Port by 60h
 60h:D2h:Ready Write Data to Output Port 
 */
