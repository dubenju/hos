package hos.asm;

public class Cmd {
	public static String[][] cmds = {
		{"INC", "1", ""},
		{"", "", ""}
	};
	public static String getCmd(String cmd) {
		String result = "";
		for(int i = 0; i < cmds.length; i ++) {
			if (cmd.equals(cmds[i][0])) {
				result = cmds[i][1];
				break;
			}
		}
		return result;
	}
}
