#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
/*
Dev C++ -> include libnetapi32.a
BCC 5.5 or VC++ -> #pragma comment(lib,"netapi32.lib")
*/
 
typedef struct _ASTAT_
{
    ADAPTER_STATUS adapt;
    NAME_BUFFER NameBuff [30];
} ASTAT, *PASTAT;
 
void getMac(char * mac)
{
    ASTAT Adapter;
    NCB Ncb;
    UCHAR uRetCode;
    LANA_ENUM lenum;
    int i = 0;
 
    memset(&Ncb, 0, sizeof(Ncb));
    Ncb.ncb_command = NCBENUM;
    Ncb.ncb_buffer = (UCHAR *)&lenum;
    Ncb.ncb_length = sizeof(lenum);
 
    uRetCode = Netbios( &Ncb );
    printf( "The NCBENUM return adapter number is: %d \n ", lenum.length);
    for(i=0; i < lenum.length ; i++)
    {
        memset(&Ncb, 0, sizeof(Ncb));
        Ncb.ncb_command = NCBRESET;
        Ncb.ncb_lana_num = lenum.lana[i];
        uRetCode = Netbios( &Ncb );
 
        memset(&Ncb, 0, sizeof(Ncb));
        Ncb.ncb_command = NCBASTAT;
        Ncb.ncb_lana_num = lenum.lana[i];
        strcpy((char *)Ncb.ncb_callname, "* ");
        Ncb.ncb_buffer = (unsigned char *) &Adapter;
        Ncb.ncb_length = sizeof(Adapter);
        uRetCode = Netbios( &Ncb );
 
        if (uRetCode == 0)
        {
            //sprintf(mac, "%02x-%02x-%02x-%02x-%02x-%02x ",
            sprintf(mac, "%02X%02X%02X%02X%02X%02X ",
                    Adapter.adapt.adapter_address[0],
                    Adapter.adapt.adapter_address[1],
                    Adapter.adapt.adapter_address[2],
                    Adapter.adapt.adapter_address[3],
                    Adapter.adapt.adapter_address[4],
                    Adapter.adapt.adapter_address[5]
                   );
            //printf( "The Ethernet Number on LANA %d is: %s\n ", lenum.lana[i], mac);
        }
    }
}
 
int main(int argc, char *argv[])
{
    char *mac=(char *)malloc(32);
    getMac(mac);
    printf( "%s\n ", mac);
    free(mac);
    system( "PAUSE> NUL ");
    return 0;
}
