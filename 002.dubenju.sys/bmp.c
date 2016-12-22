#include "bootpack.h"

extern int * u_fat;

void bmp_conv(int xsize, int ysize, unsigned short *vram) {
  struct BMPFLHDR bfh;
  struct BMPIFHDR bih;
  struct FILEHANDLE fh;
  int i, j, p, q;
  long fwidth = xsize + ((4 - (xsize % 4)) % 4);
  //struct SHTCTL *ctl = (struct SHTCTL *) *((int *) 0x0fe4);
    struct SHTCTL *ctl = (struct SHTCTL *) *((int *) ADR_SHTCTL);
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  unsigned char *bmpbuf = (unsigned char *) memman_alloc_4k(memman, fwidth * ysize * 3);

  /* BMPファイルヘッダー */
  bfh.type    = 0x4d42;
  bfh.size    = sizeof(bfh) - 2 + sizeof(bih) + fwidth * ysize * 3;
  bfh.rsv1    = 0;
  bfh.rsv2    = 0;
  bfh.offbits = sizeof(bfh) - 2 + sizeof(bih);

  /* BMP情報ヘッダー */
  bih.size    = sizeof(bih);
  bih.width   = xsize;
  bih.height  = ysize;
  bih.planes  = 1;
  bih.bitcnt  = 24;
  bih.comp    = 0;
  bih.sizeimg = fwidth * ysize * 3;
  bih.xperm   = 0;
  bih.yperm   = 0;
  bih.clused  = 0;
  bih.climpt  = 0;

  /* BMPピクセルデータ */
  for (i = 0; i < bih.height; i++) {
    for (j = 0; j < bih.width; j++) {
      p = ((bih.height - 1 - i) * fwidth + j) * 3;
      q = i * ctl->xsize + j;
      bmpbuf[p + 0] = (char) (((vram[q] << 3) & 0xf8) + ((vram[q] >>  2) & 0x07));
      bmpbuf[p + 1] = (char) (((vram[q] >> 3) & 0xfc) + ((vram[q] >>  9) & 0x03));
      bmpbuf[p + 2] = (char) (((vram[q] >> 8) & 0xf8) + ((vram[q] >> 13) & 0x07));
    }
    for (j = bih.width; j < fwidth; j++) {
      p = ((bih.height - 1 - i) * fwidth + j) * 3;
      bmpbuf[p + 0] = 0;
      bmpbuf[p + 1] = 0;
      bmpbuf[p + 2] = 0;
    }
  }

  if (hrb_api_fopen("/screen.bmp", 0x10, &fh, u_fat) != 0) {
    hrb_api_fwrite((char *) &bfh.type, sizeof(bfh) - 2, &fh, u_fat);
    hrb_api_fwrite((char *) &bih, sizeof(bih), &fh, u_fat);
    hrb_api_fwrite(bmpbuf, fwidth * ysize * 3, &fh, u_fat);
  }
  hrb_api_fclose(&fh, u_fat);
  memman_free_4k(memman, (int) bmpbuf, fwidth * ysize * 3);

  return;
}
