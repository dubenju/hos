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

	/**
	 *
	 * @param in
	 * @param pos
	 * @param w
	 * @param dir 方向
	 * @param cnt 操作数个数
	 * @param buf
	 * @return
	 */
	private static int get_w_oo_mmm_dir (byte[] in, int pos, int w, int dir, int cnt, StringBuffer buf) {
		int oo  = (in[pos] >> 6) & 0x03;
//		int rrr = (in[pos] >> 3) & 0x07;
		int mmm = (in[pos]     ) & 0x07;
/*
		System.out.println(" get_oo_mmm_dir >> w=" + w);
		System.out.println(" get_oo_mmm_dir >> oo=" + oo);
		System.out.println(" get_oo_mmm_dir >> rrr=" + rrr);
		System.out.println(" get_oo_mmm_dir >> mmm=" + mmm);
*/
		if (oo == 0) {
			/* 00 : If mmm = 110, then a displacement follows the operation; otherwise, no displacement is used */
			// buf.append(mmms[mmm]);
			if (mmm == 6) {
				buf.append("[");
				buf.append(Strings.format(Integer.toHexString(in[pos + 2]).toUpperCase(), 2, '0'));
				buf.append(Strings.format(Integer.toHexString(in[pos + 1]).toUpperCase(), 2, '0'));
				buf.append("]");
				pos += 2;
			}
		}
		if (oo == 1) {
			buf.append(mmms[mmm]);
			pos ++;
			int it = in[pos];
			if (it < 0) {
				buf.append("-");
				it = 0 - it;
			} else {
				buf.append("+");
			}
			buf.append(Strings.format(Integer.toHexString(it).toUpperCase(), 2, '0'));
			if (cnt == 2) {
				buf.append(",");
				pos ++;
				buf.append(Strings.format(Integer.toHexString(in[pos]).toUpperCase(), 2, '0'));
			}
		}
		if (oo == 2) {
			buf.append(mmms[mmm]);
		}
		if (oo == 3) {
			/* 11 : mmm specifies a register, instead of an addressing mode  */
			buf.append(w == 0 ? rrrw0[mmm] : rrrw1[mmm]);
			if (cnt == 2) {
				buf.append(",");
				pos ++;
				buf.append(Strings.format(Integer.toHexString(in[pos]).toUpperCase(), 2, '0'));
			}
		}
		return pos;
	}

	private static int get_oo_sss_mmm_dir(byte[] in, int pos, StringBuffer buf) {
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

	/**
	 *
	 * @param in
	 * @param pos
	 * @param w
	 * @param dir
	 * @param buf
	 * @return
	 */
	private static int get_w_oo_rrr_mmm_dir(byte[] in, int pos, int w, int dir, StringBuffer buf) {
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
				//buf.append((w == 0) ? rrrw0[mmm] : rrrw1[mmm]);
				buf.append(mmms[mmm]);
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
				pos ++;
				int it = in[pos];
				if (it < 0) {
					buf.append("-");
					it = 0 - it;
				} else {
					buf.append("+");
				}
				buf.append(Strings.format(Integer.toHexString(it).toUpperCase(), 2, '0'));
			} else {
				buf.append((w == 0) ? mmms[mmm] : mmms[mmm]);
				pos ++;
				int it = in[pos];
				if (it < 0) {
					buf.append("-");
					it = 0 - it;
				} else {
					buf.append("+");
				}
				buf.append(Strings.format(Integer.toHexString(it).toUpperCase(), 2, '0'));
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
	public static int proc_0x00_06(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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

	public static int proc_0x00_07(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
	public static int proc_0x0(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;
		if (op == 0x07) {
			if (env != null && env.getProc() <= 1) {
				out.append("!!!80186!!!");
			}
			if (env != null && env.getProc() > 1) {

			}
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
			/*
			 * OR Reg,Reg 0000101woorrrmmm
			 * OR Reg,Mem 0000101woorrrmmm
			 */
			// out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
			out.append("OR  ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
		} else if (op == 0x06) {
			/* OR Acc,Imm 0000110w */
			out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
			out.append("OR  ");
			if (w == 0) {
				out.append("AL, ");
				pos ++;
				out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 2, ' '));
			} else {
				out.append("AX, ");
				pos += 2;
				out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
				out.append(Strings.format2(UInteger.fmtHex(buf[pos - 1], 2).toUpperCase(), 18, ' '));
			}

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
	public static int proc_0x1(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		//int w = (buf[i]) & 0x0F;
		if (op < 0x03) {
			/*
			 * ADC Reg,Reg 0001001woorrrmmm
			 * ADC Reg,Mem 0001001woorrrmmm
			 */
			out.append("ADC ");
		} else {
			out.append("SBB ");
		}
		pos ++;
		pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);

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

	public static int proc_0x2(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		// int w =   buf[pos] & 0x01;
		int w = (buf[pos]) & 0x0F;
		if(w == 0x0E) {
			out.append("CS:"); /* CS段覆盖前缀码 */
		} else if(w == 0x06) {
			out.append("ES:"); /* ES段覆盖前缀码 */
		} else if (w < 0x03) {
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
	public static int proc_0x3(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;
		int low4 = (buf[pos]) & 0x0F;

		if (low4 == 0x06) {
			/* SS:   00110110 */
			out.append("SS:"); /* SS段覆盖前缀码 */
		} else if (low4 == 0x7) {
			/* AAA   00110111 */
			out.append("AAA");
		} else if (low4 == 0x0E) {
			/* DS   00111110 */
			out.append("DS:");/* DS段覆盖前缀码 */
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
			out.append("CMP ");
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
	public static int proc_0x4(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
	public static int proc_0x5(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
	public static int proc_0x6(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (env != null && env.getProc() == 0) {
			out.append("!!!8086!!!");
		}
		if (env != null && env.getProc() > 2) {
			if (op == 0) {
				if (w == 0) {
					/* PUSHAD   01100000*/
					out.append("PUSHAD ");
				} else {
					/* POPAD   01100001 */
					out.append("POPAD ");
				}
			}
			if (op == 1) {
				if (w == 0) {
					/* BOUND Reg32,Mem64 01100010oorrrmmm */
					out.append("BOUND ");
				} else {

				}
			}
			if (op == 2) {
				if (w == 0) {
					/* FS:   01100100 */
					out.append("FS: "); /* FS段覆盖前缀码64H */
				} else {
					/* GS:   01100101 */
					out.append("GS "); /* GS段覆盖前缀码65H */
				}
			}
			if (op == 3) {
				if (w == 0) {
					// out.append(""); /* 前缀码66H:用于在16位与32位操作数切换 */
				} else {
					// out.append(""); /* 前缀码67H:用于在16位与32位地址切换 */
				}
			}
			if (op == 4) {
				if (w == 0) {
					/* PUSHD Imm32 01101000 */
					out.append("PUSHD ");
				} else {

				}
			}
			if (op == 6) {
				if (w == 1) {
					/* INSD   01101101 */
					out.append("INSD ");
				} else {

				}
			}
			if (op == 7) {
				if (w == 1) {
					/* OUTSD   01101111 */
					out.append("OUTSD ");
				} else {

				}
			}
		}
		if (env != null && env.getProc() > 1) {
			if (op == 1 && w == 1) {
				/* ARPL Reg16,Reg16 01100011oorrrmmm
				ARPL Mem16,Reg16 01100011oorrrmmm */
				out.append("ARPL ");
				pos ++;
				pos = get_w_oo_rrr_mmm_dir(buf, pos, 1, 0, out);
			} else if (op == 4 && w == 0) {
				/* PUSHW Imm16 01101000 */
				out.append("PUSHW ");
			} else {
				out.append("!!!80286!!!");
			}
		}
		if (env != null && env.getProc() > 0) {
			if (op == 0) {
				if (w == 0) {
					/* PUSHA   01100000 */
					out.append("PUSHA ");
				} else {
					/* POPA   01100001 */
					out.append("POPA ");
				}
			} else if (op == 1) {
				if (w == 0) {
					/* BOUND Reg16,Mem32 01100010oorrrmmm */
					out.append("BOUND ");
					pos ++;
					pos = get_w_oo_rrr_mmm_dir(buf, pos, 1, 0, out);
				} else {
					out.append("!!!80186!!!");
				}
			} else if (op == 4) {
				if (w == 0) {
					/*
					 * IMUL RegWord,RegWord,Imm 01101001oorrrmmm
					 * IMUL RegWord,MemWord,Imm 01101001oorrrmmm
					 * IMUL RegWord,Imm         0110100111rrrqqq
					 * PUSH Imm 01101000
					*/
					out.append("PUSH ");
					pos ++;
					out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 2, '0'));
				} else {
					out.append("IMUL ");
				}
			} else if (op == 5) {
				if (w == 0) {
					/*
					 * IMUL RegWord,RegWord,Imm8 01101011oorrrmmm
					 * IMUL RegWord,MemWord,Imm8 01101011oorrrmmm
					 * IMUL RegWord,Imm8 0110101111rrrqqq
					 * PUSH Imm8 01101010
					*/
					out.append("PUSH ");
					pos ++;
					out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 2, '0'));
				} else {
					out.append("IMUL ");
				}
			} else if (op == 6) {
				if (w == 0) {
					/* INSB   01101100 */
					out.append("INSB ");
				} else {
					/* INSW   01101101 */
					out.append("INSW ");
				}
			} else if (op == 7) {
				if (w == 0) {
					/* OUTSB   01101110 */
					out.append("OUTSB");
				} else {
					/* OUTSW   01101111 */
					out.append("OUTSW ");
				}
			} else {
				out.append("!!!80186!!!");
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
	public static int proc_0x7(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
	public static int proc_0x8(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
			if (rrr == 0x01) {
				/* OR Reg,Imm8 1000001woo001mmm */
				/* OR Mem,Imm8 1000001woo001mmm */
				/* OR Reg,Imm 1000000woo001mmm */
				/* OR Mem,Imm 1000000woo001mmm */
				out.append("OR ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
			if (rrr == 0x02) {
				/* ADC Reg,Imm8 1000001woo010mmm */
				/* ADC Mem,Imm8 1000001woo010mmm */
				/* ADC Reg,Imm 1000000woo010mmm */
				/* ADC Mem,Imm 1000000woo010mmm */
				out.append("ADC ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
			if (rrr == 0x03) {
				/*
				 * SBB Reg,Imm8 1000001woo011mmm
				 * SBB Mem,Imm8 1000001woo011mmm
				 * SBB Reg,Imm 1000000woo011mmm
				 * SBB Mem,Imm 1000000woo011mmm
				 */
				out.append("SBB");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
			if (rrr == 0x04) {
				/*
				 * AND Reg,Imm8 1000001woo100mmm
AND Mem,Imm8 1000001woo100mmm
AND Reg,Imm 1000000woo100mmm
AND Mem,Imm 1000000woo100mmm
				 */
				out.append("AND ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
			if (rrr == 0x05) {
				/* SUB Reg,Imm8 1000001woo101mmm */
				/* SUB Mem,Imm8 1000001woo101mmm */
				/* SUB Reg,Imm  1000000woo101mmm */
				/* SUB Mem,Imm  1000000woo101mmm */
				out.append("SUB ");
				pos ++;
				// System.out.println("-------test-------");
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
			if (rrr == 0x06) {
				/*
				 * XOR Reg,Imm8 1000001woo110mmm
XOR Mem,Imm8 1000001woo110mmm
XOR Reg,Imm 1000000woo110mmm
XOR Mem,Imm 1000000woo110mmm
				 */
				out.append("XOR ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
			if (rrr == 0x07) {
				/*
				 * CMP Reg,Imm8 1000001woo111mmm
CMP Mem,Imm8 1000001woo111mmm
CMP Reg,Imm 1000000woo111mmm
CMP Mem,Imm 1000000woo111mmm
				 */
				out.append("CMP ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
			}
		} else if (op == 0x2) {
			/*
			 * TEST Reg,Reg 1000010woorrrmmm
			 * TEST Mem,Reg 1000010woorrrmmm
			 * TEST Reg,Mem 1000010woorrrmmm
			 */
			out.append("TEST ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
		} else if (op == 0x3) {
			/*
			 * XCHG Reg,Reg 1000011woorrrmmm
			 * XCHG Mem,Reg 1000011woorrrmmm
			 * XCHG Reg,Mem 1000011woorrrmmm
			 */
			out.append("XCHG ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
		} else if (op == 0x4) {
			/* MOV Mem,Reg 1000100woorrrmmm
*/
			out.append("MOV ");
			pos ++;
			pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 1, out);
		} else if (op == 0x5) {
			/*
			 * MOV Reg,Reg 1000101woorrrmmm
			 * MOV Reg,Mem 1000101woorrrmmm
			 */
			out.append("MOV ");
			pos ++;
			pos =get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
		} else if (op == 0x06) {
			if (w == 0) {
				/* MOV Reg16,Seg 10001100oosssmmm */
				/* MOV Mem16,Seg 10001100oosssmmm */
				out.append("MOV ");
				pos ++;
				pos = get_oo_sss_mmm_dir(buf, pos, out);
			} else {
				/* LEA RegWord,Mem 10001101oorrrmmm */
				out.append("LEA ");
				pos ++;
				pos = get_w_oo_rrr_mmm_dir(buf, pos, 1, 0, out);
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
				pos = get_w_oo_mmm_dir(buf, pos, 0, 0, 1, out);
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
	public static int proc_0x9(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
	public static int proc_0xA(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (op == 0) {
			/* MOV Acc,MemOfs 1010000w */
			out.append("MOV ");
			out.append(w == 1 ? "AX" : "AL");
			out.append(", [");
			out.append(Strings.format(Integer.toHexString(buf[pos + 2]).toUpperCase(), 2, '0'));
			out.append(Strings.format(Integer.toHexString(buf[pos + 1]).toUpperCase(), 2, '0'));
			out.append("H]");
			pos += 2;
		}
		if (op == 1) {
			/* MOV MemOfs,Acc 1010001w */
			out.append("MOV [");
			out.append(Strings.format(Integer.toHexString(buf[pos + 2]).toUpperCase(), 2, '0'));
			out.append(Strings.format(Integer.toHexString(buf[pos + 1]).toUpperCase(), 2, '0'));
			out.append("H], ");
			out.append(w == 1 ? "AX" : "AL");
			pos += 2;
		}
		if (op == 2) {
			if (w == 0) {
				out.append("MOVSB ");
			} else {
				out.append("MOVSW " + ", ");
			}
		}
		if (op == 3) {
			if (w == 0) {
				out.append("CMPSB ");
			} else {
				out.append("CMPSW ");
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
				/* LODSB   10101100*/
				out.append("LODSB ");
			} else {
				/* LODSW   10101101
				 * LODSD   10101101 */
				out.append("LODSW ");
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
	public static int proc_0xB(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		// int op = (buf[pos] >> 1) & 0x07;

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
		for (byte by : imm) {
			out.append(Strings.format(Integer.toHexString(by).toUpperCase(), 2, '0'));
		}
		out.append("H");

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
	public static int proc_0xC(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (op == 0x00) {
			if (env != null && env.getProc() == 0) {
				out.append("!!!8086!!!");
			} else {
				int q = (buf[pos + 1] >> 3) & 0x07;
				if (q == 0) {
					/*
					 * ROL Reg,Imm8 1100000woo000mmm
					 * ROL Mem,Imm8 1100000woo000mmm
					 */
					out.append("ROL ");
					pos ++;
					pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
				}
				if (q == 1) {
					/*
					 * ROR Reg,Imm8 1100000woo001mmm
					 * ROR Mem,Imm8 1100000woo001mmm
					 */
					out.append("ROR ");
					pos ++;
					pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
				}
				if (q == 2) {
					/*
					 * RCL Reg,Imm8 1100000woo010mmm
					 * RCL Mem,Imm8 1100000woo010mmm
					 */
					out.append("RCL ");
					pos ++;
					pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
				}
				if (q == 3) {
					/*
					 * RCR Reg,Imm8 1100000woo011mmm
					 * RCR Mem,Imm8 1100000woo011mmm
					 */
					out.append("RCR ");
					pos ++;
					pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
				}
				if (q == 4) {
					/*
					 * SAL Reg,Imm8 1100000woo100mmm
					 * SAL Mem,Imm8 1100000woo100mmm
					 * SHL Reg,Imm8 1100000woo100mmm
					 * SHL Mem,Imm8 1100000woo100mmm
					 */
					out.append("SAL ");
					pos ++;
					pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
				}
				if (q == 5) {
					/*
					 * SHR Reg,Imm8 1100000woo101mmm
					 * SHR Mem,Imm8 1100000woo101mmm
					 */
					out.append("SHR ");
					pos ++;
					pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
				}
				if (q == 7) {
					/*
					 * SAR Reg,Imm8 1100000woo111mmm
					 * SAR Mem,Imm8 1100000woo111mmm
					 */
					out.append("SAR ");
					pos ++;
					pos = get_w_oo_mmm_dir(buf, pos, w, 0, 2, out);
				}
			}
		}
		if (op == 0x01) {
			/* RET NEAR 11000011
			 * RET imm NEAR 11000010
			 */
			out.append("RET ");
		}
		if (op == 0x02) {
			if (env != null && env.getProc() >= 3) {
				/* LDS Reg32,Mem64 11000101oorrrmmm
				 * LES Reg32,Mem64 11000100oorrrmmm */
			} else if (env != null && env.getProc() >= 0) {
				/*
				 * LDS Reg16,Mem32 11000101oorrrmmm
				 * LES Reg16,Mem32 11000100oorrrmmm
				 */
				out.append(((buf[pos] & 0x01) == 0x01 ? "LDS " : "LES "));
				pos ++;
				// System.out.println("TEST============================= begin");
				pos = get_w_oo_rrr_mmm_dir(buf, pos, w, 0, out);
				// System.out.println("TEST============================= end");
			}
		}

		if (op == 0x03) {
			/* MOV Mem,Imm 1100011woo000mmm */
			int q = (buf[pos + 1] >> 3) & 0x07;
			if (q == 0) {
				out.append("MOV ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, 0, 0, 2, out);
			} else {
				System.out.println("!!!WARNING!!!" + UInteger.fmtHex(buf[pos], 2) + " " + UInteger.fmtHex(buf[pos + 1], 2));
				pos ++;
			}
		}

		if (op == 0x04) {
			if (env != null && env.getProc() == 0) {
				out.append("!!!8086!!!");
			} else {
				if (w == 0) {
					/* ENTER Imm16,Imm8 11001000 */
					out.append("ENTER ");
				} else {
					/* LEAVE   11001001 */
					out.append("LEAVE ");
				}
			}
		}
		if (op == 0x05) {
			out.append("RET ");
			if (w == 0) {
				/* RET imm FAR 11001010 */
				pos ++;
				out.append(Strings.format(Integer.toHexString(buf[pos]).toUpperCase(), 2, '0'));
				out.append("H FAR");
			} else {
				/* RET FAR 11001011 */
				out.append("FAR");
			}

		}
		if (op == 0x06) {
			/* INT 3 11001100
			 * INT Imm8 11001101
			 */
			out.append("INT ");
			if (w ==0) {
				out.append("03H");
			} else {
				pos ++;
				out.append(Strings.format(Integer.toHexString(buf[pos]).toUpperCase(), 2, '0'));
				out.append("H");
			}
		}
		if (op == 0x07) {
			if (w ==0) {
				out.append("INTO ");
			} else {
				if (env != null && env.getProc() >= 3) {
					/* IRETD   11001111 */
					out.append("IRETD ");
				} else {
					/* IRET   11001111 */
					out.append("IRET ");
				}
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
	public static int proc_0xD(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
				out.append("AAM ");
				if (env != null && env.getProc() >= 5) {
					/* AAM Imm8 11010100 */
					pos ++;
					out.append(Strings.format(Integer.toHexString(buf[pos]).toUpperCase(), 2, '0'));
					out.append("H");
				} else {
					/* AAM      1101010000001010 */
					if (buf[pos + 1] == 0x0A) {
					} else {
						out.append("!!!>=Pentium!!!");
					}
				}
			} else {
				out.append("AAD");
				if (env != null && env.getProc() >= 5) {
					/* AAD Imm8 11010101 */
					pos ++;
					out.append(Strings.format(Integer.toHexString(buf[pos]).toUpperCase(), 2, '0'));
					out.append("H");
				} else {
					/* AAD      1101010100001010 */
					if (buf[pos + 1] == 0x0A) {
					} else {
						out.append("!!!>=Pentium!!!");
					}
				}
			}
		}
		if (op == 3) {
			if (w == 0) {
				/* SALC   11010110 */
				if (env != null && env.getProc() >= 6) {
					out.append("SALC ");
				} else {
					out.append("!!!>=Pentium Pro!!!");
				}
			} else {
				/* XLAT   11010111 */
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
	public static int proc_0xE(byte[] buf, int pos, int core, StringBuffer out, Env env) {
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
				out.append("H");
				pos ++;
			}
			if (w == 0x01) {
				/* LOOPZ Short 11100001 */
				/* LOOPE Short 11100001 */
				out.append("LOOPZ SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				out.append("H");
				pos ++;
			}
		} else if (op == 0x01) {
			if (w == 0x00) {
				/* LOOP Short 11100010 */
				out.append("LOOP SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				out.append("H");
				pos ++;
			}
			if (w == 0x01) {
				/* JCXZ Short 11100011 */
				/* JCXE Short 11100011 */
				/* JECXZ Short 11100011 */
				/* JECXE Short 11100011 */
				out.append("JCXZ SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				out.append("H");
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
			out.append("H");
			pos ++;
		}
		else if (op == 0x03) {
			/* OUT Imm8,Acc 1110011w */
			out.append("OUT ");
			out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
			out.append("H");
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
				out.append("H");
				pos += 2;
			}
			if (w == 1) {
				/* JMP Near 11101001 */
				out.append("JMP NEAR ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				out.append("H");
				pos ++;
			}
		} else if (op == 0x05) {
			if (w == 0x00) {
				/* JMP Far 11101010 */
				out.append("JMP FAR   ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				out.append("H");
				pos ++;
			}
			if (w == 0x01) {
				/* JMP Short 11101011 */
				out.append("JMP SHORT ");
				out.append(Strings.format(Integer.toHexString(pos + 2 + buf[pos + 1]).toUpperCase(), 8, '0'));
				out.append("H");
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
	public static int proc_0xF(byte[] buf, int pos, int core, StringBuffer out, Env env) {
		out.append(Strings.format(Integer.toHexString(pos).toUpperCase(), 8, '0'));
		out.append(" ");
		out.append(Strings.format2(UInteger.fmtHex(buf[pos], 2).toUpperCase(), 18, ' '));
		int start = pos;
		int op = (buf[pos] >> 1) & 0x07;
		int w =   buf[pos] & 0x01;

		if (op == 0x00) {
			out.append("LOCK "); /* 前缀码：用于互斥访问共享内存的操作 */
		}
		if (op == 0x01) {
			if (w == 0) {
				out.append("REPNE ");/* 前缀码：用于字符串操作指令 */
			} else {
				out.append("REP ");/* 前缀码：用于字符串操作指令 */
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
				pos = get_w_oo_mmm_dir(buf, pos, 0, 0, 2, out);
			}
			if (q == 2) {
				out.append("NOT ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, 0, 0, 1, out);
			}
			if (q == 3) {
				out.append("NEG ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, 0, 0, 1, out);
			}
			if (q == 4) {
				/* MUL Reg 1111011woo100mmm
				 * MUL Mem 1111011woo100mmm */
				// System.out.println("-------------------------------");
				out.append("MUL ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 5) {
				out.append("IMUL ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 6) {
				out.append("DIV ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 7) {
				out.append("IDIV ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
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
				/*
				 * INC Reg 1111111woo000mmm
				 * INC Mem 1111111woo000mmm
				 */
				// System.out.println("------------------test---------------------------");
				out.append("INC ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 1) {
				out.append("DEC ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 2) {
				out.append("CALL ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 3) {
				out.append("CALL ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 4) {
				out.append("JMP ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 5) {
				out.append("JMP ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
			}
			if (q == 6) {
				out.append("PUSH ");
				pos ++;
				pos = get_w_oo_mmm_dir(buf, pos, w, 0, 1, out);
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
		Env env = new Env();

		env.setProc(03);
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
				i = proc_0x00_06(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight2 == 0x00 && low3 == 0x07) {
				StringBuffer sbf = new StringBuffer();
				i = proc_0x00_07(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x00) {
				/* TODO:0x0* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x0(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x01) {
				/* TODO:0x1* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x1(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x02) {
				/* TODO:0x2* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x2(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x03) {
				/* TODO:0x3* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x3(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x04) {
				/* TODO:0x4* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x4(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x05) {
				/* TODO:0x5* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x5(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x06) {
				/* TODO:0x6* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x6(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x07) {
				/* TODO:0x7* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x7(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x08) {
				/* TODO:0x8* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x8(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x09) {
				/* TODO:0x9* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0x9(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x0A) {
				/* TODO:0xA* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xA(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x0B) {
				/* TODO:0xB* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xB(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x0C) {
				/* TODO:0xC* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xC(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x0D) {
				/* TODO:0xD* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xD(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x0E) {
				/* TODO:0xE* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xE(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else if (hight4 == 0x0F) {
				/* TODO:0xF* */
				StringBuffer sbf = new StringBuffer();
				i = proc_0xF(buf, i, core, sbf, env);
				System.out.print(sbf);
			} else {
				System.out.println(
					Strings.format(Integer.toHexString(i).toUpperCase(), 8, '0') + " " +
					Strings.format2(UInteger.fmtHex(buf[i], 2).toUpperCase(), 18, ' ') + "??? ");
			}
		}
	}
}
