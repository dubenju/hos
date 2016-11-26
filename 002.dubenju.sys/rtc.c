/* rtc.c */
#include "bootpack.h"

void init_rtc() {
/*  int f = io_load_eflags();
  disabled_interruput();
  io_out8(RTC_ADRS, 0x0B);
  io_out8(RTC_DATA, 0x02);  *//* 24h */
/*  io_store_eflags(f); */
}

int rtc_get(int type) {
  static unsigned char adr[7] = { 0x32, 0x08, 0x07, 0x04, 0x02, 0x00, 0x09 };
  static unsigned char max[7] = { 0x99, 0x12, 0x31, 0x23, 0x59, 0x60, 0x99 };
  unsigned char s, t;
  int err, r = 0;
  /* Type are...
     0 : Year	1 : Month	2 : Day
     3 : Hour	4 : Minute	5 : Second */
  if (6 <= type) {
    /* 6以上はエラー */
    return -1;
  }

  do {
    err = 0;
    io_out8(CMOD_RAM_IDX_REG, adr[type]); /* 0x0070 */
    s = io_in8(CMOS_RAM_DATA);            /* 0x0071 */
    io_out8(CMOD_RAM_IDX_REG, adr[type]); /* 0x0070 */
    t = io_in8(CMOS_RAM_DATA);            /* 0x0071 */
    if (s != t || 9 < (t & 0x0f) || max[type] < t) {
      /* 2度読みで違いがあったショウヘイヘーイ！ */
      /* a秒とかf分なんてないんだぜ～？ */
      /* コイツも限界突破だぜ？ */
      err++;
    }
    if (type == 0) {
      /* Yearだけトクベツ */
      r = ((t >> 4) * 10 + (t & 0x0f)) * 100;
      type = 6;
      err++;		// かわいそうだけどエラー扱い
    }
  } while(err != 0);
  r += ((t >> 4) * 10 + (t & 0x0f));
  return r;
}
