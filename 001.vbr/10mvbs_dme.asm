00000000 EB 3C                               JMP SHORT 0000003E
00000002 90                NOP
0000003E 33 C9                               XOR CX, CX
00000040 8E D1                               MOV SS, CX
00000042 BC FC 7B                            MOV SP, 007B FC 
00000045 16                PUSH SS
00000046 7                 POP ES
00000047 BD 78 00                            MOV BP, 0000 78 
0000004A C5 76                               LDS SI, SS:[BP]
0000004C 0  1E                               ADD DH, BL
0000004E 56                PUSH SI
0000004F 16                PUSH SS
00000050 55                PUSH BP
00000051 BF 22 05                            MOV DI, 0005 22 
00000054 89 7E                               MOV SS:[BP], DI
00000056 0  89                               ADD 
00000058 4E                DEC SI
00000059 2  B1                               ADD 
0000005B B                 B                 OR  
0000005C FC                CLD 
0000005D F3                REPNE 
0000005E A4                MOVSB , 
0000005F 6                 PUSH ES
00000060 1F                POP DS
00000061 BD 00 7C                            MOV BP, 007C 00 
00000064 C6 45                               MOV DS:[DI]
00000066 FE 0F                               DEC DS:[BX]
00000068 38 4E                               CMP SS:[BP], CL
0000006A 24                SUB 
0000006B 7D 20                               JGE SHORT 0000008D
0000006D 8B C1                               MOV AX, CX
0000006F 99                CWD
00000070 E8 7E 01                            CALL NEAR 000000F0
00000073 83 EB                               SUB SS:[BP+DI]
00000075 3A 66                               CMPAH, SS:[BP]
00000077 A1                MOV , 
00000078 1C                SBB 
00000079 7C 66                               JL SHORT 000000E1
0000007B 3B 07                               CMPAX, DI
0000007D 8A 57                               MOV DL, DS:[BX]
0000007F FC                CLD 
00000080 75 06                               JNE SHORT 00000088
00000082 80                OR 
00000083 CA                RET , 
00000084 2  88                               ADD 
00000086 56                PUSH SI
00000087 2  80                               ADD 
00000089 C3                RET , 
0000008A 10                ADC 
0000008B 73 ED                               JNC SHORT 0000007A
0000008D 33 C9                               XOR CX, CX
0000008F FE 06                               INC SS:[BP]
00000091 D8                
00000092 7D 8A                               JGE SHORT 0000001E
00000094 46                INC SI
00000095 10                ADC 
00000096 98                CBW
00000097 F7 66                               MUL SS:[BP]
00000099 16                PUSH SS
0000009A 3  46                               ADD AX, SS:[BP]
0000009C 1C                SBB 
0000009D 13                ADC 
0000009E 56                PUSH SI
0000009F 1E                PUSH DS
000000A0 3  46                               ADD AX, SS:[BP]
000000A2 E                 PUSH CS
000000A3 13                ADC 
000000A4 D1                ROR 
000000A5 8B 76                               MOV SI, SS:[BP]
000000A7 11                ADC 
000000A8 60                !!!8086!!!
000000A9 89 46                               MOV SS:[BP], AX
000000AB FC                CLD 
000000AC 89 56                               MOV SS:[BP], DX
000000AE FE                
000000AF B8 20 00                            MOV AX, 0000 20 
000000B2 F7 E6                               MUL SS:[BP]
000000B4 8B 5E                               MOV BX, SS:[BP]
000000B6 B                 B                 OR  
000000B7 3  C3                               ADD AX, BX
000000B9 48                DEC AX
000000BA F7 F3                               DIV SS:[BP+DI]
000000BC 1  46                               ADD SS:[BP], AX
000000BE FC                CLD 
000000BF 11                ADC 
000000C0 4E                DEC SI
000000C1 FE 61                               JMP DS:[BX+DI]
000000C3 BF 00 07                            MOV DI, 0007 00 
000000C6 E8 28 01                            CALL NEAR 000000F0
000000C9 72 3E                               JC SHORT 00000109
000000CB 38 2D                               CMP CH, CH
000000CD 74 17                               JE SHORT 000000E6
000000CF 60                !!!8086!!!
000000D0 B1 0B                               MOV CL, 000000B 
000000D2 BE D8 7D                            MOV SI, 007D D8 
000000D5 F3                REPNE 
000000D6 A6                CMPSB , 
000000D7 61                !!!8086!!!
000000D8 74 3D                               JE SHORT 00000117
000000DA 4E                DEC SI
000000DB 74 09                               JE SHORT 000000E6
000000DD 83                ADD 
!!!WARNING!!!c7 20
000000DE C7 20                               
000000E0 3B FB                               CMPDI, BX
000000E2 72 E7                               JC SHORT 000000CB
000000E4 EB DD                               JMP SHORT 000000C3
000000E6 FE 0E                               DEC SS:[BP]
000000E8 D8                
000000E9 7D 7B                               JGE SHORT 00000166
000000EB A7                CMPSW , 
000000EC BE 7F 7D                            MOV SI, 007D 7F 
000000EF AC                LODSB , 
000000F0 98                CBW
000000F1 3  F0                               ADD SI, AX
000000F3 AC                LODSB , 
000000F4 98                CBW
000000F5 40                INC AX
000000F6 74 0C                               JE SHORT 00000104
000000F8 48                DEC AX
000000F9 74 13                               JE SHORT 0000010E
000000FB B4 0E                               MOV AH, 000000E 
000000FD BB 07 00                            MOV BX, 0000 07 
00000100 CD                INT , 
00000101 10                ADC 
00000102 EB EF                               JMP SHORT 000000F3
00000104 BE 82 7D                            MOV SI, 007D 82 
00000107 EB E6                               JMP SHORT 000000EF
00000109 BE 80 7D                            MOV SI, 007D 80 
0000010C EB E1                               JMP SHORT 000000EF
0000010E CD                INT , 
0000010F 16                PUSH SS
00000110 5E                POP SI
00000111 1F                POP DS
00000112 66                !!!8086!!!
00000113 8F 04                               POP DS:[SI]
00000115 CD                INT , 
00000116 19                SBB 
00000117 BE 81 7D                            MOV SI, 007D 81 
0000011A 8B 7D                               MOV DI, DS:[DI]
0000011C 1A                SBB 
0000011D 8D                LEA 
0000011E 45                INC BP
0000011F FE 8A                               DEC SS:[BP+SI]
00000121 4E                DEC SI
00000122 D                 D                 OR  
00000123 F7 E1                               MUL DS:[BX+DI]
00000125 3  46                               ADD AX, SS:[BP]
00000127 FC                CLD 
00000128 13                ADC 
00000129 56                PUSH SI
0000012A FE B1                               PUSH DS:[BX+DI]
0000012C 4  E8                               ADD E8                
0000012E C2                RET , 
0000012F 0  72                               ADD SS:[BP+SI], DH
00000131 D7                XLAT 
00000132 EA 00                               JMP FAR 00000134
00000134 2  70                               ADD DH, DS:[BX+SI]
00000136 0  52                               ADD SS:[BP+SI], DL
00000138 50                PUSH AX
00000139 6                 PUSH ES
0000013A 53                PUSH BX
0000013B 6A                !!!8086!!!
0000013C 1  6A                               ADD SS:[BP+SI], BP
0000013E 10                ADC 
0000013F 91                XCHG ;!!!!
00000140 8B 46                               MOV AX, SS:[BP]
00000142 18                SBB 
00000143 A2                MOV , 
00000144 26                PUSH FS
00000145 5  96 92                            ADD 92                96                
00000148 33 D2                               XOR DX, DX
0000014A F7 F6                               DIV SS:[BP]
0000014C 91                XCHG ;!!!!
0000014D F7 F6                               DIV SS:[BP]
0000014F 42                INC DX
00000150 87                XCHG 
00000151 CA                RET , 
00000152 F7 76                               DIV SS:[BP]
00000154 1A                SBB 
00000155 8A F2                               MOV DH, DL
00000157 8A E8                               MOV CH, AL
00000159 C0                MOV , 
0000015A CC                INT , 
0000015B 2  0A                               ADD CL, DL
0000015D CC                INT , 
0000015E B8 01 02                            MOV AX, 0002 01 
00000161 80                CMP 
00000162 7E 02                               JLE SHORT 00000166
00000164 E                 PUSH CS
00000165 75 04                               JNE SHORT 0000016B
00000167 B4 42                               MOV AH, 0000042 
00000169 8B F4                               MOV SI, SP
0000016B 8A 56                               MOV DL, SS:[BP]
0000016D 24                SUB 
0000016E CD                INT , 
0000016F 13                ADC 
00000170 61                !!!8086!!!
00000171 61                !!!8086!!!
00000172 72 0A                               JC SHORT 0000017E
00000174 40                INC AX
00000175 75 01                               JNE SHORT 00000178
00000177 42                INC DX
00000178 3  5E                               ADD BX, SS:[BP]
0000017A B                 B                 OR  
0000017B 49                DEC CX
0000017C 75 77                               JNE SHORT 000001F5
0000017E C3                RET , 
0000017F 3  18                               ADD BX, AX
00000181 1  27                               ADD DI, SP
000001EE 7F 01                               JG SHORT 000001F1
000001F0 0  41                               ADD DS:[BX+DI], AL
000001F2 BB 00 07                            MOV BX, 0007 00 
000001F5 60                !!!8086!!!
000001F6 66                !!!8086!!!
000001F7 6A                !!!8086!!!
000001F8 0  E9                               ADD CL, CH
000001FA 3B FF                               CMPDI, DI
000001FC 0  00                               ADD AL, AL
