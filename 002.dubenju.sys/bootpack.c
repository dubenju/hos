/* bootpackのメイン */

//#pragma pack (1)

#include "bootpack.h"
#include <stdio.h>
#include <string.h>

#define KEYCMD_LED		0xed

int * u_fat;
char fat_flag;
char current_path[256];    /* pwd */
char epath[1024];
struct TASK * fdc;
struct TASK * inout;
struct TASK * taskmgr;

void keywin_off(struct SHEET *key_win);
void keywin_on(struct SHEET *key_win);
void close_console(struct SHEET *sht);
void close_constask(struct TASK *task);
void close_taskmgr(void);

void init_taskbar(unsigned char * buf, int xsize, int ysize, int color);
void init_menu(struct MNLV * mnlv, struct MENU ** menu);

void HariMain(void) {
    struct BOOTINFO *binfo = (struct BOOTINFO *) ADR_BOOTINFO; /* 0x000005f0 */

    char s[40];

    struct FIFO32 fifo;
    int fifobuf[128];

    struct FIFO32 keycmd;
    int keycmd_buf[32];

    int mx, my;                    /* for mouse's position */
    int i;
    int new_mx = -1, new_my = 0, new_wx = 0x7fffffff, new_wy = 0;
    unsigned int memtotal;
    struct MOUSE_DEC mdec;
    struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR; /* 0x003c0000 */

    unsigned short *buf_back;      /* background */
    unsigned short buf_mouse[256]; /* mouse      */
    unsigned short *buf_browser;   /* browser    */

    struct SHTCTL *shtctl;         /* sheets control */
    struct SHEET *sht_back;
    struct SHEET *sht_mouse;
    struct SHEET *key_win;
    struct SHEET *sht_browser;

    struct SHEET *sht = 0;         /* moves sheet */
    struct SHEET *sht2;
 
    struct TASK *task_a;
    struct TASK *task;
 
    static char keytable0[0x80] = {
         0,   0,  '1', '2',  '3', '4', '5', '6', '7', '8', '9', '0', '-', '^', 0x08,  0,
        'Q', 'W', 'E', 'R',  'T', 'Y', 'U', 'I', 'O', 'P', '@', '[', 0x0a, 0,   'A', 'S',
        'D', 'F', 'G', 'H',  'J', 'K', 'L', ';', ':',  0,   0,  ']', 'Z', 'X',  'C', 'V',
        'B', 'N', 'M', ',',  '.', '/',  0,  '*',  0,  ' ',  0,   0,   0,   0,    0,   0,
         0,   0,   0,   0,    0,   0,   0,  '7', '8', '9', '-', '4', '5', '6',  '+', '1',
        '2', '3', '0', '.',   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,    0,   0,
         0,   0,   0,   0,    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,    0,   0,
         0,   0,   0,   0x5c, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0x5c, 0,   0
    };
    static char keytable1[0x80] = {
         0,   0,  '!', 0x22, '#', '$', '%', '&', 0x27, '(', ')', '~',  '=',   '~', 0x08,  0,
        'Q', 'W', 'E',  'R', 'T', 'Y', 'U', 'I',  'O', 'P', '`', '{', 0x0a,    0,   'A', 'S',
        'D', 'F', 'G',  'H', 'J', 'K', 'L', '+',  '*', 0,    0,  '}',   'Z',  'X',  'C', 'V',
        'B', 'N', 'M',  '<', '>', '?',  0,  '*',   0,  ' ',  0,   0,     0,    0,    0,   0,
         0,   0,   0,    0,   0,   0,   0,  '7',  '8', '9', '-', '4',   '5',  '6',  '+', '1',
        '2', '3', '0',  '.',  0,   0,   0,   0,    0,   0,   0,   0,     0,    0,    0,   0,
         0,   0,   0,    0,   0,   0,   0,   0,    0,   0,   0,   0,     0,    0,    0,   0,
         0,   0,   0,   '_',  0,   0,   0,   0,    0,   0,   0,   0,     0,   '|',   0,   0
    };
    int key_shift = 0, key_leds = (binfo->leds >> 4) & 7, keycmd_wait = -1;
    int j, x, y, mmx = -1, mmy = -1, mmx2 = 0;

    /* *** menu *** */
    int fw_flg = 0;
    int mn_flg = -1;
    int rc;
    struct MENU * menu;
    struct MNLV mnlv[MAX_MNLV];

    /* *** font *** */
    unsigned char *nihongo;
    struct FILEINFO * finfo = 0;
    extern char hankaku[4096]; /* *.c */

    /* *** debug *** */
    char dbg_msg[41];
    fat_flag = 0;

    /* partition */
    struct PartitionEntry * partition;
    struct BPB1216 * bpb;



    /* *** ************** ******** *** */
    /* *** Initialization hardware *** */
    /* *** ************** ******** *** */

    /* *** interrupt *** */
    /*
     * ■processor management(i386-i586)
     * protected mode:set gdt, idt
     */
    init_gdtidt();                           /* dsctbl.c */
    init_pic();                              /* int.c 8259A */
    /* init_RTC */
                                             /* IDT/PICの初期化が終わったのでCPUの割り込み禁止を解除 */
    io_sti();                                /* naskfunc.nas */
    fifo32_init(&fifo, 128, fifobuf, 0);     /* fifo.c */
    *((int *) ADR_FIFO) = (int) &fifo;       /* ■Save to memmory */

    init_pit();                              /* timer.c 8254 */
    init_keyboard(&fifo, 256);               /* keyboard.c 8042 */
    enable_mouse(&fifo, 512, &mdec);         /* mouse.c 8042 */
    /* io_out8(PIC0_IMR, 0xf8);                *//* naskfunc.nas PITとPIC1とキーボードを許可(11111000) */
    io_out8(PIC0_IMR, 0xb8);                 /* LPT1:1,FDC:0,LPT2:1,COM13:1,COM24:1,PIC1:0,Keyboard:,0,PIT:0 */
    /* io_out8(PIC1_IMR, 0xef);                *//* HDC2:1,HDC1:1,MP:1,PS/2:0,111,RTC:1) */
    io_out8(PIC1_IMR, 0x2f);                 /* HDC2:0,HDC1:0,MP:1,PS/2:0,111,RTC:1) */
    fifo32_init(&keycmd, 32, keycmd_buf, 0); /* fifo.c */

    /* *** ************** ******** *** */
    /* *** Initialization memory   *** */
    /* *** ************** ******** *** */
    /* ■memory management */
    memtotal = memtest(0x00400000, 0xbfffffff);              /* memory.c */
    memman_init(memman);                                     /* memory.c */
    memman_free(memman, 0x00010000, 0x0009e000);             /* 0x00001000 - 0x0009efff */
    memman_free(memman, 0x00400000, memtotal - 0x00400000);  /* memory.c */

    /* **** */
    /* initialization dma after memory */
    /* initialization fdc */
    /* init_fdcc(); */
    /* initialization sound blaster */

    /* *** ************** *********** *** */
    /* *** Initialization File System *** */
    /* *** ************** *********** *** */
    /* ■file system management */
//    u_fat = (int *) memman_alloc_4k(memman, 4 * 2880);
//    file_readfat(u_fat, (unsigned char *) (ADR_DISKIMG + 0x000200)); /* file.c */
//    file_inittbl();                                                  /* file.c */
    partition = (struct PartitionEntry *) ADR_PT_PRIM;
    bpb = (struct BPB1216 *) 0x7c0b; //ADR_BPB_PRIM + 8;
//    strcpy(current_path, "/");
//    fat_flag = 1;
//       out_log("[filesystem]file system is installed.");

    /* *** ************** ******** *** */
    /* *** Initialization gdi      *** */
    /* *** ************** ******** *** */
 
    /* *** gdi *** */
    init_palette();                                                        /* graphic.c */
    shtctl = shtctl_init(memman, binfo->vram, binfo->scrnx, binfo->scrny); /* sheet.c */
    /* ■processes management */
    task_a = task_init(memman);     /* task_a = system initial all task */ /* mtask.c */
    fifo.task = task_a;                                                    /* keyboard & mouse */
    task_run(task_a, 1, 2);                                                /* mtask.c */
    *((int *) 0x05e4) = (int) shtctl;                                      /* ■Save to memmory */
    task_a->langmode = 0;                                                  /* 0:ASCII Mode,1:SHIFTJIS,2:EUC */
 
    /* sht_back (★background) */
    sht_back  = sheet_alloc(shtctl);                                       /* sheet.c */
    buf_back  = (unsigned short *) memman_alloc_4k(memman, binfo->scrnx * binfo->scrny * 2); /* memory.c */
    sheet_setbuf(sht_back, buf_back, binfo->scrnx, binfo->scrny, -1);      /* sheet.c 透明色なし */
    init_screen8(buf_back, binfo->scrnx, binfo->scrny);                    /* graphic.c */
    // idc = 0;
    // istep = 20;
    // for (ida = 0; ida < 640; ida += istep) {
    //     for (idb = 0; idb < 960; idb += istep) {
    //         boxfill8(binfo->vram, binfo->scrnx, idc, ida, idb, ida + istep - 1, idb + istep - 1);
    //         idc += 1;
    //         idc %= 16;
    //     }
    // }

    sht_back->callback = NULL;

     dbg_init(sht_back); /* dbgs.c */
     dbg_putstr0("\nCreate sheet\n", COL8_FFFFFF);
//       out_log("[gdi]debug window is installed.");

    if (binfo->vmode == 8) {
        dbg_putstr0("vmode=8\n", COL8_FFFFFF);
    } else {
        dbg_putstr0("vmode<>8\n", COL8_FFFFFF);
    }
    memset(dbg_msg, 0, sizeof(dbg_msg));
    sprintf(dbg_msg, "stsno:%d.\n", partition->start_sector_no);
    dbg_putstr0(dbg_msg, COL8_FFFFFF);
    memset(dbg_msg, 0, sizeof(dbg_msg));
    sprintf(dbg_msg, "ststo:%d.\n", partition->sector_total);
    dbg_putstr0(dbg_msg, COL8_FFFFFF);

    memset(dbg_msg, 0, sizeof(dbg_msg));
    sprintf(dbg_msg, "psec:%d.\n", bpb->bpb_BytesPerSector);
    dbg_putstr0(dbg_msg, COL8_FFFFFF);
    memset(dbg_msg, 0, sizeof(dbg_msg));
    sprintf(dbg_msg, "scft:%d.\n", bpb->bpb_SectorsPerFAT);
    dbg_putstr0(dbg_msg, COL8_FFFFFF);

//     memset(dbg_msg, 0, sizeof(dbg_msg));
//     sprintf(dbg_msg, "cyls:%d.\n", binfo->cyls);
//     dbg_putstr0(dbg_msg, COL8_FFFFFF);
//     memset(dbg_msg, 0, sizeof(dbg_msg));
//     sprintf(dbg_msg, "leds:%d.\n", binfo->leds);
//     dbg_putstr0(dbg_msg, COL8_FFFFFF);
//     memset(dbg_msg, 0, sizeof(dbg_msg));
//     sprintf(dbg_msg, "vmode:%d.\n", binfo->vmode);
//     dbg_putstr0(dbg_msg, COL8_FFFFFF);
//     memset(dbg_msg, 0, sizeof(dbg_msg));
//     sprintf(dbg_msg, "scrnx:%d.\n", binfo->scrnx);
//     dbg_putstr0(dbg_msg, COL8_FFFFFF);
//     memset(dbg_msg, 0, sizeof(dbg_msg));
//     sprintf(dbg_msg, "scrny:%d.\n", binfo->scrny);
//     dbg_putstr0(dbg_msg, COL8_FFFFFF);
//   memset(dbg_msg, 0, sizeof(dbg_msg));
//   sprintf(dbg_msg, "vram:%p.\n", binfo->vram);
//   dbg_putstr0(dbg_msg, COL8_FFFFFF);
//      out_log("[gdi]initial gdi sheet.");

    /* sht_cons (★console) */
    /* sheet_alloc          */
    /* memman_alloc_4k w*h  */
    /* sheet_setbuf    w*h  */
    /* init_console         */
    key_win = open_console(shtctl, memtotal);
    key_win->callback = NULL;
    dbg_putstr0("Open Console\n", COL8_FFFFFF);
    /* browser */

    /* sht_mouse (★mouse) */
    sht_mouse = sheet_alloc(shtctl);
    /* buf_mouse = 16 * 16 = 256 */
    sheet_setbuf(sht_mouse, buf_mouse, 16, 16, 99);
    init_mouse_cursor8(buf_mouse, 99);

    sht_browser = sheet_alloc(shtctl);
    buf_browser  = (unsigned short *) memman_alloc_4k(memman, 600 * 400 * 2); /* memory.c */
    sheet_setbuf(sht_browser, buf_browser, 600, 400, 99);
    make_window8(buf_browser, 600, 400, "browser", 0);
    sht_browser->task = task_alloc();
    int * browser_fifo = (int *) memman_alloc_4k(memman, 128 * 4);
    sht_browser->task->tss.esp = memman_alloc_4k(memman, 64 * 1024) + 64 * 1024 - 8;
    sht_browser->task->tss.eip = (int) &browser_task;
    sht_browser->task->tss.es = 1 * 8;
    sht_browser->task->tss.cs = 2 * 8;
    sht_browser->task->tss.ss = 1 * 8;
    sht_browser->task->tss.ds = 1 * 8;
    sht_browser->task->tss.fs = 1 * 8;
    sht_browser->task->tss.gs = 1 * 8;
    strcpy( sht_browser->task->name, "browser");
    *((int *) (sht_browser->task->tss.esp + 4)) = (int) sht_browser;
    *((int *) (sht_browser->task->tss.esp + 8)) = memtotal;
    task_run(sht_browser->task, 3, 2);/* level=3, priority=2 */
    fifo32_init(&(sht_browser->task->fifo), 128, browser_fifo, sht_browser->task);
    sht_browser->callback = brow_callback;

    /* for mouse */
    mx = (binfo->scrnx - 16) / 2; /* 画面中央になるように座標計算 */
    my = (binfo->scrny - 28 - 16) / 2;

    /* set sheet's position show it by sheetlst cmd */
    sheet_slide(sht_back,    0, 0);
    sheet_slide(key_win,     148, 16); /* cosole position */
    sheet_slide(sht_mouse,   mx, my);
    sheet_slide(sht_browser, 144, 8);

     /* set sheet's layer */
    sheet_updown(sht_back,    0);
    sheet_updown(sht_browser, 1);
    sheet_updown(key_win,     2);
    sheet_updown(sht_mouse,   3);

    keywin_on(key_win);

    /* 最初にキーボード状態との食い違いがないように、設定しておくことにする */
    io_cli();   /* soon after change ss:sp */
    fifo32_put(&keycmd, KEYCMD_LED);
    fifo32_put(&keycmd, key_leds);
    io_sti();   /* changed ss:sp */

    /* *** ==>font begin<== *** */
    /* nihongo.fntの読み込み */
    // finfo = file_search2("/nihongo.fnt", (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224, u_fat);
    if (finfo != 0 && (finfo->attribute & 0x18) == 0) {
        /* exist */
        i = finfo->size;
        memset(dbg_msg, 0, sizeof(dbg_msg));
        sprintf(dbg_msg, "fong size:%d.\n", i);
        dbg_putstr0(dbg_msg, COL8_FFFFFF);
        /* nihongo = file_loadfile2(finfo->clustno, &i, fat); */
        nihongo = file_loadfile2(finfo->clustno, &i, u_fat);
        dbg_putstr0("Load Font from disk\n", COL8_FFFFFF);
    } else {
        nihongo = (unsigned char *) memman_alloc_4k(memman, 16 * 256 + 32 * 94 * 47);
        for (i = 0; i < 16 * 256; i++) {
            nihongo[i] = hankaku[i]; /* フォントがなかったので半角部分をコピー */
        }
        for (i = 16 * 256; i < 16 * 256 + 32 * 94 * 47; i++) {
            nihongo[i] = 0xff; /* フォントがなかったので全角部分を0xffで埋め尽くす */
        }
        dbg_putstr0("Load Font from coding.\n", COL8_FFFFFF);
    }
    *((int *) 0x05e8) = (int) nihongo; /* ■Save to memmory */
    /* *** ==>font  end <== *** */
    dbg_putstr0("Load Font End\n", COL8_FFFFFF);
//        out_log("[gdi]font is installed.");
 
    /* init menu */
    init_menu(mnlv, &menu);
    dbg_putstr0("Init Menu\n", COL8_FFFFFF);
//       out_log("[gdi]menu is installed.");

    struct TASK * clock = task_alloc();
    int * clock_fifo = (int *) memman_alloc_4k(memman, 128 * 4);
    clock->tss.esp = memman_alloc_4k(memman, 64 * 1024) + 64 * 1024;
    clock->tss.eip = (int) &sysclock_task; /* taskmgr.c */
    clock->tss.es = 1 * 8;
    clock->tss.cs = 2 * 8;
    clock->tss.ss = 1 * 8;
    clock->tss.ds = 1 * 8;
    clock->tss.fs = 1 * 8;
    clock->tss.gs = 1 * 8;
    strcpy(clock->name, "sysclock");
    task_run(clock, 1, 2);
    clock->langmode = 0;                                                  /* 0:ASCII Mode,1:SHIFTJIS,2:EUC */
    fifo32_init(&clock->fifo, 128, clock_fifo, clock);
//       out_log("[task]clock is installed.");
 
   /* flpydsk_set_working_drive(0);
   flpydsk_install(38);
   flpydsk_set_dma(0x8000); */
 
//    fdc = task_alloc();
//    int *fdc_fifo = (int *) memman_alloc_4k(memman, 2880 * 4 * 4);
//    fdc->tss.esp = memman_alloc_4k(memman, 64 * 1024) + 64 * 1024;
//    fdc->tss.eip = (int) &fdc_task; /* fdc.c */
//    fdc->tss.es = 1 * 8;
//    fdc->tss.cs = 2 * 8;
//    fdc->tss.ss = 1 * 8;
//    fdc->tss.ds = 1 * 8;
//    fdc->tss.fs = 1 * 8;
//    fdc->tss.gs = 1 * 8;
//    fdc->time = 0;
//    strcpy(fdc->name, "fdc");
//    task_run(fdc, 2, 2);    /* level=2, priority=2 */
//    fifo32_init(&fdc->fifo, 2880 * 4, fdc_fifo, fdc);

//    inout = task_alloc();
//    int *inout_fifo = (int *) memman_alloc_4k(memman, 128 * 4);
//    inout->tss.esp = memman_alloc_4k(memman, 64 * 1024) + 64 * 1024 - 8;
//    inout->tss.eip = (int) &inout_task; /* file.c */
//    inout->tss.es = 1 * 8;
//    inout->tss.cs = 2 * 8;
//    inout->tss.ss = 1 * 8;
//    inout->tss.ds = 1 * 8;
//    inout->tss.fs = 1 * 8;
//    inout->tss.gs = 1 * 8;
//    inout->time = 0;
//    strcpy(inout->name, "ioctrl");
//    *((int *) (inout->tss.esp + 4)) = (int) sht_back;
//    task_run(inout, 2, 2);  /* level=2, priority=2 */
//    fifo32_init(&inout->fifo, 128, inout_fifo, inout);

    for (;;) {
        if (fifo32_status(&keycmd) > 0 && keycmd_wait < 0) {
            /* キーボードコントローラに送るデータがあれば、送る */
            keycmd_wait = fifo32_get(&keycmd);
            wait_KBC_sendready();
            io_out8(PORT_KEYDAT, keycmd_wait);
        }
 
        io_cli();
        if (fifo32_status(&fifo) == 0) {
            /* FIFOがからっぽになったので、保留している描画があれば実行する */
            if (new_mx >= 0) {
                io_sti();
                sheet_slide(sht_mouse, new_mx, new_my);
                // memset(dbg_msg, 0, sizeof(dbg_msg));
                // sprintf(dbg_msg, "[%d,%d]\n", new_mx, new_my); /* 640 * 480 ■*/
                // dbg_putstr0(dbg_msg, COL8_FFFFFF);
 
                if (((key_win->vx0 <= new_mx) && (new_mx <= key_win->vx0 + 3))) {
                    if (((key_win->vy0 <= new_my) && (new_my <= key_win->vy0 + 3))) {
                        set_mouse_cursorlt8(buf_mouse, 99);
                    } else if ((key_win->vy0 + 3 <= new_my) && (new_my <= key_win->vy0 + key_win->bysize - 3)) {
                        set_mouse_cursorl8(buf_mouse, 99);
                    } else if (((key_win->vy0 + key_win->bysize - 3 <= new_my) && (new_my <= key_win->vy0 + key_win->bysize))) {
                        set_mouse_cursorrb8(buf_mouse, 99);
                    }
                } else if ((key_win->vx0 + 3 <= new_mx) && (new_mx <= key_win->vx0 + key_win->bxsize - 3)) {
                    if (((key_win->vy0 <= new_my) && (new_my <= key_win->vy0 + 3)) || 
                        ((key_win->vy0 + key_win->bysize - 3 <= new_my) && (new_my <= key_win->vy0 + key_win->bysize))) {
                        set_mouse_cursorh8(buf_mouse, 99);
                    } else {
                        init_mouse_cursor81(buf_mouse, 99);
                    }
                } else if (((key_win->vx0 + key_win->bxsize - 3 <= new_mx) && (new_mx <= key_win->vx0 + key_win->bxsize))) {
                    if (((key_win->vy0 <= new_my) && (new_my <= key_win->vy0 + 3))) {
                        set_mouse_cursorrb8(buf_mouse, 99);
                    } else if ((key_win->vy0 + 3 <= new_my) && (new_my <= key_win->vy0 + key_win->bysize - 3)) {
                        set_mouse_cursorl8(buf_mouse, 99);
                    } else if (((key_win->vy0 + key_win->bysize - 3 <= new_my) && (new_my <= key_win->vy0 + key_win->bysize))) {
                        set_mouse_cursorlt8(buf_mouse, 99);
                    }
                } else {
                    init_mouse_cursor81(buf_mouse, 99);
                }

                (*reset_back)(new_wx, new_wy);
                reset_key_win(key_win, new_wx, new_wy);

                new_mx = -1;
            } else if (new_wx != 0x7fffffff) {
                io_sti();
                sheet_slide(sht, new_wx, new_wy);
                new_wx = 0x7fffffff;
            } else {
                task_sleep(task_a);
                io_sti();
            }
        } else {
            i = fifo32_get(&fifo);
            io_sti();
            if (key_win != 0 && key_win->flags == 0) {
                /* ****************** */
                /* (@)come from       */
                /* ****************** */
                /* window is closed. */
                if (shtctl->top == 1) {	/* もうマウスと背景しかない */
                    key_win = 0;
                } else {
                    key_win = shtctl->sheets[shtctl->top - 1];
                    keywin_on(key_win);
                }
            }
 
       /* 
        *  256 <= i && i <=  511:keyboard             *
        *  512 <= i && i <=  767:mouse                *
        *  768 <= i && i <= 1023:close console        *
        * 1024 <= i && i <= 2023:close contask        *
        * 2024 <= i && i <= 2279:console close only   *
        */
       if (256 <= i && i <= 511 || 4352 <= i && i <= 4607) {
         /* ********************* */
         /* (@)come from keyboard */
         /* ********************* */
         if (i == 4352 + 0x37) {	/* PrintScreen */
           bmp_conv(640, 480, (unsigned short *) shtctl->vram);
           dbg_putstr0("==Print Screen ==\n", COL8_FFFFFF);
         }
 
         if (mn_flg != -1) {
           for (;mn_flg > -1;) {
             mn_flg = close_menu(shtctl->sheets[0], &mnlv[mn_flg]);
           }
         }
 
         if (i < 0x80 + 256) { /* キーコードを文字コードに変換 */
           if (key_shift == 0) {
             s[0] = keytable0[i - 256];
           } else {
             s[0] = keytable1[i - 256];
           }
         } else {
           s[0] = 0;
         }
 
         if ('A' <= s[0] && s[0] <= 'Z') {	/* 入力文字がアルファベット */
           if (((key_leds & 4) == 0 && key_shift == 0) || ((key_leds & 4) != 0 && key_shift != 0)) {
             s[0] += 0x20;	/* 大文字を小文字に変換 */
           }
         }
 
         if (s[0] != 0 && key_win != 0) { /* 通常文字、バックスペース、Enter */
           io_cli();   /* soon after change ss:sp */
           fifo32_put(&key_win->task->fifo, s[0] + 256);
           io_sti();   /* changed ss:sp */
         }
 
         if (i == 256 + 0x0f && key_win != 0) {	/* Tab */
           keywin_off(key_win);
           j = key_win->height - 1;
           if (j == 0) {
             j = shtctl->top - 1;
           }
           key_win = shtctl->sheets[j];
           keywin_on(key_win);
         }
         if (i == 256 + 0x2a) {	/* 左シフト ON */
           key_shift |= 1;
         }
         if (i == 256 + 0x36) {	/* 右シフト ON */
           key_shift |= 2;
         }
         if (i == 256 + 0xaa) {	/* 左シフト OFF */
           key_shift &= ~1;
         }
         if (i == 256 + 0xb6) {	/* 右シフト OFF */
           key_shift &= ~2;
         }
         if (i == 256 + 0x3a) {	/* CapsLock */
           key_leds ^= 4;
           io_cli();   /* soon after change ss:sp */
           fifo32_put(&keycmd, KEYCMD_LED);
           fifo32_put(&keycmd, key_leds);
           io_sti();   /* changed ss:sp */
         }
         if (i == 256 + 0x45) {	/* NumLock */
           key_leds ^= 2;
           io_cli();   /* soon after change ss:sp */
           fifo32_put(&keycmd, KEYCMD_LED);
           fifo32_put(&keycmd, key_leds);
           io_sti();   /* changed ss:sp */
         }
         if (i == 256 + 0x46) {	/* ScrollLock */
           key_leds ^= 1;
           io_cli();   /* soon after change ss:sp */
           fifo32_put(&keycmd, KEYCMD_LED);
           fifo32_put(&keycmd, key_leds);
           io_sti();   /* changed ss:sp */
         }
         if (i == 256 + 0x3b && key_shift != 0 && key_win != 0) {	/* Shift+F1 */
           task = key_win->task;
           if (task != 0 && task->tss.ss0 != 0) {
             cons_putstr0(task->cons, "\nBreak(key) :(Shift+F1)\n");
             io_cli();	/* 強制終了処理中にタスクが変わると困るから */
             task->tss.eax = (int) &(task->tss.esp0);
             task->tss.eip = (int) asm_end_app;
             io_sti();
             task_run(task, -1, 0);	/* 終了処理を確実にやらせるために、寝ていたら起こす */
           }
         }
         if (i == 256 + 0x3c && key_shift != 0) {	/* Shift+F2 */
           /* 新しく作ったコンソールを入力選択状態にする（そのほうが親切だよね？） */
           if (key_win != 0) {
             keywin_off(key_win);
           }
           key_win = open_console(shtctl, memtotal);
           sheet_slide(key_win, 32, 4);
           sheet_updown(key_win, shtctl->top);
           keywin_on(key_win);
           dbg_putstr0("Shift+F2 Open Console.\n", COL8_FFFFFF);
         }
         if (i == 256 + 0x57) {	/* F11 */
           if (shtctl->top > 2) {
             sheet_updown(shtctl->sheets[1], shtctl->top - 1);
           }
         }
         if (i == 256 + 0xfa) {	/* キーボードがデータを無事に受け取った */
           keycmd_wait = -1;
         }
         if (i == 256 + 0xfe) {	/* キーボードがデータを無事に受け取れなかった */
           wait_KBC_sendready();
           io_out8(PORT_KEYDAT, keycmd_wait);
         }
 
       } else if (512 <= i && i <= 767) {
         /* memset(dbg_msg, 0, sizeof(dbg_msg));
         sprintf(dbg_msg, "(%d,%d)\n", mdec.x, mdec.y);
         dbg_putstr0(dbg_msg, COL8_FFFFFF); */
 
         /* ****************** */
         /* (@)come from mouse */
         /* ****************** */
         if (mouse_decode(&mdec, i - 512) != 0) {
           /* マウスカーソルの移動 */
           mx += mdec.x;
           my += mdec.y;
           if (mx < 0) {
             mx = 0;
           }
           if (my < 0) {
             my = 0;
           }
           if (mx > binfo->scrnx - 1) {
             mx = binfo->scrnx - 1;
           }
           if (my > binfo->scrny - 1) {
             my = binfo->scrny - 1;
           }
           new_mx = mx;
           new_my = my;
 /*          memset(dbg_msg, 0, sizeof(dbg_msg));
           sprintf(dbg_msg, "(%d,%d)\n", new_mx, new_my); *//* 640 * 480 */
 /*          dbg_putstr0(dbg_msg, COL8_FFFFFF); */
           
           if ((mdec.btn & 0x02) != 0) {
             /* Right */
             memset(dbg_msg, 0, sizeof(dbg_msg));
             sprintf(dbg_msg, "right:%d.\n", mdec.btn);
             dbg_putstr0(dbg_msg, COL8_FFFFFF);
             
             if (i >= 512 && key_win != 0) { /* 通常文字、バックスペース、Enter */
               io_cli();   /* soon after change ss:sp */
               fifo32_put(&key_win->task->fifo, i);
               io_sti();   /* changed ss:sp */
             }
             /* init_mouse_cursor81(buf_mouse, 99); */
             set_mouse_cursorl8(buf_mouse, 99);
           } else {
           }
           
           if ((mdec.btn & 0x01) != 0) {
             /* 左ボタンを押している */
             memset(dbg_msg, 0, sizeof(dbg_msg));
             sprintf(dbg_msg, "left:%d.\n", mdec.btn);
             dbg_putstr0(dbg_msg, COL8_FFFFFF);
             init_mouse_cursor8(buf_mouse, 99);
             
             if (i >= 512 && key_win != 0) { /* 通常文字、バックスペース、Enter */
               io_cli();   /* soon after change ss:sp */
               fifo32_put(&key_win->task->fifo, i);
               io_sti();   /* changed ss:sp  */
             }
             
             if (mmx < 0) {
               /* 通常モードの場合 */
               
               if (mn_flg != -1) {
                 rc = exec_menu(&mnlv[mn_flg], memtotal);
                 if (rc == -1) {
                   for (; mn_flg > -1; ) {
                     mn_flg = close_menu(shtctl->sheets[0], &mnlv[mn_flg]);
                   }
                 } else {
                   mn_flg = rc;
                 }
                 continue;
               }
               
               /* 上の下じきから順番にマウスが指している下じきを探す */
               fw_flg = 0;
               for (j = shtctl->top - 1; j > 0; j--) {
                 sht = shtctl->sheets[j];
                 x = mx - sht->vx0;
                 y = my - sht->vy0;
                 if (0 <= x && x < sht->bxsize && 0 <= y && y < sht->bysize) {
                   if ((sht->flags & 0x100) == 0 && sht->buf[y * sht->bxsize + x] != sht->col_inv) {
                     sheet_updown(sht, shtctl->top - 1);
                     if (sht != key_win) {
                       keywin_off(key_win);
                       key_win = sht;
                       keywin_on(key_win);
                     }
                     if ((sht->flags & 0x100) == 0 && 3 <= x && x < sht->bxsize - 3 && 3 <= y && y < 21) {
                       mmx = mx;	/* ウィンドウ移動モードへ */
                       mmy = my;
                       mmx2 = sht->vx0;
                       new_wy = sht->vy0;
                     }
                     /* if ((sht->flags & 0x100) == 0 && sht->bxsize - 21 <= x && x < sht->bxsize - 5 && 5 <= y && y < 19) { */
                     if ((sht->flags & 0x100) == 0 && sht->bxsize -x - 17 < y && y < sht->bxsize - x - 2 && 5 < y && y < 16) {
                       /* 「×」ボタンクリック */
                       if ((sht->flags & 0x10) != 0) {		/* アプリが作ったウィンドウか？ */
                         task = sht->task;
                         cons_putstr0(task->cons, "\nBreak(mouse) :\n");
                         io_cli();	/* 強制終了処理中にタスクが変わると困るから */
                         task->tss.eax = (int) &(task->tss.esp0);
                         task->tss.eip = (int) asm_end_app;
                         io_sti();
                         task_run(task, -1, 0);
                       } else {	/* コンソール */
                         task = sht->task;
                         sheet_updown(sht, -1); /* とりあえず非表示にしておく */
                         keywin_off(key_win);
                         key_win = shtctl->sheets[shtctl->top - 1];
                         keywin_on(key_win);
                         io_cli();
                         fifo32_put(&task->fifo, 4);
                         io_sti();
                       }
                     }
                                        if ((sht->flags & 0x100) == 0 && sht->bxsize - x - 32 < y && y < sht->bxsize - x - 17 && 5 < y && y < 16) {
                                            sheet_updown(sht, -100);
                                        }
                                        fw_flg = (int) sht;
                                        break;
                                    }
                                }
                            }
                            if (fw_flg == 0 && mn_flg == -1) {
                                sht = shtctl->sheets[0];
                                if (2 <= mx && mx <= 60 && sht->bysize - 24 <= my && my <= sht->bysize - 3) {
                                    mn_flg = open_menu(sht, mnlv, menu);
                                }
                            }
                        } else {
                            /* ウィンドウ移動モードの場合 */
                            x = mx - mmx;   /* マウスの移動量を計算 */
                            y = my - mmy;
                            new_wx = (mmx2 + x + 2) & ~3;
                            new_wy = new_wy + y;
                            mmy = my;   /* 移動後の座標に更新 */
                        }
                    } else {
                        /* 左ボタンを押していない */
                        mmx = -1;	/* 通常モードへ */
                        if (new_wx != 0x7fffffff) {
                            sheet_slide(sht, new_wx, new_wy);   /* 一度確定させる */
                            new_wx = 0x7fffffff;
                        } else if (mn_flg != -1) {
                            x = mx - mnlv[mn_flg].sht->vx0;
                            y = my - mnlv[mn_flg].sht->vy0;
                            select_menu(&mnlv[mn_flg], x, y);
                        }
                    }
                }
            } else if (768 <= i && i <= 1023) {
                /* コンソール終了処理 */
                close_console(shtctl->sheets0 + (i - 768));
            } else if (1024 <= i && i <= 2023) {
                 close_constask(taskctl->tasks0 + (i - 1024));
            } else if (2024 <= i && i <= 2279) {
                 /* コンソールだけを閉じる */
                sht2 = shtctl->sheets0 + (i - 2024);
                memman_free_4k(memman, (int) sht2->buf, 256 * 165);
                sheet_free(sht2);
            } else if (i == 2280) {
                close_taskmgr(); /* close taskmgr */
            }
        }
    } /* for */

//     for (;;) {
//         //io_hlt();
//         io_loop();
//     }
}

/*
 * lost focus.
 */
void keywin_off(struct SHEET *key_win) {
  change_wtitle8(key_win, 0);
  if ((key_win->flags & 0x20) != 0) {
    io_cli();   /* soon after change ss:sp */
    fifo32_put(&key_win->task->fifo, 3); /* コンソールのカーソルOFF */
    io_sti();   /* changed ss:sp */
  }
  return;
}

/*
 * set focus.
 */
void keywin_on(struct SHEET *key_win) {
  change_wtitle8(key_win, 1);
  if ((key_win->flags & 0x20) != 0) {
    io_cli();   /* soon after change ss:sp */
    fifo32_put(&key_win->task->fifo, 2); /* コンソールのカーソルON */
    io_sti();   /* changed ss:sp */
  }
  return;
}

struct TASK *open_constask(struct SHEET *sht, unsigned int memtotal) {
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  struct TASK *task = task_alloc();
  int *cons_fifo = (int *) memman_alloc_4k(memman, 128 * 4);
  task->cons_stack = memman_alloc_4k(memman, 64 * 1024);
  task->tss.esp = task->cons_stack + 64 * 1024 - 12;
  task->tss.eip = (int) &console_task;
  task->tss.es = 1 * 8;
  task->tss.cs = 2 * 8;
  task->tss.ss = 1 * 8;
  task->tss.ds = 1 * 8;
  task->tss.fs = 1 * 8;
  task->tss.gs = 1 * 8;
  strcpy(task->name, "console");
  *((int *) (task->tss.esp + 4)) = (int) sht;
  *((int *) (task->tss.esp + 8)) = memtotal;
  task_run(task, 3, 2); /* level=3, priority=2 */
  fifo32_init(&task->fifo, 128, cons_fifo, task);
  return task;
}

struct SHEET *open_console(struct SHTCTL *shtctl, unsigned int memtotal) {
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  struct SHEET *sht = sheet_alloc(shtctl);
  unsigned short *buf = (unsigned short *) memman_alloc_4k(memman, 600 * 400 * 2);
  sheet_setbuf(sht, buf, 600, 400, -1); /* 透明色なし */
  make_window8(buf, 600, 400, "console", 0);
  make_textbox8(sht, 8, 28, 584, 363, COL8_000000);
  sht->task = open_constask(sht, memtotal);
  sht->flags |= 0x20;	/* カーソルあり */
  dbg_putstr0("open console\n", COL8_FF0000);

  return sht;
}

void close_constask(struct TASK *task) {
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  task_sleep(task);
  memman_free_4k(memman, task->cons_stack, 64 * 1024);
  memman_free_4k(memman, (int) task->fifo.buf, 128 * 4);
  task->flags = 0; /* task_free(task); の代わり */
  dbg_putstr0("close console\n", COL8_FF0000);
  return;
}

void close_console(struct SHEET *sht) {
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  struct TASK *task = sht->task;
  memman_free_4k(memman, (int) sht->buf, 600 * 400 * 2);
  sheet_free(sht);
  close_constask(task);
  return;
}

void debug_msg(int no, const char * msg) {
  char s[100];
  struct SHTCTL *ctl = (struct SHTCTL *) *((int *) 0x05e4);
  struct SHEET *sht = &ctl->sheets0[0];
  sprintf(s, "[%s]", msg);

  putfonts8_asc(sht->buf, sht->bxsize, 56, 6 + no * 20, COL8_000000, 1, s);
}

void open_taskmgr(unsigned int memtotal) {
  int i;
  struct SHEET * sht;
  struct SHTCTL *ctl = (struct SHTCTL *) *((int *) 0x05e4);
  struct MEMMAN * memman = (struct MEMMAN *) MEMMAN_ADDR;
  if (taskmgr != 0) {
    for (i = 0; i < MAX_SHEETS; i ++) {
      sht = &(ctl->sheets0[i]);
      if (sht->task == taskmgr) {
        keywin_on(sht);
      }
    }
    return ;
  }
  taskmgr = task_alloc();
  int * tmgr_fifo = (int *) memman_alloc_4k(memman, 128 * 4);
  taskmgr->tss.esp = memman_alloc_4k(memman, 64 * 1024) + 64 *1024 - 8;
  taskmgr->tss.eip = (int) &taskmgr_task; /* taskmgr.c */
  taskmgr->tss.es = 1 * 8;
  taskmgr->tss.cs = 2 * 8;
  taskmgr->tss.ss = 1 * 8;
  taskmgr->tss.ds = 1 * 8;
  taskmgr->tss.fs = 1 * 8;
  taskmgr->tss.gs = 1 * 8;
  strcpy(taskmgr->name, "taskmgr");
  taskmgr->time = 0;
  *((int *) (taskmgr->tss.esp + 4)) = memtotal;
  task_run(taskmgr, 2, 2);
  fifo32_init(&taskmgr->fifo, 128, tmgr_fifo, taskmgr);
  dbg_putstr0("open taskmgr\n", COL8_FF0000);
  return ;
}

void close_taskmgr(void) {
  struct MEMMAN * memman = (struct MEMMAN *) MEMMAN_ADDR;
  task_sleep(taskmgr);
  memman_free_4k(memman, (int) taskmgr->fifo.buf, 128 * 4);
  task_free(taskmgr);
  taskmgr = 0;
  dbg_putstr0("close taskmgr\n", COL8_FF0000);
  return ;
}

int open_menu(struct SHEET * sht, struct MNLV * mnlv, struct MENU * menu) {
  struct MEMMAN * memman = (struct MEMMAN *) MEMMAN_ADDR;
  struct SHTCTL * ctl = (struct SHTCTL *) *((int *) 0x05e4);
  int xsize = 144, ysize;
  int num_menu;
  int x, y;
  int yp;
  for (num_menu = 0; num_menu < MAX_MENU; num_menu ++) {
    if (menu[num_menu].next == 0) {
      break;
    }
  }
  num_menu ++;

  if (menu->level == 0) {
    push_menu(sht->buf, sht->bxsize, sht->bysize);
    sheet_refresh(sht, 2, sht->bysize - 24, 61, sht->bysize - 2);
  }

  ysize = num_menu * 24 + (num_menu - 1) * 2 + 4;
  if (menu->level == 0) {
    ysize += 18;
  }
  mnlv->sht = sheet_alloc(ctl);
  mnlv->sht->flags |= 0x100;
  mnlv->buf = (unsigned short *) memman_alloc_4k(memman, xsize * ysize * 2);
  sheet_setbuf(mnlv->sht, mnlv->buf, xsize, ysize, -1);
  make_menu8(mnlv->buf, xsize, ysize, "OS Menu", menu, num_menu);

  if (menu->level == 0) {
    x = 0;
    y = ctl->ysize - (ysize + 28);
  } else {
    x = (xsize - 4) * menu->level;
    yp = (mnlv - 1)->pos * 26 + 2;
    if (menu->level == 1) {
      yp += 18;
    }
    y = (mnlv - 1)->sht->vy0 + yp - ysize;
  }
  sheet_slide(mnlv->sht, x, y);
  sheet_updown(mnlv->sht, ctl->top);
  mnlv->menu = menu;
  mnlv->pos = 0;
  mnlv->num = num_menu;

  return menu->level;
}

int close_menu(struct SHEET * sht, struct MNLV * mnlv) {
  struct MEMMAN * memman = (struct MEMMAN *) MEMMAN_ADDR;
  sheet_updown(mnlv->sht, -1);
  memman_free_4k(memman, (int) mnlv->buf, mnlv->sht->bxsize * mnlv->sht->bysize * 2);
  sheet_free(mnlv->sht);
  if (mnlv->menu->level == 0) {
    pull_menu(sht->buf, sht->bxsize, sht->bysize);
    sheet_refresh(sht, 2, sht->bysize - 24, 61, sht->bysize - 2);
  }
  return mnlv->menu->level - 1;
}

void select_menu(struct MNLV * mnlv, int x, int y) {
  int yp = 1;
  if (mnlv->pos != 0) {
    change_mtitle8(mnlv->sht, mnlv->menu->level, mnlv->pos, 0);
  }
  if (mnlv->menu->level == 0) {
    yp += 18;
  }
  if (2 <= x && x < mnlv->sht->bxsize - 2 && yp < y && y < mnlv->sht->bysize - 2) {
    mnlv->pos = (int) ((y - yp) / 26) + 1;
    change_mtitle8(mnlv->sht, mnlv->menu->level, mnlv->pos, 1);
  } else {
    mnlv->pos = 0;
  }
  return ;
}

int exec_menu(struct MNLV * mnlv, unsigned int memtotal) {
  struct SHTCTL * ctl = (struct SHTCTL *) *((int *) 0x05e4);
  struct MENU *menu;
  struct TASK *task;
  struct SHEET *key_win;
  struct FIFO32 *fifo;
  int i, end = mnlv->num - mnlv->pos;
  if (mnlv->pos == 0) {
    return -1;
  }
  menu = mnlv->menu;
  for(i = 0; i < end; i ++) {
    menu = menu->next;
  }
  if (strcmp(menu->cmd_line, "<submenu>") == 0) {
    return open_menu(0, mnlv + 1, menu->sub);
  } else if (strcmp(menu->cmd_line, "<console>") == 0) {
    key_win = open_console(ctl, memtotal);
    sheet_slide(key_win, 8, 8);
    sheet_updown(key_win, ctl->top);
    keywin_on(key_win);
  } else if (strcmp(menu->cmd_line, "<taskmgr>") == 0) {
    debug_msg(1, "open taskmgr");
    open_taskmgr(memtotal);
  } else {
    task = open_constask(0, memtotal);
    fifo = &task->fifo;
    for (i = 0; menu->cmd_line[i] != 0; i ++) {
      io_cli();   /* soon after change ss:sp */
      /* fifo32_put_io(fifo, menu->cmd_line[i] + 256); */
      fifo32_put(fifo, menu->cmd_line[i] + 256);
      io_sti();   /* changed ss:sp */
    }
    io_cli();   /* soon after change ss:sp */
    /* fifo32_put_io(fifo, 10 + 256); *//* Enter */
    fifo32_put(fifo, 10 + 256); /* Enter */
    io_sti();   /* changed ss:sp */
  }
  return -1;
}

int set_menu(struct MENU * menu, int level, char * item_name, char * cmd_line, char * parent_name, char * prev_name) {
  int i;
  int fs_flag = -1;
  struct MENU * parent_menu = 0;
  struct MENU * prev_menu = 0;
  for (i = 0; i < MAX_MENU; i ++) {
    if (parent_name != 0) {
      if (strcmp(menu[i].name, parent_name) == 0) {
        parent_menu = &menu[i];
      }
    } else if (prev_name != 0) {
      if (strcmp(menu[i].name, prev_name) == 0) {
        prev_menu = &menu[i];
      }
    }
    if (menu[i].name[0] == 0) {
      if ((parent_name != 0 && parent_menu == 0) || (prev_name != 0 && prev_menu ==0)) {
        break;
      }
      if (parent_name != 0) {
        parent_menu->sub = &menu[i];
      } else if (prev_name != 0) {
        prev_menu->next = &menu[i];
      }
      menu[i].level = level;
      strcpy(menu[i].name, item_name);
      strcpy(menu[i].cmd_line, cmd_line);
      fs_flag = i;
      break;
    }
  }
  return fs_flag;
}


void init_menu(struct MNLV * mnlv, struct MENU ** menu) {
  struct MEMMAN * memman = (struct MEMMAN *) MEMMAN_ADDR;
  int i;
  *menu = (struct MENU *) memman_alloc_4k(memman, 64 * MAX_MENU);
  /* init menu */
  for (i = 0; i < MAX_MENU; i ++) {
    (*menu)[i].level = 0;
    (*menu)[i].name[0] = 0;
    (*menu)[i].cmd_line[0] = 0;
    (*menu)[i].next = 0;
    (*menu)[i].sub = 0;
  }
  for (i = 0; i < MAX_MNLV; i ++) {
    mnlv[i].menu = 0;
    mnlv[i].sht = 0;
    mnlv[i].buf = 0;
    mnlv[i].pos = 0;
    mnlv[i].num = 0;
  }

  /* level 1 */
  set_menu(*menu, 0, "taskmgr",   "<taskmgr>",    0, 0);
  set_menu(*menu, 0, "console",   "<console>",    0, "taskmgr");
  set_menu(*menu, 0, "explorer",  "explorer.hrb", 0, "console");
  set_menu(*menu, 0, "programs+", "<submenu>",    0, "explorer");

  /* level 2 */
  set_menu(*menu, 1, "walk",      "walk",          "programs+", 0);

  return ;
}

void reset_back(int x, int y) {
  int idx;
  struct SHEET * sht;

/*   struct SHTCTL * shtctl = (struct SHTCTL *) 0x05e4;

  for (idx = 0; idx < shtctl->top; idx ++) {
    sht = &shtctl->sheets0[idx];
    if (sht != NULL) {
      if (sht->callback != NULL) {
        (* sht->callback)(sht, 1, 0, 0);
      }
    }
  } */
}

void reset_key_win(struct SHEET * sht, int x, int y) {
  
}
