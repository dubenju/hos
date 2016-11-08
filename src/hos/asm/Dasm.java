package hos.asm;

import java.io.File;
import java.io.FileInputStream;

import javay.util.Strings;
import javay.util.UBytes;
import javay.util.UInteger;

public class Dasm {

	public static String[] cccc = {
		"O",
		"NO",
		"C",
		"NC",
		"E",
		"NE",
		"BE",
		"A",
		"S",
		"NS",
		"P",
		"NP",
		"L",
		"GE",
		"LE",
		"G"
	};
	public static String[] rrrw0 = {
		"AL",
		"CL",
		"DL",
		"BL",
		"AH",
		"CH",
		"DH",
		"BH"
	};
	public static String[] rrrw1 = {
		"AX",
		"CX",
		"DX",
		"BX",
		"SP",
		"BP",
		"SI",
		"DI"
	};
	public static String[] mmms = {
		"DS:[BX+SI]",
		"DS:[BX+DI]",
		"SS:[BP+SI]",
		"SS:[BP+DI]",
		"DS:[SI]",
		"DS:[DI]",
		"SS:[BP]",
		"DS:[BX]"
	};
	public static String[] ssss = {
		"ES",
		"CS",
		"SS",
		"DS",
		"FS",
		"GS"
	};
	public static String get_oo_mmm(int oo, int mmm) {
		StringBuffer buf = new StringBuffer();
		if (oo == 0) {
			buf.append(mmms[mmm]);
		}
		if (oo == 1) {
			System.out.println("@get_oo_mmm oo=" + oo);
		}
		if (oo == 2) {
			System.out.println("@get_oo_mmm oo=" + oo);
		}
		if (oo == 3) {
			System.out.println("@get_oo_mmm oo=" + oo);
		}
		return buf.toString();
	}
	public static String get_oo_sss_mmm(int oo, int sss, int mmm) {
		StringBuffer buf = new StringBuffer();
		buf.append(ssss[sss]);
		buf.append(", ");
		if (oo == 0) {
			buf.append(mmms[mmm]);
		}
		if (oo == 1) {
			System.out.println("@get_oo_sss_mmm oo=" + oo);
		}
		if (oo == 2) {
			System.out.println("@get_oo_sss_mmm oo=" + oo);
			buf.append(mmms[mmm]);
		}
		if (oo == 3) {
			buf.append(rrrw1[mmm]);
		}
		return buf.toString();
	}
	public static String get_w_oo_rrr_mmm(int w, int oo, int rrr, int mmm) {
		StringBuffer buf = new StringBuffer();
		if (oo == 0) {
			System.out.println("@get_w_oo_rrr_mmm oo=" + oo);
			/* 00 : If mmm = 110, then a displacement follows the operation; otherwise, no displacement is used */
			/* 110 : SS:[BP] */
			/* 110 : DH : SI : ESI */
			buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
			buf.append(", ");
			buf.append((w == 0) ? rrrw0[mmm] : rrrw1[mmm]);
		}
		if (oo == 1) {
			System.out.println("@get_w_oo_rrr_mmm oo=" + oo);
		}
		if (oo == 2) {
			System.out.println("@get_w_oo_rrr_mmm oo=" + oo);
		}
		if (oo == 3) {
			/* 11 : mmm specifies a register, instead of an addressing mode */
			buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
			buf.append(", ");
			buf.append((w == 0) ? rrrw0[mmm] : rrrw1[mmm]);
		}
		return buf.toString();
	}
	public static void main(String[] args) throws Exception {
		String file_name = "C:/Users/DBJ/git/hos/001.vbr/10mvbs.bin";
		File in_file = new File(file_name);
		long file_length = in_file.length();
		byte[] buf = new byte[(int) file_length];
		FileInputStream is = new FileInputStream(file_name);
		is.read(buf);
		is.close();
		System.out.println(UBytes.toHexString(buf));
		for (int i = 0; i < buf.length; i ++) {
			int hight2 = (buf[i] >> 6) & 0x03;
			int hight4 = (buf[i] >> 4) & 0x0F;
			int low3   = buf[i] & 0x07;
			// System.out.println("hight4=" + hight4);

			if (3 <= i && i <= 61) {
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "DB " +
					Strings.format(Integer.toHexString(buf[i]).toUpperCase(), 2, '0')); }
			else if (387 <= i && i <= 493) {
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "DB " +
					Strings.format(Integer.toHexString(buf[i]).toUpperCase(), 2, '0')); }
			else if (510 <= i && i <= 511) {
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "DB " +
					Strings.format(Integer.toHexString(buf[i]).toUpperCase(), 2, '0')); }

			else if (hight2 == 0x00 && low3 == 0x06) {
				System.out.println(
						Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
						Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "PUSH " + ssss[( buf[i] >> 3 ) & 0x07]);
			} else if (hight2 == 0x00 && low3 == 0x07) {
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "POP " + ssss[( buf[i] >> 3 ) & 0x07]);

			} else if (hight4 == 0x03) {
				int w = (buf[i]) & 0x0F;
				if (w == 0x6) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "SS:");}
				else if (w == 0x7) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "AAA");}
				else if (w == 0x0E) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "DS:");}
				else if (w == 0x0F) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "AAS");}
				else  {
					/* CMP XOR */
					w = (buf[i]) & 0x01;
					int k = (buf[i] >> 1) & 0x07;
					byte[] tmp = new byte[2];
					System.arraycopy(buf, i, tmp, 0, tmp.length);
					System.out.println(
						Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' ') + (( k < 3) ? "XOR " : "CMP ") +
						get_w_oo_rrr_mmm(w, (buf[i + 1] >> 6) & 0x03,(buf[i + 1] >> 3) & 0x07, (buf[i + 1]) & 0x07)); i ++;
				}

			} else if (hight4 == 0x04) {
				/* INC DEC */
				int w = (buf[i] >> 3) & 0x1;
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + (( w == 0) ? "INC " : "DEC ") + rrrw1[buf[i] & 0x7]);}
			else if (hight4 == 0x05) {
				/* PUSH POP */
				int w = (buf[i] >> 3) & 0x1;
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + (( w == 0) ? "PUSH " : "POP ") + rrrw1[buf[i] & 0x7]);
			} else if (hight4 == 0x07) {
				/* Jcccc */
				byte[] tmp = new byte[2];
				System.arraycopy(buf, i, tmp, 0, tmp.length);
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' ') + "J" + cccc[buf[i] & 0x0F] + " SHORT " +
					Strings.format(Integer.toHexString(i + 2 + buf[i + 1]).toUpperCase(), 8, '0')); i ++;

			} else if (hight4 == 0x08) {
				int w = (buf[i] >> 1) & 0x07;
				System.out.println("w=" + w + "@" + i + ":" + Integer.toHexString(buf[i]));
				if (w == 0x00 || w == 0x01) {
					int rrr = ( buf[i + 1] >> 3 ) & 0x07;
					if (rrr == 0x00) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "ADD ");
					}
					if (rrr == 0x01) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "OR ");
					}
					if (rrr == 0x02) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "ADC ");
					}
					if (rrr == 0x03) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "SBB");
					}
					if (rrr == 0x04) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "AND ");
					}
					if (rrr == 0x05) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "SUB ");
					}
					if (rrr == 0x06) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "XOR ");
					}
					if (rrr == 0x07) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "CMP ");
					}
				} else if (w == 0x2) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "TEST ");}
				else if (w == 0x3) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "XCHG ");}
				else if (w == 0x4) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "MOV ");}
				else if (w == 0x5) {
					System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "MOV ");}
				else if (w == 0x06) {
					if (( buf[i] & 0x01 ) == 0) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "MOV ");
					} else {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "LEA ");
					}
				} else if (w == 0x07) {
					if (( buf[i] & 0x01 ) == 0) {
						System.out.println(
								Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
								Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "MOV " +
								get_oo_sss_mmm((buf[i + 1] >> 6) & 0x03, (buf[i + 1] >> 3) & 07, buf[i + 1] & 0x7));
						i ++;
					} else {
						int rrr = (buf[i + 1] >> 3) & 07;
						if (rrr != 000) {
							System.out.println("WARNING!!! @8F rrr!= 000" +rrr);
						}
						System.out.println(
							Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
							Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "POP " +
							get_oo_mmm((buf[i + 1] >> 6) & 0x03, (buf[i + 1]) & 0x07));
						i ++;
					}
				} else  {
					/* CMP XOR */
					w = (buf[i]) & 0x01;
					int k = (buf[i] >> 1) & 0x07;
					byte[] tmp = new byte[2];
					System.arraycopy(buf, i, tmp, 0, tmp.length);
					System.out.println(
						Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
						Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' ') + (( k < 3) ? "XOR " : "CMP ") +
						get_w_oo_rrr_mmm(w, (buf[i + 1] >> 6) & 0x03,(buf[i + 1] >> 3) & 0x07, (buf[i + 1]) & 0x07)); i ++;
				}
			} else if (hight4 == 0x0B) {
				/* MOV Reg,Imm */
				int w = (buf[i] >> 3) & 0x1;
				int len = 1;
				if (w == 0) {
					len ++;
				}
				if (w == 1) {
					len += 2;
				}
				byte[] tmp = new byte[len];
				byte[] tmp2 = new byte[len - 1];
				System.arraycopy(buf, i, tmp, 0, tmp.length);
				System.arraycopy(tmp, 1, tmp2, 0, tmp2.length);
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' ') + "MOV " + (( w == 0) ? rrrw0[buf[i] & 0x7]: rrrw1[buf[i] & 0x7]) + ", " +
					Strings.format(UBytes.toHexString(tmp2).toUpperCase(), 8, '0')); i += (len - 1); }
			else if (buf[i] == (byte) 0x90) {
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "NOP");}
			else if (buf[i] == (byte) 0xEB) {
				byte[] tmp = new byte[2];
				System.arraycopy(buf, i, tmp, 0, tmp.length);
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' ') + "JMP SHORT " +
					Strings.format(Integer.toHexString(i + 2 + buf[i + 1]).toUpperCase(), 8, '0'));
				i ++;
			} else {
				System.out.println("???");;
			}
		}
	}
}
