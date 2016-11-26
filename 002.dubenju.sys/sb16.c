#include "bootpack.h"

#define DSP_READY     0xAA
#define DSPVersion    0xE1

  short CardID;
  short IOAddr;
  short SBIntr;
  short DMA;
  short HDMA;
  short MIDI;
  short Mixer;
  short MixerAddr;
  short MixerData;
  short DSPReset;
  short DSPRead;
  short DSPWrite;
  short DSPStatus;
  short DSPIntAck;

float DSPVersionNum;
  char ver1;
  char ver2;

/* A220 I5 D1 H5 P330 E620 T6 */
int test_sb16() {
  int p;

  CardID = 6;      /* T6 */
  IOAddr = 0x0220; /* A0x0200 */
  SBIntr = 5;      /* I5 */
  DMA = 1;         /* D1 */
  HDMA = 5;        /* H5 */
  MIDI = 0;        /* P0x0330 */
  Mixer = 0x0330;  /* M */
  MixerAddr = IOAddr + 0x0004;
  MixerData = IOAddr + 0x0005;
  DSPReset  = IOAddr + 0x0006;
  DSPRead   = IOAddr + 0x000A;
  DSPWrite  = IOAddr + 0x000C;
  DSPStatus = IOAddr + 0x000E;
  DSPIntAck = IOAddr + 0x000F;

  io_out8(DSPReset, 0x01);
  io_out8(DSPReset, 0x00);
  dsp_data_avail();
  for(p = 0; p < 1000; p ++) {
    if((io_in8(DSPRead)) == DSP_READY) {
      get_dsp_version();
      return 0; //return to caller (SUCCESS)
    }	
  } 
  /* cout<<"Unable to Reset the DSP!\n"; */
  return -1;
}

void dsp_data_avail() {
  while((io_in8(DSPStatus) & 0x80)==0) {
    ;
  }
}

void dsp_wait(void) {
  while((io_in8(DSPWrite) & 0x80)!=0) {
    ;
  }
}

void get_dsp_version(void) {
  unsigned char VersionMaj,VersionMin;
  dsp_wait();
  io_out8(DSPWrite, DSPVersion); //send instruction
  dsp_data_avail(); //wait for dsp to flag u for instruction

  read_dsp(&VersionMaj);
  read_dsp(&VersionMin);
  /* DSPVersionNum=(float) VersionMaj;
  DSPVersionNum+=((float).01*(float)VersionMin); */
  ver1 = VersionMaj;
  ver2 = VersionMin;
}

void read_dsp(unsigned char * value) {
  dsp_data_avail(); 
  *value=io_in8(DSPRead);
}

void write_dsp(unsigned char value) {
  dsp_wait();    
  io_out8(DSPWrite,(unsigned char)value);
}


