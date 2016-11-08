package javay.util;

public class UInteger {
	public static String fmtHex(int i, int len) {
		String a = Integer.toHexString(i);
		int lena = a.length();
		if (lena > len) {
			a = a.substring(lena - len, lena);
		}
		return a;
	}
}
