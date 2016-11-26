/* FIFO���C�u���� */

#include "bootpack.h"

#define FLAGS_OVERRUN 0x0001

/* FIFO�o�b�t�@�̏����� */
/*
 * FIFO32* fifo to setup
 * int size
 * int * buf
 * TASK * task
 */
void fifo32_init(struct FIFO32 *fifo, int size, int *buf, struct TASK *task) {
  fifo->size = size;
  fifo->buf = buf;
  fifo->free = size; /* �� */
  fifo->flags = 0;
  fifo->p = 0;       /* �������݈ʒu */
  fifo->q = 0;       /* �ǂݍ��݈ʒu */
  fifo->task = task; /* �f�[�^���������Ƃ��ɋN�����^�X�N */
  return;
}

/* FIFO�փf�[�^�𑗂荞��Œ~���� */
int fifo32_put(struct FIFO32 *fifo, int data) {
  if (fifo->free == 0) {
    /* �󂫂��Ȃ��Ă��ӂꂽ */
    fifo->flags |= FLAGS_OVERRUN;
    return -1;
  }
  fifo->buf[fifo->p] = data;
  fifo->p++;
  if (fifo->p == fifo->size) {
    fifo->p = 0;
  }
  fifo->free --;
  if (fifo->task != 0) {
    if (fifo->task->flags != 2) { /* �^�X�N���Q�Ă����� */
      task_run(fifo->task, -1, 0); /* �N�����Ă����� */
    }
  }
  return 0;
}

/* fifo32_put�̊��荞�݋֎~�� */
int fifo32_put_io(struct FIFO32 *fifo, int data) {
  int rc;
  io_cli();
  rc = fifo32_put(fifo, data);
  io_sti();
  return rc;
}

/* FIFO����f�[�^����Ƃ��Ă��� */
int fifo32_get(struct FIFO32 *fifo) {
  int data;
  if (fifo->free == fifo->size) {
    /* �o�b�t�@������ۂ̂Ƃ��́A�Ƃ肠����-1���Ԃ���� */
    return -1;
  }
  data = fifo->buf[fifo->q];
  fifo->q++;
  if (fifo->q == fifo->size) {
    fifo->q = 0;
  }
  fifo->free ++;
  return data;
}

/* �ǂ̂��炢�f�[�^�����܂��Ă��邩��񍐂��� */
int fifo32_status(struct FIFO32 *fifo) {
  return fifo->size - fifo->free;
}
