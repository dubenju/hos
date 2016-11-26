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
	public static int get_oo_mmm_dir (byte[] in, int pos, int dir, StringBuffer buf) {
		int oo  = (in[pos] >> 6) & 0x03;
		int rrr = (in[pos] >> 3) & 0x07;
		int mmm = (in[pos]     ) & 0x07;
		if (oo == 0) {
			buf.append(mmms[mmm]);
		}
		if (oo == 1) {
			buf.append(mmms[mmm]);
		}
		if (oo == 2) {
			buf.append(mmms[mmm]);
		}
		if (oo == 3) {
			buf.append(mmms[mmm]);
		}
		return pos;
	}

	public static int get_oo_sss_mmm_dir(byte[] in, int pos, StringBuffer buf) {
		int oo  = (in[pos] >> 6) & 0x03;
		int sss = (in[pos] >> 3) & 0x07;
		int mmm = (in[pos]     ) & 0x07;
		buf.append(ssss[sss]);
		buf.append(", ");
		if (oo == 0) {
			buf.append(mmms[mmm]);
		}
		if (oo == 1) {
			System.out.println("@get_oo_sss_mmm_dir oo=" + oo);
		}
		if (oo == 2) {
			buf.append(mmms[mmm]);
		}
		if (oo == 3) {
			buf.append(rrrw1[mmm]);
		}
		return pos;
	}

	public static int get_w_oo_rrr_mmm_dir(byte[] in, int pos, int w, int dir, StringBuffer buf) {
		int oo  = (in[pos] >> 6) & 0x03;
		int rrr = (in[pos] >> 3) & 0x07;
		int mmm = (in[pos]     ) & 0x07;
/*
System.out.println("@get_w_oo_rrr_mmm_dir w=" + w);
System.out.println("@get_w_oo_rrr_mmm_dir oo=" + oo);
System.out.println("@get_w_oo_rrr_mmm_dir rrr=" + rrr);
System.out.println("@get_w_oo_rrr_mmm_dir mmm=" + mmm);
*/
		if (oo == 0) {
			/* 00 : If mmm = 110, then a displacement follows the operation; otherwise, no displacement is used */
			/* 110 : SS:[BP] */
			/* 110 : DH : SI : ESI */
			if (dir == 0) {
				buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
				buf.append(", ");
				buf.append((w == 0) ? rrrw0[mmm] : rrrw1[mmm]);
			} else {
				buf.append((w == 0) ? rrrw0[mmm] : rrrw1[mmm]);
				buf.append(", ");
				buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
			}
		}
		if (oo == 1) {
			/* 01 : An 8-bit signed displacement follows the opcode  */
			if (dir == 0) {
				buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
				buf.append(", ");
				buf.append((w == 0) ? mmms[mmm] : mmms[mmm]);
			} else {
				buf.append((w == 0) ? mmms[mmm] : mmms[mmm]);
				buf.append(", ");
				buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
			}
		}
		if (oo == 2) {
			/* 10 : A 16-bit signed displacement follows the opcode */
		}
		if (oo == 3) {
			/* 11 : mmm specifies a register, instead of an addressing mode */
			if (dir == 0) {
				buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
				buf.append(", ");
				buf.append((w == 0) ? rrrw0[mmm] : rrrw1[mmm]);
			} else {
				buf.append((w == 0) ? rrrw0[mmm] : rrrw1[mmm]);
				buf.append(", ");
				buf.append((w == 0) ? rrrw0[rrr] : rrrw1[rrr]);
			}
		}
		return pos;
	}

	// TODO:start
	public static int proc_0x00_06(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		out.append("PUSH ");
		out.append(ssss[( buf[pos] >> 3 ) & 0x07]);

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}

	public static int proc_0x00_07(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		out.append("POP ");
		out.append(ssss[( buf[pos] >> 3 ) & 0x07]);

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}

	/**
	 *
	 * @param buf
	 * @param pos
	 * @param core 0:8086
	 * @param out
	 * @return
	 */
	public static int proc_0x0(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;
		if (op == 0x07) {
		} else if (op == 0x00) {
			/* ADD Mem,Reg 0000000woorrrmmm */
			out.append("ADD ");
			pos ++;
			if (pos < buf.length) {
				pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 1, out);
			} else {
				out.append(";!!!WARNING !!!  pos over");
			}
		} else if (op == 0x01) {
			/* ADD Reg,Reg 0000001woorrrmmm */
			/* ADD Reg,Mem 0000001woorrrmmm */
			out.append("ADD ");
			pos ++;
			if (pos < buf.length) {
				pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
			} else {
				out.append(";!!!WARNING !!!  pos over");
			}
		} else if (op == 0x02) {
			/* ADD Acc,Imm 0000010w */
			out.append("ADD ");
			if (w == 0) {
				pos ++;
				if (pos < buf.length) {
					out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
				} else {
					out.append(";!!!WARNING !!!  pos over");
				}
			}
			if (w == 1) {
				pos += 2;
				if (pos < buf.length) {
					out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
					out.append(Strings.format2(UInteger.fmtHex(buf[pos - 1], 2).toUpperCase(), 18, ' '));
				} else {
					out.append(";!!!WARNING !!!  pos over");
				}
			}
		} else if (op == 0x04) {
			out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
			out.append("OR  ");
		} else if (op == 0x05) {
			out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
			out.append("OR  ");
		} else if (op == 0x06) {
			out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
			out.append("OR  ");
		} else {
			out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
			out.append(";!!!WARNING !!!  undefined op");
		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	/**
	 *
	 * @param buf
	 * @param pos
	 * @param core 0:8086
	 * @param out
	 * @return
	 */
	public static int proc_0x1(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		//int w = (buf[i]) & 0x0F;
		if (op < 0x03) {
			out.append("ADC ");
		} else {
			out.append("SBB ");
		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}

	public static int proc_0x2(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		// int w =   buf[pos] & 0x01;
		int w = (buf[pos]) & 0x0F;
		if (w < 0x03) {
			out.append("AND ");
		} else {
			out.append("SUB ");
		}
		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0x3(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;
		int low4 = (buf[pos]) & 0x0F;

		if (low4 == 0x6) {
			/* SS:   00110110 */
			out.append("SS:");
		} else if (low4 == 0x7) {
			/* AAA   00110111 */
			out.append("AAA");
		} else if (low4 == 0x0E) {
			/* DS   00111110 */
			out.append("DS:");
		} else if (low4 == 0x0F) {
			/* AAS   00111111 */
			out.append("AAS");
		} else if (op == 0x00) {
			/* XOR Mem,Reg 0011000woorrrmmm */
			out.append("XOR ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 1, out);
		} else if (op == 0x01) {
			/* XOR Reg,Reg 0011001woorrrmmm */
			/* XOR Reg,Mem 0011001woorrrmmm */
			out.append("XOR ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);

		} else if (op == 0x02) {
			/* XOR Acc,Imm 0011010w */
			out.append("XOR ");
			if (w == 0) {
				out.append("AL, ");
			}
			if (w == 1) {
				out.append("AX, ");
			}
			out.append(Strings.format2(UInteger.fmtHex(buf[pos + 1], 2).toUpperCase(), 18, ' '));
			pos ++;
		} else if (op == 0x04) {
			/* CMP Mem,Reg 0011100woorrrmmm */
			out.append("CMP ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 1, out);
		} else if (op == 0x05) {
			/* CMP Reg,Reg 0011101woorrrmmm */
			/* CMP Reg,Mem 0011101woorrrmmm */
			out.append("CMP");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
		} else if (op == 0x06) {
			/* CMP Acc,Imm 0011110w */
			out.append("CMP ");
			if (w == 0) {
				out.append("AL, ");
			}
			if (w == 1) {
				out.append("AX, ");
			}
			out.append(Strings.format2(UInteger.fmtHex(buf[pos + 1], 2).toUpperCase(), 18, ' '));
			pos ++;
		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}

		return pos;
	}
	public static int proc_0x4(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		// int w =   buf[pos] & 0x01;
		/* INC DEC */
		int w = (buf[pos] >> 3) & 0x1;
		out.append((( w == 0) ? "INC " : "DEC ") + rrrw1[buf[pos] & 0x7]);

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0x5(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		// int w =   buf[pos] & 0x01;
		/* PUSH POP */
		int w = (buf[pos] >> 3) & 0x1;
		out.append((( w == 0) ? "PUSH " : "POP ") + rrrw1[buf[pos] & 0x7]);
		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0x6(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		out.append("!!!8086!!!");

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0x7(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;
		/* Jcccc */
		out.append("J" + cccc[buf[pos] & 0x0F] + " SHORT ");
		out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
		pos ++;
		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0x8(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;


		if (op == 0x00 || op == 0x01) {
			int rrr = ( buf[pos + 1] >> 3 ) & 0x07;
			if (rrr == 0x00) {
				/* ADD Reg,Imm8 1000001woo000mmm */
				/* ADD Mem,Imm8 1000001woo000mmm */
				/* ADD Reg,Imm  1000000woo000mmm */
				/* ADD Mem,Imm  1000000woo000mmm */
				out.append("ADD ");
			}
			if (rrr == 0x01) {
				/* OR Reg,Imm8 1000001woo001mmm */
				/* OR Mem,Imm8 1000001woo001mmm */
				/* OR Reg,Imm 1000000woo001mmm */
				/* OR Mem,Imm 1000000woo001mmm */
				out.append("OR ");
			}
			if (rrr == 0x02) {
				/* ADC Reg,Imm8 1000001woo010mmm */
				/* ADC Mem,Imm8 1000001woo010mmm */
				/* ADC Reg,Imm 1000000woo010mmm */
				/* ADC Mem,Imm 1000000woo010mmm */
				out.append("ADC ");
			}
			if (rrr == 0x03) {
				/*
				 * SBB Reg,Imm8 1000001woo011mmm
SBB Mem,Imm8 1000001woo011mmm
SBB Reg,Imm 1000000woo011mmm
SBB Mem,Imm 1000000woo011mmm
				 */
				out.append("SBB");
			}
			if (rrr == 0x04) {
				/*
				 * AND Reg,Imm8 1000001woo100mmm
AND Mem,Imm8 1000001woo100mmm
AND Reg,Imm 1000000woo100mmm
AND Mem,Imm 1000000woo100mmm

				 */
				out.append("AND ");
			}
			if (rrr == 0x05) {
				/* SUB Reg,Imm8 1000001woo101mmm */
				/* SUB Mem,Imm8 1000001woo101mmm */
				/* SUB Reg,Imm 1000000woo101mmm */
				/* SUB Mem,Imm 1000000woo101mmm */
				out.append("SUB ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0, out);
			}
			if (rrr == 0x06) {
				/*
				 * XOR Reg,Imm8 1000001woo110mmm
XOR Mem,Imm8 1000001woo110mmm
XOR Reg,Imm 1000000woo110mmm
XOR Mem,Imm 1000000woo110mmm

				 */
				out.append("XOR ");
			}
			if (rrr == 0x07) {
				/*
				 * CMP Reg,Imm8 1000001woo111mmm
CMP Mem,Imm8 1000001woo111mmm
CMP Reg,Imm 1000000woo111mmm
CMP Mem,Imm 1000000woo111mmm

				 */
				out.append("CMP ");
			}
		} else if (op == 0x2) {
			/*
			 * TEST Reg,Reg 1000010woorrrmmm
TEST Mem,Reg 1000010woorrrmmm
TEST Reg,Mem 1000010woorrrmmm

			 */
			out.append("TEST ");}
		else if (op == 0x3) {
			/*
			 * XCHG Reg,Reg 1000011woorrrmmm
XCHG Mem,Reg 1000011woorrrmmm
XCHG Reg,Mem 1000011woorrrmmm

			 */
			out.append("XCHG ");}
		else if (op == 0x4) {
			/* MOV Mem,Reg 1000100woorrrmmm
*/
			out.append("MOV ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 1, out);
		} else if (op == 0x5) {
			/*
			 * MOV Reg,Reg 1000101woorrrmmm
MOV Reg,Mem 1000101woorrrmmm

			 */
			out.append("MOV ");
			pos ++;
			pos =get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
		} else if (op == 0x06) {
			if (w == 0) {
				/* MOV Reg16,Seg 10001100oosssmmm */
				/* MOV Mem16,Seg 10001100oosssmmm */
				out.append("MOV ");
			} else {
				/* LEA RegWord,Mem 10001101oorrrmmm */
				out.append("LEA ");
			}
		} else if (op == 0x07) {
			if (w == 0) {
				/* MOV Seg,Reg16 10001110oosssmmm */
				/* MOV Seg,Mem16 10001110oosssmmm */
				out.append("MOV ");
				pos ++;
				pos = get_oo_sss_mmm_dir(buf, pos, out);
			} else {
				/* POP MemWord 10001111oo000mmm */
				int rrr = (buf[pos + 1] >> 3) & 07;
				if (rrr != 000) {
					System.out.println("WARNING!!! @8F rrr!= 000" +rrr);
				}
				out.append("POP ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0, out);
			}
		} else  {
			System.out.println("WARNING!!! @8F op!= 000" + op);
		}


		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0x9(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;
		int low4 = buf[pos] & 0x0F;

		if (buf[pos] == (byte) 0x90) {
			/* NOP   10010000 */
			out.append("NOP");
		} else if (low4 == 0x08) {
			/* CBW   10011000 */
			out.append("CBW");
		} else if (low4 == 0x09) {
			/* CWD   10011001 */
			out.append("CWD");
		} else if (low4 == 0x0A) {
			/* CALL Far 10011010 */
			out.append("CALL");
		} else if (low4 == 0x0B) {
			/* WAIT   10011011 */
			out.append("WAIT");
		} else if (low4 == 0x0C) {
			/* PUSHF   10011100 */
			out.append("PUSHF");
		} else if (low4 == 0x0D) {
			/* POPF   10011101 */
			out.append("POPF");
		} else if (low4 == 0x0E) {
			/* SAHF   10011110 */
			out.append("SAHF");
		} else if (low4 == 0x0F) {
			/* LAHF   10011111 */
			out.append("LAHF");
		} else if (op == 0x00) {
			/* XCHG AccWord,RegWord 10010rrr */
			/* XCHG RegWord,AccWord 10010rrr */
			out.append("XCHG ;!!!!");
		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0xA(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (op == 0) {
			out.append("MOV " + ", ");
		}
		if (op == 1) {
			out.append("MOV " + ", ");
		}
		if (op == 2) {
			if (w == 0) {
				out.append("MOVSB " + ", ");
			} else {
				out.append("MOVSW " + ", ");
			}
		}
		if (op == 3) {
			if (w == 0) {
				out.append("CMPSB " + ", ");
			} else {
				out.append("CMPSW " + ", ");
			}
		}
		if (op == 4) {
			out.append("TEST " + ", ");
		}
		if (op == 5) {
			if (w == 0) {
				out.append("STOSB " + ", ");
			} else {
				out.append("STOSW " + ", ");
			}
		}
		if (op == 6) {
			if (w == 0) {
				out.append("LODSB " + ", ");
			} else {
				out.append("LODSW " + ", ");
			}
		}
		if (op == 7) {
			if (w == 0) {
				out.append("SCASB " + ", ");
			} else {
				out.append("SCASW " + ", ");
			}
		}
		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0xB(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;

		/* MOV Reg,Imm 1011wrrr */
		int w = (buf[pos] >> 3) & 0x1;
		int rrr = (buf[pos] & 0x07);

		out.append("MOV ");
		out.append((( w == 0) ? rrrw0[rrr]: rrrw1[rrr]));
		out.append(", ");
		byte[] imm;
		int ln = 1;
		if (w == 1) {
			ln ++;
			imm = new byte[ln];
			pos += 2;
			imm[0] = buf[pos];
			imm[1] = buf[pos - 1];
		} else {
			imm = new byte[ln];
			pos ++;
			imm[0] = buf[pos];
		}
		out.append(Strings.format(UBytes.toHexString(imm).toUpperCase(), 8, '0'));

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0xC(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (op == 0x00) {
			out.append("MOV " + ", ");

		}
		if (op == 0x01) {
			out.append("RET " + ", ");

		}
		if (op == 0x02) {
			out.append(((buf[pos] & 0x01) == 0x01 ? "LDS " : "LES "));
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
		}

		if (op == 0x03) {
			int q = (buf[pos + 1] >> 3) & 0x07;
			if (q == 0) {
				out.append("MOV ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0, out);
			} else {
				System.out.println("!!!WARNING!!!" + UInteger.fmtHex(buf[pos], 2) + " " + UInteger.fmtHex(buf[pos + 1], 2));
				pos ++;
			}
		}

		if (op == 0x04) {
			out.append("ENTER " + ", ");

		}
		if (op == 0x05) {
			out.append("RET " + ", ");

		}
		if (op == 0x06) {
			out.append("INT " + ", ");

		}
		if (op == 0x07) {
			out.append("INTO " + ", ");

		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0xD(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (op == 0 || op == 1) {
			int v = (buf[pos + 1] >> 3) & 0x07;
			if (v == 0) {
				out.append("ROL ");
			}
			if (v == 1) {
				out.append("ROR ");
			}
			if (v == 2) {
				out.append("RCL ");
			}
			if (v == 3) {
				out.append("RCR ");
			}
			if (v == 4) {
				out.append("SAL ");
			}
			if (v == 5) {
				out.append("SHR ");
			}
//			if (v == 6) {
//				System.out.println(
//						Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
//						Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "ROL ");
//			}
			if (v == 7) {
				out.append("SAR ");
			}
		}

		if (op == 2) {
			if (w == 0) {
				out.append("AAD ");
			} else {
				out.append("AAM");
			}
		}
		if (op == 3) {
			if (w == 0) {
				out.append("SALC ");
			} else {
				out.append("XLAT ");
			}
		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0xE(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;


		if (op == 0x00) {
			if (w == 0x00) {
				/* LOOPNZ Short 11100000 */
				/* LOOPNE Short 11100000 */
				out.append("LOOPNZ SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos ++;
			}
			if (w == 0x01) {
				/* LOOPZ Short 11100001 */
				/* LOOPE Short 11100001 */
				out.append("LOOPZ SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos ++;
			}
		} else if (op == 0x01) {
			if (w == 0x00) {
				/* LOOP Short 11100010 */
				out.append("LOOP SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos ++;
			}
			if (w == 0x01) {
				/* JCXZ Short 11100011 */
				/* JCXE Short 11100011 */
				/* JECXZ Short 11100011 */
				/* JECXE Short 11100011 */
				out.append("JCXZ SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos ++;
			}
		} else if (op == 0x02) {
			/* IN Acc,Imm8 1110010w */
			out.append("IN ");
			if (w == 0) {
				out.append("AL, ");
			}
			if (w == 1) {
				out.append("AX, ");
			}
			out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
			pos ++;
		}
		else if (op == 0x03) {
			/* OUT Imm8,Acc 1110011w */
			out.append("OUT ");
			out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
			if (w == 0) {
				out.append(", AL");
			}
			if (w == 1) {
				out.append(", AX");
			}
			pos ++;
		} else if (op == 0x04) {
			if (w == 0) {
				/* CALL Near 11101000 */
				out.append("CALL NEAR ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos += 2;
			}
			if (w == 1) {
				/* JMP Near 11101001 */
				out.append("JMP NEAR ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos ++;
			}
		} else if (op == 0x05) {
			if (w == 0x00) {
				/* JMP Far 11101010 */
				out.append("JMP FAR ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos ++;
			}
			if (w == 0x01) {
				/* JMP Short 11101011 */
				out.append("JMP SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				pos ++;
			}
		} else if (op == 0x06) {
			/* IN Acc,DX 1110110w */
			out.append("IN ");
			if (w == 0) {
				out.append("AL, DX");
			}
			if (w == 1) {
				out.append("AX, DX");
			}
			// out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
			pos ++;
		}
		else if (op == 0x07) {
			/* OUT DX,Acc 1110111w */
			out.append("OUT ");
			if (w == 0) {
				out.append("DX, AL");
			}
			if (w == 1) {
				out.append("DX, AX");
			}
			// Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
			pos ++;
		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static int proc_0xF(byte[] buf, int pos, int core, StringBuffer out) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (op == 0x00) {
			out.append("LOCK ");
		}
		if (op == 0x01) {
			if (w == 0) {
				out.append("REPE ");
			} else {
				out.append("REPNE ");
			}
		}
		if (op == 0x02) {
			if (w == 0) {
				out.append("HLT ");
			} else {
				out.append("CMC ");
			}
		}
		if (op == 0x03) {
			int q = (buf[pos + 1] >> 3) & 0x07;
			if (q == 0) {
				out.append("TEST ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 2) {
				out.append("NOT ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 3) {
				out.append("NEG ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 4) {
				out.append("MUL ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 5) {
				out.append("IMUL ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 6) {
				out.append("DIV ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 7) {
				out.append("IDIV ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
		}
		if (op == 0x04) {
			if (w == 0) {
				out.append("CLC ");
			} else {
				out.append("STC ");
			}
		}
		if (op == 0x05) {
			if (w == 0) {
				out.append("CLI ");
			} else {
				out.append("STI ");
			}
		}
		if (op == 0x06) {
			if (w == 0) {
				out.append("CLD ");
			} else {
				out.append("STD ");
			}
		}
		if (op == 0x07) {
			int q = (buf[pos + 1] >> 3) & 0x07;
			if (q == 0) {
				out.append("INC ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 1) {
				out.append("DEC ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 2) {
				out.append("CALL ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 3) {
				out.append("CALL ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 4) {
				out.append("JMP ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 5) {
				out.append("JMP ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
			if (q == 6) {
				out.append("PUSH ");
				pos ++;
				pos = get_oo_mmm_dir(buf, pos, 0 , out);
			}
		}

		out.append("\n");
		int len = pos - start;
		// System.out.printf("len=" + len);
			if (len > 0) {
			byte[] tmp = new byte[len];
			System.arraycopy(buf, start + 1, tmp, 0, len);
			out.insert(12, Strings.format2(UBytes.toHexString(tmp).toUpperCase(), 18, ' '));
		}
		return pos;
	}
	public static void main(String[] args) throws Exception {
		String file_name = "C:/Users/DBJ/git/hos/001.vbr/10mvbs.bin";
		File in_file = new File(file_name);
		long file_length = in_file.length();
		byte[] buf = new byte[(int) file_length];
		FileInputStream is = new FileInputStream(file_name);
		is.read(buf);
		is.close();
//		System.out.println(UBytes.toHexString(buf));

		int core = 0;

		for (int i = 0; i < buf.length; i ++) {
			int hight2 = (buf[i] >> 6) & 0x03;
			int hight4 = (buf[i] >> 4) & 0x0F;
			int low3   = buf[i] & 0x07;
			// System.out.println("hight4=" + hight4);

			if (3 <= i && i <= 61) {
//				System.out.println(
//					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
//					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "DB " +
//					Strings.format(Integer.toHexString(buf[i]).toUpperCase(), 2, '0'));
			} else if (387 <= i && i <= 493) {
//				System.out.println(
//					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
//					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "DB " +
//					Strings.format(Integer.toHexString(buf[i]).toUpperCase(), 2, '0'));
			} else if (510 <= i && i <= 511) {
//				System.out.println(
//					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
//					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "DB " +
//					Strings.format(Integer.toHexString(buf[i]).toUpperCase(), 2, '0'));
			} else if (hight2 == 0x00 && low3 == 0x06) {
				StringBuffer sbf = new StringBuffer();
				i = proc_0x00_06(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight2 == 0x00 && low3 == 0x07) {
				StringBuffer sbf = new StringBuffer();
				i = proc_0x00_07(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x00) {
				/* TODO:0x0* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x0(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x01) {
				/* TODO:0x1* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x1(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x02) {
				/* TODO:0x2* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x2(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x03) {
				/* TODO:0x3* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x3(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x04) {
				/* TODO:0x4* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x4(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x05) {
				/* TODO:0x5* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x5(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x06) {
				/* TODO:0x6* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x6(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x07) {
				/* TODO:0x7* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x7(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x08) {
				/* TODO:0x8* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x8(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x09) {
				/* TODO:0x9* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x9(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x0A) {
				/* TODO:0xA* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xA(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x0B) {
				/* TODO:0xB* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xB(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x0C) {
				/* TODO:0xC* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xC(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x0D) {
				/* TODO:0xD* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xD(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x0E) {
				/* TODO:0xE* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xE(buf, i, core, sbf);
				System.out.print(sbf);
			} else if (hight4 == 0x0F) {
				/* TODO:0xF* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xF(buf, i, core, sbf);
				System.out.print(sbf);
			} else {
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "??? ");
			}
		}
	}
}
