            org     0x7C00          ; 该命令表示程序将被装在到偏移地址为0x7C00的地方  
                                    ; 该命令效果是全局的，但只能使用一次，之后不得再用  
                                    ; 从该位置开始到整个源代码结束之间的所有标号在被访问时都会隐式地自动加上0x7C00  
                                    ; 但是和vstart=0x7C00不同，vstart会将整个段内所有指令的汇编地址都加上0x7C00  
                                    ; 而org不影响汇编地址，仅仅就是在访问标号的时候临时加一个0x7C00  
                                    ; 并将这个临时的和作为访问结果返回  

            jmp     start

GDT_BEG: ; GDT表的定义  
DESC_SG_NULL    dd  0x00000000, 0x00000000  
DESC_SG_CODE    dd  0x7C0001FF, 0x00409A00 ; TYPE=1010,代码段必须可读，否则msg中的内容是无法读出并写到显卡中的  
DESC_SG_VIDEO   dd  0x8000FFFF, 0x0040920B  
DESC_SG_STACK   dd  0x00007A00, 0x00409600  
GDT_END:  
  
; 段选择子  
SLCT_NULL       equ DESC_SG_NULL  - GDT_BEG  
SLCT_CODE       equ DESC_SG_CODE  - GDT_BEG  
SLCT_VIDEO      equ DESC_SG_VIDEO - GDT_BEG  
SLCT_STACK      equ DESC_SG_STACK - GDT_BEG  
  
; GDT总共有多少个双字  
GDT_SIZE_DWORD  equ (GDT_END - GDT_BEG) / 4  
  
GDTR:   ; 以下48位内容需要加载到全局描述符表寄存器gdtr中  
GDT_BOUND       dw  GDT_END - GDT_BEG - 1   ; 低16位是GDT的界限（即GDT总共多少字节）  
                                            ; 如果把GDT看做以字节为单位的数组，则下标从0开始  
                                            ; 所以该项为GDT总字节数减1  
                                            ; 本程序总共有4个描述符，GDT每个表项都占8字节  
GDT_BASE        dd  0x7E00          ; GDT加载在内存中的起始物理地址  
                                    ; 由于在加载GDTR时还没有进入保护模式，因此只能用20位地址  
                                    ; 这里就只能用32位来表示20位地址了  
                                    ; 因此在进入保护模式前只能将GDT加载到1MB的内存空间中  
                                    ; 在进入保护模式之后可以再将GDT移动到其它位置  
                                    ; 由于MBR位于0x7C00开始的512字节空间中了  
                                    ; 因此就将GDT放在后面一个新的512字节处（7E00H = 7C00H + 512）  

PORT_FAST_A20   equ 0x92            ; 快速设置A20地址线的端口  
GATE_ALT_A20    equ 0x02            ; 开启A20地址线的位掩码（门控），也称作A20替代门控  
                                    ; 即该8位端口的1号位置1即可打开A20地址线  

GATE_PE         equ 0x01            ; 控制寄存器（32位）的第0位——保护模式允许位（Protection Enable）  
                                    ; 也称作PE门控  
                                    ; 将其设置为1就真正进入保护模式了  
                                    ; 从此之后都要按照保护模式的规矩来了  
                                    ; 这是真正的保护模式的开关  
; 程序开始  
start:      mov     ax, cs  
            mov     ss, ax  
            mov     sp, 0x7C00  
  
            ; ds:si指向本代码中的临时GDT  
            mov     ax, cs  
            mov     ds, ax  
            mov     si, GDT_BEG  
  
            ; es:di指向GDT实际加载的位置0x7E00:0  
            mov     ax, [cs: GDT_BASE]  
            mov     dx, [cs: GDT_BASE+2]  
            mov     bx, 16  
            div     bx                      ; 获取实际物理地址对应的16位段地址  
            mov     es, ax  
            mov     di, 0  
  
            ; 将GDT加载到指定位置  
            mov     cx, GDT_SIZE_DWORD  
            cld  
            rep     movsd  
  
            lgdt    [cs: GDTR]              ; load gdtr，将GDTR处的48位内容加载进gdtr中  
  
            ; 由于实模式下地址只有20位，为了使20位地址溢出时归0并产生进位CF就必须关闭  
            ; 第21根地址线即A20（Address #20），如果不关闭则20位地址溢出时的进位会  
            ; 出现在A20处而不产生CF进位标记，同时不能归0  
            ; 因此在进入32位保护模式之前必须先开启A20（实模式下A20不工作，即一直为0）  
            ; 从而使32位的每一位都能工作成为真正意义上的32位模式  
            in      al, PORT_FAST_A20  
            or      al, GATE_ALT_A20  
            out     PORT_FAST_A20, al  
  
            ; 保护模式下段的定位和实模式不同  
            ; 因此在保护模式下所有BIOS中断都不能使用（跳转到中断例程时需要定位）  
            ; 因此在进入保护模式之后需要重新设置BIOS中断的定位  
            ; 因此在这个问题解决之前不能相应任何中断  
            ; 因此在进入保护模式之前到BIOS中断重新设置完毕的过程中必须要关中断以免发生未知异常  
            cli         ; clear IF，将IF标志位（中断允许标志位）置0  
                        ; 对应的sti，即set IF，将IF位置1重新允许中断  
                        ; 由于本程序并不重新设置BIOS的定位，因此就无需sti  
  
            mov     eax, cr0            ; cr0是0号寄存器，还有cr1、cr2等  
            or      eax, GATE_PE        ; 彻底进入保护模式  
            mov     cr0, eax  
  
            ; 虽然是进入了保护模式，但cs的描述符高速缓冲寄存器中的内容还是20位模式下的内容  
            ; 如果这个问题不解决会导致程序的错误，因此必须刷新cs  
            ; 刷新的同时也会自动更新描述符高速缓冲寄存器，同时清空了流水线  
            ; 只能通过转移、调用、返回、中断指令来修改cs  
            jmp     dword SLCT_CODE:(pm32_start - 0x7C00)   ; 注意cs现在是段选择子  
                                                            ; 由于所有标号被引用的时候会加0x7C00  
                                                            ; 而段选择子中起始位置是从0x7C00开始算起的  
                                                            ; 所以在这里跳转的时候偏移地址需要减去0x7C00  
                                                            ; 使用dword主要是约束偏移地址，使之成为32位的  
                                                            ; 这之后就会使用eip作为偏移指针了  
    msg     db  'Already in protect mode...'  
    len_msg equ $-msg  
  
            [bits 32]  
pm32_start:  
            mov     eax, SLCT_VIDEO             ; 段选择子  
            mov     ds, eax  
  
            ; 显示msg  
            mov     ebx, msg-0x7C00  
            mov     esi, 0  
            mov     edi, 0  
    .lp:    mov     al, [cs: ebx+esi]
            mov     [edi], al
            inc     esi
            add     edi, 2
            loop    .lp

            ; 测试栈段
            mov     eax, SLCT_STACK
            mov     ss, eax
            mov     esp, 0x7C00

            mov     ebp, esp        ; 备份esp

            push    byte '!'        ; 立即数压入实验
            sub     ebp, 4
            cmp     ebp, esp        ; 考察一下压入的是否是32位数
            jne     .tail
            pop     eax             ; 事实证明32位模式下压入的立即数必定都是32为的
            mov     [0x1A], al  
            mov     [0x1C], byte ' '     ; 抽马桶

    .tail:  jmp     $

times 510 - ($ - $$)    db  0
                        dw  0xAA55

