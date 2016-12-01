package hos.asm;

public class Env {

	private int proc;

	public Env() {
		this.proc = -1;
	}
	/**
	 * 00:8086
	 * 01:80186
	 * 02:80286
	 * 03:80386
	 * 04:80486
	 * 05:80586
	 * 06:80686 Pentium Pro
	 * @return proc
	 */
	public int getProc() {
		return proc;
	}

	/**
	 * 00:8086
	 * 01:80186
	 * 02:80286
	 * 03:80386
	 * 04:80486
	 * 05:80586
	 * 06:80686 Pentium Pro
	 * @param proc
	 */
	public void setProc(int proc) {
		this.proc = proc;
	}
}
