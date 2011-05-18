/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : main.c  
 Version   : DS203_SYS Ver 1.3x                                  Author : bure
 Translated:
            Seeedstudio: hugeman 
*******************************************************************************/
#include "SPI_flash.h"
#include "Function.h"
#include "USB_lib.h"
#include "Config.h"
#include "Ident.h"
#include "BIOS.h"
#include "LCD.h"
#include "ASM.h"
#include "USB_pwr.h"

typedef  void (*pFunc)(void);

pFunc Jump_To_App;
u32 JumpAddr;

/*******************************************************************************
  �汾�޸�˵��
SYS V1.24: �޸���144MHz�������ģʽ�µĲ�ֵϵ��(BIOS.C)
           �޸���V2.6Ӳ����·��ģ���������̵�λ(BIOS.C)
SYS V1.30: ��Licenceʶ����ת�Ƶ���DFUģ����(ASM.s,Ident.c)
           �޸���LicenceȨ�޿�������(Main.c, Ident.c)
           �޸���DFU,SYS�⺯������������÷�ʽ(ASM.s, VECTOR.c)
           ������µ�SYS�⺯��(BIOS.C)
SYS V1.31: ���ڲ�U�̵ĳ�ʼ���Ƴٵ�Licenceʶ������(Main.c,Config.c)
           �޸���U��������д����(SPI_flash.c)
           �޸���SYS�⺯������������ʼ��ַ
SYS V1.32: �޸���Set(T_BASE_ARR, Value)�����е�BUG(BIOS.C)
SYS V1.33: �����˶�LCD����оƬILI9327��R61509V�ļ��ݺ��Զ�ʶ��(LCD.c, ASM.s)
SYS V1.34: �Ӹð汾�� �ɲ���ʹ�� IAR 4.42�룵.���汾 �������ļ��С�IAR_V5_Prpject
           �޸���ASM.s�ļ�
          
Version LOG:
SYS V1.24: Modified the Interpolation factor in 144M interlaced mode(BIOS.C)
		   Modified the analog input gears in HWv2.6(BIOS.C)
SYS V1.30: Transfered the Licence identifying function to DFU module (ASM.s,Ident.c)
		   Modified the Licence power(Main.c,Ident.c)
		   Modified the function invoke method of DFU and SYS(ASM.s,VECTOR.c)
		   New functions in SYS added(BIOS.c)
SYS V1.31: Init the U disk after the Licence identifying(Main.c,Config.c)
		   Modified U disk access function(SPI flash.c)
		   Modified address for storing the vector of SYS function
SYS V1.32: Debug the Set(T_BASE_ARR, Value) function (BIOS.C)
SYS V1.33: Functions to identify the LCD control IC:ILI9327 added.(BIOS.C) 
SYS V1.34: Folder IAR_V5_Project added. Modified the ASM.s

*******************************************************************************/

/*******************************************************************************
  main : Main routine.
*******************************************************************************/
int main(void)
{ 
  u32 Licence;
  u8  NumStr[9];
  
  Set_System();
  NVIC_Config();
  GPIO_Config();
  Timer_Config();
  FSMC_Config();
  SPI_Config();

  DMA_Config();
  ADC_Config();
  DAC_Config();
  
  Beep(20, 500); 
  LCD_Initial();
  Clear_Screen(0x0000);

  Display_Logo(70,150); 
  
  Display_Str( 6*8, 90, GRN, PRN,  HDW_VERSION );
  Display_Str(24*8, 90, GRN, PRN, "Serial No: ");
  Word2Hex(NumStr, __Dev_SN());            
  Display_Str(35*8, 90, YEL, PRN, NumStr);    // ��ʾ��ȡ�����豸���к�//Show the Serial No.
  Display_Str(6*8, 70, GRN, PRN,   SYS_VERSION);

  if((KEY2_OFF)&&(KEY3_OFF)&&(KEY4_OFF)){       // �����ް�������//No key was pressed when power up
    Key_Buffer = 0;                             // �������״̬����ʼ�ȴ��µİ���//Clear the key buffer, and wait for new pressing
    Licence = Get_Lic(SYS_LIC_OFFSET);          // Get master licence
    if(__Chk_SYS(Licence)!= 1){                 // No master licence 
      Display_Str(6*8,50,GRN,PRN,     "Please input master licence: 00000000");
      Licence = Input_Lic(48+29*8, 50);         // Input Licence
      if(__Chk_SYS(Licence)!= 1){               // Licence error
        Display_Str(6*8,50,YEL,PRN,   "        Licence input error          ");
      } else {                                  // Licence ok
        if(Add_Lic(Licence, SYS_LIC_OFFSET)== 1)// Licence writen ok
          Display_Str(6*8,50,GRN,PRN, "         Licence writen ok           ");
        else  
          Display_Str(6*8,50,GRN,PRN, "        Licence writen error         ");
      }
      Display_Str(6*8,30,GRN,PRN,     "      Push any key to next step      ");
      while (Key_Buffer == 0){};
    }
    JumpAddr = *(vu32*) (APP1_BASE + 4);
    Jump_To_App = (pFunc) JumpAddr;
    __MSR_MSP(*(vu32*) APP1_BASE);
  } else if(KEY2_ON){                           // ��������K2��  //Key2 was pressed
    JumpAddr = *(vu32*) (APP2_BASE + 4);
    Jump_To_App = (pFunc) JumpAddr;
    __MSR_MSP(*(vu32*) APP2_BASE);
  } else if(KEY3_ON){                           // ��������K3�� //Key3 was pressed  
    JumpAddr = *(vu32*) (APP3_BASE + 4);
    Jump_To_App = (pFunc) JumpAddr;
    __MSR_MSP(*(vu32*) APP3_BASE);
  } else if(KEY4_ON){                           // ��������K4�� //Key4 wad pressed
    JumpAddr = *(vu32*) (APP4_BASE + 4);
    Jump_To_App = (pFunc) JumpAddr;
    __MSR_MSP(*(vu32*) APP4_BASE);
  }
  USB_EN();
  USB_Init();  
  Jump_To_App();
}
/*********************************  END OF FILE  ******************************/
