/* �}�E�X�֌W 8042 */
#include "bootpack.h"

struct FIFO32 *mousefifo;
int mousedata0; /* 512 */

/* PS/2�}�E�X����̊��荞�� */
void inthandler2c(int *esp) {
  int data;
  io_out8(PIC1_OCW2, 0x64);	/* IRQ-12��t������PIC1�ɒʒm */
  io_out8(PIC0_OCW2, 0x62);	/* IRQ-02��t������PIC0�ɒʒm */
  data = io_in8(PORT_KEYDAT);
  fifo32_put(mousefifo, data + mousedata0);
  return;
}

#define KEYCMD_SENDTO_MOUSE 0xd4
/* 11110100 */
/* |||||||+- */
#define MOUSECMD_ENABLE     0xf4

void enable_mouse(struct FIFO32 *fifo, int data0, struct MOUSE_DEC *mdec) {
  /* �������ݐ��FIFO�o�b�t�@���L�� */
  mousefifo = fifo;
  mousedata0 = data0; /* mousedata0=data0=512 */
  /* �}�E�X�L�� */
  wait_KBC_sendready();
  /* A8h:Enable mouse chennal */
  /* D4h:60h's Data to Mouse */
  /* 60h:60h's Port Data to 8042 */
  io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE); /* 0x0064:0xd4 */
  wait_KBC_sendready();
  io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);     /* 0x0060:0xf4 */
  /* ���܂�������ACK(0xfa)�����M����Ă��� */
  mdec->phase = 0; /* �}�E�X��0xfa��҂��Ă���i�K */
  return;
}

int mouse_decode(struct MOUSE_DEC *mdec, unsigned char dat) {

  if (mdec->phase == 0) {
    /* �}�E�X��0xfa��҂��Ă���i�K */
    if (dat == 0xfa) {
      mdec->phase = 1;
    }
    return 0;
  }

  if (mdec->phase == 1) {
    /* �}�E�X��1�o�C�g�ڂ�҂��Ă���i�K */
    if ((dat & 0xc8) == 0x08) {
      /* ������1�o�C�g�ڂ����� */
      mdec->buf[0] = dat;
      mdec->phase = 2;
    }
    return 0;
  }

  if (mdec->phase == 2) {
    /* �}�E�X��2�o�C�g�ڂ�҂��Ă���i�K */
    mdec->buf[1] = dat;
    mdec->phase = 3;
    return 0;
  }

  if (mdec->phase == 3) {
    /* �}�E�X��3�o�C�g�ڂ�҂��Ă���i�K */
    mdec->buf[2] = dat;
    mdec->phase = 1;
    mdec->btn = mdec->buf[0] & 0x07;
    mdec->x = mdec->buf[1];
    mdec->y = mdec->buf[2];
    if ((mdec->buf[0] & 0x10) != 0) {
      mdec->x |= 0xffffff00;
    }
    if ((mdec->buf[0] & 0x20) != 0) {
      mdec->y |= 0xffffff00;
    }
    mdec->y = - mdec->y; /* �}�E�X�ł�y�����̕�������ʂƔ��� */
    return 1;
  }

  return -1; /* �����ɗ��邱�Ƃ͂Ȃ��͂� */
}
