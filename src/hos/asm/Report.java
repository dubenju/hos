package hos.asm;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

import javay.util.UBytes;

public class Report {
	public static String nasm_work_dir = "C:/Users/DBJ/git/hos/000.mbr/asm/";
	public static String masm_work_dir = "C:/Users/DBJ/git/hos/001.vbr/asm/";

	public static void make_report(String cmd, String context) {
		String src_file = cmd.toLowerCase() + "_" + context.toLowerCase();
		String nasm_src = readSrcFileByLines(nasm_work_dir + cmd + "/" + src_file + ".asm");
		String nasm_bin = readFileByBytes(nasm_work_dir + cmd + "/" + src_file + ".bin");
		String masm_src = readSrcFileByLines(masm_work_dir + cmd + "/" + src_file + ".asm");
		String masm_bin = readFileByBytes(masm_work_dir + cmd + "/" + src_file + ".com");
		System.out.println(nasm_src.substring(0, masm_src.indexOf(";")) + "\t" + nasm_bin + "\t" + masm_src.substring(0, masm_src.indexOf(";")) + "\t" + masm_bin);
	}

    /**
     * 以行为单位读取文件，常用于读面向行的格式化文件
     */
    public static String readSrcFileByLines(String fileName) {
    	String result = "";
        File file = new File(fileName);
        BufferedReader reader = null;
        try {
            // System.out.println("以行为单位读取文件内容，一次读一整行：");
            reader = new BufferedReader(new FileReader(file));
            String tempString = null;
            int line = 1;
            // 一次读入一行，直到读入null为文件结束
            while ((tempString = reader.readLine()) != null) {
            	if (tempString.indexOf(";  ★") >= 0) {
            		// 显示行号
            		// System.out.println("line " + line + ": " + tempString);
            		result = tempString;
            		break ;
            	}
                line++;
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e1) {
                }
            }
        }
        return result;
    }
    /**
     * 以字节为单位读取文件，常用于读二进制文件，如图片、声音、影像等文件。
     */
    public static String readFileByBytes(String fileName) {
        File file = new File(fileName);
        int file_size = (int) file.length();
        byte[] tempbytes = new byte[file_size];
        Arrays.fill(tempbytes, (byte) 0x00);

        InputStream in = null;
//        try {
//            //System.out.println("以字节为单位读取文件内容，一次读一个字节：");
//            // 一次读一个字节
//            in = new FileInputStream(file);
//            int tempbyte;
//            while ((tempbyte = in.read()) != -1) {
//                System.out.write(tempbyte);
//            }
//            in.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//            return UBytes.toHexString(tempbytes);
//        }

        try {
            //System.out.println("以字节为单位读取文件内容，一次读多个字节：");
            // 一次读多个字节

            int byteread = 0;
            in = new FileInputStream(fileName);
            // showAvailableBytes(in);
            // 读入多个字节到字节数组中，byteread为一次读入的字节数
            while ((byteread = in.read(tempbytes)) != -1) {
                // System.out.write(tempbytes, 0, byteread);
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e1) {
                }
            }
        }
        return UBytes.toHexString(tempbytes);
    }
    /**
     * 显示输入流中还剩的字节数
     */
    private static void showAvailableBytes(InputStream in) {
        try {
            System.out.println("当前字节输入流中的字节数为:" + in.available());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
