/*
 * Direct Memory Access(DMA)
 */
/* Intel 8237 */
#include "bootpack.h"

/* DMAC0(Slave) */
enum DMA0_IO {
  DMA0_STATUS_REG             = 0x08,
  DMA0_COMMAND_REG            = 0x08,
  DMA0_REQUEST_REG            = 0x09,
  DMA0_CHANMASK_REG           = 0x0A,
  DMA0_MODE_REG               = 0x0B,
  DMA0_CLEARBYTE_FLIPFLOP_REG = 0x0C,
  DMA0_TEMP_REG               = 0x0D,
  DMA0_MASTER_CLEAR_REG       = 0x0E,
  DMA0_MASK_REG               = 0x0F
};

/* DMAC1(Master) */
enum DMA1_IO {
  DMA1_STATUS_REG             = 0xD0,
  DMA1_COMMAND_REG            = 0xD0,
  DMA1_REQUEST_REG            = 0xD2,
  DMA1_CHANMASK_REG           = 0xD4,
  DMA1_MODE_REG               = 0xD6,
  DMA1_CLEARBYTE_FLIPFLOP_REG = 0xD8,
  DMA1_INTER_REG              = 0xDA,
  DMA1_UNMASK_ALL_REG         = 0xDC,
  DMA1_MASK_REG               = 0xDE
};

/* DMAC0(Slave) */
enum DMA0_CHANNEL_IO {
  DMA0_CHAN0_ADDR_REG  = 0x00,
  DMA0_CHAN0_COUNT_REG = 0x01,
  DMA0_CHAN1_ADDR_REG  = 0x02,
  DMA0_CHAN1_COUNT_REG = 0x03,
  DMA0_CHAN2_ADDR_REG  = 0x04,
  DMA0_CHAN2_COUNT_REG = 0x05,
  DMA0_CHAN3_ADDR_REG  = 0x06,
  DMA0_CHAN3_COUNT_REG = 0x07
};

/* DMAC1(Master) */
enum DMA1_CHANNEL_IO {
  DMA1_CHAN4_ADDR_REG  = 0xC0,
  DMA1_CHAN4_COUNT_REG = 0xC2,
  DMA1_CHAN5_ADDR_REG  = 0xC4,
  DMA1_CHAN5_COUNT_REG = 0xC6,
  DMA1_CHAN6_ADDR_REG  = 0xC8,
  DMA1_CHAN6_COUNT_REG = 0xCA,
  DMA1_CHAN7_ADDR_REG  = 0xCC,
  DMA1_CHAN7_COUNT_REG = 0xCE
};

enum DMA0_PAGE_REG {
  DMA_PAGE_EXTRA0          = 0x80,
  DMA_PAGE_CHAN2_ADDRBYTE2 = 0x81,
  DMA_PAGE_CHAN3_ADDRBYTE2 = 0x82,
  DMA_PAGE_CHAN1_ADDRBYTE2 = 0x83,
  DMA_PAGE_EXTRA1          = 0x84,
  DMA_PAGE_EXTRA2          = 0x85,
  DMA_PAGE_EXTRA3          = 0x86,
  DMA_PAGE_CHAN6_ADDRBYTE2 = 0x87,
  DMA_PAGE_CHAN7_ADDRBYTE2 = 0x88,
  DMA_PAGE_CHAN5_ADDRBYTE2 = 0x89,
  DMA_PAGE_EXTRA4          = 0x8C,
  DMA_PAGE_EXTRA5          = 0x8D,
  DMA_PAGE_EXTRA6          = 0x8E,
  DMA_PAGE_DRAM_REGRESH    = 0x8F
};

enum DMA_REG_MASK {
  DMA_CMD_MASK_MEMTOMEM      = 0x01,
  DMA_CMD_MASK_CHAN0ADDRHOLD = 0x02,
  DMA_CMD_MASK_ENABLE        = 0x04,
  DMA_CMD_MASK_TIMING        = 0x08,
  DMA_CMD_MASK_PRIORITY      = 0x10,
  DMA_CMD_MASK_WRITESEL      = 0x20,
  DMA_CMD_MASK_DREQ          = 0x40,
  DMA_CMD_MASK_DACK          = 0x80,
};

enum DMA_MODE_REG_MASK {
  DMA_MODE_MASK_SEL       = 0x03,

  DMA_MODE_MASK_TRA       = 0x0C,
  DMA_MODE_SELF_TEST      = 0x00,
  DMA_MODE_READ_TRANSFER  = 0x04,
  DMA_MODE_WRITE_TRANSFER = 0x08,

  DMA_MODE_MASK_AUTO = 0x10,
  DMA_MODE_MASK_IDE  = 0x20,

  DMA_MODE_MASK               = 0xC0,
  DMA_MODE_TRANSFER_ON_DEMAND = 0x00,
  DMA_MODE_TRANSFER_SINGLE    = 0x40,
  DMA_MODE_TRANSFER_BLOCK     = 0x80,
  DMA_MODE_TRANSFER_CASCADE   = 0xC0
};

void dma_reset(int dma) {
  io_out8(DMA0_TEMP_REG, 0xFF);
}

void dma_mask_channel(unsigned char channel) {
  if (channel <= 4) {
    io_out8(DMA0_CHANMASK_REG, (1 << (channel - 1)));
  } else {
    io_out8(DMA1_CHANMASK_REG, (1 << (channel - 5)));
  }
}

void dma_unmask_channel(unsigned char channel) {
  if (channel <= 4) {
    io_out8(DMA0_CHANMASK_REG, channel);
    /* outportb(DMA0_CHANMASK_REG, (1 << (channel - 1))); */
  } else {
    /* outportb(DMA1_CHANMASK_REG, (1 << (channel - 5))); */
    io_out8(DMA1_CHANMASK_REG, channel);
  }
}

void dma_reset_flipflop(int dma) {
  if (dma < 2) {
    return ;
  }

  io_out8( (dma ==0) ? DMA0_CLEARBYTE_FLIPFLOP_REG : DMA1_CLEARBYTE_FLIPFLOP_REG, 0xFF);
}

void dma_set_address(unsigned char channel, unsigned char low, unsigned char hight) {
  if (channel > 8) {
    return ;
  }

  unsigned short port = 0;
  switch (channel ) {
    case 0: {port = DMA0_CHAN0_ADDR_REG; break;}
    case 1: {port = DMA0_CHAN1_ADDR_REG; break;}
    case 2: {port = DMA0_CHAN2_ADDR_REG; break;}
    case 3: {port = DMA0_CHAN3_ADDR_REG; break;}
    case 4: {port = DMA1_CHAN4_ADDR_REG; break;}
    case 5: {port = DMA1_CHAN5_ADDR_REG; break;}
    case 6: {port = DMA1_CHAN6_ADDR_REG; break;}
    case 7: {port = DMA1_CHAN7_ADDR_REG; break;}
  }

  io_out8(port, low);
  io_out8(port, hight);
}

void dma_set_count(unsigned char channel, unsigned char low, unsigned char hight) {
  if (channel > 8) {
    return ;
  }
  unsigned short port = 0;
  switch (channel) {
    case 0: {port = DMA0_CHAN0_COUNT_REG; break; }
    case 1: {port = DMA0_CHAN1_COUNT_REG; break; }
    case 2: {port = DMA0_CHAN2_COUNT_REG; break; }
    case 3: {port = DMA0_CHAN3_COUNT_REG; break; }
    case 4: {port = DMA1_CHAN4_COUNT_REG; break; }
    case 5: {port = DMA1_CHAN5_COUNT_REG; break; }
    case 6: {port = DMA1_CHAN6_COUNT_REG; break; }
    case 7: {port = DMA1_CHAN7_COUNT_REG; break; }
  }
  io_out8(port, low);
  io_out8(port, hight);
}

void dma_set_mode(unsigned char channel, unsigned char mode) {
  int dma = (channel < 4) ? 0 : 1;
  int chan = (dma == 0) ? channel : channel - 4;
  dma_mask_channel(channel);
  io_out8((channel < 4) ? (DMA0_MODE_REG) : DMA1_MODE_REG, chan | (mode));
  dma_unmask_all(dma);
}

void dma_set_read(unsigned char channel) {
  dma_set_mode(channel, DMA_MODE_READ_TRANSFER | DMA_MODE_TRANSFER_SINGLE | DMA_MODE_MASK_AUTO);
}

void dma_set_write(unsigned char channel) {
  dma_set_mode(channel, DMA_MODE_WRITE_TRANSFER | DMA_MODE_TRANSFER_SINGLE | DMA_MODE_MASK_AUTO);
}

void dma_set_external_page_register(unsigned char reg, unsigned char val) {
  if (reg > 14) {
    return ;
  }
  unsigned short port = 0;
  switch( reg ) {
    case 1: {port = DMA_PAGE_CHAN1_ADDRBYTE2; break;}
    case 2: {port = DMA_PAGE_CHAN2_ADDRBYTE2; break;}
    case 3: {port = DMA_PAGE_CHAN3_ADDRBYTE2; break;}
    case 4: {return;} /* nothing should ever write to register 4 */
    case 5: {port = DMA_PAGE_CHAN5_ADDRBYTE2; break;}
    case 6: {port = DMA_PAGE_CHAN6_ADDRBYTE2; break;}
    case 7: {port = DMA_PAGE_CHAN7_ADDRBYTE2; break;}
  }
  io_out8(port, val);
}

void dma_unmask_all (int dma) {
  io_out8(DMA1_UNMASK_ALL_REG, 0xFF);
}
