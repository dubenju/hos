package hos.test;

public class TestAry {

	public static void main(String[] args) {
		byte[] buf = new byte[512];
		for (int i = 0; i < buf.length; i ++) {
			StringBuffer tmp = new StringBuffer();
			i = get(buf, i, tmp);
			System.out.println("i=" + i + ",tmp=" + tmp.toString());
		}

	}
	public static int get(byte[] buf, int pos, StringBuffer out) {
		//StringBuffer res = new StringBuffer();
		pos += 3;
		out.append(pos);
		return pos;
	}

}
