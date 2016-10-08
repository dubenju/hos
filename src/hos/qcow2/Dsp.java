package hos.qcow2;

import hos.fat.BootSector;
import hos.fat.MasterBootSector;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;

import javay.util.UBytes;

public class Dsp {

    public static void main(String[] args)  throws Exception {
        Dsp proc = new Dsp();
//        proc.test(args[0]);
//        proc.test(".\\tools\\qemu\\qemu_img\\qcow2m_create.qcow2");
//        proc.test(".\\tools\\qemu\\qemu_img\\qcow2m_fdisk.qcow2");
        proc.test(".\\tools\\qemu\\qemu_img\\format\\qcow2_600m.qcow2");
    }
    public void test(String file) throws Exception {
        System.out.println(file);
        QcowHeader qcow2header = null;
        int bytesum = 1;
        int byteread = 0;
        int readed = 72;

        FileInputStream is = new FileInputStream(file);
//        ByteArrayInputStream bais = new ByteArrayInputStream(is);
        if (!is.markSupported()) {
            System.out.println("★★★★★mark/reset not supported!");
        }
        is.mark(Integer.MAX_VALUE);
        // Header
        byte[] buf = new byte[readed];
        if ( (byteread = is.read(buf)) == -1) {
            System.out.println("read error Header(72bytes)");
            is.close();
            System.out.println("read=" + bytesum);
            return ;
        }
        qcow2header = new QcowHeader(buf);
        System.out.println("Qcow2Header=" + qcow2header);
        System.out.println("L1 Offset=" + qcow2header.getL1TblOff());
        System.out.println("L1 size  =" + qcow2header.getL1TblSize());
        System.out.println("Level1 管理着每个Level2的起始地址。");
        buf = new byte[(int) (qcow2header.getL1TblOff() - readed)];
        if ( (byteread = is.read(buf)) == -1) {
            System.out.println("read error Header");
            is.close();
            System.out.println("read=" + bytesum);
            return ;
        }
        readed = (int) qcow2header.getL1TblOff();

        // Level 1
        buf = new byte[8 * qcow2header.getL1TblSize()];
        if ( (byteread = is.read(buf)) == -1) {
            System.out.println("read error L1");
            is.close();
            System.out.println("read=" + bytesum);
            return ;
        }
        System.out.println("Level1:" + UBytes.toHexString(buf));
        readed += (8 * qcow2header.getL1TblSize());
        // 1xxx QCOW_OFLAG_COPIED
        // x1xx QCOW_OFLAG_COMPRESSED
        byte a = (byte) (buf[0] & 0x3F);
        buf[0] = a;
        byte[] bf = new byte[8];
        System.arraycopy(buf, 0, bf, 0, bf.length);
        long l2Offset = UBytes.be64Tolong(bf);
        System.out.println("Level1:l2Offset=" + l2Offset);

        // refcount table
        System.out.println("refcount Offset=" + qcow2header.getRefCntTblOff());
        // System.out.println("readed=" + readed);
        buf = new byte[(int) (qcow2header.getRefCntTblOff() - readed)];
        if ( (byteread = is.read(buf)) == -1) {
            System.out.println("read error L1");
            is.close();
            System.out.println("read=" + bytesum);
            return ;
        }
        System.out.println("引用计数表管理着每个引用计数块的起始地址。");
        readed = (int) qcow2header.getRefCntTblOff();
        int cnt = qcow2header.getRefcntTblCnt();
        int refblock_offset = -1;
        for (int i = 0; i < cnt; i ++) {
            buf = new byte[8];
            if ( (byteread = is.read(buf)) == -1) {
                System.out.println("read error refcount ");
                is.close();
                System.out.println("read=" + bytesum);
                return ;
            }
            readed += 8;
            System.out.println(UBytes.toHexString(buf));
            if (UBytes.be64Tolong(buf) != 0) {
                refblock_offset = (int) UBytes.be64Tolong(buf);
            } else {
                break ;
            }
        }
        // refcount block
        if (refblock_offset > 0) {
        	System.out.println("refblock Offset=" + refblock_offset);
        	System.out.println("引用计数块标记着从镜像文件头开始每个簇的使用情况。");
	        buf = new byte[(int) (refblock_offset - readed)];
	        if ( (byteread = is.read(buf)) == -1) {
	            System.out.println("read error refblock");
	            is.close();
	            System.out.println("read=" + bytesum);
	            return ;
	        }
	        System.out.println("l2Offset=" + l2Offset + ",refblock_offset=" + refblock_offset);
	        readed = (int) refblock_offset;
	        buf = new byte[(int) (l2Offset - refblock_offset)];
	        if ( (byteread = is.read(buf)) == -1) {
	            System.out.println("read error refblock");
	            is.close();
	            System.out.println("read=" + bytesum);
	            return ;
	        }
	        readed = (int) l2Offset;
        }

        // Level 2
        System.out.println("Level 2 Offset:" + l2Offset + "," + Long.toHexString(l2Offset));
        ArrayList<Long> lstL2 = new ArrayList<Long>();
        int dataOffset = -1;
        cnt = qcow2header.getL2TblSize();
        for (int i = 0; i < cnt; i ++) {
            buf = new byte[8];
            if ( (byteread = is.read(buf)) == -1) {
                System.out.println("read error level2 ");
                is.close();
                System.out.println("read=" + bytesum);
                return ;
            }
            readed += 8;
            System.out.println("1:" + UBytes.toHexString(buf));
            if (UBytes.be64Tolong(buf) != 0) {
                // 1xxx QCOW_OFLAG_COPIED
                // x1xx QCOW_OFLAG_COMPRESSED
                a = (byte) (buf[0] & 0x3F);
                buf[0] = a;
//                System.out.println("2:" + UBytes.toHexString(buf));
                if (dataOffset < 0) {
                	dataOffset = (int) UBytes.be64Tolong(buf);
                }
                lstL2.add(UBytes.be64Tolong(buf));
            } else {
                lstL2.add(0L);
            }
        }

        // data
        System.out.println("dataOffset=" + dataOffset);
        MasterBootSector mbs = null;
        if (dataOffset > 0) {
        	System.out.println("dataOffset Offset=" + dataOffset);
	        buf = new byte[(int) (dataOffset - readed)];
	        if ( (byteread = is.read(buf)) == -1) {
	            System.out.println("read error refblock");
	            is.close();
	            System.out.println("read=" + bytesum);
	            return ;
	        }
	        readed = (int) dataOffset;
	        buf = new byte[512];
	        if ( (byteread = is.read(buf)) == -1) {
	            System.out.println("read error refblock");
	            is.close();
	            System.out.println("read=" + bytesum);
	            return ;
	        }
	        readed += 512;
	        mbs = new MasterBootSector(buf);
	        System.out.println(mbs);
	        writeToFile(".\\000.mbr\\mbs.bin", buf);
//	        BootSector bs = new BootSector(buf);
//	        System.out.println(bs);
        }

        if (lstL2.size() > 1) {
        	int rs= mbs.getFirstPartitionTableEntry().getRelativeSector();

            int idx = rs / 8;
            int offset = rs % 8;
            System.out.println(rs + "," + idx + "," + offset);
            int bsUnitOffset = lstL2.get(idx).intValue();
            int bsOffset = bsUnitOffset + 512 * offset;
            System.out.println("BootSectorOffset=" + bsUnitOffset + "," + bsOffset + "," + Integer.toHexString(bsOffset));

            if(is.markSupported()) {
	            is.reset();
            } else {
            	is.close();
            	is = null;
            	is = new FileInputStream(file);
            }

	        buf = new byte[bsOffset];
	        if ( (byteread = is.read(buf)) == -1) {
	            System.out.println("read error bootsector");
	            is.close();
	            System.out.println("read=" + bytesum);
	            return ;
	        }
	        readed = bsOffset;
	        buf = new byte[512];
	        if ( (byteread = is.read(buf)) == -1) {
	            System.out.println("read error bootsector");
	            is.close();
	            System.out.println("read=" + bytesum);
	            return ;
	        }
	        readed += 512;
	        BootSector bs = new BootSector(buf);
	        System.out.println(bs);
	        writeToFile(".\\000.mbr\\boots.bin", buf);
//	        BootSector bs = new BootSector(buf);
//	        System.out.println(bs);

        }
        is.close();
    }
    public static void writeToFile(String fileName, byte[] in) throws Exception {
    	FileOutputStream os = new FileOutputStream(fileName);
    	os.write(in);
    	os.close();
    }
}
