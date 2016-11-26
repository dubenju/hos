/* GDTÇ‚IDTÇ»Ç«ÇÃÅA descriptor table ä÷åW */

#include "bootpack.h"

void init_gdtidt(void) {
  struct SEGMENT_DESCRIPTOR *gdt = (struct SEGMENT_DESCRIPTOR *) ADR_GDT; /* 0x00270000 */
  struct GATE_DESCRIPTOR    *idt = (struct GATE_DESCRIPTOR    *) ADR_IDT; /* 0x0026f800 */

  int i;
  /* GDTÇÃèâä˙âª */
  for (i = 0; i <= LIMIT_GDT / 8; i++) { /* 0x0000ffff */
    set_segmdesc(gdt + i, 0, 0, 0);
  }
  /* EDS */
  /* 0x4092 0100000010010010 */
  /*        ^^^^    ^^^^^^^^ */
  set_segmdesc(gdt + 1, 0xffffffff,   0x00000000, AR_DATA32_RW);
  /* ECS */
  /* 0x0007ffff,0x00280000 */
  /* 0x409a 0100000010011010 */
  /*        ^^^^    ^^^^^^^^ */
  set_segmdesc(gdt + 2, LIMIT_BOTPAK, ADR_BOTPAK, AR_CODE32_ER);
  /* ESS */

  load_gdtr(LIMIT_GDT, ADR_GDT); /* naskfunc.nas */

  /* IDTÇÃèâä˙âª */
  for (i = 0; i <= LIMIT_IDT / 8; i++) {
    set_gatedesc(idt + i, 0, 0, 0);
  }
  load_idtr(LIMIT_IDT, ADR_IDT); /* naskfunc.nas */

  /* IDTÇÃê›íË */
  set_gatedesc(idt + 0x0c, (int) asm_inthandler0c, 2 * 8, AR_INTGATE32); /* stack */
  set_gatedesc(idt + 0x0d, (int) asm_inthandler0d, 2 * 8, AR_INTGATE32); /* protected */
  set_gatedesc(idt + 0x20, (int) asm_inthandler20, 2 * 8, AR_INTGATE32); /* timer */
  set_gatedesc(idt + 0x21, (int) asm_inthandler21, 2 * 8, AR_INTGATE32); /* keyboard */
  set_gatedesc(idt + 0x26, (int) asm_inthandler26, 2 * 8, AR_INTGATE32); /* fdc */
  set_gatedesc(idt + 0x2c, (int) asm_inthandler2c, 2 * 8, AR_INTGATE32); /* mouse */
  set_gatedesc(idt + 0x40, (int) asm_hrb_api,      2 * 8, AR_INTGATE32 + 0x60);

  return;
}

/*
 * Segnebt Descriptor
 * limit 20Bit(0-19)
 * base  32Bit(0-31)
 * ar    12Bit(0-11) G,D,0,AVL,P,DPL,DT,TYPE
 */
void set_segmdesc(struct SEGMENT_DESCRIPTOR *sd, unsigned int limit, int base, int ar) {
  if (limit > 0xfffff) {
    ar |= 0x8000; /* G_bit = 1 */
    limit /= 0x1000;
  }
  sd->limit_low    = limit & 0xffff;
  sd->base_low     = base & 0xffff;
  sd->base_mid     = (base >> 16) & 0xff;
  sd->access_right = ar & 0xff; /* P,DPL2,DT,TYPE4 */
  sd->limit_high   = ((limit >> 16) & 0x0f) | ((ar >> 8) & 0xf0); /* G,D,0,AVL */
  sd->base_high    = (base >> 24) & 0xff;
  return;
}

void set_gatedesc(struct GATE_DESCRIPTOR *gd, int offset, int selector, int ar) {
  gd->offset_low   = offset & 0xffff;
  gd->selector     = selector;
  gd->dw_count     = (ar >> 8) & 0xff;
  gd->access_right = ar & 0xff;
  gd->offset_high  = (offset >> 16) & 0xffff;
  return;
}
