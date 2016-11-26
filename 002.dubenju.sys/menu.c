/* menu */
/* window.c */

#include "bootpack.h"

extern unsigned short table_8_565[256];

void make_menu8(unsigned short * buf, int xsize, int ysize, char * title, struct MENU * menu, int num) {
  int i;
  int yp;
  int col = 16 + 2 + 2 * 6 + 2 * 36;
  struct MENU * pmenu;

  boxfill8(buf, xsize, COL8_C6C6C6,         0,         0, xsize - 1,         0);
  boxfill8(buf, xsize, COL8_FFFFFF,         1,         1, xsize - 2,         1);
  boxfill8(buf, xsize, COL8_C6C6C6,         0,         0,         0, ysize - 1);
  boxfill8(buf, xsize, COL8_FFFFFF,         1,         1,         1, ysize - 2);
  boxfill8(buf, xsize, COL8_848484, xsize - 2,         1, xsize - 2, ysize - 2);
  boxfill8(buf, xsize, COL8_000000, xsize - 1,         0, xsize - 1, ysize - 1);
  boxfill8(buf, xsize, COL8_C6C6C6,         2,         2, xsize - 3, ysize - 3);
  boxfill8(buf, xsize, COL8_848484,         1, ysize - 2, xsize - 2, ysize - 2);
  boxfill8(buf, xsize, COL8_000000,         0, ysize - 1, xsize - 1, ysize - 1);

  pmenu = menu;
  for (i = 0; i < num; i ++) {
    putfonts8_asc(buf, xsize, 8, ysize - (2 + 26 * (i + 1)) + 6, COL8_000000, 1, pmenu->name);
    pmenu = pmenu->next;
  }
  for (i = 0; i < num - 1; i ++) {
    yp = ysize - (2 + 26 * (i + 1));
    boxfill8(buf, xsize, col, 4, yp, xsize - 6, yp);
    boxfill8(buf, xsize, COL8_FFFFFF, 5, yp + 1, xsize - 5, yp + 1);
  }
  if (menu->level == 0) {
    make_mtitle8(buf, xsize, title, 1);
  }
  return ;
}

void make_mtitle8(unsigned short * buf, int xsize, char * title, char act) {
  unsigned char tc, tbc;
  if (act != 0) {
    tc = COL8_FFFFFF;
    tbc = 16 + 1 + 2 *6 + 5 * 36;
  } else {
    tc = COL8_FFFFFF;
    tbc = COL8_848484;
  }
  boxfill8(buf, xsize, tbc, 5, 4, xsize - 6, 19);
  putfonts8_asc(buf, xsize, 24, 4, tc, 1, title);
}

void change_mtitle8(struct SHEET * sht, int level, int mn_flg, char act) {
  int x, y;
  int yp;
  int xsize = sht->bxsize;
  int ys, ye;
  unsigned char tc_new, tbc_new, tc_old, tbc_old;
  unsigned short c565, *buf = sht->buf;
  if (act != 0) {
    tc_new  = COL8_FFFFFF;
    tbc_new = COL8_0000FF;
    tc_old  = COL8_000000;
    tbc_old = COL8_C6C6C6;
  } else {
    tc_new  = COL8_000000;
    tbc_new = COL8_C6C6C6;
    tc_old  = COL8_FFFFFF;
    tbc_old = COL8_0000FF;
  }
  yp = (mn_flg - 1) * 26 + 3;
  if (level == 0) {
    yp += 18;
  }
  for (y = 0; y < 22; y++) {
    for (x = 5; x <= xsize - 6; x++) {
      c565 = buf[(yp + y) * xsize + x];
      if (c565 == table_8_565[tc_old]) {
        c565 = table_8_565[tc_new];
      } else if (c565 == table_8_565[tbc_old]) {
        c565 = table_8_565[tbc_new];
      }
      buf[(yp + y) * xsize + x] = c565;
    }
  }
  sheet_refresh(sht, 5, yp, xsize - 5, yp + 22);
  return ;
}

void push_menu(char * vram, int bxsize, int bysize) {
  return ;
}

void pull_menu(char * vram, int bxsize, int bysize) {
  return ;
}
