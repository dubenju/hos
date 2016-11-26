/* ********** */
/* browser    */
/* ********** */

#include "bootpack.h"

void browser_task(struct SHEET *sheet, int memtotal) {
  int i;
  int cur_x = 8;
  int cur_y = 26;
  char msg[80];

  int perr;

  struct TASK *task = task_now();

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "File(F) Edit(E) Format(O) View(V) Help(H)");
  putfonts8_asc(sheet->buf, sheet->bxsize, cur_x, cur_y, COL8_000000, 1, msg);
  make_textbox8(sheet, 6, 44, 160, 320, COL8_FFFFFF);
  make_h_scroll(sheet, 6, 350, 160);
  make_v_scroll(sheet, 152, 44, 306);
  cur_y += 18;

  make_progress(sheet, 200, 44, 90, 22, 0);
  perr = 0;

  DDAline(sheet->buf, sheet->bxsize, COL8_000000, 100, 100, 200, 200);

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "Desktop");
  putfonts8_asc(sheet->buf, sheet->bxsize, cur_x, cur_y, COL8_000000, 1, msg);
  cur_y += 18;

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "Document");
  putfonts8_asc(sheet->buf, sheet->bxsize, cur_x + 16, cur_y, COL8_000000, 1, msg);
  cur_y += 18;

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "Computer");
  putfonts8_asc(sheet->buf, sheet->bxsize, cur_x + 16, cur_y, COL8_000000, 1, msg);
  cur_y += 18;

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "NetWork");
  putfonts8_asc(sheet->buf, sheet->bxsize, cur_x + 16, cur_y, COL8_000000, 1, msg);
  cur_y += 18;

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "Recycler");
  putfonts8_asc(sheet->buf, sheet->bxsize, cur_x + 16, cur_y, COL8_000000, 1, msg);
  cur_y += 18;

  for (;;) {
    io_cli();
    if (fifo32_status(&task->fifo) == 0) {
      task_sleep(task);
      io_sti();
    } else {
      i = fifo32_get(&task->fifo);
      io_sti();

    /*  memset(msg, 0, sizeof(msg));
      sprintf(msg, "%d", i);
      putfonts8_asc(sheet->buf, sheet->bxsize, cur_x, cur_y, COL8_0000FF, 1, msg);
      cur_y += 18; */

      if (256 <= i && i <= 511) {
        msg[0] = i - 256;
        msg[1] = 0;
        putfonts8_asc(sheet->buf, sheet->bxsize, cur_x, cur_y, COL8_0000FF, 1, msg);
        cur_y += 18;
      }
      if (512 <= i && i <= 767) {
        memset(msg, 0, sizeof(msg));
        sprintf(msg, "%d", i);
        putfonts8_asc(sheet->buf, sheet->bxsize, cur_x, cur_y, COL8_0000FF, 1, msg);
        cur_y += 18;

        perr += 10;
        if (perr > 90) {
          perr = 0;
          make_progress(sheet, 200, 44, 90, 22, 0);
        } else {
          make_progress(sheet, 200, 44, perr, 22, 1);
        }

      }
      sheet_refresh(sheet, 10, 10, 520, 360);
    }
  }
}

void brow_callback(struct SHEET * sht, int msg, int param1, int param2) {
  putfonts8_asc(sht->buf, sht->bxsize, 100, 100, COL8_0000FF, 1, "test");
}
