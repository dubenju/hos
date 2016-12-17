                    ORG 0x7F00
                    JMP VBE_START
                    NOP
vbei_signature      DD  00H
vbei_version        DW  00H
vbei_oem            DD  00H
vbei_capabilities   DD  00H
vbei_video_modes    DD  00H
vbei_video_memory   DW  00H
vbei_software_rev   DW  00H
vbei_vendor         DD  00H
vbei_product_name   DD  00H
vbei_product_rev    DD  00H
vbei_reserved TIMES 222 DB 00H
vbei_oem_data TIMES 256 DB 00H

VBE_START:
                    XOR AX, AX
                    MOV ES, AX
                    MOV DI, 7F04H
                    MOV AX, 4F00H       ; Get VESA mode information
                    INT 10H
                    CMP AX, 004FH

                    MOV AX, 4F01H       ; Get VESA mode information
                    MOV CX, 0111H
                    MOV DI, 0500H
                    INT 10H
                    CMP AX, 004FH
;                    JMP FIN

                    MOV AX, 4F03H       ; Get current VBE mode
                    INT 10H
                    CMP AX, 004FH

                    MOV AX, 4F02H       ; Set VBE mode
                    MOV BX, 0111H + 4000H
                    INT 10H
                    CMP AX, 004FH

                    MOV AX, 4F03H       ; Get current VBE mode
                    INT 10H
                    CMP AX, 004FH

FIN:
                    JMP FIN
