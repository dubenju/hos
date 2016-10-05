package hos.fat;

/**
 * 主引导扇区
 * @author DBJ
 *
 */
public class MasterBootSector {
	private byte[] mbs_Code = new byte[440];
	private byte[] mbs_32_BitDiskSignature = new byte[4];
	private byte[] mbs_DiskSignature = new byte[2]; // 0x0000 or 0x5A5A if copy-protected
	private byte[] mbs_PartitionTableEntry1 = new byte[16];
	private byte[] mbs_PartitionTableEntry2 = new byte[16];
	private byte[] mbs_PartitionTableEntry3 = new byte[16];
	private byte[] mbs_PartitionTableEntry4 = new byte[16];
	private byte[] bs_EndFlag = new byte[2];
	private PartitionTableEntry[] mbs_PT = new PartitionTableEntry[4];

	  // byte 512
	  public MasterBootSector(byte[] in) {
	    int offset = 0;
	    System.arraycopy(in, offset, mbs_Code, 0, mbs_Code.length);
	    offset += mbs_Code.length;
	    System.arraycopy(in, offset, mbs_32_BitDiskSignature, 0, mbs_32_BitDiskSignature.length);
	    offset += mbs_32_BitDiskSignature.length;
	    System.arraycopy(in, offset, mbs_DiskSignature, 0, mbs_DiskSignature.length);
	    offset += mbs_DiskSignature.length;
	    System.arraycopy(in, offset, mbs_PartitionTableEntry1, 0, mbs_PartitionTableEntry1.length);
	    offset += mbs_PartitionTableEntry1.length;
	    mbs_PT[0] = new PartitionTableEntry(mbs_PartitionTableEntry1);
	    System.arraycopy(in, offset, mbs_PartitionTableEntry2, 0, mbs_PartitionTableEntry2.length);
	    offset += mbs_PartitionTableEntry2.length;
	    mbs_PT[1] = new PartitionTableEntry(mbs_PartitionTableEntry2);
	    System.arraycopy(in, offset, mbs_PartitionTableEntry3, 0, mbs_PartitionTableEntry3.length);
	    offset += mbs_PartitionTableEntry3.length;
	    mbs_PT[2] = new PartitionTableEntry(mbs_PartitionTableEntry3);
	    System.arraycopy(in, offset, mbs_PartitionTableEntry4, 0, mbs_PartitionTableEntry4.length);
	    offset += mbs_PartitionTableEntry4.length;
	    mbs_PT[3] = new PartitionTableEntry(mbs_PartitionTableEntry4);
	    System.arraycopy(in, offset, bs_EndFlag, 0, bs_EndFlag.length);
	    offset += bs_EndFlag.length;
	  }
	  public String toString() {
		    StringBuffer buf = new StringBuffer();
		    for (int i = 0; i < mbs_PT.length; i ++) {
		    	buf.append(mbs_PT[i]);
		    }
		    return buf.toString();
	  }
	  public PartitionTableEntry getFirstPartitionTableEntry() {
		  return mbs_PT[0];
	  }
}
