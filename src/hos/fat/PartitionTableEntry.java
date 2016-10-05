package hos.fat;

import javay.util.UBytes;
import javay.util.USystemID;

public class PartitionTableEntry {
	private byte[] data;
	private byte pte_Flag; // Boot indicator bit flag: 0 = no, 0x80 = bootable (or "active")
	private byte pte_StartHead; // Starting head
	private byte pte_StarSector; // Starting sector (Bits 6-7 are the upper two bits for the Starting Cylinder field.)
	private int pte_StartCylinder; // Starting Cylinder
	private byte pte_SystemID; // System ID
	private byte pte_EndHead; // Ending Head
	private byte pte_EndSector; // Ending Sector (Bits 6-7 are the upper two bits for the ending cylinder field)
	private int pte_EndCylinder; // Ending Cylinder
	private byte[] pte_RelativeSector = new byte[4]; // Relative Sector (to start of partition -- also equals the partition's starting LBA value)
	private byte[] pte_TotalSectors = new byte[4]; // Total Sectors in partition
	public PartitionTableEntry(byte[] in) {
		data = new byte[in.length];
		System.arraycopy(in, 0, data, 0, in.length);
		pte_Flag = data[0];
		pte_StartHead = data[1];
		pte_StarSector = (byte) (data[2] & 0x3F);
		pte_StartCylinder = ((data[2] & 0xC0) << 8 ) | data[3];
		pte_SystemID = data[4];
		pte_EndHead = data[5];
		pte_EndSector = (byte) (data[6] & 0x3F);
		pte_EndCylinder = ((data[2] & 0xC0) << 8 ) | data[7];
		System.arraycopy(in, 8, pte_RelativeSector, 0, pte_RelativeSector.length);
		System.arraycopy(in, 12, pte_TotalSectors, 0, pte_TotalSectors.length);
	}
    public String toString() {
    	System.out.println("-------------------- Partition Table Entry --------------------------");
        System.out.println(UBytes.toHexString(this.data));
        if (this.data[0] == 0) {
        	System.out.println("-------------------- Partition Table Entry --------------------------");
        	return "";
        }
        StringBuffer buf = new StringBuffer();
        buf.append("\nC-H-S:");
        buf.append(pte_StartCylinder);
        buf.append("-");
        buf.append(pte_StartHead);
        buf.append("-");
        buf.append(pte_StarSector);
        buf.append("\n");
        buf.append(USystemID.getNameByID(pte_SystemID));
        buf.append("\nC-H-S:");
        buf.append(pte_EndCylinder);
        buf.append("-");
        buf.append(pte_EndHead);
        buf.append("-");
        buf.append(pte_EndSector);
        System.out.println(UBytes.toHexString(this.pte_RelativeSector));
        buf.append("\n起始扇区：");
        buf.append(UBytes.toInt(this.pte_RelativeSector, 1));
        System.out.println(UBytes.toHexString(this.pte_TotalSectors));
        buf.append("\n扇区数量：");
        buf.append(UBytes.toInt(this.pte_TotalSectors, 1));
        System.out.println("-------------------- Partition Table Entry --------------------------");
        return buf.toString();
    }
    public int getRelativeSector() {
    	return UBytes.toInt(this.pte_RelativeSector, 1);
    }
}
