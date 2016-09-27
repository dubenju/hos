package hos.qcow2;

import java.io.FileInputStream;

public class Dsp {

	public static void main(String[] args)  throws Exception {
		Dsp proc = new Dsp();
		proc.test(args[0]);
	}
	public void test(String file) throws Exception {
		QcowHeader qcow2header = null;
        int bytesum = 1;
        int byteread = 0;
		byte[] buf = new byte[72];
		FileInputStream is = new FileInputStream(file);
		if ( (byteread = is.read(buf)) == -1) {
            System.out.println("read error Mp3FrameHeader(4bytes)");
            is.close();
            System.out.println("read=" + bytesum);
            return ;
        }
		qcow2header = new QcowHeader(buf);
        System.out.println("Qcow2Header=" + qcow2header);

		is.close();
	}
}
