; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; FileName: RemoteMAC.asm
; Function: Display the MAC addr (NIC_ID) refered by IP addr
;   Author: Purple Endurer
;
; log
;-----------------
; 2004-03-02
;   Created.
; 2004-03-06
;   Can display the MAC addr (NIC_ID) refered by IP addr
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 
.386
.Model Flat,StdCall
Option Casemap :None 
 
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\ws2_32.inc
include \masm32\include\comctl32.inc
include \masm32\include\comdlg32.inc
 
includeLib \masm32\lib\user32.lib
includeLib \masm32\lib\kernel32.lib
includelib \masm32\lib\ws2_32.lib
includelib \masm32\lib\comctl32.lib
includelib \masm32\lib\comdlg32.lib
 
;ssssssssssssssssssssssssssss
.data
;ssssssssssssssssssssssssssss
wsa WSADATA <>
sa in_addr <>
remoteHostent hostent <>
iphlpapierror db "load iphlpapi.dll error",0
SendArpError db "Get SendArp Address error",0
iphlpapi db "iphlpapi.dll",0
SendArp db "SendARP",0
SendArpOk db "Get SendArp is Ok!",0
ipAddr db "192.168.0.57", 0   ;测试用的IP
noline   db "计算机可能不在线！",0
 
szMac  db "%02X:%02X:%02X:%02X:%02X:%02X",0
len      db 06
bname    db 100   dup(0)
 
;ssssssssssssssssssssssssssss
.data?
;ssssssssssssssssssssssssssss
hInstance dd ?
macaddr     db 10 dup(?)
ipaddress   db 10 dup(?)
buff        db 200 dup(?)
SendArpAddr dd ?
nRemoteAddr dd ?
buffer      db 200 dup(?)
 
;ssssssssssssssssssssssssssss
.code
;ssssssssssssssssssssssssssss
 
START:
 
  invoke InitCommonControls
  invoke GetModuleHandle,NULL
  mov    hInstance,eax
 
  
   invoke WSAStartup,202h,offset wsa ;装载winsock 2.2
    .if eax != NULL
       invoke ExitProcess,0     
    .endif
 
    invoke LoadLibrary,addr iphlpapi   ;装载iphlpapi.dll
    .if eax==NULL
        invoke MessageBox,NULL,addr iphlpapierror,addr iphlpapi,NULL
        invoke WSACleanup
        invoke ExitProcess,0
    .endif                                    
 
    invoke GetProcAddress,eax,addr SendArp ;从iphlpapi.dll中动态得到SendArp函数的地址，后面要用到
    .if eax==NULL
        invoke MessageBox,NULL,addr SendArpError,addr SendArp,NULL
        invoke WSACleanup
        invoke ExitProcess,0
   .endif
 
   mov SendArpAddr,eax  ;保存得到的SendArp涵数地址
 
   invoke inet_addr,addr ipAddr     ;bname
   mov nRemoteAddr,eax
 
   push offset len
   push offset macaddr
   push 0
   push eax
   call SendArpAddr
 
   .if eax == NO_ERROR
       lea edi,offset macaddr
       mov ebx,6
 
       .while ebx
          movzx eax,byte ptr [edi+ebx-1]
          push eax
          dec ebx
       .endw
            
       invoke wsprintf,addr buff,addr szMac
       invoke MessageBox,NULL,addr buff,addr ipAddr,NULL ;显示MAC地址信息
   .else
       invoke MessageBox,NULL,addr noline,addr ipAddr,NULL  ;显示对方计算机不在线信息
   .endif
 
  invoke WSACleanup
  invoke ExitProcess,0
 
END START
