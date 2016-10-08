package hos.mbr;

import java.io.FileInputStream;

import javay.util.UBytes;
import hos.fat.PartitionTableEntry;
import hos.qcow2.Dsp;

public class Mbr {

	public static void main(String[] args) throws Exception {
		Mbr proc = new Mbr();
		proc.test(".\\000.mbr\\mbs.bin");
	}
    public void test(String file) throws Exception {
    	int byteread = 1;
    	System.out.println(file);
    	byte[] buf = new byte[512];
    	FileInputStream is = new FileInputStream(file);
    	if ( (byteread = is.read(buf)) == -1) {
            System.out.println("read error (512bytes)");
            is.close();
            System.out.println("read=" + byteread);
            return ;
        }
    	is.close();

    	// Classical Generic
    	int offset = 0;

    	byte[] Bootstrapcode = new byte[446];
    	System.arraycopy(buf, offset, Bootstrapcode, 0, Bootstrapcode.length);
    	offset += Bootstrapcode.length;
    	Dsp.writeToFile(".\\000.mbr\\mbs_bootstrap.bin", Bootstrapcode);

    	// Modern Standard
    	byte[] bootstrap = new byte[434];
    	System.arraycopy(buf, 0, bootstrap, 0, 218);
    	System.arraycopy(buf, 224, bootstrap, 218, 216);
    	Dsp.writeToFile(".\\000.mbr\\mbs_bootstrap_bin.bin", bootstrap);

    	byte[] pt = new byte[16];
    	System.arraycopy(buf, offset, pt, 0, pt.length);
    	offset += pt.length;
    	System.out.println(new PartitionTableEntry(pt));
    	System.arraycopy(buf, offset, pt, 0, pt.length);
    	offset += pt.length;
    	System.out.println(new PartitionTableEntry(pt));
    	System.arraycopy(buf, offset, pt, 0, pt.length);
    	offset += pt.length;
    	System.out.println(new PartitionTableEntry(pt));
    	System.arraycopy(buf, offset, pt, 0, pt.length);
    	offset += pt.length;
    	System.out.println(new PartitionTableEntry(pt));
    	byte[] s = new byte[2];
    	System.arraycopy(buf, offset, s, 0, s.length);
    	offset += s.length;
    	System.out.println(UBytes.toHexString(s));
    }
}
