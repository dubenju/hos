package hos.qcow2;

import javay.util.UBytes;

public class QcowHeader {
    private byte[] head;
    private byte[] magic = new byte[4];  // 4
    private byte[] version = new byte[4]; // 4 版本号
    private byte[] backing_file_offset = new byte[8]; // 8 开始偏移
    private byte[] backing_file_size = new byte[4]; // 4
    private byte[] cluster_bits = new byte[4]; // 4
    private int clusterBits = -1;
    private byte[] size = new byte[8]; /* in bytes */ // 8
    private byte[] crypt_method = new byte[4]; // 4
    private byte[] l1_size = new byte[4]; // 4
    private int l1Size = -1;
    private byte[] l1_table_offset = new byte[8]; // 8
    private long l1TblOff = -1;
    private byte[] refcount_table_offset = new byte[8]; // 8
    private long refCntTblOff = -1;
    private byte[] refcount_table_clusters = new byte[4]; // 4
    private int refcntTblClu = -1;
    private byte[] nb_snapshots = new byte[4]; // 4
    private byte[] snapshots_offset = new byte[8]; // 8

    public QcowHeader(byte[] in) {
        this.head          = new byte[in.length];
        System.arraycopy(in, 0, head, 0, in.length);
        int offset = 0;
        System.arraycopy(in, offset, magic, 0, magic.length);
        offset += magic.length;
        System.arraycopy(in, offset, version, 0, version.length);
        offset += version.length;
        System.arraycopy(in, offset, backing_file_offset, 0, backing_file_offset.length);
        offset += backing_file_offset.length;
        System.arraycopy(in, offset, backing_file_size, 0, backing_file_size.length);
        offset += backing_file_size.length;

        System.arraycopy(in, offset, cluster_bits, 0, cluster_bits.length);
        clusterBits = (
                (cluster_bits[0] << 24) |
                (cluster_bits[1] << 16) |
                (cluster_bits[2] << 8) |
                 cluster_bits[3]);
        offset += cluster_bits.length;
        System.arraycopy(in, offset, size, 0, size.length);
        offset += size.length;
        System.arraycopy(in, offset, crypt_method, 0, crypt_method.length);
        offset += crypt_method.length;
        System.arraycopy(in, offset, l1_size, 0, l1_size.length);
        offset += l1_size.length;
        l1Size = (
                (l1_size[0] << 24) |
                (l1_size[1] << 16) |
                (l1_size[2] << 8) |
                 l1_size[3]);

        System.arraycopy(in, offset, l1_table_offset, 0, l1_table_offset.length);
        offset += l1_table_offset.length;
        l1TblOff = (
                (l1_table_offset[0] << 56) |
                (l1_table_offset[1] << 48) |
                (l1_table_offset[2] << 40) |
                (l1_table_offset[3] << 32) |
                (l1_table_offset[4] << 24) |
                (l1_table_offset[5] << 16) |
                (l1_table_offset[6] <<  8) |
                 l1_table_offset[7]);
        System.arraycopy(in, offset, refcount_table_offset, 0, refcount_table_offset.length);
        offset += refcount_table_offset.length;
        refCntTblOff = (
                (refcount_table_offset[0] << 56) |
                (refcount_table_offset[1] << 48) |
                (refcount_table_offset[2] << 40) |
                (refcount_table_offset[3] << 32) |
                (refcount_table_offset[4] << 24) |
                (refcount_table_offset[5] << 16) |
                (refcount_table_offset[6] <<  8) |
                 refcount_table_offset[7]);
        System.arraycopy(in, offset, refcount_table_clusters, 0, refcount_table_clusters.length);
        offset += refcount_table_clusters.length;
        refcntTblClu =  (
                (refcount_table_clusters[0] << 24) |
                (refcount_table_clusters[1] << 16) |
                (refcount_table_clusters[2] << 8) |
                 refcount_table_clusters[3]);

        System.arraycopy(in, offset, nb_snapshots, 0, nb_snapshots.length);
        offset += nb_snapshots.length;
        System.arraycopy(in, offset, snapshots_offset, 0, snapshots_offset.length);
        offset += snapshots_offset.length;
    }
    public String toString() {
        System.out.println(UBytes.toHexString(this.head));
        StringBuffer buf = new StringBuffer();
        buf.append("\n--------------------------------------------");
        buf.append("\nmagic:");
        // System.out.println(UBytes.toHexString(this.magic));
        buf.append(UBytes.toHexString(this.magic));
        buf.append("\n版本号:");
        //System.out.println(UBytes.toHexString(this.version));
        buf.append(UBytes.toHexString(this.version));
        buf.append("\nbacking_file开始偏移:");
        // System.out.println(UBytes.toHexString(this.backing_file_offset));
        buf.append(UBytes.toHexString(this.backing_file_offset));
        buf.append("\nbacking_file大小:");
        // System.out.println(UBytes.toHexString(this.backing_file_size));
        buf.append(UBytes.toHexString(this.backing_file_size));

        buf.append("\ncluster_bits字段，决定了怎样映射镜像偏移地址到文件偏移地址，其决定了在一个簇中，将拿偏移地址的多少位(低位)来作为索引。:");
        //System.out.println(UBytes.toHexString(this.cluster_bits));
        //System.out.println("簇Bits:" + (clusterBits));
        //System.out.println("簇大小(字节):" + (1 << clusterBits));
        //System.out.println("簇扇区:" + (1 << (clusterBits - 9)));
        //System.out.println("Level2Bits:" + (clusterBits - 3));
        //System.out.println("Level2大小(字节):" + (1 << ( clusterBits - 3)));

        buf.append("\n簇Bits:" + (clusterBits));
        buf.append("\n簇大小(字节):" + (1 << clusterBits));
        buf.append("\n簇扇区:" + (1 << (clusterBits - 9)));
        buf.append("\nLevel2Bits:" + (clusterBits - 3));
        buf.append("\nLevel2大小(8字节):" + (1 << ( clusterBits - 3)));
        buf.append("\nL2 is always one cluster");

        buf.append(UBytes.toHexString(this.cluster_bits));
        buf.append("\n大小(镜像以块设备呈现时的大小，单位字节；):");
        // System.out.println(UBytes.toHexString(this.size));
        buf.append(UBytes.toHexString(this.size));
        buf.append("\nAES加密:");
        // System.out.println(UBytes.toHexString(this.crypt_method));
        buf.append(UBytes.toHexString(this.crypt_method));

        buf.append("\nL1 表表项个数,在L1表中，可用的8字节项的个数:");
        // System.out.println(UBytes.toHexString(this.l1_size));
        buf.append(UBytes.toHexString(this.l1_size));
        buf.append("\n" + l1Size);
        buf.append("\nL1 表开始偏移:");
        //System.out.println(UBytes.toHexString(this.l1_table_offset));
        // System.out.println(l1TblOff);
        buf.append(UBytes.toHexString(this.l1_table_offset));
        buf.append("=" + l1TblOff);
        buf.append("\n引用计数refcount 表偏移:");
        // System.out.println(UBytes.toHexString(this.refcount_table_offset));
        buf.append(UBytes.toHexString(this.refcount_table_offset));
        buf.append(",refcount_table_offset指定了refcount表相对起始位置的偏移值");
        buf.append("\n引用计数以 cluster 为单位的 refcount 表的大小:");
        // System.out.println(UBytes.toHexString(this.refcount_table_clusters));
        buf.append(UBytes.toHexString(this.refcount_table_clusters));
        buf.append(",refcount_table_clusters指定了refcount表占用的簇数。");
        buf.append("\n引用计数大小(8Byte)" + (refcntTblClu << (clusterBits - 3)));

        buf.append("\n快照数量:");
        // System.out.println(UBytes.toHexString(this.nb_snapshots));
        buf.append(UBytes.toHexString(this.nb_snapshots));
        buf.append("\n快照偏移量:");
        // System.out.println(UBytes.toHexString(this.snapshots_offset));
        buf.append(UBytes.toHexString(this.snapshots_offset));
        buf.append("\n--------------------------------------------");
        return buf.toString();
    }
    public long getL1TblOff() {
        return this.l1TblOff;
    }
    /**
     * Level 1 表项(8字节)个数
     * @return Level 1 表项(8字节)个数
     */
    public int getL1TblSize() {
        return this.l1Size;
    }
    /**
     * Level 2 表项(8字节)个数
     * @return Level 2 表项(8字节)个数
     */
    public int getL2TblSize() {
        return (1 << ( this.clusterBits - 3));
    }
    public long getRefCntTblOff() {
        return this.refCntTblOff;
    }
    public int getRefcntTblClu() {
        return this.refcntTblClu;
    }
    public int getRefcntTblCnt() {
        return (refcntTblClu << (clusterBits - 3));
    }
}
