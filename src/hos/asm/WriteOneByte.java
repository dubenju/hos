package hos.asm;

import java.io.FileOutputStream;

public class WriteOneByte {

	public static void main(String[] args) throws Exception {
		String path = "C:/Users/DBJ/git/hos/dasm/one/";
		byte[] buf = new byte[1];
		for (int i = 0; i < 256; i ++) {
			FileOutputStream os = new FileOutputStream(path + i + ".bin");
			buf[0] = (byte) i;
			os.write(buf);
			os.close();
		}
	}
}
