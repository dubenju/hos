/* */

#include <stdio.h>
#include <string.h>
#include "bootpack.h"

#define DSP_LINE	12
#define min(a, b)	(((a) < (b)) ? (a) : (b))

unsigned char t[7];

extern struct TASK * taskmgr;

void task_display(struct SHEET *sht, int offset, int cpu, int time, unsigned int memtotal) {
  int i, j = 0;
  int x = 12, y = 48;
  char msg[40];
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;

  boxfill8(sht->buf, sht->bxsize, COL8_000000, 8, 48, 8 + 280 - 1, 48 + 192 - 1);
  for (i = offset; i < taskctl->alloc; i++) {
  /* for (i = 0; i < MAX_TASKS; i++) { */
    if (taskctl->tasks0[i].flags == 0) {
      continue;
    }
    memset(msg, 0, sizeof(msg));
    sprintf(msg, "%3d %-15s %1d %1d %1d", 
      i, 
      taskctl->tasks0[i].name, 
      taskctl->tasks0[i].level, 
      taskctl->tasks0[i].priority, 
      taskctl->tasks0[i].flags);
    putfonts8_asc(sht->buf, sht->bxsize, x, y + 16 * j++, COL8_FFFFFF, 1, msg);
    if (j >= DSP_LINE) {
      break;
    }
  }
  if (cpu == 0) {
    sheet_refresh(sht, 8, 48, 8 + 280, 48 + 192);
    return;
  }
  boxfill8(sht->buf, sht->bxsize, COL8_FFFFFF, 8, 250, 8 + 280 - 1, 250 + 32 - 1);

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "CPU    :        %3d Åì     %4d TS", 100 - min(time, 100), taskctl->alive);
  putfonts8_asc(sht->buf, sht->bxsize, x, y + 202, COL8_0000FF, 1, msg);

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "Memory :    %7d Å^  %7d KB", (memtotal - memman_total(memman)) / 1024, memtotal / 1024);
  putfonts8_asc(sht->buf, sht->bxsize, x, y + 218, COL8_0000FF, 1, msg);

  sheet_refresh(sht, 8, 48, 8 + 580, 48 + 334);

  return;
}

void taskmgr_task(unsigned int memtotal) {
  int i;
  int x = 12, y = 28, offset = 0;
  int prev_time, curr_time;
  char msg[80];
  struct TASK * task = task_now();
  struct TIMER * task_timer = timer_alloc("tmg");
  struct MEMMAN * memman = (struct MEMMAN *) MEMMAN_ADDR;
  struct FIFO32 * fifo = (struct FIFO32 *) *((int *) 0xfec);
  struct SHTCTL * ctl = (struct SHTCTL *) *((int *) 0xfe4);
  struct SHEET * sht = sheet_alloc(ctl);
  unsigned char * buf = (unsigned char *) memman_alloc_4k(memman, 296 * 290 *2);
  task->langmode = 1;
  sheet_setbuf(sht, buf, 296, 290, -1);
  make_window8(buf, 296, 290, "taskmgr", 0);
  make_textbox8(sht, 8,  28, 280, 212, COL8_000000);
  make_textbox8(sht, 8, 250, 280,  32, COL8_FFFFFF);
/*  make_header8(sht, 7, 27, 31, 18, COL8_C6C6C6); */
  memset(msg, 0, sizeof(msg));
  strcpy(msg, " ID NAME           LV  TIME");
  putfonts8_asc(sht->buf, sht->bxsize, x + 1, y + 1, COL8_FFFFFF, 1, msg);
/*  putfonts8_asc(sht->buf, sht->bxsize, x + 0, y + 0, COL8_000000, 1, msg); */

  sht->task = taskmgr;
  sheet_slide(sht, 336, 8);
  sheet_updown(sht, ctl->top);
  keywin_on(sht);
  timer_init(task_timer, &task->fifo, 1);
  prev_time = taskctl->tasks0[1].time - 99;
  timer_settime(task_timer, 1);

  for(;;) {
    io_cli();
    if (fifo32_status(&task->fifo) == 0) {
      task_sleep(task);
      io_sti();
    } else {
      i = fifo32_get(&task->fifo);
      io_sti();
      if (i == 1) {
        timer_settime(task_timer, 100);
        curr_time = taskctl->tasks0[1].time;
        task_display(sht, offset, 1, curr_time - prev_time, memtotal);
        prev_time = curr_time;
      } else if (i == 4) { /* Å~ */
        timer_cancel(task_timer);
        break;
      } else if (256 <= i && i <= 511) {
        if (i == '2' + 256) {
          if (offset < taskctl->alive - DSP_LINE) {
            offset ++;
          }
        } else if (i == '8' + 256) {
          if ( offset > 0 ) {
            offset --;
          }
        }
        task_display(sht, offset, 0, 0, 0);
      }
    }
  }
  timer_free(task_timer);
  memman_free_4k(memman, (int) sht->buf, 296 * 290 * 2);
  sheet_free(sht);
  fifo32_put_io(fifo, 2280);
  for (;;) {
    task_sleep(task);
  }
}

/* show time by rtc */
void sysclock_task(void) {
  int i, j;
  char err, cnt;
  unsigned char s[6];
  static unsigned char adr[7] = { 0x00, 0x02, 0x04, 0x07, 0x08, 0x09, 0x32 };
  static unsigned char max[7] = { 0x60, 0x59, 0x23, 0x31, 0x12, 0x99, 0x99 };
  struct TASK *task = task_now();
  struct TIMER *clock_timer = timer_alloc("sck");
  timer_init(clock_timer, &task->fifo, 1);
  timer_settime(clock_timer, 100);

  for (;;) {
    io_cli();
    if (fifo32_status(&task->fifo) == 0) {
      task_sleep(task);
      io_sti();
    } else {
      i = fifo32_get(&task->fifo);
      io_sti();
      if (i == 1) {
        for (cnt = 0; cnt < 3; cnt++) {
          err = 0;
          for (j = 0; j < 7; j++) {
            io_out8(CMOD_RAM_IDX_REG, adr[j]); /* 0x0070 */
            t[j] = io_in8(CMOS_RAM_DATA);      /* 0x0071 */
          }
          for (j = 0; j < 7; j++) {
            io_out8(CMOD_RAM_IDX_REG, adr[j]); /* 0x0070 */
            if (t[j] != io_in8(CMOS_RAM_DATA) || (t[j] & 0x0f) > 9 || t[j] > max[j]) { /* 0x0071 */
              err = 1;
            }
          }
          if (err == 0) {
            break;
          }
        }

        struct SHTCTL *ctl = (struct SHTCTL *) *((int *) ADR_SHTCTL);
        struct SHEET *sht = &ctl->sheets0[0];
        memset(s, 0, sizeof(s));
        //sprintf(s, "%02X:%02X\0", t[2], t[1]);
        sprintf(s, "test");
        //sprintf(s, "aa%02X:%02X\0", t[2], t[1]);
        // putfonts8_asc_sht(sht, sht->bxsize - 45, sht->bysize - 21, COL8_000000, COL8_C6C6C6, s, 5);
        //dbg_putstr0(s, COL8_FFFFFF);
        putfonts8_asc_sht(sht, sht->bxsize - 45, sht->bysize - 21, COL8_00FF00, COL8_FFFF00, s, 5); /* window.c */
        timer_settime(clock_timer, 100);
      }
    }
  }
}
