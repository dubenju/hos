package hos.asm;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStreamReader;

public class Run_Cmd {
	public static String nasm_work_dir = "C:/Users/DBJ/git/hos/000.mbr/asm/";
	public static String masm_work_dir = "C:/Users/DBJ/git/hos/001.vbr/asm/";

	public static void run(String type, String cmd, String context) throws Exception {
		String work_dir = nasm_work_dir;
		if ("masm".equalsIgnoreCase(type)) {
			work_dir = masm_work_dir;
		}
		File workDir = new File(work_dir + cmd.toLowerCase());
		if(workDir.exists() == false) {
			workDir.mkdir();
		}
		if (workDir.isDirectory() == false) {
			System.out.println(workDir + "is not a directory.");
			return ;
		}
		System.out.println("目录" + workDir + "创建完毕." + workDir.getAbsolutePath());


		String src_file_name = cmd.toLowerCase() + "_" + context.toLowerCase() + ".asm";
		System.out.println("源文件名:" + src_file_name);
		write_src(type, workDir.getAbsolutePath() + "/", src_file_name, cmd + " " + context);

		compile(type, workDir.getAbsolutePath() + "/", src_file_name);
	}

	public static void write_src(String type, String path, String fileName, String context) throws Exception {
		FileOutputStream os = new FileOutputStream(path + fileName);
		if ("nasm".equalsIgnoreCase(type)) {
			os.write(context.getBytes());
			os.write("  ;  ★\r\n".getBytes());
		}
		if ("masm".equalsIgnoreCase(type)) {
			os.write(".MODEL TINY\r\n".getBytes());
			os.write(".CODE\r\n".getBytes());
			os.write("ORG 100H\r\n".getBytes());
			os.write("START:\r\n".getBytes());
			os.write(context.getBytes());
			os.write("  ;  ★\r\nEND START\r\n".getBytes());
		}
		os.close();
	}
    public static void compile(String type, String path, String srcFile) {

        String file = srcFile.substring(0, srcFile.indexOf("."));
        String cmd = "C:/nasm/nasm.exe -o " + path + file + ".bin -f bin -l " + path + file + ".lst " + path + srcFile;
        if ("masm".equalsIgnoreCase(type)) {
        	cmd = "C:/masm32/bin/ml.exe /BlC:/masm32/bin/link16.exe " + path + srcFile;
        }

        System.out.println("编译命令行：" + cmd);
        Runtime run = Runtime.getRuntime();//返回与当前 Java 应用程序相关的运行时对象
        try {
            Process p = run.exec(cmd, null, new File(path));// 启动另一个进程来执行命令
            BufferedInputStream in = new BufferedInputStream(p.getInputStream());
            BufferedReader inBr = new BufferedReader(new InputStreamReader(in));
            String lineStr;
            while ((lineStr = inBr.readLine()) != null)
                //获得命令执行后在控制台的输出信息
                System.out.println(lineStr);// 打印输出信息
            //检查命令是否执行失败。
            if (p.waitFor() != 0) {
                if (p.exitValue() == 1)//p.exitValue()==0表示正常结束，1：非正常结束
                    System.err.println("命令执行失败!");
            }
            inBr.close();
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
