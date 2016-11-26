/* **************** */
/*  console         */
/* **************** */

#include "bootpack.h"
#include <stdio.h>
#include <string.h>

extern char current_path[256];          /* bootpack,c */
extern int * u_fat;                     /* *.c */
extern unsigned short table_8_565[256]; /* graphic.c */
extern struct TASKCTL * taskctl;        /* mtask.c */
extern struct TIMERCTL timerctl;        /* time.c */

extern short CardID;
extern short IOAddr;
extern short SBIntr;
extern short DMA;
extern short HDMA;
extern short MIDI;
extern short Mixer;
extern short MixerAddr;
extern short MixerData;
extern short DSPReset;
extern short DSPRead;
extern short DSPWrite;
extern short DSPStatus;
extern short DSPIntAck;
extern float DSPVersionNum;
extern char ver1;
extern char ver2;

void console_task(struct SHEET *sheet, int memtotal) {

  struct TASK *task = task_now();
/*  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR; */
/*  int *fat = (int *) memman_alloc_4k(memman, 4 * 2880); */
  struct CONSOLE cons;
  struct FILEHANDLE fhandle[8];
  char cmdline[256];  /* char cmdline[30]; */
  unsigned char *nihongo = (char *) *((int *) 0x0fe8);
  int i;

  cons.sht = sheet;
  cons.cur_x =  8;
  cons.cur_y = 28;
  cons.cur_c = -1;
  task->cons = &cons;
  task->cmdline = cmdline;

  if (cons.sht != 0) {
    cons.timer = timer_alloc("con");
    timer_init(cons.timer, &task->fifo, 1);
    timer_settime(cons.timer, 50);
  }

/*   file_readfat(fat, (unsigned char *) (ADR_DISKIMG + 0x000200)); */
  for (i = 0; i < 8; i++) {
    fhandle[i].buf = 0;	/* 未使用マーク */
  }
  task->fhandle = fhandle;
/*   task->fat = fat; */
  task->fat = u_fat;

  if (nihongo[4096] != 0xff) {	/* 日本語フォントファイルを読み込めたか？ */
    task->langmode = 1;
    /* dbg_putstr0("langmode=1\n", COL8_FF0000); */
  } else {
    task->langmode = 0;
    /* dbg_putstr0("langmode=0\n", COL8_FF0000); */
  }
  task->langbyte1 = 0;

  /* プロンプト表示 */
  cons_putchar(&cons, '>', 1);

  for (;;) {
    io_cli();
    if (fifo32_status(&task->fifo) == 0) {
      task_sleep(task);
      io_sti();
    } else {
      i = fifo32_get(&task->fifo);
      io_sti();
      if (i <= 1 && cons.sht != 0) { /* cursor'timer */
        if (i != 0) {
          /* when i = 1 */
          timer_init(cons.timer, &task->fifo, 0); /* 次は0を */
          if (cons.cur_c >= 0) {
            cons.cur_c = COL8_FFFFFF;
          }
        } else {
          /* when i = 0 */
          timer_init(cons.timer, &task->fifo, 1); /* 次は1を */
          if (cons.cur_c >= 0) {
            cons.cur_c = COL8_000000;
          }
        }
        timer_settime(cons.timer, 50);
      }

      if (i == 2) {	/* カーソルON */
        cons.cur_c = COL8_FFFFFF;
      }

      if (i == 3) {	/* カーソルOFF */
        if (cons.sht != 0) {
          boxfill8(cons.sht->buf, cons.sht->bxsize, COL8_000000, cons.cur_x, cons.cur_y, cons.cur_x + 7, cons.cur_y + 15);
        }
        cons.cur_c = -1;
      }

      if (i == 4) {	/* コンソールの「×」ボタンクリック */
        cmd_exit(&cons, u_fat);
      }

      if (256 <= i && i <= 511) { /* キーボードデータ（タスクA経由） */
        if (i == 8 + 256) {
          /* Backspace */
          if (cons.cur_x > 16) {
            /* カーソルをスペースで消してから、カーソルを1つ戻す */
            cons_putchar(&cons, ' ', 0);
            cons.cur_x -= 8;
          }

        } else if (i == 10 + 256) {
          /* Enter */
          /* カーソルをスペースで消してから改行する */
          cons_putchar(&cons, ' ', 0);
          cmdline[cons.cur_x / 8 - 2] = 0;
          cons_newline(&cons);
          cons_runcmd(cmdline, &cons, u_fat, memtotal);	/* コマンド実行 */
          if (cons.sht == 0) {
            cmd_exit(&cons, u_fat);
          }
          /* プロンプト表示 */
          cons_putchar(&cons, '>', 1);
        } else {
          /* 一般文字 */
          /* if (cons.cur_x < 240) { */
          if (cons.cur_x < 584) {
            /* 一文字表示してから、カーソルを1つ進める */
            cmdline[cons.cur_x / 8 - 2] = i - 256;
            cons_putchar(&cons, i - 256, 1);
          }
        }
      }
      /* カーソル再表示 */
      if (cons.sht != 0) {
        if (cons.cur_c >= 0) {
          boxfill8(cons.sht->buf, cons.sht->bxsize, cons.cur_c, cons.cur_x, cons.cur_y, cons.cur_x + 7, cons.cur_y + 15);
        }
        sheet_refresh(cons.sht, cons.cur_x, cons.cur_y, cons.cur_x + 8, cons.cur_y + 16);
      }
    }
  }
}

/*
 * display a char at console.
 */
void cons_putchar(struct CONSOLE *cons, int chr, char move) {

  char s[2];
  s[0] = chr;
  s[1] = 0;

  if (s[0] == 0x09) {	/* Tab */
    for (;;) {
      if (cons->sht != 0) {
        putfonts8_asc_sht(cons->sht, cons->cur_x, cons->cur_y, COL8_FFFFFF, COL8_000000, " ", 1);
      }
      cons->cur_x += 8;
      if (cons->cur_x == 8 + 584) {
        cons_newline(cons);
      }
      if (((cons->cur_x - 8) & 0x1f) == 0) {
        break;	/* 32で割り切れたらbreak */
      }
    }
  } else if (s[0] == 0x0a) {	/* Enter */
    cons_newline(cons);
  } else if (s[0] == 0x0d) {	/* 復帰 */
    /* とりあえずなにもしない */
  } else {	/* 普通の文字 */
    if (cons->sht != 0) {
      putfonts8_asc_sht(cons->sht, cons->cur_x, cons->cur_y, COL8_FFFFFF, COL8_000000, s, 1);
    }
    if (move != 0) {
      /* moveが0のときはカーソルを進めない */
      cons->cur_x += 8;
      if (cons->cur_x == 8 + 584) {
        cons_newline(cons);
      }
    }
  }
  return;
}

/*
 * add a new line an console on some's event.
 */
void cons_newline(struct CONSOLE *cons) {
  int x, y;
  struct SHEET *sheet = cons->sht;
  struct TASK *task = task_now();
  if (cons->cur_y < 28 + 336) {
    cons->cur_y += 16; /* 次の行へ */
  } else {
    /* スクロール */
    if (sheet != 0) {

      for (y = 28; y < 28 + 336; y++) {
        for (x = 8; x < 8 + 584; x++) {
          sheet->buf[x + y * sheet->bxsize] = sheet->buf[x + (y + 16) * sheet->bxsize];
        }
      }

      for (y = 28 + 336; y < 28 + 363; y++) {
        for (x = 8; x < 8 + 584; x++) {
          sheet->buf[x + y * sheet->bxsize] = COL8_000000;
        }
      }
      sheet_refresh(sheet, 8, 28, 8 + 584, 28 + 363);
    }
  }
  cons->cur_x = 8;
  if (task->langmode == 1 && task->langbyte1 != 0) {
    cons->cur_x = 16;
  }
  return;
}

/*
 * display a string at console.
 */
void cons_putstr0(struct CONSOLE *cons, char *s) {
  for (; *s != 0; s++) {
    cons_putchar(cons, *s, 1);
  }
  return;
}

/*
 * display a string at console.
 */
void cons_putstr1(struct CONSOLE *cons, char *s, int l) {
  int i;
  for (i = 0; i < l; i++) {
    cons_putchar(cons, s[i], 1);
  }
  return;
}

/*
 * commands.
 * resident commnads and search transient commands.
 */
void cons_runcmd(char *cmdline, struct CONSOLE *cons, int *fat, int memtotal) {
  if (strcmp(cmdline, "mem") == 0 && cons->sht != 0) {
    cmd_mem(cons, memtotal);
  } else if (strcmp(cmdline, "cls") == 0 && cons->sht != 0) {
    cmd_cls(cons);
  } else if (strcmp(cmdline, "dir") == 0 && cons->sht != 0) {
    cmd_dir(cons);
  } else if (strcmp(cmdline, "exit") == 0) {
    cmd_exit(cons, fat);
  } else if (strncmp(cmdline, "start ", 6) == 0) {
    cmd_start(cons, cmdline, memtotal);
  } else if (strncmp(cmdline, "ncst ", 5) == 0) {
    cmd_ncst(cons, cmdline, memtotal);
  } else if (strncmp(cmdline, "langmode ", 9) == 0) {
    cmd_langmode(cons, cmdline);
  } else if (strncmp(cmdline, "?", 1) == 0) {
    cmd_help(cons, cmdline);
  } else if (strncmp(cmdline, "ver", 3) == 0) {
    cmd_ver(cons, cmdline);
  } else if ( ( strncmp(cmdline, "time", 4) == 0 && 
            ( cmdline[4] == 0 || cmdline[4] == ' ') ) || 
             strncmp(cmdline, "date", 4) == 0) {
    cmd_time(cons, cmdline);
  } else if (strncmp(cmdline, "tasklst", 7) == 0) {
    cmd_tasklst(cons, cmdline);
  } else if (strncmp(cmdline, "timerlst", 8) == 0) {
    cmd_timerlst(cons, cmdline);
  } else if (strncmp(cmdline, "sheetlst", 8) == 0) {
    cmd_sheetlst(cons, cmdline);
  } else if (strncmp(cmdline, "title" , 5) == 0 && (
             cmdline[5] == 0 || cmdline[5] == ' ' ||
             cmdline[5] == '/' ) ) {
    cmd_title(cons, cmdline);
  } else if (strncmp(cmdline, "test", 4) == 0) {
    open_taskmgr(memtotal); /* bootpack.c */
  } else if (strncmp(cmdline, "read" , 4) == 0 && (
             cmdline[4] == 0 || cmdline[4] == ' ' ||
             cmdline[4] == '/' ) ) {
    cmd_read(cons, cmdline);
  } else if (strncmp(cmdline, "sond" , 4) == 0 && (
             cmdline[4] == 0 || cmdline[4] == ' ' ||
             cmdline[4] == '/' ) ) {
    cmd_sond(cons, cmdline);
  } else if (strncmp(cmdline, "cd", 2) == 0 || strncmp(cmdline, "chdir", 5) == 0) {
    cmd_cd(cons, cmdline, fat);
  } else if (strncmp(cmdline, "md", 2) == 0 || strncmp(cmdline, "mkdir", 5) == 0) {
    cmd_md(cons, cmdline, fat);
  } else if (strncmp(cmdline, "rd", 2) == 0 || strncmp(cmdline, "rmdir", 5) == 0) {
    cmd_rd(cons, cmdline, fat);

  } else if (strncmp(cmdline, "del ", 4) == 0) {
    cmd_del(cons, cmdline);
  } else if (strncmp(cmdline, "pwd", 3) == 0) {
    cmd_pwd(cons);
  } else if (cmdline[0] != 0) {
    /* try as transient command */
    if (cmd_app(cons, fat, cmdline) == 0) {
      /* コマンドではなく、アプリでもなく、さらに空行でもない */
      cons_putstr0(cons, "Bad command.\n\n");
    }
  }
  return;
}

void cmd_mem(struct CONSOLE *cons, int memtotal) {
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  char s[60];
  sprintf(s, "total   %dMB\nfree %dKB\n\n", memtotal / (1024 * 1024), memman_total(memman) / 1024);
  cons_putstr0(cons, s);
  return;
}

void cmd_cls(struct CONSOLE *cons) {
  int x, y;
  struct SHEET *sheet = cons->sht;
  /* for (y = 28; y < 28 + 128; y++) { */
  for (y = 28; y < 28 + 363; y++) {
    /* for (x = 8; x < 8 + 240; x++) { */
    for (x = 8; x < 8 + 584; x++) {
      sheet->buf[x + y * sheet->bxsize] = COL8_000000;
    }
  }
  /* sheet_refresh(sheet, 8, 28, 8 + 240, 28 + 128); */
  sheet_refresh(sheet, 8, 28, 8 + 584, 28 + 363);
  cons->cur_y = 28;
  return;
}

void cmd_dir(struct CONSOLE *cons) {
  struct FILEINFO *finfo = (struct FILEINFO *) (ADR_DISKIMG + 0x002600);
  int i, j;
  char s[50];
  char attr[2];
  short modify_year;
  short modify_month;
  short modify_day;
  short modify_hour;
  short modify_mi;
  char modify_date_yyyy[5];
  char modify_date_mm[3];
  char modify_date_dd[3];
  char modify_time_hh[3];
  char modify_time_mi[3];
  char modify_time_ss[3];
  char dbg_msg[80];

  attr[1] = 0;
  for (i = 0; i < 224; i++) {
    memset(dbg_msg, 0, sizeof(dbg_msg));
    sprintf(dbg_msg, "%d", i);
    dbg_putstr0(dbg_msg, COL8_FFFFFF);

    if (finfo[i].name[0] == 0x00) {
      /* End */
      break;
    }
    if (finfo[i].name[0] != 0xe5) {
      /* 0xE5:Deleted */
      if ((finfo[i].attribute & 0x18) == 0) {
        attr[0] = ' ';
        if ((finfo[i].attribute & 0x01) == 1) {
          attr[0] = 'R';
        }
        if ((finfo[i].attribute & 0x02) == 1) {
          attr[0] = 'H';
        }
        if ((finfo[i].attribute & 0x04) == 1) {
          attr[0] = 'S';
        }
        if ((finfo[i].attribute & 0x20) == 1) {
          attr[0] = 'A';
        }

        modify_year = (short) ((finfo[i].mod_date >> 9) & 0x007F);
        memset(modify_date_yyyy, 0, sizeof(modify_date_yyyy));
        sprintf(modify_date_yyyy, "%04d", modify_year + 1980);

        modify_month = (short) ((finfo[i].mod_date >> 5) & 0x000F);
        memset(modify_date_mm, 0, sizeof(modify_date_mm));
        sprintf(modify_date_mm, "%02d", modify_month);

        modify_day = (short) ((finfo[i].mod_date >> 0) & 0x001F);
        memset(modify_date_dd, 0, sizeof(modify_date_dd));
        sprintf(modify_date_dd, "%02d", modify_day);

        modify_hour = (short) ((finfo[i].mod_time >> 9) & 0x007F);
        memset(modify_time_hh, 0, sizeof(modify_time_hh));
        sprintf(modify_time_hh, "%02d", modify_hour);

        modify_mi = (short) ((finfo[i].mod_time >> 5) & 0x000F);
        memset(modify_time_mi, 0, sizeof(modify_time_mi));
        sprintf(modify_time_mi, "%02d", modify_mi);

        /* 0x08:Label + 0x10:SubFolder */
                 /*       8+1+3+1+4+1+2+1+2+1+2+1+2+1+7 */
        memset(s, 0, sizeof(s));
        sprintf(s, "%s/%s/%s  %s:%s <DIR>%7d filename.ext\n", modify_date_yyyy, modify_date_mm, modify_date_dd, modify_time_hh, modify_time_mi, finfo[i].size);
        for (j = 0; j < 8; j++) {
          s[31 + j] = finfo[i].name[j];
        }
        s[40] = finfo[i].ext[0];
        s[41] = finfo[i].ext[1];
        s[42] = finfo[i].ext[2];

        cons_putstr0(cons, s);
      }
    }
  }
  cons_newline(cons);
  return;
}

void cmd_exit(struct CONSOLE *cons, int *fat) {
/*  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR; */
  struct TASK *task = task_now();
  struct SHTCTL *shtctl = (struct SHTCTL *) *((int *) 0x0fe4);
  struct FIFO32 *fifo = (struct FIFO32 *) *((int *) 0x0fec);
  if (cons->sht != 0) {
    timer_cancel(cons->timer);
  }
/*  memman_free_4k(memman, (int) fat, 4 * 2880); */
  io_cli();
  if (cons->sht != 0) {
    fifo32_put(fifo, cons->sht - shtctl->sheets0 + 768);	/* 768～1023 */
  } else {
    fifo32_put(fifo, task - taskctl->tasks0 + 1024);	/* 1024～2023 */
  }
  io_sti();
  for (;;) {
    task_sleep(task);
  }
}

void cmd_start(struct CONSOLE *cons, char *cmdline, int memtotal){
  struct SHTCTL *shtctl = (struct SHTCTL *) *((int *) 0x0fe4);
  struct SHEET *sht = open_console(shtctl, memtotal);
  struct FIFO32 *fifo = &sht->task->fifo;
  int i;
  sheet_slide(sht, 32, 4);
  sheet_updown(sht, shtctl->top);
  /* コマンドラインに入力された文字列を、一文字ずつ新しいコンソールに入力 */
  for (i = 6; cmdline[i] != 0; i++) {
   fifo32_put(fifo, cmdline[i] + 256);
  }
  fifo32_put(fifo, 10 + 256);	/* Enter */
  cons_newline(cons);
  return;
}

void cmd_ncst(struct CONSOLE *cons, char *cmdline, int memtotal) {
  struct TASK *task = open_constask(0, memtotal);
  struct FIFO32 *fifo = &task->fifo;
  int i;
  /* コマンドラインに入力された文字列を、一文字ずつ新しいコンソールに入力 */
  for (i = 5; cmdline[i] != 0; i++) {
    fifo32_put(fifo, cmdline[i] + 256);
  }
  fifo32_put(fifo, 10 + 256);	/* Enter */
  cons_newline(cons);
  return;
}

void cmd_langmode(struct CONSOLE *cons, char *cmdline) {
  struct TASK *task = task_now();
  unsigned char mode = cmdline[9] - '0';
  if (mode <= 2) {
    task->langmode = mode;
  } else {
    cons_putstr0(cons, "mode number error.\n");
  }
  cons_newline(cons);
  return;
}

void cmd_help(struct CONSOLE *cons, char *cmdline) {
  char s[81];
  sprintf(s, "cls      dir      exit     help      langmode mem      ncst     start \n");
  cons_putstr0(cons, s);
  sprintf(s, "pwd      \n");
  cons_putstr0(cons, s);
  sprintf(s, "Internam commands available:\n");
  cons_putstr0(cons, s);
  sprintf(s, "ALIAS    BEEP     BREAK    CALL      CD=      CHDIR=   CDD      CHCP\n");
  cons_putstr0(cons, s);
  sprintf(s, "CLS*     COPY     CTTY     DATE*     DEL*     DIR*     DIRS     DOSKEY\n");
  cons_putstr0(cons, s);
  sprintf(s, "ECHO     ERASE    EXIT     FOR       GOTO     HISTORY  IF       LFNFOR\n");
  cons_putstr0(cons, s);
  sprintf(s, "LH       LOADHIGH LOADFIX  MEMORY    MD=      MKDIR=   PATH     PAUSE\n");
  cons_putstr0(cons, s);
  sprintf(s, "PROMPT   PUSHD    POPD     RD=       REM      REN      RENAME   RMDIR=\n");
  cons_putstr0(cons, s);
  sprintf(s, "SET      SHIFT    TIME*    TRUENAME  TYPE*    VER*     VERIFY   VOL\n");
  cons_putstr0(cons, s);
  sprintf(s, "?        WHICH    TITLE\n");
  cons_putstr0(cons, s);
  cons_newline(cons);
  return ;
}

void cmd_ver(struct CONSOLE *cons, char *cmdline) {
  char s[81];
  sprintf(s, "\nHaribote version 1.0 [2010].\n");
  cons_putstr0(cons, s);
  cons_newline(cons);
  return ;
}

/*
 * dispaly current's date and time at console.
 */
void cmd_time(struct CONSOLE *cons, char *cmdline) {
  int i, t[6];
  char s[18];
  for (i = 0; i < 7; i++) {
    t[i] = rtc_get(i);
  }
  sprintf(s, "%04d/%02d/%02d %02d:%02d:%02d\n", t[0], t[1], t[2], t[3], t[4], t[5]);
  cons_putstr0(cons, s);
  cons_newline(cons);
  return;
}

void cmd_title(struct CONSOLE * cons, char * cmdline) {
  char msg[81];
  int idx;
  int ilen = strlen(cmdline);
  if (ilen <= 6) {
    cons_newline(cons);
    return ;
  }

  idx = 5;
  while (idx < ilen) {
    if (cmdline[idx] == '/') {
      idx ++;
      continue;
    }
    if (cmdline[idx] == '?') {
      cons_putstr0(cons, "[USEAGE]TITLE ""title""\n");
      cons_newline(cons);
      return ;
    }
    if (cmdline[idx] != ' ') {
      break;
    }

    idx ++;
  }

  sprintf(msg, "%s", cmdline + idx);
  /* cons_putstr0(cons, msg); */
  cons_putstr0(cons, "\n");

  set_console_title(cons, msg);

  return ;
}

void cmd_read(struct CONSOLE * cons, char * cmdline) {
  cons_putstr0(cons, "read.\n");
}

void cmd_sond(struct CONSOLE * cons, char * cmdline) {
  char msg[129];
    char CardType[7][34]={
	  "-Creative Sound Blaster Series -",
	  "Sound Blaster",
	  "Sound Blaster Pro",
	  "Sound Blaster 2.0",
	  "Sound Blaster Pro 2.0",
	  "Sound Blaster Pro MCV",
	  "Sound Blaster 16"};


  if(test_sb16() == -1) {
    cons_putstr0(cons, "Error\n");
  }

  if(CardID < 7 && CardID >=0) {

    memset(msg, 0, sizeof(msg));
    sprintf(msg, "\n\nThe %s is detected\n", CardType[CardID]);
    cons_putstr0(cons, msg);

    memset(msg, 0, sizeof(msg));
    sprintf(msg, "Blaster I/O Port : %x\n", IOAddr);
    cons_putstr0(cons, msg);

    memset(msg, 0, sizeof(msg));
    sprintf(msg, "DSP Version : %d.%d\n", ver1, ver2);
    cons_putstr0(cons, msg);

    memset(msg, 0, sizeof(msg));
    sprintf(msg, "IRQ : %d\n", SBIntr);
    cons_putstr0(cons, msg);

    memset(msg, 0, sizeof(msg));
    sprintf(msg, "DMA : %d\n", DMA);
    cons_putstr0(cons, msg);

    if(HDMA) {
      memset(msg, 0, sizeof(msg));
      sprintf(msg, "HDMA : %d\n", HDMA);
      cons_putstr0(cons, msg);
    }
    if(MIDI) {
      memset(msg, 0, sizeof(msg));
      sprintf(msg, "MIDI : %x\n", MIDI);
      cons_putstr0(cons, msg);
    }
    if(Mixer) {
      memset(msg, 0, sizeof(msg));
      sprintf(msg, "Mixer Addr : %x\n", Mixer);
      cons_putstr0(cons, msg);
    }
  } else {
    memset(msg, 0, sizeof(msg));
    sprintf(msg, "Unknown Card!\n");
    cons_putstr0(cons, msg);
  }

  write_dsp(0x00D1);
  cons_putstr0(cons, "sond.\n");
}


void cmd_tasklst(struct CONSOLE *cons, char *cmdline) {
  int i;
  char msg[80];
  char task_state[10];
  struct TASKLEVEL * tl = &taskctl->level[taskctl->now_lv];

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "current level:%d\n", taskctl->now_lv);
  cons_putstr0(cons, msg);

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "search  task :%d\n", taskctl->lv_change);
  cons_putstr0(cons, msg);

  memset(msg, 0, sizeof(msg));
  sprintf(msg, "current task:%s\n", tl->tasks[tl->now]->name);
  cons_putstr0(cons, msg);

  cons_putstr0(cons, "No. Command Line    lvl p  name       state      mode byte\n");
  cons_putstr0(cons, "--- --------------- --- -- ---------- ---------- ---- ----\n");
  for( i = 0; i < MAX_TASKS; i ++) {
    if( taskctl->tasks0[i].flags == 0 ) {
      continue;
    }
    task_state[0] = 0;
    if ( taskctl->tasks0[i].flags == 2 ) {
      sprintf(task_state, "running ");
    }
    if ( taskctl->tasks0[i].flags == 1 ) {
      sprintf(task_state, "sleeping");
    }
    if ( taskctl->tasks0[i].flags == 0 ) {
      sprintf(task_state, "unused");
    }
    memset(msg, 0, sizeof(msg));
    sprintf(msg, "%3d %-15s %3d %2d %-10s %s %4d %4d\n", 
      (i + 1), 
      taskctl->tasks0[i].cmdline, 
      taskctl->tasks0[i].level, 
      taskctl->tasks0[i].priority, 
      taskctl->tasks0[i].name, 
      task_state,
      taskctl->tasks0[i].langmode,
      taskctl->tasks0[i].langbyte1);
      cons_putstr0(cons, msg);
  }

/*  cons_putstr0(cons, "running now\n");
  for ( i = 0; i < MAX_TASKLEVELS; i ++) {
    memset(msg, 0, sizeof(msg));
    sprintf(msg, "%d  %d\n", taskctl->level[i].running, taskctl->level[i].now);
    cons_putstr0(cons, msg);
  }*/
  cons_newline(cons);
  return ;
}

void cmd_timerlst(struct CONSOLE *cons, char *cmdline) {
	int i;
	char msg[80];
	char task_state[10];

	cons_putstr0(cons, "Information of TIMERCTL:\n");

	msg[0]= 0;

	sprintf(msg, "count:%d\n", timerctl.count);
	cons_putstr0(cons, msg);

	sprintf(msg, "next: %d \n", timerctl.next);
	cons_putstr0(cons, msg);

	task_state[0] = 0;
	if ( timerctl.t0->flags == 2 ) {
		sprintf(task_state, "using");
	}
	if ( timerctl.t0->flags == 1 ) {
		sprintf(task_state, "alloc");
	}
	if ( timerctl.t0->flags == 0 ) {
		sprintf(task_state, "unused");
	}

	sprintf(msg, "t0: %s %10d %10s %10d %10d\n", timerctl.t0->name, timerctl.t0->timeout, task_state, timerctl.t0->flags2, timerctl.t0->data);
	cons_putstr0(cons, msg);

	cons_putstr0(cons, "name            timeout      state      flag2       data\n");
	cons_putstr0(cons, "------------ ---------- ---------- ---------- ----------\n");
	for( i = 0; i < MAX_TIMER; i ++) {
		msg[0]=0;
		if( timerctl.timers0[i].flags == 0 ) {
			continue;
		}
		task_state[0] = 0;
		if ( timerctl.timers0[i].flags == 2 ) {
			sprintf(task_state, "using");
		}
		if ( timerctl.timers0[i].flags == 1 ) {
			sprintf(task_state, "alloc");
		}
		if ( timerctl.timers0[i].flags == 0 ) {
			sprintf(task_state, "unused");
		}
		memset(msg, 0, sizeof(msg));
		sprintf(msg, "%12s %10u %10s %10d %10d\n", timerctl.timers0[i].name, timerctl.timers0[i].timeout, task_state, timerctl.timers0[i].flags2, timerctl.timers0[i].data);
		cons_putstr0(cons, msg);
	}

	cons_newline(cons);
	return ;
}

void cmd_sheetlst(struct CONSOLE *cons, char *cmdline) {
	int i;
	char msg[80];
	char task_state[10];

	cons_putstr0(cons, "Information of SHEETCTL:\n");

	struct SHTCTL *ctl = (struct SHTCTL *) *((int *) 0x0fe4);

	msg[0]= 0;

	sprintf(msg, "vram:%p\n", ctl->vram);
	cons_putstr0(cons, msg);
	sprintf(msg, "map: %d \n", ctl->map);
	cons_putstr0(cons, msg);
	sprintf(msg, "xsize: %d \n", ctl->xsize);
	cons_putstr0(cons, msg);
	sprintf(msg, "ysize: %d \n", ctl->ysize);
	cons_putstr0(cons, msg);
	sprintf(msg, "top: %d \n", ctl->top);
	cons_putstr0(cons, msg);

/*	task_state[0] = 0;
	if ( timerctl.t0->flags == 2 ) {
		sprintf(task_state, "using");
	}
	if ( timerctl.t0->flags == 1 ) {
		sprintf(task_state, "alloc");
	}
	if ( timerctl.t0->flags == 0 ) {
		sprintf(task_state, "unused");
	}
	sprintf(msg, "t0: %s %10d %10s %10d %10d\n", timerctl.t0->name, timerctl.t0->timeout, task_state, timerctl.t0->flags2, timerctl.t0->data);
	cons_putstr0(cons, msg);
*/
	cons_putstr0(cons, "No. buf        bxsize bysize vx0    vy0    taskname  \n");
	cons_putstr0(cons, "--- ---------- ------ ------ ------ ------ ----------\n");
	for( i = 0; i < MAX_SHEETS; i ++) {
		msg[0]=0;
		if( ctl->sheets0[i].flags == 0 ) {
			continue;
		}
		task_state[0] = 0;
		if ( ctl->sheets0[i].flags == 1 ) {
			sprintf(task_state, "n_alloc");
		}
		if ( ctl->sheets0[i].flags == 0 ) {
			sprintf(task_state, "unused");
		}
		if (ctl->sheets0[i].task != 0) {
			sprintf(task_state, "%-10s", ctl->sheets0[i].task->name);
		}
		memset(msg, 0, sizeof(msg));
		sprintf(msg, "%3d %10d %6d %6d %6d %6d %-10s%X\n", (i + 1), ctl->sheets0[i].buf, ctl->sheets0[i].bxsize, ctl->sheets0[i].bysize, ctl->sheets0[i].vx0, ctl->sheets0[i].vy0, task_state, ctl->sheets0[i].callback);
		cons_putstr0(cons, msg);
	}

	cons_newline(cons);
	return ;
}

/*
 * 現在のディレクトリを表示または変更します。
 */
void cmd_cd(struct CONSOLE *cons, char *cmdline, int * fat) {
  char fpath[256];
  struct FILEINFO *ffinfo;

  file_path(fpath, cmdline + 3, sizeof(fpath));
  if (fpath[0] == 0) {
    cons_putstr0(cons, "No such directory.\n\n");
    return;
  }

  if (strcmp(fpath, "/") == 0) {
    memset(current_path, 0, sizeof(current_path));
    current_path[0] = '/';
  } else {
    ffinfo = file_search2(fpath, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224, fat);
    if (ffinfo != 0 && (ffinfo->attribute & 0x10) == 0x10) {
      memset(current_path, 0, sizeof(current_path));
      strcpy(current_path, fpath);
      if (current_path[strlen(current_path) - 1] != '/') {
        current_path[strlen(current_path)] = '/';
      }
    } else {
      cons_putstr0(cons, "No such directory.\n\n");
    }
  }
  return;
}

/*
 * ディレクトリを作成します。 
 */
void cmd_md(struct CONSOLE *cons, char *cmdline, int * fat) {
  return ;
}

/*
 * ディレクトリを削除します。
 */
void cmd_rd(struct CONSOLE *cons, char *cmdline, int * fat) {
  return ;
}

void cmd_del(struct CONSOLE *cons, char *cmdline) {
  /* if (hrb_api_remove(cmdline + 4, fat) == -1) {
    if (cons->sht != 0) {
      cons_putstr0(cons, "No such file.\n\n");
    }
  } */
  return;
}

void cmd_pwd(struct CONSOLE *cons) {
  int len;
  char msg[256];
  memset(msg, 0, sizeof(msg));
  strncpy(msg, current_path, 255);
  if ((len = strlen(msg)) > 1 ) {
    msg[len - 1 ] = '\n';
  } else {
    msg[1] = '\n';
  }
  cons_putstr0(cons, msg);
  cons_putstr0(cons, "\n");
  return ;
}

/*
 * transient command.
 * search path:current path,%PATH%.
 */
int cmd_app(struct CONSOLE *cons, int *fat, char *cmdline) {
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  struct FILEINFO *finfo;
  char name[18], *p, *q;
  struct TASK *task = task_now();
  int i, segsiz, datsiz, esp, dathrb, appsiz;
  struct SHTCTL *shtctl;
  struct SHEET *sht;

  /* コマンドラインからファイル名を生成 */
  for (i = 0; i < 13; i++) {
    if (cmdline[i] <= ' ') {
      break;
    }
    name[i] = cmdline[i];
  }
  name[i] = 0; /* とりあえずファイル名の後ろを0にする */

  /* ファイルを探す */
  finfo = file_search(name, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224);
  if (finfo == 0 && name[i - 1] != '.') {
    /* 見つからなかったので後ろに".HRB"をつけてもう一度探してみる */
    name[i    ] = '.';
    name[i + 1] = 'H';
    name[i + 2] = 'R';
    name[i + 3] = 'B';
    name[i + 4] = 0;
    finfo = file_search(name, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224);
  }

  if (finfo != 0) {
    /* ファイルが見つかった場合 */
    appsiz = finfo->size;
    p = file_loadfile2(finfo->clustno, &appsiz, fat);
    if (appsiz >= 36 && strncmp(p + 4, "Hari", 4) == 0 && *p == 0x00) {
      segsiz = *((int *) (p + 0x0000));
      esp    = *((int *) (p + 0x000c));
      datsiz = *((int *) (p + 0x0010));
      dathrb = *((int *) (p + 0x0014));
      q = (char *) memman_alloc_4k(memman, segsiz);
      task->ds_base = (int) q;
      set_segmdesc(task->ldt + 0, appsiz - 1, (int) p, AR_CODE32_ER + 0x60);
      set_segmdesc(task->ldt + 1, segsiz - 1, (int) q, AR_DATA32_RW + 0x60);
      for (i = 0; i < datsiz; i++) {
        q[esp + i] = p[dathrb + i];
      }
      start_app(0x1b, 0 * 8 + 4, esp, 1 * 8 + 4, &(task->tss.esp0));
      shtctl = (struct SHTCTL *) *((int *) 0x0fe4);
      for (i = 0; i < MAX_SHEETS; i++) {
        sht = &(shtctl->sheets0[i]);
        if ((sht->flags & 0x11) == 0x11 && sht->task == task) {
          /* アプリが開きっぱなしにした下じきを発見 */
          sheet_free(sht);	/* 閉じる */
        }
      }
      for (i = 0; i < 8; i++) {	/* クローズしてないファイルをクローズ */
        if (task->fhandle[i].buf != 0) {
          memman_free_4k(memman, (int) task->fhandle[i].buf, task->fhandle[i].size);
          task->fhandle[i].buf = 0;
        }
      }
      timer_cancelall(&task->fifo);
      memman_free_4k(memman, (int) q, segsiz);
      task->langbyte1 = 0;
    } else {
      cons_putstr0(cons, ".hrb file format error.\n");
    }
    memman_free_4k(memman, (int) p, appsiz);
    cons_newline(cons);
    return 1;
  }
  /* ファイルが見つからなかった場合 */
  return 0;
}

int *hrb_api(int edi, int esi, int ebp, int esp, int ebx, int edx, int ecx, int eax) {
  struct TASK *task = task_now();
  int ds_base = task->ds_base;
  struct CONSOLE *cons = task->cons;
  struct SHTCTL *shtctl = (struct SHTCTL *) *((int *) 0x0fe4);
  struct SHEET *sht;
  struct FIFO32 *sys_fifo = (struct FIFO32 *) *((int *) 0x0fec);
  int *reg = &eax + 1;	/* eaxの次の番地 */
    /* 保存のためのPUSHADを強引に書き換える */
    /* reg[0] : EDI,   reg[1] : ESI,   reg[2] : EBP,   reg[3] : ESP */
    /* reg[4] : EBX,   reg[5] : EDX,   reg[6] : ECX,   reg[7] : EAX */
  int i;
  struct FILEINFO *finfo;
  struct FILEHANDLE *fh;
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;

  if (edx == 1) {
    cons_putchar(cons, eax & 0xff, 1);
  } else if (edx == 2) {
    cons_putstr0(cons, (char *) ebx + ds_base);
  } else if (edx == 3) {
    cons_putstr1(cons, (char *) ebx + ds_base, ecx);
  } else if (edx == 4) {
    return &(task->tss.esp0);
  } else if (edx == 5) {
    dbg_putstr0("INT 0x40 5<start>\n", COL8_FF0000);
    sht = sheet_alloc(shtctl);
    sht->task = task;
    sht->flags |= 0x10;
    if (eax != -1) { sht->flags |= 0x40; }
    sheet_setbuf(sht, (short *) (ebx + ds_base), esi, edi, eax);
    dbg_putstr0("INT 0x40 5[make_window8]<start>\n", COL8_FF0000);
    dbg_putstr0((char *) ecx + ds_base, COL8_FF0000);

    make_window8((short *) (ebx + ds_base), esi, edi, (char *) ecx + ds_base, 0);
/*    task->langmode = 1;
    task->langbyte1 = 0; */

    dbg_putstr0("INT 0x40 5[make_window8]< end >\n", COL8_FF0000);


    sheet_slide(sht, ((shtctl->xsize - esi) / 2) & ~3, (shtctl->ysize - edi) / 2);
    sheet_updown(sht, shtctl->top); /* 今のマウスと同じ高さになるように指定： マウスはこの上になる */
    reg[7] = (int) sht;
    dbg_putstr0("INT 0x40 5< end >\n", COL8_FF0000);
  } else if (edx == 6) {
    sht = (struct SHEET *) (ebx & 0xfffffffe);
    putfonts8_asc(sht->buf, sht->bxsize, esi, edi, eax, 1, (char *) ebp + ds_base);
    if ((ebx & 1) == 0) {
      sheet_refresh(sht, esi, edi, esi + ecx * 8, edi + 16);
    }
  } else if (edx == 7) {
    sht = (struct SHEET *) (ebx & 0xfffffffe);
    boxfill8(sht->buf, sht->bxsize, ebp, eax, ecx, esi, edi);
    if ((ebx & 1) == 0) {
      sheet_refresh(sht, eax, ecx, esi + 1, edi + 1);
    }
  } else if (edx == 8) {
    memman_init((struct MEMMAN *) (ebx + ds_base));
    ecx &= 0xfffffff0;	/* 16バイト単位に */
    memman_free((struct MEMMAN *) (ebx + ds_base), eax, ecx);
  } else if (edx == 9) {
    ecx = (ecx + 0x0f) & 0xfffffff0; /* 16バイト単位に切り上げ */
    reg[7] = memman_alloc((struct MEMMAN *) (ebx + ds_base), ecx);
  } else if (edx == 10) {
    ecx = (ecx + 0x0f) & 0xfffffff0; /* 16バイト単位に切り上げ */
    memman_free((struct MEMMAN *) (ebx + ds_base), eax, ecx);
  } else if (edx == 11) {
    sht = (struct SHEET *) (ebx & 0xfffffffe);
    /* sht->buf[sht->bxsize * edi + esi] = eax; */
    sht->buf[sht->bxsize * edi + esi] = table_8_565[eax];
    if ((ebx & 1) == 0) {
      sheet_refresh(sht, esi, edi, esi + 1, edi + 1);
    }
  } else if (edx == 12) {
    sht = (struct SHEET *) ebx;
    sheet_refresh(sht, eax, ecx, esi, edi);
  } else if (edx == 13) {
    sht = (struct SHEET *) (ebx & 0xfffffffe);
    /* hrb_api_linewin(sht, eax, ecx, esi, edi, ebp); */
    hrb_api_linewin(sht, eax, ecx, esi, edi, table_8_565[ebp]);
    if ((ebx & 1) == 0) {
      if (eax > esi) {
        i = eax;
        eax = esi;
        esi = i;
      }
      if (ecx > edi) {
        i = ecx;
        ecx = edi;
        edi = i;
      }
      sheet_refresh(sht, eax, ecx, esi + 1, edi + 1);
    }
  } else if (edx == 14) {
    sheet_free((struct SHEET *) ebx);
  } else if (edx == 15) {
    for (;;) {
      io_cli();
      if (fifo32_status(&task->fifo) == 0) {
        if (eax != 0) {
          task_sleep(task);	/* FIFOが空なので寝て待つ */
        } else {
          io_sti();
          reg[7] = -1;
          return 0;
        }
      }
      i = fifo32_get(&task->fifo);
      io_sti();
      if (i <= 1 && cons->sht != 0) { /* カーソル用タイマ */
        /* アプリ実行中はカーソルが出ないので、いつも次は表示用の1を注文しておく */
        timer_init(cons->timer, &task->fifo, 1); /* 次は1を */
        timer_settime(cons->timer, 50);
      }
      if (i == 2) {	/* カーソルON */
        cons->cur_c = COL8_FFFFFF;
      }
      if (i == 3) {	/* カーソルOFF */
        cons->cur_c = -1;
      }
      if (i == 4) {	/* コンソールだけを閉じる */
        timer_cancel(cons->timer);
        io_cli();
        fifo32_put(sys_fifo, cons->sht - shtctl->sheets0 + 2024);	/* 2024～2279 */
        cons->sht = 0;
        io_sti();
      }
      if (i >= 256) { /* キーボードデータ（タスクA経由）など */
        reg[7] = i - 256;
        return 0;
      }
    }
  } else if (edx == 16) {
    reg[7] = (int) timer_alloc("api");
    ((struct TIMER *) reg[7])->flags2 = 1;	/* 自動キャンセル有効 */
  } else if (edx == 17) {
    timer_init((struct TIMER *) ebx, &task->fifo, eax + 256);
  } else if (edx == 18) {
    timer_settime((struct TIMER *) ebx, eax);
  } else if (edx == 19) {
    timer_free((struct TIMER *) ebx);
  } else if (edx == 20) {
    if (eax == 0) {
      i = io_in8(0x61);
      io_out8(0x61, i & 0x0d);
    } else {
      i = 1193180000 / eax;
      io_out8(0x43, 0xb6);
      io_out8(0x42, i & 0xff);
      io_out8(0x42, i >> 8);
      i = io_in8(0x61);
      io_out8(0x61, (i | 0x03) & 0x0f);
    }
  } else if (edx == 21) {
    for (i = 0; i < 8; i++) {
      if (task->fhandle[i].buf == 0) {
        break;
      }
    }
    fh = &task->fhandle[i];
    reg[7] = 0;
    if (i < 8) {
        finfo = file_search((char *) ebx + ds_base,
        (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224);
      if (finfo != 0) {
        reg[7] = (int) fh;
        fh->size = finfo->size;
        fh->pos = 0;
        fh->buf = file_loadfile2(finfo->clustno, &fh->size, task->fat);
      }
    }
  } else if (edx == 22) {
    fh = (struct FILEHANDLE *) eax;
    memman_free_4k(memman, (int) fh->buf, fh->size);
    fh->buf = 0;
  } else if (edx == 23) {
    fh = (struct FILEHANDLE *) eax;
    if (ecx == 0) {
      fh->pos = ebx;
    } else if (ecx == 1) {
      fh->pos += ebx;
    } else if (ecx == 2) {
      fh->pos = fh->size + ebx;
    }
    if (fh->pos < 0) {
      fh->pos = 0;
    }
    if (fh->pos > fh->size) {
      fh->pos = fh->size;
    }
  } else if (edx == 24) {
    fh = (struct FILEHANDLE *) eax;
    if (ecx == 0) {
      reg[7] = fh->size;
    } else if (ecx == 1) {
      reg[7] = fh->pos;
    } else if (ecx == 2) {
      reg[7] = fh->pos - fh->size;
    }
  } else if (edx == 25) {
    fh = (struct FILEHANDLE *) eax;
    for (i = 0; i < ecx; i++) {
      if (fh->pos == fh->size) {
        break;
      }
      *((char *) ebx + ds_base + i) = fh->buf[fh->pos];
      fh->pos++;
    }
    reg[7] = i;
  } else if (edx == 26) {
    i = 0;
    for (;;) {
      *((char *) ebx + ds_base + i) =  task->cmdline[i];
      if (task->cmdline[i] == 0) {
        break;
      }
      if (i >= ecx) {
        break;
      }
      i++;
    }
    reg[7] = i;
  } else if (edx == 27) {
    reg[7] = task->langmode;
  } else if (edx == 0x1005) {
    /* Haritomo common API tomo_systime() */
    struct TIME_INFO *time = (struct TIME_INFO *) (eax + ds_base);
    time->year    = rtc_get(0);
    time->month   = rtc_get(1);
    time->day     = rtc_get(2);
    time->hour    = rtc_get(3);
    time->minutes = rtc_get(4);
    time->second  = rtc_get(5);
  }
  return 0;
}

int *inthandler0c(int *esp)
{
	struct TASK *task = task_now();
	struct CONSOLE *cons = task->cons;
	char s[30];
	cons_putstr0(cons, "\nINT 0C :\n Stack Exception.\n");
	sprintf(s, "EIP = %08X\n", esp[11]);
	cons_putstr0(cons, s);
	return &(task->tss.esp0);	/* 異常終了させる */
}

int *inthandler0d(int *esp)
{
	struct TASK *task = task_now();
	struct CONSOLE *cons = task->cons;
	char s[30];
	cons_putstr0(cons, "\nINT 0D :\n General Protected Exception.\n");
	sprintf(s, "EIP = %08X\n", esp[11]);
	cons_putstr0(cons, s);
	return &(task->tss.esp0);	/* 異常終了させる */
}

void hrb_api_linewin(struct SHEET *sht, int x0, int y0, int x1, int y1, int col) {
  int i, x, y, len, dx, dy;

  dx = x1 - x0;
  dy = y1 - y0;
  x = x0 << 10;
  y = y0 << 10;
  if (dx < 0) {
    dx = - dx;
  }
  if (dy < 0) {
    dy = - dy;
  }
  if (dx >= dy) {
    len = dx + 1;
    if (x0 > x1) {
      dx = -1024;
    } else {
      dx =  1024;
    }
    if (y0 <= y1) {
      dy = ((y1 - y0 + 1) << 10) / len;
    } else {
      dy = ((y1 - y0 - 1) << 10) / len;
    }
  } else {
    len = dy + 1;
    if (y0 > y1) {
      dy = -1024;
    } else {
      dy =  1024;
    }
    if (x0 <= x1) {
      dx = ((x1 - x0 + 1) << 10) / len;
    } else {
      dx = ((x1 - x0 - 1) << 10) / len;
    }
  }

  for (i = 0; i < len; i++) {
    sht->buf[(y >> 10) * sht->bxsize + (x >> 10)] = col;
    x += dx;
    y += dy;
  }

  return;
}

void set_console_title(struct CONSOLE *cons, char * title) {
  set_title(cons->sht, title);
  return ;
}
