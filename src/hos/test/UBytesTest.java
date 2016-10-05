package hos.test;

import javay.util.UBytes;

public class UBytesTest {

	public static void main(String[] args) {
		byte[] b = new byte[8];
		b[0] = 0x12;
		b[1] = 0x34;
		b[2] = 0x56;
		b[3] = 0x78;
		b[4] = (byte) 0x9A;
		b[5] = (byte) 0xBC;
		b[6] = (byte) 0xDE;
//		for(int i = 0; i < 3; i ++) {
//			b[i] = 0;
//		}
		b[7] = (byte) 0xF0;

		System.out.println(UBytes.toHexString(b));
		long l = UBytes.be64Tolong(b);
		System.out.println(l);
	}

}
