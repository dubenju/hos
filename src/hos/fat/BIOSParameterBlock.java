package hos.fat;

import javay.util.UBytes;

public class BIOSParameterBlock {
  private byte[] bpb_BytesPerSector = new byte[2];    /* Bytes Per Sector    */
  private byte[] bpb_SectorsPerCluster = new byte[1]; /* Sectors Per Cluster */
  private byte[] bpb_ReservedSectorst = new byte[2];  /* Reserved Sectors    */
  private byte[] bpb_FatCopies = new byte[1];         /* Number of FATs      */
  private byte[] bpb_RootDirEntries = new byte[2];    /* Root Entries        */
  private byte[] bpb_NumSectors = new byte[2];        /* Small Sectors       */
  private byte[] bpb_MediaType = new byte[1];         /* Media Descriptor    */
  private byte[] bpb_SectorsPerFAT = new byte[2];     /* Sectors Per FAT     */
  private byte[] bpb_SectorsPerTrack = new byte[2];   /* Sectors Per Track   */
  private byte[] bpb_NumberOfHeads = new byte[2];     /* Number of Heads     */
  private byte[] bpb_HiddenSectors = new byte[4];     /* Hidden Sectors      */
  private byte[] bpb_SectorsBig = new byte[4];        /* Large Sectors       */

  // 25 byte
  public BIOSParameterBlock(byte[] in) {
    int offset = 0;
    System.arraycopy(in, offset, bpb_BytesPerSector, 0, bpb_BytesPerSector.length);
    offset += bpb_BytesPerSector.length;
    System.arraycopy(in, offset, bpb_SectorsPerCluster, 0, bpb_SectorsPerCluster.length);
    offset += bpb_SectorsPerCluster.length;
    System.arraycopy(in, offset, bpb_ReservedSectorst, 0, bpb_ReservedSectorst.length);
    offset += bpb_ReservedSectorst.length;
    System.arraycopy(in, offset, bpb_FatCopies, 0, bpb_FatCopies.length);
    offset += bpb_FatCopies.length;
    System.arraycopy(in, offset, bpb_RootDirEntries, 0, bpb_RootDirEntries.length);
    offset += bpb_RootDirEntries.length;
    System.arraycopy(in, offset, bpb_NumSectors, 0, bpb_NumSectors.length);
    offset += bpb_NumSectors.length;
    System.arraycopy(in, offset, bpb_MediaType, 0, bpb_MediaType.length);
    offset += bpb_MediaType.length;
    System.arraycopy(in, offset, bpb_SectorsPerFAT, 0, bpb_SectorsPerFAT.length);
    offset += bpb_SectorsPerFAT.length;
    System.arraycopy(in, offset, bpb_SectorsPerTrack, 0, bpb_SectorsPerTrack.length);
    offset += bpb_SectorsPerTrack.length;
    System.arraycopy(in, offset, bpb_NumberOfHeads, 0, bpb_NumberOfHeads.length);
    offset += bpb_NumberOfHeads.length;
    System.arraycopy(in, offset, bpb_HiddenSectors, 0, bpb_HiddenSectors.length);
    offset += bpb_HiddenSectors.length;
    System.arraycopy(in, offset, bpb_SectorsBig, 0, bpb_SectorsBig.length);
    offset += bpb_SectorsBig.length;
  }
  public String toString() {
    StringBuffer buf = new StringBuffer();
    buf.append("\n   BytesPerSector=" + UBytes.toHexString(bpb_BytesPerSector));
    buf.append("\nSectorsPerCluster=" + UBytes.toHexString(bpb_SectorsPerCluster));
    buf.append("\n ReservedSectorst=" + UBytes.toHexString(bpb_ReservedSectorst));
    buf.append("\n        FatCopies=" + UBytes.toHexString(bpb_FatCopies));
    buf.append("\n   RootDirEntries=" + UBytes.toHexString(bpb_RootDirEntries));
    buf.append("\n       NumSectors=" + UBytes.toHexString(bpb_NumSectors));
    buf.append("\n        MediaType=" + UBytes.toHexString(bpb_MediaType));
    buf.append("\n    SectorsPerFAT=" + UBytes.toHexString(bpb_SectorsPerFAT));
    buf.append("\n    NumberOfHeads=" + UBytes.toHexString(bpb_NumberOfHeads));
    buf.append("\n    HiddenSectors=" + UBytes.toHexString(bpb_HiddenSectors));
    buf.append("\n       SectorsBig=" + UBytes.toHexString(bpb_SectorsBig));
    return buf.toString();
  }
}
