///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  14:17:27 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\SYS_V1.34\source\USB_scsi.c                   /
//    Command line =  E:\DS0203\SYS_V1.34\source\USB_scsi.c -lA               /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\SYS_V1.34\IAR_V5_Prpject\Obj\ --no_inline     /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\SYS_V1.34\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\SYS_V1.34\IAR_V5_Prpject\List\USB_scsi.s      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME USB_scsi

        EXTERN Bot_Abort
        EXTERN Bot_State
        EXTERN CBW
        EXTERN MAL_GetStatus
        EXTERN Mass_Block_Count
        EXTERN Mass_Block_Size
        EXTERN Mode_Sense10_data
        EXTERN Mode_Sense6_data
        EXTERN Page00_Inquiry_Data
        EXTERN ReadCapacity10_Data
        EXTERN ReadFormatCapacity_Data
        EXTERN Read_Memory
        EXTERN Scsi_Sense_Data
        EXTERN SetEPRxStatus
        EXTERN Set_CSW
        EXTERN Standard_Inquiry_Data
        EXTERN Transfer_Data_Request
        EXTERN Write_Memory

        PUBLIC SCSI_Address_Management
        PUBLIC SCSI_Format_Cmd
        PUBLIC SCSI_Inquiry_Cmd
        PUBLIC SCSI_Invalid_Cmd
        PUBLIC SCSI_ModeSense10_Cmd
        PUBLIC SCSI_ModeSense6_Cmd
        PUBLIC SCSI_Read10_Cmd
        PUBLIC SCSI_ReadCapacity10_Cmd
        PUBLIC SCSI_ReadFormatCapacity_Cmd
        PUBLIC SCSI_RequestSense_Cmd
        PUBLIC SCSI_Start_Stop_Unit_Cmd
        PUBLIC SCSI_TestUnitReady_Cmd
        PUBLIC SCSI_Valid_Cmd
        PUBLIC SCSI_Verify10_Cmd
        PUBLIC SCSI_Write10_Cmd
        PUBLIC Set_Scsi_Sense_Data
        
        CFI Names cfiNames0
        CFI StackFrame CFA R13 DATA
        CFI Resource R0:32, R1:32, R2:32, R3:32, R4:32, R5:32, R6:32, R7:32
        CFI Resource R8:32, R9:32, R10:32, R11:32, R12:32, R13:32, R14:32
        CFI EndNames cfiNames0
        
        CFI Common cfiCommon0 Using cfiNames0
        CFI CodeAlign 2
        CFI DataAlign 4
        CFI ReturnAddress R14 CODE
        CFI CFA R13+0
        CFI R0 Undefined
        CFI R1 Undefined
        CFI R2 Undefined
        CFI R3 Undefined
        CFI R4 SameValue
        CFI R5 SameValue
        CFI R6 SameValue
        CFI R7 SameValue
        CFI R8 SameValue
        CFI R9 SameValue
        CFI R10 SameValue
        CFI R11 SameValue
        CFI R12 Undefined
        CFI R14 SameValue
        CFI EndCommon cfiCommon0
        
// E:\DS0203\SYS_V1.34\source\USB_scsi.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : usb_scsi.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.2.1
//    5 * Date               : 09/22/2008
//    6 * Description        : All processing related to the SCSI commands
//    7 ********************************************************************************
//    8 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
//    9 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE TIME.
//   10 * AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY DIRECT,
//   11 * INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING FROM THE
//   12 * CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE CODING
//   13 * INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
//   14 *******************************************************************************/
//   15 
//   16 /* Includes ------------------------------------------------------------------*/
//   17 #include "Config.h"
//   18 #include "USB_scsi.h"
//   19 //#include "Mass_mal.h"
//   20 #include "USB_bot.h"
//   21 #include "USB_regs.h"
//   22 #include "SPI_flash.h"
//   23 #include "Memory.h"
//   24 //#include "nand_if.h"
//   25 //#include "platform_config.h"
//   26 
//   27 /* Private typedef -----------------------------------------------------------*/
//   28 /* Private define ------------------------------------------------------------*/
//   29 /* Private macro -------------------------------------------------------------*/
//   30 /* Private variables ---------------------------------------------------------*/
//   31 /* External variables --------------------------------------------------------*/
//   32 extern u8 Bulk_Data_Buff[BULK_MAX_PACKET_SIZE];  /* data buffer*/
//   33 extern u8 Bot_State;
//   34 extern Bulk_Only_CBW CBW;
//   35 extern Bulk_Only_CSW CSW;
//   36 extern u32 Mass_Memory_Size;
//   37 extern u32 Mass_Block_Size;
//   38 extern u32 Mass_Block_Count;
//   39 
//   40 /* Private function prototypes -----------------------------------------------*/
//   41 /* Private functions ---------------------------------------------------------*/
//   42 
//   43 /*******************************************************************************
//   44 * Function Name  : SCSI_Inquiry_Cmd
//   45 * Description    : SCSI Inquiry Command routine.
//   46 * Input          : None.
//   47 * Output         : None.
//   48 * Return         : None.
//   49 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function SCSI_Inquiry_Cmd
        THUMB
//   50 void SCSI_Inquiry_Cmd(void)
//   51 {
//   52   u8* Inquiry_Data;
//   53   u16 Inquiry_Data_Length;
//   54 
//   55   if (CBW.CB[1] & 0x01)/*Evpd is set*/
SCSI_Inquiry_Cmd:
        LDR.N    R1,??DataTable16  ;; CBW
        LDRB     R0,[R1, #+16]
        TST      R0,#0x1
        BEQ.N    ??SCSI_Inquiry_Cmd_0
//   56   {
//   57     Inquiry_Data = Page00_Inquiry_Data;
        LDR.N    R0,??SCSI_Inquiry_Cmd_1  ;; Page00_Inquiry_Data
//   58     Inquiry_Data_Length = 5;
        MOVS     R1,#+5
        B.N      ??SCSI_Inquiry_Cmd_2
//   59   }
//   60   else
//   61   {
//   62 
//   63 //    if ( lun == 0)
//   64 //    {
//   65       Inquiry_Data = Standard_Inquiry_Data;
??SCSI_Inquiry_Cmd_0:
        LDR.N    R0,??SCSI_Inquiry_Cmd_1+0x4  ;; Standard_Inquiry_Data
//   66 //    }
//   67 //    else
//   68 //    {
//   69 //      Inquiry_Data = Standard_Inquiry_Data2;
//   70 //    }
//   71 //
//   72     if (CBW.CB[4] <= STANDARD_INQUIRY_DATA_LEN)
        LDRB     R1,[R1, #+19]
        CMP      R1,#+37
        IT       CS 
//   73       Inquiry_Data_Length = CBW.CB[4];
//   74     else
//   75       Inquiry_Data_Length = STANDARD_INQUIRY_DATA_LEN;
        MOVCS    R1,#+36
//   76 
//   77   }
//   78   Transfer_Data_Request(Inquiry_Data, Inquiry_Data_Length);
??SCSI_Inquiry_Cmd_2:
        B.W      Transfer_Data_Request
        Nop      
        DATA
??SCSI_Inquiry_Cmd_1:
        DC32     Page00_Inquiry_Data
        DC32     Standard_Inquiry_Data
        CFI EndBlock cfiBlock0
//   79 }
//   80 
//   81 /*******************************************************************************
//   82 * Function Name  : SCSI_ReadFormatCapacity_Cmd
//   83 * Description    : SCSI ReadFormatCapacity Command routine.
//   84 * Input          : None.
//   85 * Output         : None.
//   86 * Return         : None.
//   87 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function SCSI_ReadFormatCapacity_Cmd
        THUMB
//   88 void SCSI_ReadFormatCapacity_Cmd(void)
//   89 {
SCSI_ReadFormatCapacity_Cmd:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//   90 
//   91   MAL_GetStatus();
        BL       MAL_GetStatus
//   92   ReadFormatCapacity_Data[4] = (u8)(Mass_Block_Count >> 24);
        LDR.N    R0,??DataTable15  ;; Mass_Block_Count
        LDR      R1,[R0, #+0]
        LDR.N    R0,??SCSI_ReadFormatCapacity_Cmd_0  ;; ReadFormatCapacity_Data
        LSRS     R2,R1,#+24
        STRB     R2,[R0, #+4]
//   93   ReadFormatCapacity_Data[5] = (u8)(Mass_Block_Count >> 16);
        LSRS     R2,R1,#+16
        STRB     R2,[R0, #+5]
//   94   ReadFormatCapacity_Data[6] = (u8)(Mass_Block_Count >>  8);
        LSRS     R2,R1,#+8
        STRB     R2,[R0, #+6]
//   95   ReadFormatCapacity_Data[7] = (u8)(Mass_Block_Count);
        STRB     R1,[R0, #+7]
//   96 
//   97   ReadFormatCapacity_Data[9] = (u8)(Mass_Block_Size >>  16);
        LDR.N    R1,??DataTable17  ;; Mass_Block_Size
        LDR      R1,[R1, #+0]
        LSRS     R2,R1,#+16
        STRB     R2,[R0, #+9]
//   98   ReadFormatCapacity_Data[10] = (u8)(Mass_Block_Size >>  8);
        LSRS     R2,R1,#+8
        STRB     R2,[R0, #+10]
//   99   ReadFormatCapacity_Data[11] = (u8)(Mass_Block_Size);
        STRB     R1,[R0, #+11]
//  100   Transfer_Data_Request(ReadFormatCapacity_Data, READ_FORMAT_CAPACITY_DATA_LEN);
        MOVS     R1,#+12
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      Transfer_Data_Request
        Nop      
        DATA
??SCSI_ReadFormatCapacity_Cmd_0:
        DC32     ReadFormatCapacity_Data
        CFI EndBlock cfiBlock1
//  101 }
//  102 
//  103 /*******************************************************************************
//  104 * Function Name  : SCSI_ReadCapacity10_Cmd
//  105 * Description    : SCSI ReadCapacity10 Command routine.
//  106 * Input          : None.
//  107 * Output         : None.
//  108 * Return         : None.
//  109 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function SCSI_ReadCapacity10_Cmd
        THUMB
//  110 void SCSI_ReadCapacity10_Cmd(void)
//  111 {
SCSI_ReadCapacity10_Cmd:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  112 
//  113   MAL_GetStatus();
        BL       MAL_GetStatus
//  114   ReadCapacity10_Data[0] = (u8)(Mass_Block_Count - 1 >> 24);
        LDR.N    R0,??DataTable15  ;; Mass_Block_Count
        LDR      R1,[R0, #+0]
        SUBS     R2,R1,#+1
        LDR.N    R0,??SCSI_ReadCapacity10_Cmd_0  ;; ReadCapacity10_Data
        LSRS     R3,R2,#+24
        STRB     R3,[R0, #+0]
//  115   ReadCapacity10_Data[1] = (u8)(Mass_Block_Count - 1 >> 16);
        LSRS     R3,R2,#+16
        STRB     R3,[R0, #+1]
//  116   ReadCapacity10_Data[2] = (u8)(Mass_Block_Count - 1 >>  8);
        LSRS     R2,R2,#+8
        STRB     R2,[R0, #+2]
//  117   ReadCapacity10_Data[3] = (u8)(Mass_Block_Count - 1);
        SUBS     R1,R1,#+1
        STRB     R1,[R0, #+3]
//  118 
//  119   ReadCapacity10_Data[4] = (u8)(Mass_Block_Size >>  24);
        LDR.N    R1,??DataTable17  ;; Mass_Block_Size
        LDR      R1,[R1, #+0]
        LSRS     R2,R1,#+24
        STRB     R2,[R0, #+4]
//  120   ReadCapacity10_Data[5] = (u8)(Mass_Block_Size >>  16);
        LSRS     R2,R1,#+16
        STRB     R2,[R0, #+5]
//  121   ReadCapacity10_Data[6] = (u8)(Mass_Block_Size >>  8);
        LSRS     R2,R1,#+8
        STRB     R2,[R0, #+6]
//  122   ReadCapacity10_Data[7] = (u8)(Mass_Block_Size);
        STRB     R1,[R0, #+7]
//  123   Transfer_Data_Request(ReadCapacity10_Data, READ_CAPACITY10_DATA_LEN);
        MOVS     R1,#+8
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      Transfer_Data_Request
        Nop      
        DATA
??SCSI_ReadCapacity10_Cmd_0:
        DC32     ReadCapacity10_Data
        CFI EndBlock cfiBlock2
//  124 }
//  125 
//  126 /*******************************************************************************
//  127 * Function Name  : SCSI_ModeSense6_Cmd
//  128 * Description    : SCSI ModeSense6 Command routine.
//  129 * Input          : None.
//  130 * Output         : None.
//  131 * Return         : None.
//  132 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function SCSI_ModeSense6_Cmd
        THUMB
//  133 void SCSI_ModeSense6_Cmd (void)
//  134 {
//  135   Transfer_Data_Request(Mode_Sense6_data, MODE_SENSE6_DATA_LEN);
SCSI_ModeSense6_Cmd:
        MOVS     R1,#+4
        LDR.N    R0,??SCSI_ModeSense6_Cmd_0  ;; Mode_Sense6_data
        B.W      Transfer_Data_Request
        DATA
??SCSI_ModeSense6_Cmd_0:
        DC32     Mode_Sense6_data
        CFI EndBlock cfiBlock3
//  136 }
//  137 
//  138 /*******************************************************************************
//  139 * Function Name  : SCSI_ModeSense10_Cmd
//  140 * Description    : SCSI ModeSense10 Command routine.
//  141 * Input          : None.
//  142 * Output         : None.
//  143 * Return         : None.
//  144 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function SCSI_ModeSense10_Cmd
        THUMB
//  145 void SCSI_ModeSense10_Cmd (void)
//  146 {
//  147   Transfer_Data_Request(Mode_Sense10_data, MODE_SENSE10_DATA_LEN);
SCSI_ModeSense10_Cmd:
        MOVS     R1,#+8
        LDR.N    R0,??SCSI_ModeSense10_Cmd_0  ;; Mode_Sense10_data
        B.W      Transfer_Data_Request
        DATA
??SCSI_ModeSense10_Cmd_0:
        DC32     Mode_Sense10_data
        CFI EndBlock cfiBlock4
//  148 }
//  149 
//  150 /*******************************************************************************
//  151 * Function Name  : SCSI_RequestSense_Cmd
//  152 * Description    : SCSI RequestSense Command routine.
//  153 * Input          : None.
//  154 * Output         : None.
//  155 * Return         : None.
//  156 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function SCSI_RequestSense_Cmd
        THUMB
//  157 void SCSI_RequestSense_Cmd (void)
//  158 {
SCSI_RequestSense_Cmd:
        LDR.N    R0,??DataTable16  ;; CBW
        LDRB     R1,[R0, #+19]
        CMP      R1,#+19
        IT       CS 
//  159   u8 Request_Sense_data_Length;
//  160 
//  161   if (CBW.CB[4] <= REQUEST_SENSE_DATA_LEN)
//  162   {
//  163     Request_Sense_data_Length = CBW.CB[4];
//  164   }
//  165   else
//  166   {
//  167     Request_Sense_data_Length = REQUEST_SENSE_DATA_LEN;
        MOVCS    R1,#+18
//  168   }
//  169   Transfer_Data_Request(Scsi_Sense_Data, Request_Sense_data_Length);
        LDR.N    R0,??DataTable7  ;; Scsi_Sense_Data
        B.W      Transfer_Data_Request
        CFI EndBlock cfiBlock5
//  170 }
//  171 
//  172 /*******************************************************************************
//  173 * Function Name  : Set_Scsi_Sense_Data
//  174 * Description    : Set Scsi Sense Data routine.
//  175 * Input          : u8 Sens_Key
//  176                    u8 Asc.
//  177 * Output         : None.
//  178 * Return         : None.
//  179 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function Set_Scsi_Sense_Data
        THUMB
//  180 void Set_Scsi_Sense_Data(u8 Sens_Key, u8 Asc)
//  181 {
//  182   Scsi_Sense_Data[2] = Sens_Key;
Set_Scsi_Sense_Data:
        LDR.N    R2,??DataTable7  ;; Scsi_Sense_Data
        STRB     R0,[R2, #+2]
//  183   Scsi_Sense_Data[12] = Asc;
        STRB     R1,[R2, #+12]
//  184 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock6

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable7:
        DC32     Scsi_Sense_Data
//  185 
//  186 /*******************************************************************************
//  187 * Function Name  : SCSI_Start_Stop_Unit_Cmd
//  188 * Description    : SCSI Start_Stop_Unit Command routine.
//  189 * Input          : None.
//  190 * Output         : None.
//  191 * Return         : None.
//  192 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function SCSI_Start_Stop_Unit_Cmd
        THUMB
//  193 void SCSI_Start_Stop_Unit_Cmd(void)
//  194 {
//  195   Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
SCSI_Start_Stop_Unit_Cmd:
        MOVS     R1,#+1
        MOVS     R0,#+0
        B.W      Set_CSW
        CFI EndBlock cfiBlock7
//  196 }
//  197 
//  198 /*******************************************************************************
//  199 * Function Name  : SCSI_Read10_Cmd
//  200 * Description    : SCSI Read10 Command routine.
//  201 * Input          : None.
//  202 * Output         : None.
//  203 * Return         : None.
//  204 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function SCSI_Read10_Cmd
        THUMB
//  205 void SCSI_Read10_Cmd(u32 LBA , u32 BlockNbr)
//  206 {
SCSI_Read10_Cmd:
        PUSH     {R4-R6,LR}
        CFI R14 Frame(CFA, -4)
        CFI R6 Frame(CFA, -8)
        CFI R5 Frame(CFA, -12)
        CFI R4 Frame(CFA, -16)
        CFI CFA R13+16
        MOVS     R5,R0
        MOVS     R4,R1
//  207 
//  208   if (Bot_State == BOT_IDLE)
        LDR.N    R6,??DataTable10  ;; Bot_State
        LDRB     R0,[R6, #+0]
        CBNZ     R0,??SCSI_Read10_Cmd_0
//  209   {
//  210     if (!(SCSI_Address_Management(SCSI_READ10, LBA, BlockNbr)))/*address out of range*/
        MOVS     R2,R4
        MOVS     R1,R5
        MOVS     R0,#+40
        BL       SCSI_Address_Management
        CBZ      R0,??SCSI_Read10_Cmd_1
//  211     {
//  212       return;
//  213     }
//  214 
//  215     if ((CBW.bmFlags & 0x80) != 0)
        LDR.N    R0,??DataTable16  ;; CBW
        LDRB     R0,[R0, #+12]
        TST      R0,#0x80
        BEQ.N    ??SCSI_Read10_Cmd_2
//  216     {
//  217       Bot_State = BOT_DATA_IN;
        MOVS     R0,#+2
        STRB     R0,[R6, #+0]
//  218       Read_Memory(LBA , BlockNbr);
        MOVS     R1,R4
        B.N      ??SCSI_Read10_Cmd_3
//  219     }
//  220     else
//  221     {
//  222       Bot_Abort(BOTH_DIR);
??SCSI_Read10_Cmd_2:
        MOVS     R0,#+2
        BL       Bot_Abort
//  223       Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
        MOVS     R1,#+36
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  224       Set_CSW (CSW_CMD_FAILED, SEND_CSW_ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       Set_CSW
        POP      {R4-R6,PC}
//  225     }
//  226     return;
//  227   }
//  228   else if (Bot_State == BOT_DATA_IN)
??SCSI_Read10_Cmd_0:
        CMP      R0,#+2
        BNE.N    ??SCSI_Read10_Cmd_1
//  229   {
//  230     Read_Memory(LBA , BlockNbr);
??SCSI_Read10_Cmd_3:
        MOVS     R0,R5
        BL       Read_Memory
??SCSI_Read10_Cmd_1:
        POP      {R4-R6,PC}       ;; return
        CFI EndBlock cfiBlock8
//  231   }
//  232 }
//  233 
//  234 /*******************************************************************************
//  235 * Function Name  : SCSI_Write10_Cmd
//  236 * Description    : SCSI Write10 Command routine.
//  237 * Input          : None.
//  238 * Output         : None.
//  239 * Return         : None.
//  240 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function SCSI_Write10_Cmd
        THUMB
//  241 void SCSI_Write10_Cmd(u32 LBA , u32 BlockNbr)
//  242 {
SCSI_Write10_Cmd:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
//  243 
//  244   if (Bot_State == BOT_IDLE)
        LDR.N    R4,??DataTable10  ;; Bot_State
        LDRB     R2,[R4, #+0]
        CBNZ     R2,??SCSI_Write10_Cmd_0
//  245   {
//  246     if (!(SCSI_Address_Management(SCSI_WRITE10 , LBA, BlockNbr)))/*address out of range*/
        MOVS     R2,R1
        MOVS     R1,R0
        MOVS     R0,#+42
        BL       SCSI_Address_Management
        CBZ      R0,??SCSI_Write10_Cmd_1
//  247     {
//  248       return;
//  249     }
//  250 
//  251     if ((CBW.bmFlags & 0x80) == 0)
        LDR.N    R0,??DataTable16  ;; CBW
        LDRB     R0,[R0, #+12]
        TST      R0,#0x80
        BNE.N    ??SCSI_Write10_Cmd_2
//  252     {
//  253       Bot_State = BOT_DATA_OUT;
        MOVS     R0,#+1
        STRB     R0,[R4, #+0]
//  254       SetEPRxStatus(ENDP2, EP_RX_VALID);
        MOV      R1,#+12288
        MOVS     R0,#+2
        BL       SetEPRxStatus
        POP      {R4,PC}
//  255     }
//  256     else
//  257     {
//  258       Bot_Abort(DIR_IN);
??SCSI_Write10_Cmd_2:
        MOVS     R0,#+0
        BL       Bot_Abort
//  259       Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
        MOVS     R1,#+36
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  260       Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       Set_CSW
        POP      {R4,PC}
//  261     }
//  262     return;
//  263   }
//  264   else if (Bot_State == BOT_DATA_OUT)
??SCSI_Write10_Cmd_0:
        CMP      R2,#+1
        IT       EQ 
//  265   {
//  266     Write_Memory(LBA , BlockNbr);
        BLEQ     Write_Memory
??SCSI_Write10_Cmd_1:
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock9
//  267   }
//  268 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable10:
        DC32     Bot_State
//  269 
//  270 /*******************************************************************************
//  271 * Function Name  : SCSI_Verify10_Cmd
//  272 * Description    : SCSI Verify10 Command routine.
//  273 * Input          : None.
//  274 * Output         : None.
//  275 * Return         : None.
//  276 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function SCSI_Verify10_Cmd
        THUMB
//  277 void SCSI_Verify10_Cmd(void)
//  278 {
SCSI_Verify10_Cmd:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  279   if ((CBW.dDataLength == 0) && !(CBW.CB[1] & BLKVFY))/* BLKVFY not set*/
        LDR.N    R0,??DataTable16  ;; CBW
        LDR      R1,[R0, #+8]
        CBNZ     R1,??SCSI_Verify10_Cmd_0
        LDRB     R0,[R0, #+16]
        TST      R0,#0x4
        BNE.N    ??SCSI_Verify10_Cmd_0
//  280   {
//  281     Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+0
        B.N      ??SCSI_Verify10_Cmd_1
//  282   }
//  283   else
//  284   {
//  285     Bot_Abort(BOTH_DIR);
??SCSI_Verify10_Cmd_0:
        MOVS     R0,#+2
        BL       Bot_Abort
//  286     Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
        MOVS     R1,#+36
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  287     Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
??SCSI_Verify10_Cmd_1:
        BL       Set_CSW
//  288   }
//  289 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock10
//  290 /*******************************************************************************
//  291 * Function Name  : SCSI_Valid_Cmd
//  292 * Description    : Valid Commands routine.
//  293 * Input          : None.
//  294 * Output         : None.
//  295 * Return         : None.
//  296 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function SCSI_Valid_Cmd
        THUMB
//  297 void SCSI_Valid_Cmd(void)
//  298 {
SCSI_Valid_Cmd:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  299   if (CBW.dDataLength != 0)
        LDR.N    R0,??DataTable16  ;; CBW
        LDR      R0,[R0, #+8]
        CBZ      R0,??SCSI_Valid_Cmd_0
//  300   {
//  301     Bot_Abort(BOTH_DIR);
        MOVS     R0,#+2
        BL       Bot_Abort
//  302     Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
        MOVS     R1,#+32
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  303     Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
        B.N      ??SCSI_Valid_Cmd_1
//  304   }
//  305   else
//  306     Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
??SCSI_Valid_Cmd_0:
        MOVS     R1,#+1
??SCSI_Valid_Cmd_1:
        BL       Set_CSW
//  307 }
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock11
//  308 /*******************************************************************************
//  309 * Function Name  : SCSI_Valid_Cmd
//  310 * Description    : Valid Commands routine.
//  311 * Input          : None.
//  312 * Output         : None.
//  313 * Return         : None.
//  314 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function SCSI_TestUnitReady_Cmd
        THUMB
//  315 void SCSI_TestUnitReady_Cmd(void)
//  316 {
SCSI_TestUnitReady_Cmd:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  317   MAL_GetStatus();
        BL       MAL_GetStatus
//  318   Set_CSW (CSW_CMD_PASSED, SEND_CSW_ENABLE);
        MOVS     R1,#+1
        MOVS     R0,#+0
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      Set_CSW
        CFI EndBlock cfiBlock12
//  319 }
//  320 /*******************************************************************************
//  321 * Function Name  : SCSI_Format_Cmd
//  322 * Description    : Format Commands routine.
//  323 * Input          : None.
//  324 * Output         : None.
//  325 * Return         : None.
//  326 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function SCSI_Format_Cmd
        THUMB
//  327 void SCSI_Format_Cmd(void)
//  328 {
//  329   MAL_GetStatus();
SCSI_Format_Cmd:
        B.W      MAL_GetStatus
        CFI EndBlock cfiBlock13
//  330 }
//  331 /*******************************************************************************
//  332 * Function Name  : SCSI_Invalid_Cmd
//  333 * Description    : Invalid Commands routine
//  334 * Input          : None.
//  335 * Output         : None.
//  336 * Return         : None.
//  337 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function SCSI_Invalid_Cmd
        THUMB
//  338 void SCSI_Invalid_Cmd(void)
//  339 {
SCSI_Invalid_Cmd:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  340   if (CBW.dDataLength == 0)
        LDR.N    R0,??DataTable16  ;; CBW
        LDR      R1,[R0, #+8]
        CBNZ     R1,??SCSI_Invalid_Cmd_0
//  341   {
//  342     Bot_Abort(DIR_IN);
        MOVS     R0,#+0
        B.N      ??SCSI_Invalid_Cmd_1
//  343   }
//  344   else
//  345   {
//  346     if ((CBW.bmFlags & 0x80) != 0)
??SCSI_Invalid_Cmd_0:
        LDRB     R0,[R0, #+12]
        TST      R0,#0x80
        BEQ.N    ??SCSI_Invalid_Cmd_2
//  347     {
//  348       Bot_Abort(DIR_IN);
        MOVS     R0,#+0
        B.N      ??SCSI_Invalid_Cmd_1
//  349     }
//  350     else
//  351     {
//  352       Bot_Abort(BOTH_DIR);
??SCSI_Invalid_Cmd_2:
        MOVS     R0,#+2
??SCSI_Invalid_Cmd_1:
        BL       Bot_Abort
//  353     }
//  354   }
//  355   Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_COMMAND);
        MOVS     R1,#+32
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  356   Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {LR}
        CFI R14 SameValue
        CFI CFA R13+0
        B.W      Set_CSW
        CFI EndBlock cfiBlock14
//  357 }
//  358 
//  359 /*******************************************************************************
//  360 * Function Name  : SCSI_Address_Management
//  361 * Description    : Test the received address.
//  362 * Input          : u8 Cmd : the command can be SCSI_READ10 or SCSI_WRITE10.
//  363 * Output         : None.
//  364 * Return         : Read\Write status (bool).
//  365 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function SCSI_Address_Management
        THUMB
//  366 bool SCSI_Address_Management(u8 Cmd , u32 LBA , u32 BlockNbr)
//  367 {
SCSI_Address_Management:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
//  368 
//  369   if ((LBA + BlockNbr) > Mass_Block_Count )
        LDR.N    R3,??DataTable15  ;; Mass_Block_Count
        LDR      R3,[R3, #+0]
        ADDS     R1,R2,R1
        CMP      R3,R1
        BCS.N    ??SCSI_Address_Management_0
//  370   {
//  371     if (Cmd == SCSI_WRITE10)
        CMP      R0,#+42
        BNE.N    ??SCSI_Address_Management_1
//  372     {
//  373       Bot_Abort(BOTH_DIR);
        MOVS     R0,#+2
        BL       Bot_Abort
//  374     }
//  375     Bot_Abort(DIR_IN);
??SCSI_Address_Management_1:
        MOVS     R0,#+0
        BL       Bot_Abort
//  376     Set_Scsi_Sense_Data(ILLEGAL_REQUEST, ADDRESS_OUT_OF_RANGE);
        MOVS     R1,#+33
??SCSI_Address_Management_2:
        MOVS     R0,#+5
        BL       Set_Scsi_Sense_Data
//  377     Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       Set_CSW
//  378     return (FALSE);
        MOVS     R0,#+0
        B.N      ??SCSI_Address_Management_3
//  379   }
//  380 
//  381 
//  382   if (CBW.dDataLength != BlockNbr * Mass_Block_Size)
??SCSI_Address_Management_0:
        LDR.N    R1,??DataTable16  ;; CBW
        LDR      R1,[R1, #+8]
        LDR.N    R3,??DataTable17  ;; Mass_Block_Size
        LDR      R3,[R3, #+0]
        MULS     R2,R2,R3
        CMP      R1,R2
        BEQ.N    ??SCSI_Address_Management_4
//  383   {
//  384     if (Cmd == SCSI_WRITE10)
        CMP      R0,#+42
        BNE.N    ??SCSI_Address_Management_5
//  385     {
//  386       Bot_Abort(BOTH_DIR);
        MOVS     R0,#+2
        B.N      ??SCSI_Address_Management_6
//  387     }
//  388     else
//  389     {
//  390       Bot_Abort(DIR_IN);
??SCSI_Address_Management_5:
        MOVS     R0,#+0
??SCSI_Address_Management_6:
        BL       Bot_Abort
//  391     }
//  392     Set_Scsi_Sense_Data(ILLEGAL_REQUEST, INVALID_FIELED_IN_COMMAND);
        MOVS     R1,#+36
        B.N      ??SCSI_Address_Management_2
//  393     Set_CSW (CSW_CMD_FAILED, SEND_CSW_DISABLE);
//  394     return (FALSE);
//  395   }
//  396   return (TRUE);
??SCSI_Address_Management_4:
        MOVS     R0,#+1
??SCSI_Address_Management_3:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock15
//  397 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable15:
        DC32     Mass_Block_Count

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable16:
        DC32     CBW

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     Mass_Block_Size

        END
//  398 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 660 bytes in section .text
// 
// 660 bytes of CODE memory
//
//Errors: none
//Warnings: none
