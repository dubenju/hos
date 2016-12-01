00000000 EB 3C                               JMP SHORT 0000003EH
00000002 90                NOP
0000003E 33 C9                               XOR CX, CX
00000040 8E D1                               MOV SS, CX
00000042 BC FC 7B                            MOV SP, 7BFCH
00000045 16                PUSH SS
00000046 07                POP ES
00000047 BD 78 00                            MOV BP, 0078H
0000004A C5                
0000004B 76 00                               JBE SHORT 0000004D
0000004D 1E                PUSH DS
0000004E 56                PUSH SI
0000004F 16                PUSH SS
00000050 55                PUSH BP
00000051 BF 22 05                            MOV DI, 0522H
00000054 89 7E 00                            MOV SS:[BP]+00, DI
00000057 89 4E 02                            MOV SS:[BP]+02, CX
0000005A B1 0B                               MOV CL, 0BH
0000005C FC                CLD 
0000005D F3                REPNE 
0000005E A4                MOVSB 
0000005F 06                PUSH ES
00000060 1F                POP DS
00000061 BD 00 7C                            MOV BP, 7C00H
00000064 C6 45 FE 0F                         MOV DS:[DI]-02,0F
00000068 38 4E 24                            CMP SS:[BP]+24, CL
0000006B 7D 20                               JGE SHORT 0000008D
0000006D 8B C1                               MOV AX, CX
0000006F 99                CWD
00000070 E8 7E 01                            CALL NEAR 000000F0H
00000073 83 EB 3A                            SUB BX,3A
00000076 66                !!!80286!!!!!!80186!!!
00000077 A1 1C 7C                            MOV AX, [7C1CH]
0000007A 66                !!!80286!!!!!!80186!!!
0000007B 3B 07                               CMP AX, DI
0000007D 8A 57 FC                            MOV DL, DS:[BX]-04
00000080 75 06                               JNE SHORT 00000088
00000082 80 CA 02                            OR DL,02
00000085 88 56 02                            MOV SS:[BP]+02, DL
00000088 80 C3 10                            ADD BL,10
0000008B 73 ED                               JNC SHORT 0000007A
0000008D 33 C9                               XOR CX, CX
0000008F FE 06 D8 7D                         INC [7DD8]
00000093 8A 46 10                            MOV AL, SS:[BP]+10
00000096 98                CBW
00000097 F7 66 16                            MUL SS:[BP]+16
0000009A 03 46 1C                            ADD AX, SS:[BP]+1C
0000009D 13 56 1E                            ADC DX, SS:[BP]+1E
000000A0 03 46 0E                            ADD AX, SS:[BP]+0E
000000A3 13 D1                               ADC DX, CX
000000A5 8B 76 11                            MOV SI, SS:[BP]+11
000000A8 60                PUSHAD !!!80286!!!PUSHA 
000000A9 89 46 FC                            MOV SS:[BP]-04, AX
000000AC 89 56 FE                            MOV SS:[BP]-02, DX
000000AF B8 20 00                            MOV AX, 0020H
000000B2 F7 E6                               MUL SI
000000B4 8B 5E 0B                            MOV BX, SS:[BP]+0B
000000B7 03 C3                               ADD AX, BX
000000B9 48                DEC AX
000000BA F7 F3                               DIV BX
000000BC 01 46 FC                            ADD SS:[BP]-04, AX
000000BF 11 4E FE                            ADC CX, SS:[BP]-02
000000C2 61                POPAD !!!80286!!!POPA 
000000C3 BF 00 07                            MOV DI, 0700H
000000C6 E8 28 01                            CALL NEAR 000000F0H
000000C9 72 3E                               JC SHORT 00000109
000000CB 38 2D                               CMP DS:[DI], CH
000000CD 74 17                               JE SHORT 000000E6
000000CF 60                PUSHAD !!!80286!!!PUSHA 
000000D0 B1 0B                               MOV CL, 0BH
000000D2 BE D8 7D                            MOV SI, 7DD8H
000000D5 F3                REPNE 
000000D6 A6                CMPSB 
000000D7 61                POPAD !!!80286!!!POPA 
000000D8 74 3D                               JE SHORT 00000117
000000DA 4E                DEC SI
000000DB 74 09                               JE SHORT 000000E6
000000DD 83 C7 20                            ADD DI,20
000000E0 3B FB                               CMP DI, BX
000000E2 72 E7                               JC SHORT 000000CB
000000E4 EB DD                               JMP SHORT 000000C3H
000000E6 FE 0E D8 7D                         DEC [7DD8]
000000EA 7B A7                               JNP SHORT 00000093
000000EC BE 7F 7D                            MOV SI, 7D7FH
000000EF AC                LODSB 
000000F0 98                CBW
000000F1 03 F0                               ADD SI, AX
000000F3 AC                LODSB 
000000F4 98                CBW
000000F5 40                INC AX
000000F6 74 0C                               JE SHORT 00000104
000000F8 48                DEC AX
000000F9 74 13                               JE SHORT 0000010E
000000FB B4 0E                               MOV AH, 0EH
000000FD BB 07 00                            MOV BX, 0007H
00000100 CD 10                               INT 10H
00000102 EB EF                               JMP SHORT 000000F3H
00000104 BE 82 7D                            MOV SI, 7D82H
00000107 EB E6                               JMP SHORT 000000EFH
00000109 BE 80 7D                            MOV SI, 7D80H
0000010C EB E1                               JMP SHORT 000000EFH
0000010E CD 16                               INT 16H
00000110 5E                POP SI
00000111 1F                POP DS
00000112 66                !!!80286!!!!!!80186!!!
00000113 8F 04                               POP 
00000115 CD 19                               INT 19H
00000117 BE 81 7D                            MOV SI, 7D81H
0000011A 8B 7D 1A                            MOV DI, DS:[DI]+1A
0000011D 8D 45 FE                            LEA AX, DS:[DI]-02
00000120 8A 4E 0D                            MOV CL, SS:[BP]+0D
00000123 F7 E1                               MUL CX
00000125 03 46 FC                            ADD AX, SS:[BP]-04
00000128 13 56 FE                            ADC DX, SS:[BP]-02
0000012B B1 04                               MOV CL, 04H
0000012D E8 C2 00                            CALL NEAR 000000F1H
00000130 72 D7                               JC SHORT 00000109
00000132 EA 00                               JMP FAR   00000134H
00000134 02 70 00                            ADD DH, DS:[BX+SI]+00
00000137 52                PUSH DX
00000138 50                PUSH AX
00000139 06                PUSH ES
0000013A 53                PUSH BX
0000013B 6A 01                               !!!80286!!!PUSH 01
0000013D 6A 10                               !!!80286!!!PUSH 10
0000013F 91                XCHG ;!!!!
00000140 8B 46 18                            MOV AX, SS:[BP]+18
00000143 A2 26 05                            MOV [0526H], AL
00000146 96                
00000147 92                
00000148 33 D2                               XOR DX, DX
0000014A F7 F6                               DIV SI
0000014C 91                XCHG ;!!!!
0000014D F7 F6                               DIV SI
0000014F 42                INC DX
00000150 87 CA                               XCHG CX, DX
00000152 F7 76 1A                            DIV SS:[BP]+1A
00000155 8A F2                               MOV DH, DL
00000157 8A E8                               MOV CH, AL
00000159 C0 CC 02                            ROR AH,02
0000015C 0A CC                               OR  CL, AH
0000015E B8 01 02                            MOV AX, 0201H
00000161 80 7E 02 0E                         CMP SS:[BP]+02,0E
00000165 75 04                               JNE SHORT 0000016B
00000167 B4 42                               MOV AH, 42H
00000169 8B F4                               MOV SI, SP
0000016B 8A 56 24                            MOV DL, SS:[BP]+24
0000016E CD 13                               INT 13H
00000170 61                POPAD !!!80286!!!POPA 
00000171 61                POPAD !!!80286!!!POPA 
00000172 72 0A                               JC SHORT 0000017E
00000174 40                INC AX
00000175 75 01                               JNE SHORT 00000178
00000177 42                INC DX
00000178 03 5E 0B                            ADD BX, SS:[BP]+0B
0000017B 49                DEC CX
0000017C 75 77                               JNE SHORT 000001F5
0000017E C3                RET 
0000017F 03 18                               ADD BX, AX
00000181 01 27                               ADD DS:[BX], SP
000001EE 7F 01                               JG SHORT 000001F1
000001F0 00 41 BB                            ADD DS:[BX+DI]-45, AL
000001F3 00 07                               ADD DS:[BX], AL
000001F5 60                PUSHAD !!!80286!!!PUSHA 
000001F6 66                !!!80286!!!!!!80186!!!
000001F7 6A 00                               !!!80286!!!PUSH 00
000001F9 E9 3B                               JMP NEAR 00000236H
000001FB FF 00                               INC 
000001FD 00 55 AA                            ADD DS:[DI]-56, DL
