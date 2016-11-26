#include "bootpack.h"
#include <stdio.h>
#include <string.h>

int *fdc_fbuf;
struct FIFO32 fdc_fifo;
extern int i_sta[80][2];
extern struct TASK *inout;

void fdc_init(struct FDCSV *sv);
void fdc_setread(int secnum);
void fdc_setwrite(int secnum);
int  fdc_readwrite(int rw, int secno, struct FDCSV *sv, int *mot);
void fdc_sendseek(char cyl, char hed);
void fdc_sendint(void);
void fdc_sendcmd(int rw, char cyl, char hed, char sec);
int  fdc_getsint(void);
int  fdc_getstat(void);
void wait_fdc_init(void);
void wait_fdc_sint(void);
void wait_fdc_send(void);
void wait_fdc_recv(void);
void put_retcode(int rc);

void fdc_task(void) {
  int i, rw, secno, rc = 0, mot = 0;
  struct TASK *task = task_now();
  struct FDCSV fdcsv;
  struct TIMER *timer = timer_alloc("fdc");
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  timer_init(timer, &task->fifo, 2880);
  fdc_fbuf = (int *) memman_alloc_4k(memman, 4096 * 4);
  fifo32_init(&fdc_fifo, 4096, fdc_fbuf, task);

  fdc_init(&fdcsv);		/* 最初に1度だけやっておくべき設定 */
  /* Digital Output Registter(DOR) */
  /* 76543210 */
  /* ++++++**-DR1:0:DriverA */
  /*    ++++--DR2:0:Driver */
  /*    +++---RESET:0: hold FDC at reset */
  /*    ++----Mode:1DMA*/
  /*    +-----Motor Control (Drives 0-3) */
  /* 00001100 */
  io_out8(FDC_DOR, 0x0c);	/* 0x03F2:OS起動後に1度FDDのモーター停止 */


  for (;;) {
    io_cli();
    if (fifo32_status(&task->fifo) == 0) {
      if (fdcsv.num > 0) {
        rc = fdc_readwrite(fdcsv.rw, 2880, &fdcsv, &mot);
        put_retcode(rc);
        fifo32_put(&inout->fifo, 255 - rc);
      } else {
        timer_settime(timer, 300);
        task_sleep(task);
        io_sti();
      }
    } else {
      i = fifo32_get(&task->fifo);
      io_sti();
      if (i == 2880) {
        io_out8(FDC_DOR, 0x0c);	/* 0x03f2:FDDのモーター停止 */
        mot = 0;
      } else {
        timer_cancel(timer);
        rw    = i >> 12;
        secno = i & 0x0fff;
        rc = fdc_readwrite(rw, secno, &fdcsv, &mot);
        if (rc != 100) {
          put_retcode(rc);
        } else {
          rc = 0;
        }
        fifo32_put(&inout->fifo, 255 - rc);
      }
    }
  }
}

void fdc_init(struct FDCSV *sv) {
  sv->rw  =  0;
  sv->cyl = -1;
  sv->hed = -1;
  sv->sec =  0;
  sv->num =  0;
  io_out8(0x00d6, 0xc0);	/* DMA2:マスタのch0をカスケードモードに */
  io_out8(0x00c0, 0x00);	/* DMA2:スレーブのDMAを許可 */
  io_out8(0x000a, 0x06);	/* DMA1:マスタのch2のDMAをマスク */
  return;
}

void fdc_setread(int secnum) {
  io_out8(0x000b, 0x06);	/* DMA1モード設定：デマンド・アドレス増加方向・メモリへの書き込み・ch2 */
  io_out8(0x0005, 0xff);
  io_out8(0x0005, secnum * 2 - 1);			/* バイト数の設定 */
  io_out8(0x0004, ADR_DMABUF & 0xff);
  io_out8(0x0004, (ADR_DMABUF >>  8) & 0xff);
  io_out8(0x0081, (ADR_DMABUF >> 16) & 0xff);	/* メモリ番地の設定 */
  io_out8(0x000a, 0x02);						/* マスタのch2のDMAをマスク解除 */
  return;
}

void fdc_setwrite(int secnum) {
  io_out8(0x000b, 0x0a);	/* モード設定：デマンド・アドレス増加方向・メモリからの読み込み・ch2 */
  io_out8(0x0005, 0xff);
  io_out8(0x0005, secnum * 2 - 1);			/* バイト数の設定 */
  io_out8(0x0004, ADR_DMABUF & 0xff);
  io_out8(0x0004, (ADR_DMABUF >>  8) & 0xff);
  io_out8(0x0081, (ADR_DMABUF >> 16) & 0xff);	/* メモリ番地の設定 */
  io_out8(0x000a, 0x02);						/* マスタのch2のDMAをマスク解除 */
  return;
}

int fdc_readwrite(int rw, int secno, struct FDCSV *sv, int *mot) {
  int i, j, ph = 0, rc = 0, errcnt = 0;
  char cyl, hed, sec, *offset;
  struct TASK *task = task_now();
  struct TIMER *fdc_timer = 0;

  cyl = (char) (secno / 36); secno %= 36;
  hed = (char) (secno / 18); secno %= 18;
  sec = (char) secno + 1;

  if (sv->num == 0) {
    sv->rw  = rw;
    sv->cyl = cyl;
    sv->hed = hed;
    sv->sec = sec;
    sv->num = 1;
    return 100;
  }
  if (rw == sv->rw && cyl == sv->cyl && hed == sv->hed) {
    sv->num = sec - sv->sec + 1;
    return 100;
  }

  char msg[30];
  memset(msg, 0, sizeof(msg));
  if (sv->rw == 1) {	/* 読み込みモード */
    sprintf(msg, "fdc read  -- C:%02d H:%02d S:%02d N:%02d", sv->cyl, sv->hed, sv->sec, sv->num);
    dbg_putstr0(msg, COL8_FFFFFF);
    fdc_setread (sv->num);
  } else {			/* 書き込みモード */
    sprintf(msg, "fdc write -- C:%02d H:%02d S:%02d N:%02d", sv->cyl, sv->hed, sv->sec, sv->num);
    dbg_putstr0(msg, COL8_FFFFFF);
    fdc_setwrite(sv->num);
  }
  offset = (char *) (ADR_DISKIMG + (sv->cyl * 36 + sv->hed * 18 + sv->sec - 1) * 512);

  if (*mot == 0) {
    /* 00011100 */
    io_out8(0x03f2, 0x1c);	/* FDDのモーター起動 */
    fdc_timer = timer_alloc("fdd");
    timer_init(fdc_timer, &fdc_fifo, 128);
    timer_settime(fdc_timer, 300);
    *mot = 1;
  } else {
    fdc_sendseek(sv->cyl, sv->hed);
  }

  for (;;) {
    io_cli();
    if (fifo32_status(&fdc_fifo) == 0) {
      task_sleep(task);
      io_sti();
    } else {
      i = fifo32_get(&fdc_fifo);
      io_sti();
      if (i == 128) {
        fdc_sendseek(sv->cyl, sv->hed);
      } else if (i == 255) {
        if (ph == 0) {
          fdc_sendint();
          rc = fdc_getsint();
          if (rc != -1) {
            if (rc == 0) {
              if (sv->rw != 1) {
                memcpy((char *) ADR_DMABUF, offset, sv->num * 512);
              }
              fdc_sendcmd(sv->rw, sv->cyl, sv->hed, sv->sec);
              ph++;
            } else {
              break;
            }
          }
        } else {
          rc = fdc_getstat();
          if (rc == 0) {
            if (sv->rw == 1) {
              for (j = 0; j < sv->num; j++) {
                io_cli();
                if ((i_sta[sv->cyl][sv->hed] & (1 << (sv->sec - 1 + j))) == 0) {
                  memcpy(offset + j * 512, (char *) ADR_DMABUF + j * 512, 512);
                  i_sta[sv->cyl][sv->hed] |= (1 << (sv->sec - 1 + j));
                }
                io_sti();
              }
            }
            break;
          } else {
            if (errcnt < 3) {
              errcnt++;
              fdc_sendcmd(sv->rw, sv->cyl, sv->hed, sv->sec);
            } else {
              break;
            }
          }
        }
      }
    }
  }

  if (cyl < 80) {
    sv->rw  = rw;
    sv->cyl = cyl; sv->hed = hed;
    sv->sec = sec; sv->num = 1;
  } else {
    sv->rw  =  0;
    sv->cyl = -1;  sv->hed = -1;
    sv->sec =  0;  sv->num =  0;
  }
  io_out8(0x000a, 0x06);	/* マスタのch2のDMAをマスク */
  if (fdc_timer != 0) {
    timer_free(fdc_timer);
  }

  return rc;
}

void fdc_sendseek(char cyl, char hed) {
  /* FDCへのSEEK送信 */
  wait_fdc_init();
  wait_fdc_send(); io_out8(0x03f5, 0x0f);
  wait_fdc_send(); io_out8(0x03f5, hed << 2);
  wait_fdc_send(); io_out8(0x03f5, cyl);
  return;
}

void fdc_sendint(void) {
  /* FDCへのSENSE INT STATUS送信 */
  wait_fdc_sint();
  wait_fdc_send(); io_out8(0x03f5, 0x08);
  return;
}

void fdc_sendcmd(int rw, char cyl, char hed, char sec) {
  /* FDCへのコマンド送信 */
  wait_fdc_init();
  if (rw == 1) {	/* 読み込みモード */
    wait_fdc_send(); io_out8(0x03f5, 0xe6);
    wait_fdc_send(); io_out8(0x03f5, hed << 2);
    wait_fdc_send(); io_out8(0x03f5, cyl);
    wait_fdc_send(); io_out8(0x03f5, hed);
    wait_fdc_send(); io_out8(0x03f5, sec);
    wait_fdc_send(); io_out8(0x03f5, 0x02);
    wait_fdc_send(); io_out8(0x03f5, 0x12);
    wait_fdc_send(); io_out8(0x03f5, 0x1b);
    wait_fdc_send(); io_out8(0x03f5, 0xff);
  } else {			/* 書き込みモード */
    wait_fdc_send(); io_out8(0x03f5, 0xc5);
    wait_fdc_send(); io_out8(0x03f5, hed << 2);
    wait_fdc_send(); io_out8(0x03f5, cyl);
    wait_fdc_send(); io_out8(0x03f5, hed);
    wait_fdc_send(); io_out8(0x03f5, sec);
    wait_fdc_send(); io_out8(0x03f5, 0x02);
    wait_fdc_send(); io_out8(0x03f5, 0x12);
    wait_fdc_send(); io_out8(0x03f5, 0x1b);
    wait_fdc_send(); io_out8(0x03f5, 0xff);
  }
  return;
}

int fdc_getsint(void) {
  char st0, cyl;

  /* FDCから割り込みステータス読み取り */
  wait_fdc_recv(); st0 = io_in8(0x03f5);
  wait_fdc_recv(); cyl = io_in8(0x03f5);

  if ((st0 & 0xc0) == 0xc0) {
    return -1;
  } else if ((st0 & 0xc0) != 0x00) {
    return 1;
  }
  return 0;
}

int fdc_getstat(void) {
  char st0, st1, st2, cyl, hed, sec, len;

  /* FDCからリザルトステータス読み取り */
  wait_fdc_recv(); st0 = io_in8(0x03f5);
  wait_fdc_recv(); st1 = io_in8(0x03f5);
  wait_fdc_recv(); st2 = io_in8(0x03f5);
  wait_fdc_recv(); cyl = io_in8(0x03f5);
  wait_fdc_recv(); hed = io_in8(0x03f5);
  wait_fdc_recv(); sec = io_in8(0x03f5);
  wait_fdc_recv(); len = io_in8(0x03f5);

  if ((st0 & 0xc0) != 0x00) {
    return 1;
  }
  return 0;
}

void wait_fdc_init(void) {
  /* FDCがデータ送信可能になるのを待つ */
  for (;;) {
    if ((io_in8(0x03f4) & 0x11) == 0) {
      break;
    }
  }
  return;
}

void wait_fdc_sint(void) {
  /* FDCがデータ送信可能になるのを待つ */
  for (;;) {
    if ((io_in8(0x03f4) & 0x10) == 0) {
      break;
    }
  }
  return;
}

void wait_fdc_send(void) {
  /* FDCがデータ送信可能になるのを待つ */
  for (;;) {
    if ((io_in8(0x03f4) & 0xc0) == 0x80) {
      break;
    }
  }
  return;
}

void wait_fdc_recv(void) {
  /* FDCがデータ受信可能になるのを待つ */
  for (;;) {
    if ((io_in8(0x03f4) & 0xc0) == 0xc0) {
      break;
    }
  }
  return;
}

/* FDCからの割り込み */
void inthandler26(int *esp) {
  io_in8(0x03f4); /* から読み：IRQにCPUが気づいたことをFDCへ教えてあげる */
  io_out8(PIC0_OCW2, 0x66); /* IRQ-06を終了 */
  fifo32_put(&fdc_fifo, 255);
  return;
}

void put_retcode(int rc) {
  char msg[30];
  memset(msg, 0, sizeof(msg));
  sprintf(msg, "  -> rc=%d\n", rc);
  dbg_putstr0(msg, COL8_FFFFFF);
  return;
}
