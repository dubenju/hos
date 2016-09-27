package hos.qcow2;

import javay.util.UBytes;

public class QcowHeader {
    private byte[] head;
    byte[] magic = new byte[4];  // 4
    byte[] version = new byte[4]; // 4 版本号
    byte[] backing_file_offset = new byte[8]; // 8 开始偏移
    byte[] backing_file_size = new byte[4]; // 4
    byte[] cluster_bits = new byte[4]; // 4
    byte[] size = new byte[8]; /* in bytes */ // 8
    byte[] crypt_method = new byte[4]; // 4
    byte[] l1_size = new byte[4]; // 4
    byte[] l1_table_offset = new byte[8]; // 8
    byte[] refcount_table_offset = new byte[8]; // 8
    byte[] refcount_table_clusters = new byte[4]; // 4
    byte[] nb_snapshots = new byte[4]; // 4
    byte[] snapshots_offset = new byte[8]; // 8

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
        offset += cluster_bits.length;
        System.arraycopy(in, offset, size, 0, size.length);
        offset += size.length;
        System.arraycopy(in, offset, crypt_method, 0, crypt_method.length);
        offset += crypt_method.length;
        System.arraycopy(in, offset, l1_size, 0, l1_size.length);
        offset += l1_size.length;
        System.arraycopy(in, offset, l1_table_offset, 0, l1_table_offset.length);
        offset += l1_table_offset.length;
        System.arraycopy(in, offset, refcount_table_offset, 0, refcount_table_offset.length);
        offset += refcount_table_offset.length;
        System.arraycopy(in, offset, refcount_table_clusters, 0, refcount_table_clusters.length);
        offset += refcount_table_clusters.length;
        System.arraycopy(in, offset, nb_snapshots, 0, nb_snapshots.length);
        offset += nb_snapshots.length;
        System.arraycopy(in, offset, snapshots_offset, 0, snapshots_offset.length);
        offset += snapshots_offset.length;
    }
    public String toString() {
        System.out.println(UBytes.toHexString(this.head));
        StringBuffer buf = new StringBuffer();
        buf.append("\nmagic:");
        System.out.println(UBytes.toHexString(this.magic));
        buf.append("\n版本号:");
        System.out.println(UBytes.toHexString(this.version));
        buf.append("\n开始偏移:");
        System.out.println(UBytes.toHexString(this.backing_file_offset));
        buf.append("\n大小:");
        System.out.println(UBytes.toHexString(this.backing_file_size));
        buf.append("\n索引:");
        System.out.println(UBytes.toHexString(this.cluster_bits));
        buf.append("\n大小:");
        System.out.println(UBytes.toHexString(this.size));
        buf.append("\nAES加密:");
        System.out.println(UBytes.toHexString(this.crypt_method));
        buf.append("\nL1 表大小:");
        System.out.println(UBytes.toHexString(this.l1_size));
        buf.append("\nL1 表偏移:");
        System.out.println(UBytes.toHexString(this.l1_table_offset));
        buf.append("\nrefcount 表偏移:");
        System.out.println(UBytes.toHexString(this.refcount_table_offset));
        buf.append("\n以 cluster 为单位的 refcount 表的大小:");
        System.out.println(UBytes.toHexString(this.refcount_table_clusters));
        buf.append("\n快照数量:");
        System.out.println(UBytes.toHexString(this.nb_snapshots));
        buf.append("\n快照偏移量:");
        System.out.println(UBytes.toHexString(this.snapshots_offset));
        return buf.toString();
    }
}
