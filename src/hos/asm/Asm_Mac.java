package hos.asm;

public class Asm_Mac {

	public static void main(String[] args) throws Exception {
		/* 编译 */
		for(int i = 0; i < args.length; i ++) {
			String cmd = args[i].toUpperCase();
			System.out.println("[" + i + "]=" + cmd);
			String params = Cmd.getCmd(cmd);
			System.out.print("params = " + params);
			int param_cnt = Integer.parseInt(params);
			if (param_cnt == 1) {
				for(int j = 0; j < Reg.regs.length; j ++) {
					if (Reg.regs[j][0].length() > 0) {
						System.out.println(cmd + " " + Reg.regs[j][0]);
						Run_Cmd.run("nasm", cmd, Reg.regs[j][0]);
						Run_Cmd.run("masm", cmd, Reg.regs[j][0]);
					}
				} // for
			} // if
			if (param_cnt == 2) {

			}
		} // for
		/* 结果分析 */
		for(int i = 0; i < args.length; i ++) {
			String cmd = args[i].toUpperCase();
			String params = Cmd.getCmd(cmd);
			int param_cnt = Integer.parseInt(params);
			if (param_cnt == 1) {
				for(int j = 0; j < Reg.regs.length; j ++) {
					if (Reg.regs[j][0].length() > 0) {
						Report.make_report(cmd, Reg.regs[j][0]);
					}
				} // for
			} // if
			if (param_cnt == 2) {

			}
		}
	} // main

}
