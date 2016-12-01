package javay.util;

public class UInteger {
	public static String fmtHex(int i, int len) {
		String a = Integer.toHexString(i);
		int lena = a.length();
		if (lena > len) {
			a = a.substring(lena - len, lena);
		}
		if (lena < len) {
			a = Strings.format(a, len, '0');
		}
		return a;
	}
}
