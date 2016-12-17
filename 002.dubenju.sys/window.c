/* ウィンドウ関係 */

#include "bootpack.h"

extern unsigned short table_16_65536[65536];

void make_window8(unsigned short *buf, int xsize, int ysize, char *title, char act) {
  boxfill8(buf, xsize, COL8_C6C6C6, 0,         0,         xsize - 1, 0        );
  boxfill8(buf, xsize, COL8_FFFFFF, 1,         1,         xsize - 2, 1        );
  boxfill8(buf, xsize, COL8_C6C6C6, 0,         0,         0,         ysize - 1);
  boxfill8(buf, xsize, COL8_FFFFFF, 1,         1,         1,         ysize - 2);
  boxfill8(buf, xsize, COL8_848484, xsize - 2, 1,         xsize - 2, ysize - 2);
  boxfill8(buf, xsize, COL8_000000, xsize - 1, 0,         xsize - 1, ysize - 1);
  dbg_putstr0(title, COL8_C6C6C6);
  boxfill8(buf, xsize, COL8_C6C6C6, 2,         2,         xsize - 3, ysize - 3); /* background */
  boxfill8(buf, xsize, COL8_848484, 1,         ysize - 2, xsize - 2, ysize - 2);
  boxfill8(buf, xsize, COL8_000000, 0,         ysize - 1, xsize - 1, ysize - 1);
  make_wtitle8(buf, xsize, title, act);
  return;
}

void make_wtitle8(unsigned short *buf, int xsize, char *title, char act) {
  static char closebtn[14][16] = {
    "OOOOOOOOOOOOOOO@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQ@@QQQQ@@QQ$@",
    "OQQQQ@@QQ@@QQQ$@",
    "OQQQQQ@@@@QQQQ$@",
    "OQQQQQQ@@QQQQQ$@",
    "OQQQQQ@@@@QQQQ$@",
    "OQQQQ@@QQ@@QQQ$@",
    "OQQQ@@QQQQ@@QQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "O$$$$$$$$$$$$$$@",
    "@@@@@@@@@@@@@@@@"
  };

  static char maxbtn[14][16] = {
    "OOOOOOOOOOOOOOO@",
    "OQQQQQQQQQQQQQ$@",
    "OQQ@@@@@@@@@QQ$@",
    "OQQ@@@@@@@@@QQ$@",
    "OQQ@@QQQQQ@@QQ$@",
    "OQQ@@QQQQQ@@QQ$@",
    "OQQ@@QQQQQ@@QQ$@",
    "OQQ@@QQQQQ@@QQ$@",
    "OQQ@@@@@@@@@QQ$@",
    "OQQ@@@@@@@@@QQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "O$$$$$$$$$$$$$$@",
    "@@@@@@@@@@@@@@@@"
  };

  static char minbtn[14][16] = {
    "OOOOOOOOOOOOOOO@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQ@@@@@@@@QQ$@",
    "OQQQ@@@@@@@@QQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "O$$$$$$$$$$$$$$@",
    "@@@@@@@@@@@@@@@@"
  };

  int x, y;
  unsigned char c, tc, tbc;
  if (act != 0) {
    tc = COL8_FFFFFF;
    tbc = 16 + 1 + 2 * 6 + 5 * 36;
  } else {
    tc = COL8_FFFFFF;
    tbc = COL8_848484;
  }
  boxfill8(buf, xsize, tbc, 3, 3, xsize - 4, 20);
  putfonts8_asc(buf, xsize, 24, 4, tc, 1, title);
  for (y = 0; y < 14; y++) {
    for (x = 0; x < 16; x++) {
      c = closebtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      buf[(5 + y) * xsize + (xsize - 21 + x)] = table_16_65536[c];
    }
  }

  /* for maxbtn */
  for (y = 0; y < 14; y++) {
    for (x = 0; x < 16; x++) {
      c = maxbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      buf[(5 + y) * xsize + (xsize - 38 + x)] = table_16_65536[c];
    }
  }

  /* for minbtn */
  for (y = 0; y < 14; y++) {
    for (x = 0; x < 16; x++) {
      c = minbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      buf[(5 + y) * xsize + (xsize - 55 + x)] = table_16_65536[c];
    }
  }
  return;
}

void putfonts8_asc_sht(struct SHEET *sht, int x, int y, int c, int b, char *s, int l) {
  struct TASK *task = task_now();
  boxfill8(sht->buf, sht->bxsize, b, x, y, x + l * 8 - 1, y + 15);
  if (task->langmode != 0 && task->langbyte1 != 0) {
    putfonts8_asc(sht->buf, sht->bxsize, x, y, c, 1, s);
    sheet_refresh(sht, x - 8, y, x + l * 8, y + 16);
  } else {
    putfonts8_asc(sht->buf, sht->bxsize, x, y, c, 1, s); /* graphic.c */
    sheet_refresh(sht, x, y, x + l * 8, y + 16);
  }
  return;
}

void make_textbox8(struct SHEET *sht, int x0, int y0, int sx, int sy, int c) {
  int x1 = x0 + sx, y1 = y0 + sy;
  boxfill8(sht->buf, sht->bxsize, COL8_848484, x0 - 2, y0 - 3, x1 + 1, y0 - 3);
  boxfill8(sht->buf, sht->bxsize, COL8_848484, x0 - 3, y0 - 3, x0 - 3, y1 + 1);
  boxfill8(sht->buf, sht->bxsize, COL8_FFFFFF, x0 - 3, y1 + 2, x1 + 1, y1 + 2);
  boxfill8(sht->buf, sht->bxsize, COL8_FFFFFF, x1 + 2, y0 - 3, x1 + 2, y1 + 2);
  boxfill8(sht->buf, sht->bxsize, COL8_000000, x0 - 1, y0 - 2, x1 + 0, y0 - 2);
  boxfill8(sht->buf, sht->bxsize, COL8_000000, x0 - 2, y0 - 2, x0 - 2, y1 + 0);
  boxfill8(sht->buf, sht->bxsize, COL8_C6C6C6, x0 - 2, y1 + 1, x1 + 0, y1 + 1);
  boxfill8(sht->buf, sht->bxsize, COL8_C6C6C6, x1 + 1, y0 - 2, x1 + 1, y1 + 1);
  boxfill8(sht->buf, sht->bxsize, c,           x0 - 1, y0 - 1, x1 + 0, y1 + 0);
  return;
}

void change_wtitle8(struct SHEET *sht, char act) {
  int x, y, xsize = sht->bxsize;
  unsigned char tc_new, tbc_new, tc_old, tbc_old;
  unsigned short c565, *buf = sht->buf;
  if (act != 0) {
    tc_new  = COL8_FFFFFF;
    tbc_new = 16 + 1 + 2 * 6 + 5 * 36;
    tc_old  = COL8_FFFFFF;
    tbc_old = COL8_848484;
  } else {
    tc_new  = COL8_FFFFFF;
    tbc_new = COL8_848484;
    tc_old  = COL8_FFFFFF;
    tbc_old = 16 + 1 + 2 * 6 + 5 * 36;
  }
  for (y = 3; y <= 20; y++) {
    for (x = 3; x <= xsize - 4; x++) {
      c565 = buf[y * xsize + x];
      if (c565 == table_16_65536[tc_old] && x <= xsize - 22) {
        c565 = table_16_65536[tc_new];
      } else if (c565 == table_16_65536[tbc_old]) {
        c565 = table_16_65536[tbc_new];
      }
      buf[y * xsize + x] = c565;
    }
  }
  sheet_refresh(sht, 3, 3, xsize, 21);
  return;
}

void set_title(struct SHEET * sht, char * title) {
  int x, y, xsize = sht->bxsize;
  unsigned char tc = COL8_FFFFFF;
  unsigned short c565, *buf = sht->buf;
  for (y = 3; y <= 20; y ++) {
    for (x = 3; x <= xsize - 22; x ++) {
      c565 = buf[y * xsize + x];
      c565 = table_16_65536[16 + 1 + 2 * 6 + 5 * 36];
      buf[y * xsize + x] = c565;
    }
  }
  putfonts8_asc(buf, xsize, 24, 4, tc, 1, title);
  sheet_refresh(sht, 3, 3, xsize, 21);
  return ;
}

/* <--> */
void make_h_scroll(struct SHEET *sht, int x1, int y1, int w) {
  static char leftbtn[14][16] = {
    "OOOOOOOOOOOOOOO@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQ@QQQQ$@",
    "OQQQQQQQ@@QQQQ$@",
    "OQQQQQQ@@@QQQQ$@",
    "OQQQQQ@@@@QQQQ$@",
    "OQQQQQQ@@@QQQQ$@",
    "OQQQQQQQ@@QQQQ$@",
    "OQQQQQQQQ@QQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "O$$$$$$$$$$$$$$@",
    "@@@@@@@@@@@@@@@@",
  };
  static char rightbtn[14][16] = {
    "OOOOOOOOOOOOOOO@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQ@QQQQQQQQ$@",
    "OQQQQ@@QQQQQQQ$@",
    "OQQQQ@@@QQQQQQ$@",
    "OQQQQ@@@@QQQQQ$@",
    "OQQQQ@@@QQQQQQ$@",
    "OQQQQ@@QQQQQQQ$@",
    "OQQQQ@QQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "O$$$$$$$$$$$$$$@",
    "@@@@@@@@@@@@@@@@",
  };
  static char slidbtn[14][4] = {
   "000@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0Q$@",
   "0$$@",
   "@@@@"
  };

  unsigned char c;
  int x, y;

  /* for leftbtn */
  for (y = 0; y < 14; y++) {
    for (x = 0; x < 16; x++) {
      c = leftbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      sht->buf[( y1 + y ) * sht->bxsize + x1 + x] = table_16_65536[c];
    }
  }
  /* for rightbtn */
  for (y = 0; y < 14; y++) {
    for (x = 0; x < 16; x++) {
      c = rightbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      sht->buf[( y1 + y ) * sht->bxsize + x1 + w - 16 + x] = table_16_65536[c];
    }
  }

  for (y = 0; y < 14; y++) {
    for(x = 0; x < (w - 32); x ++) {
      c = COL8_C6C6C6;
      sht->buf[(y1+y)*sht->bxsize + x1 + 16 + x] = table_16_65536[c];
    }
  }
}

/* */
/* +
   |
   |
   + */
void make_v_scroll(struct SHEET *sht, int x1, int y1, int h) {
  static char topbtn[14][16] = {
    "OOOOOOOOOOOOOOO@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQ@QQQQQQ$@",
    "OQQQQQ@@@QQQQQ$@",
    "OQQQQ@@@@@QQQQ$@",
    "OQQQ@@@@@@@QQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "O$$$$$$$$$$$$$$@",
    "@@@@@@@@@@@@@@@@",
  };
  static char botbtn[14][16] = {
    "OOOOOOOOOOOOOOO@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQ@@@@@@@QQQ$@",
    "OQQQQ@@@@@QQQQ$@",
    "OQQQQQ@@@QQQQQ$@",
    "OQQQQQQ@QQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "OQQQQQQQQQQQQQ$@",
    "O$$$$$$$$$$$$$$@",
    "@@@@@@@@@@@@@@@@",
  };

  unsigned char c;
  int x, y;

  /* for topbtn */
  for (y = 0; y < 14; y++) {
    for (x = 0; x < 16; x++) {
      c = topbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      sht->buf[( y1 + y ) * sht->bxsize + x1 + x] = table_16_65536[c];
    }
  }
  /* for botbtn */
  for (y = 0; y < 14; y++) {
    for (x = 0; x < 16; x++) {
      c = botbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      sht->buf[( y1 + h - 14 + y ) * sht->bxsize + x1 + x] = table_16_65536[c];
    }
  }

  for (y = 0; y < (h - 28); y++) {
    for(x = 0; x < 16; x ++) {
      c = COL8_C6C6C6;
      sht->buf[(y1+14+y)*sht->bxsize + x1 + x] = table_16_65536[c];
    }
  }
/*  make_v_scrollbtn(sht, x1, y1, h, 100); */
}

void make_v_scrollbtn(struct SHEET * sht, int x1, int y1, int h, int p) {
  static char slidbtn[4][16] = {
   "000000000000000@",
   "0QQQQQQQQQQQQQQ@",
   "0$$$$$$$$$$$$$$@",
   "@@@@@@@@@@@@@@@@"
  };

  unsigned char c;
  int x, y;

  for (y = 0; y < 1; y ++) {
    for(x = 0; x < 16; x ++) {
      c = slidbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      sht->buf[( y1 +  14 + y ) * sht->bxsize + x1 + x] = table_16_65536[c];

    }
  }

  for(y = 0; y < (h-28)*(p/100); y ++) {
    for(x = 0; x < 16; x ++) {
      c = slidbtn[1][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      sht->buf[( y1 + 14 + y ) * sht->bxsize + x1 + x] = table_16_65536[c];
    }
  }

  for (y = 2; y < 4; y ++) {
    for(x = 0; x < 16; x ++) {
      c = slidbtn[y][x];
      if (c == '@') {
        c = COL8_000000;
      } else if (c == '$') {
        c = COL8_848484;
      } else if (c == 'Q') {
        c = COL8_C6C6C6;
      } else {
        c = COL8_FFFFFF;
      }
      sht->buf[( y1 +  12 + h + y ) * sht->bxsize + x1 + x] = table_16_65536[c];
    }
  }

}

void make_progress(struct SHEET * sht, int x1, int y1, int w, int h, int flag) {
  int x, y;
  unsigned char c;
  c = COL8_848484;
  if (flag == 1) {
    c = COL8_0000FF;
  }
  for(y = 0; y < h; y ++) {
    for (x =0; x < w; x ++) {
      sht->buf[(y1+h+y)*sht->bxsize + x1 + x]= table_16_65536[c];
    }
  }
}
