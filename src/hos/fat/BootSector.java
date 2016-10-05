package hos.fat;

import java.io.UnsupportedEncodingException;

import javay.util.UBytes;

/**
 * 引导扇区
 * @author DBJ
 *
 */
public class BootSector {
  private byte[] bs_jmpBoot = new byte[3];
  private byte[] bs_OEMName = new byte[8];
  private byte[] bs_bpb     = new byte[25];
  private BIOSParameterBlock bpb;
  private byte[] bs_DrvNum = new byte[1];
  private byte[] bs_Reaserved1 = new byte[1];
  private byte[] bs_Bootsig = new byte[1];
  private byte[] bs_VolID = new byte[4];
  private byte[] bs_VolLab = new byte[11];
  private byte[] bs_FileSysType = new byte[8];
  private byte[] bs_Code = new byte[448];
  private byte[] bs_EndFlag = new byte[2];
  // byte 512
  public BootSector(byte[] in) {
    int offset = 0;
    System.arraycopy(in, offset, bs_jmpBoot, 0, bs_jmpBoot.length);
    offset += bs_jmpBoot.length;
    System.arraycopy(in, offset, bs_OEMName, 0, bs_OEMName.length);
    offset += bs_OEMName.length;
    System.arraycopy(in, offset, bs_bpb, 0, bs_bpb.length);
    offset += bs_bpb.length;
    bpb = new BIOSParameterBlock(bs_bpb);
    System.arraycopy(in, offset, bs_DrvNum, 0, bs_DrvNum.length);
    offset += bs_DrvNum.length;
    System.arraycopy(in, offset, bs_Reaserved1, 0, bs_Reaserved1.length);
    offset += bs_Reaserved1.length;
    System.arraycopy(in, offset, bs_Bootsig, 0, bs_Bootsig.length);
    offset += bs_Bootsig.length;
    System.arraycopy(in, offset, bs_VolID, 0, bs_VolID.length);
    offset += bs_VolID.length;
    System.arraycopy(in, offset, bs_VolLab, 0, bs_VolLab.length);
    offset += bs_VolLab.length;
    System.arraycopy(in, offset, bs_FileSysType, 0, bs_FileSysType.length);
    offset += bs_FileSysType.length;
    System.arraycopy(in, offset, bs_Code, 0, bs_Code.length);
    offset += bs_Code.length;
    System.arraycopy(in, offset, bs_EndFlag, 0, bs_EndFlag.length);
    offset += bs_EndFlag.length;
  }

  public String toString() {
    StringBuffer buf = new StringBuffer();
    try {
	    buf.append("\n          OEMName=" + new String(bs_OEMName, "ISO-8859-1") );
	    buf.append(bpb.toString());
	    buf.append("\n           DrvNum=" + UBytes.toHexString(bs_DrvNum));
	    buf.append("\n       Reaserved1=" + UBytes.toHexString(bs_Reaserved1));
	    buf.append("\n          Bootsig=" + UBytes.toHexString(bs_Bootsig));
	    buf.append("\n            VolID=" + UBytes.toHexString(bs_VolID));

		buf.append("\n           VolLab=" + new String(bs_VolLab, "ISO-8859-1"));
	} catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	}
    buf.append("\n      FileSysType=" + UBytes.toHexString(bs_FileSysType));
    buf.append("\n          EndFlag=" + UBytes.toHexString(bs_EndFlag));
    return buf.toString();
  }
}
