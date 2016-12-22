/* debug */
/* file.c */
#include "bootpack.h"

struct DBGWIN dbg;
extern unsigned short table_16_65536[65536];
extern int * u_fat;
extern char fat_flag;

void dbg_init(struct SHEET *sht) {
    dbg.sht = sht;
    dbg.bc  = 16 + 1 + 3 * 6 + 4 * 36;
    dbg.x0  = 12;
    dbg.y0  = 200;
    dbg.cx  = 0;
    dbg.cy  = 0;
    dbg.wd  = 400;
    dbg.ht  = 240;
    make_textbox8(dbg.sht, dbg.x0, dbg.y0, dbg.wd, dbg.ht, dbg.bc);
//    putfonts8_asc_sht(dbg.sht, dbg.x0, dbg.y0, COL8_FFFFFF, dbg.bc, "Debug Window", 12); /* window.c */
    sheet_refresh(dbg.sht, dbg.x0 - 3, dbg.y0 - 3, dbg.x0 + dbg.wd + 3, dbg.y0 + dbg.ht + 3);
    dbg.init_flag = 1;
    return;
}

void dbg_putchar(int chr, int fc) {
  char s[2];
  s[0] = chr;
  s[1] = 0;
  if (s[0] == 0x09) {	/* タブ */
    for (;;) {
      if (dbg.sht != 0) {
        putfonts8_asc_sht(dbg.sht, dbg.x0 + dbg.cx, dbg.y0 + dbg.cy, fc, dbg.bc, " ", 1);
      }
      dbg.cx += 8;
      if (dbg.cx == dbg.wd) {
        dbg_newline(&dbg);
      }
      if ((dbg.cx & 0x1f) == 0) {
        break;	/* 32で割り切れたらbreak */
      }
    }
  } else if (s[0] == 0x0a) {	/* 改行 */
    dbg_newline(&dbg);
  } else if (s[0] == 0x0d) {	/* 復帰 */
    /* とりあえずなにもしない */
  } else {	/* 普通の文字 */
    if (dbg.sht != 0) {
      putfonts8_asc_sht(dbg.sht, dbg.x0 + dbg.cx, dbg.y0 + dbg.cy, fc, dbg.bc, s, 1);
    }
    dbg.cx += 8;
    if (dbg.cx == dbg.wd) {
      dbg_newline(&dbg);
    }
  }
  return;
}

void dbg_newline(struct DBGWIN *dbg) {
  int x, y;
  struct SHEET *sht = dbg->sht;
  dbg->cx = 0;
  if (dbg->cy < dbg->ht - 16) {
    dbg->cy += 16; /* 次の行へ */
  } else {
    /* スクロール */
    if (sht != 0) {
      for (y = dbg->y0; y < dbg->y0 + dbg->ht - 16; y++) {
        for (x = dbg->x0; x < dbg->x0 + dbg->wd; x++) {
          sht->buf[x + y * sht->bxsize] = sht->buf[x + (y + 16) * sht->bxsize];
        }
      }
      for (y = dbg->y0 + dbg->ht - 16; y < dbg->y0 + dbg->ht; y++) {
        for (x = dbg->x0; x < dbg->x0 + dbg->wd; x++) {
          sht->buf[x + y * sht->bxsize] = table_16_65536[dbg->bc];
        }
      }
      sheet_refresh(sht, dbg->x0, dbg->y0, dbg->x0 + dbg->wd, dbg->y0 + dbg->ht);
    }
  }
  return;
}

void dbg_putstr0(char *s, int c) {
  if (dbg.init_flag != 1) {
    return ;
  }
  for (; *s != 0; s++) {
    dbg_putchar(*s, c);
  }
  return;
}

void dbg_putstr1(char *s, int l, int c) {
  int i;
  for (i = 0; i < l; i++) {
    dbg_putchar(s[i], c);
  }
  return;
}

void out_log(char * msg) {
  struct FILEHANDLE fh;
  int testfile;
  char file_buf[256];

  if(fat_flag == 0) {
    return ;
  }
  testfile = hrb_api_fopen("/ztext.txt", 0, &fh, u_fat);
  memset(file_buf, 0, sizeof(file_buf));
  sprintf(file_buf, "[log]%s\n", msg);
  hrb_api_fwrite(file_buf, strlen(file_buf), &fh, u_fat);

  hrb_api_fclose(&fh, u_fat);
}
