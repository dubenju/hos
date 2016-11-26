/* ファイル関係 */

#include "bootpack.h"

#define SYNC_INTVL	10   /* io */

int i_sta[80][2];
int r_req[80][2];
int w_req[80][2];

extern char current_path[256];
extern char t[7];
extern struct TASK *fdc;  /* io */

struct FILEINFO *file_extdir(char *name, int clustno, int *fat);
void file_entry(char *name, struct FILEINFO *finfo);
void file_name(char *name, struct FILEINFO *finfo);
void file_time(struct FILEINFO *finfo);
void file_compfat(int *fat, int clustno);
void file_savesec(int location, int target);
void file_updtbl(int secno);

/* ディスクイメージ内のFATの圧縮をとく */
void file_readfat(int *fat, unsigned char *img) {
  int i, j = 0;
  for (i = 0; i < 2880; i += 2) {
    fat[i + 0] = (img[j + 0]      | img[j + 1] << 8) & 0xfff;
    fat[i + 1] = (img[j + 1] >> 4 | img[j + 2] << 4) & 0xfff;
    j += 3;
  }
  return;
}

void file_loadfile(int clustno, int size, char *buf, int *fat, char *img)
{
	int i;
	for (;;) {
		if (size <= 512) {
			for (i = 0; i < size; i++) {
				buf[i] = img[clustno * 512 + i];
			}
			break;
		}
		for (i = 0; i < 512; i++) {
			buf[i] = img[clustno * 512 + i];
		}
		size -= 512;
		buf += 512;
		clustno = fat[clustno];
	}
	return;
}

int file_searchfat(int *fat)
/* FATから空き領域を検索 */
{
	int i;
	for (i = 0; i < 2849; i++) {
		if (fat[i] == 0x0000) {
			io_cli();
			if (fat[i] == 0x0000) {
				fat[i] = 0x0fff;
				io_sti();
				return i;
			}
			io_sti();
		}
	}
	return 0x0fff;
}

struct FILEINFO *file_search(char *name, struct FILEINFO *finfo, int max)
{
	int i, j;
	char s[12];
	for (j = 0; j < 11; j++) {
		s[j] = ' ';
	}
	j = 0;
	for (i = 0; name[i] != 0; i++) {
		if (j >= 11) { return 0; /* 見つからなかった */ }
		if (name[i] == '.' && j <= 8) {
			j = 8;
		} else {
			s[j] = name[i];
			if ('a' <= s[j] && s[j] <= 'z') {
				/* 小文字は大文字に直す */
				s[j] -= 0x20;
			} 
			j++;
		}
	}
	for (i = 0; i < max; ) {
		if (finfo->name[0] == 0x00) {
			break;
		}
		if ((finfo[i].attribute & 0x18) == 0) {
			for (j = 0; j < 11; j++) {
				if (finfo[i].name[j] != s[j]) {
					goto next;
				}
			}
			return finfo + i; /* ファイルが見つかった */
		}
next:
		i++;
	}
	return 0; /* 見つからなかった */
}

struct FILEINFO *file_search2(char *name, struct FILEINFO *finfo, int max, int *fat) {
  int i, clustno;
  char *offset, fpath[512];
  struct FILEINFO *ffinfo, dfinfo[16];

  file_path(fpath, name, sizeof(fpath));
  if (fpath[0] == 0) {
    return 0;
  }

  for (i = 0; fpath[i] != 0; i++) {
    if (fpath[i] == '/') {
      fpath[i] = 0;
    }
  }

  offset = fpath + 1;
  ffinfo = file_search(offset, finfo, max);
  for (offset = offset + strlen(offset) + 1; *offset != 0;) {
    if (ffinfo == 0 || (ffinfo->attribute & 0x10) != 0x10) {
      return 0;
    }
    for (clustno = ffinfo->clustno; clustno < 0x0ff7;) {
      file_loadfile(clustno, 512, (char *) dfinfo, fat, (char *) (ADR_DISKIMG + 0x003e00));
      ffinfo = file_search(offset, dfinfo, 16);
      if (ffinfo != 0) {
        break;
      }
      clustno = fat[clustno];
    }
    offset = offset + strlen(offset) + 1;
  }

  return ffinfo;
}

char *file_loadfile2(int clustno, int *psize, int *fat) {
  int size = *psize, size2;
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
  char *buf, *buf2;
  buf = (char *) memman_alloc_4k(memman, size);
  file_loadfile(clustno, size, buf, fat, (char *) (ADR_DISKIMG + 0x003e00));
  dbg_putstr0("文字load font.\n", COL8_000000);
  if (size >= 17) {
    size2 = tek_getsize(buf);
    if (size2 > 0) {	/* tek圧縮がかかっていた */
      buf2 = (char *) memman_alloc_4k(memman, size2);
      tek_decomp(buf, buf2, size2);
      memman_free_4k(memman, (int) buf, size);
      buf = buf2;
      *psize = size2;
      dbg_putstr0("tek font.\n", COL8_000000);
    }
  }
  return buf;
}

void file_clearfat(int *fat, int clustno)
{
	int nextno = fat[clustno];
	for (; nextno < 0x0ff7;) {
		fat[clustno] = 0x0000;
		file_compfat(fat, clustno);
		file_savesec(clustno, 2);
		clustno = nextno;
		nextno  = fat[clustno];
	}
	return;
}

int file_savefile(struct FILEHANDLE *fh, int size, int *fat, char *img)
{
	int nextno, clustno = fh->clustno, wsize = 0;
	char *buf = fh->buf;

	if (clustno >= 0x0ff7 || size == 0) {
		return 0;
	} else if (clustno != 0) {
		nextno = file_searchfat(fat);
		fat[clustno] = nextno;
		file_compfat(fat, clustno);
		file_savesec(clustno, 2);
	} else {
		nextno = file_searchfat(fat);
		fh->finfo->clustno = nextno;
		file_compfat(fat, clustno);
		file_savesec(clustno, 2);
		file_savesec((int) ((char *) fh->finfo), 1);
	}

	for (; nextno != 0x0fff;) {
		clustno = nextno;
		if (size <= 512) {
			memcpy(img + clustno * 512, buf, size);
			file_savesec(clustno, 3);
			wsize += size;
			break;
		}
		memcpy(img + clustno * 512, buf, 512);
		file_savesec(clustno, 3);
		size  -= 512;
		buf   += 512;
		wsize += 512;
		nextno = file_searchfat(fat);
		fat[clustno] = nextno;
		file_compfat(fat, clustno);
		file_savesec(clustno, 2);
	}
	fh->clustno = clustno;
	file_time(fh->finfo);
	fh->finfo->size += (wsize - (fh->finfo->size % 512));
	file_savesec((int) ((char *) fh->finfo), 1);

	return wsize;
}

int file_skipfile(struct FILEHANDLE *fh, int size, int *fat, char *img, int mode)
{
	int nextno = fh->finfo->clustno;
	int clustno = 0, ssize = 0, rsize;

	if ((mode & 0x000f) == 0) {
		file_clearfat(fat, fh->finfo->clustno);
		fh->finfo->clustno = 0xfff;
		fh->finfo->size    = 0;
		file_savesec((int) ((char *) fh->finfo), 1);
		return 0;
	}

	for (; ssize < size - 512;) {
		clustno = nextno;
		nextno  = fat[clustno];
		if (nextno >= 0x0ff7) {
			break;
		}
		ssize += 512;
	}
	rsize = size - ssize;
	if (rsize < 512) {
		memcpy(fh->buf, img + nextno * 512, rsize);
	} else if (rsize > 512) {
		rsize = 512;
		fh->finfo->size = ssize + rsize;
		file_savesec((int) ((char *) fh->finfo), 1);
	}
	fh->pos     = ssize + rsize;
	fh->bpos    = rsize % 512;
	fh->clustno = clustno;

	return fh->pos;
}

struct FILEINFO *file_insert(char *name, struct FILEINFO *finfo, int max, int *fat)
{
	int i, rde = 0;
	int clustno, nextno;
	char *term, fpath[512];
	struct FILEINFO *ffinfo, dfinfo[16];

	file_path(fpath, name, sizeof(fpath));
	if (fpath[0] == 0) {
		return 0;
	}

	term = strrchr(fpath, '/');
	if (term == fpath) {
		rde = 1;
	} else {
		*term = 0;
		ffinfo = file_search2(fpath, finfo, max, fat);
		if (ffinfo == 0 || (ffinfo->attribute & 0x10) != 0x10) {
			return 0;
		}
		if (ffinfo->clustno == 0x0000) {
			rde = 1;
		}
	}

	if (rde == 1) {
		for (i = 0; i < max; i++) {
			if (finfo[i].name[0] == 0x00 || finfo[i].name[0] == 0xe5) {
				file_entry(term + 1, &finfo[i]);
				return  finfo + i;
			}
		}
	} else {
		nextno = ffinfo->clustno;
		for (i = 0; i < MAX_ENTRY; i++) {
			if ((i % 16) == 0) {
				if (nextno >= 0x0ff7) {
					break;
				}
				clustno = nextno;
				file_loadfile(clustno, 512, (char *) dfinfo,
							  fat, (char *) (ADR_DISKIMG + 0x003e00));
				nextno = fat[clustno];
			}
			if (dfinfo[i % 16].name[0] == 0x00 || dfinfo[i % 16].name[0] == 0xe5) {
				ffinfo = (struct FILEINFO *) (ADR_DISKIMG + 0x003e00 + clustno * 512);
				file_entry(term + 1, &ffinfo[i % 16]);
				return ffinfo + (i % 16);
			}
		}
		if (0 < i && i < MAX_ENTRY) {
			if ((ffinfo = file_extdir(term + 1, clustno, fat)) == 0) {
				return ffinfo;
			}
		}
	}

	return 0;
}

void file_move(char *name, struct FILEINFO *finfo)
{
	if (name != 0) {
		file_name(name, finfo);
	} else {
		finfo->name[0] = 0xe5;
	}
	file_savesec((int) ((char *) finfo), 1);
	return;
}


void file_path(char *fpath, char *name, int size) {
  char *offset, *offset0, mpath[512];

  memset(fpath, 0, size);
  memset(mpath, 0, sizeof(mpath));
  if (name[0] == '/') {
    strncpy(mpath, name , 255);
  } else {
    strncpy(mpath, current_path, 255);
    strncat(mpath, name , 255);
  }
  /* dbg_putstr0("I:", COL8_FFFFFF); */
  /* dbg_putstr0(mpath, COL8_FFFFFF); */

  for (offset = mpath; (offset = strstr(offset, "//")) != 0 && strlen(offset) >= 2;) {
    memmove(offset, offset + 1, strlen(offset + 1) + 1);
  }
  for (offset = mpath; (offset = strstr(offset, "/.")) != 0 && strlen(offset) >= 2;) {
    if (offset[2] == 0) {
      offset[1] = 0;
    } else if (offset[2] == '/') {
      memmove(offset + 1, offset + 3, strlen(offset + 3) + 1);
    } else {
      offset += 2;
    }
  }
  for (offset0 = mpath; (offset = strstr(offset0, "/..")) != 0 && strlen(offset) >= 3;) {
    if (offset[3] == 0 || offset[3] == '/') {
      *offset = 0;
      if ((offset0 = strrchr(mpath, '/')) == 0) {
        return;
      }
      if (offset[3] == 0) {
        offset0[1] = 0;
      } else if (offset[3] == '/') {
        *offset = '/';
        memmove(offset0 + 1, offset + 4, strlen(offset + 4) + 1);
      }
    } else {
      offset0 = offset + 3;
    }
  }
  strncpy(fpath, mpath, size - 2);
  /* dbg_putstr0(" O:", COL8_FFFFFF); */
  /* dbg_putstr0(fpath, COL8_FFFFFF); */
  /* dbg_putstr0("\n", COL8_FFFFFF); */

  return;
}


struct FILEINFO *file_extdir(char *name, int clustno, int *fat) {
  int nextno;
  if ((nextno = file_searchfat(fat)) != 0x0fff) {
    fat[clustno] = nextno;
    file_compfat(fat, clustno);
    file_savesec(clustno, 2);
    file_entry(name, (struct FILEINFO *) (ADR_DISKIMG + 0x003e00 + nextno * 512));
    file_savesec(nextno, 3);
    file_compfat(fat, nextno);
    file_savesec(nextno, 2);
    return  (struct FILEINFO *) (ADR_DISKIMG + 0x003e00 + nextno * 512);
  }
  return 0;
}

void file_entry(char *name, struct FILEINFO *finfo)
{
	file_name(name, finfo);
	finfo->attribute    = 0x20;
	finfo->clustno = 0x0fff;
	finfo->size    = 0;
	file_time(finfo);
	file_savesec((int) ((char *) finfo), 1);
	return;
}

void file_name(char *name, struct FILEINFO *finfo)
{
	int i, j = 0;
	char s[13];

	memset(s, 0, sizeof(s));
	for (i = 0; i < 12; i++) {
		if (i != 8) {
			s[i] = 0x20;
		}
	}
	for (i = 0; j < 12 && name[i] != 0; i++) {
		if (name[i] == '.') {
			j = 9;
		} else {
			s[j] = name[i];
			if ('a' <= s[j] && s[j] <= 'z') {
				s[j] -= 0x20;
			} 
			j++;
		}
	}
	strcpy(finfo->name, s);
	strcpy(finfo->ext, s + 9);

	return;
}

void file_time(struct FILEINFO *finfo)
{
	int i;
	char t16[7];
	unsigned short t10[7];

	memcpy(t16, t, 7);
	for (i = 0; i < 7; i++) {
		t10[i] = (t16[i] >> 4) * 10 + (t16[i] & 0x0f);
	}
	finfo->mod_time = (t10[2] << 11)
				+ (t10[1] << 5)
				+ (unsigned short) (t10[0] / 2);
	finfo->mod_date = ((t10[6] * 100 + t10[5] - 1980) << 9)
				+ (t10[4] << 5)
				+ t10[3];

	return;
}

void file_compfat(int *fat, int clustno)
{
	int clustlow, clustupp;
	unsigned char comp[3];

	clustlow = ((int) (clustno / 2)) * 2;
	clustupp = clustlow + 1;

	comp[0] = (unsigned char) (fat[clustlow] & 0x0ff);
	comp[1] = (unsigned char) ((fat[clustupp] & 0x00f) << 4 | (fat[clustlow] & 0xf00) >> 8);
	comp[2] = (unsigned char) ((fat[clustupp] & 0xff0) >> 4);

	memcpy((char *) (ADR_DISKIMG + 0x0200 + clustlow / 2 * 3), comp, 3);
	memcpy((char *) (ADR_DISKIMG + 0x1400 + clustlow / 2 * 3), comp, 3);

	return;
}

void file_savesec(int location, int target)
{
	int i, clustlow, secno;
	int offset[2] = {0x0200, 0x1400};

	if (target == 1) {
		/* ルート領域 */
		file_updtbl((int) (location - ADR_DISKIMG) / 512);
	} else if (target == 2) {
		/* FAT領域 */
		clustlow = ((int) (location / 2)) * 2;
		for (i = 0; i < 2; i++) {
			secno = (offset[i] + clustlow / 2 * 3) / 512;
			file_updtbl(secno);
			if (((offset[i] + clustlow / 2 * 3) % 512) >= 510) {
				file_updtbl(secno + 1);
			}
		}
	} else {
		/* データ領域 */
		file_updtbl(0x3e00 / 512 + location);
	}

	return;
}

void file_updtbl(int secno)
{
	int cyl, hed;
	cyl = (int) secno / 36; secno %= 36;
	hed = (int) secno / 18; secno %= 18;
	i_sta[cyl][hed] |= (1 << secno);
	w_req[cyl][hed] |= (1 << secno);
	w_req[  0][  0] |= 0x100000;
	return;
}

void file_inittbl() {
  int i, j;
  struct BOOTINFO * binfo = (struct BOOTINFO *) ADR_BOOTINFO;
  for (i = 0; i < binfo->cyls; i ++) {
    /* MAX:80 Tracks */
    for (j = 0; j < 2; j ++) {
      i_sta[i][j] = 0x3ffff;
    }
  }
  memset(r_req, 0, sizeof(r_req));
  memset(w_req, 0, sizeof(w_req));
  return ;
}

/*
 * mode:
 * file_skipfile
 */
int hrb_api_fopen(char *fname, int mode, struct FILEHANDLE *fh, int *fat) {
  struct FILEINFO *finfo;
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;

  fh->bsize   = 4096;
  fh->pos     = 0;
  fh->bpos    = 0;
  fh->clustno = 0;
  fh->buf     = (char *) memman_alloc_4k(memman, fh->bsize);

  finfo = file_search2(fname, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224, fat);
  if (finfo != 0) {
    if ((finfo->attribute & 0x18) != 0) {
      return 0;
    }
    fh->finfo = finfo;
    file_skipfile(fh, finfo->size, fat, (char *) (ADR_DISKIMG + 0x003e00), mode);
  } else {
    finfo = file_insert(fname, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224, fat);
    if (finfo == 0) {
      return 0;
    }
    fh->finfo = finfo;
  }
  fh->size = finfo->size;

  return (int) fh;
}

void hrb_api_fclose(struct FILEHANDLE *fh, int *fat) {
  struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;

  if (fh->bpos != 0) {
    file_savefile(fh, fh->bpos, fat, (char *) (ADR_DISKIMG + 0x003e00));
  }
  memman_free_4k(memman, (int) fh->buf, fh->bsize);
  fh->buf = 0;

  return;
}

int hrb_api_fwrite(char *sbuf, int size, struct FILEHANDLE *fh, int *fat) {
  int dsize, wsize = 0, usize = 4096;

  for (; usize == 4096;) {
    if (fh->bpos + size < 4096) {
      memcpy(fh->buf + fh->bpos, sbuf, size);
      fh->pos  += size;
      fh->bpos += size;
      wsize    += size;
      break;
    }
    dsize = 4096 - fh->bpos;
    memcpy(fh->buf + fh->bpos, sbuf, dsize);
    usize = file_savefile(fh, 4096, fat, (char *) (ADR_DISKIMG + 0x003e00));
    size     -= dsize;
    sbuf     += dsize;
    fh->pos  += dsize;
    wsize    += (usize - fh->bpos);
    fh->bpos  = 0;
  }

  return (wsize);
}

int hrb_api_remove(char *fname, int *fat)
{
	struct FILEINFO *finfo;

	finfo = file_search2(fname, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224, fat);
	if (finfo == 0 || (finfo->attribute & 0x18) != 0) {
		return -1;
	}
	file_clearfat(fat, finfo->clustno);
	file_move(0, finfo);

	return 0;
}



void inout_task(struct SHEET *sht_back) {
  int i, scnt = 0;
  struct TASK *task = task_now();
  struct TIMER *inout_timer = timer_alloc("iot");
  timer_init(inout_timer, &task->fifo, 1);
  timer_settime(inout_timer, 1000);
  dbg_init(sht_back);

  for (;;) {
    io_cli();
    if (fifo32_status(&task->fifo) == 0) {
      task_sleep(task);
      io_sti();
    } else {
      i = fifo32_get(&task->fifo);
      io_sti();
      if (i == 1) {
        if (scnt >= SYNC_INTVL - 1) {
          inout_control(1);
          scnt = 0;
        } else {
          inout_control(0);
          scnt++;
        }
        timer_settime(inout_timer, 100);
      } else if (i == 254) {
        /* とりあえず何もしない */
      } else if (i == 255) {
        /* とりあえず何もしない */
      }
    }
  }
}

void inout_control(int sync) {
  int i, j, k, req;
  char msg[30];

  memset(msg, 0, sizeof(msg));
  if ((r_req[0][0] & 0x100000) != 0) {
    io_cli();
    r_req[0][0] ^= 0x100000;
    io_sti();
    for (i = 0; i < 80; i++) {
      for (j = 0; j < 2; j++) {
        if (r_req[i][j] != 0) {
          io_cli();
          req = r_req[i][j];
          r_req[i][j] = 0;
          io_sti();
          for (k = 0; k < 18; k++) {
            if ((req & (1 << k)) != 0) {
              fifo32_put_io(&fdc->fifo, 0x1000 | (i * 36 + j * 18 + k));
              sprintf(msg, "%04d ", i * 36 + j * 18 + k);
              dbg_putstr0(msg, COL8_FFFFFF);
            }
          }
        }
      }
    }
    dbg_putstr0("\n", COL8_FFFFFF);
  }
  if (sync == 0) {
    return;
  }

  if ((w_req[0][0] & 0x100000) != 0) {
    io_cli();
    w_req[0][0] ^= 0x100000;
    io_sti();
    for (i = 0; i < 80; i++) {
      for (j = 0; j < 2; j++) {
        if (w_req[i][j] != 0) {
          io_cli();
          req = w_req[i][j];
          w_req[i][j] = 0;
          io_sti();
          for (k = 0; k < 18; k++) {
            if ((req & (1 << k)) != 0) {
              fifo32_put_io(&fdc->fifo, 0x2000 | (i * 36 + j * 18 + k));
              sprintf(msg, "%04d ", i * 36 + j * 18 + k);
              dbg_putstr0(msg, COL8_FFFFFF);
            }
          }
        }
      }
    }
    dbg_putstr0("\n", COL8_FFFFFF);
  }

  return ;
}
