///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      09/Aug/2011  11:09:00 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\Mini-DS\DS203\FWLib\src\stm32f10x_flash.c            /
//    Command line =  E:\Mini-DS\DS203\FWLib\src\stm32f10x_flash.c -lA        /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\ -o      /
//                    E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\Obj\ --debug  /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\..\FWLi /
//                    b\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\..\ /
//                    ..\USBLib\inc\ -I E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prp /
//                    ject\..\include\ -I "C:\Program Files\IAR               /
//                    Systems\Embedded Workbench 5.0 Evaluation\ARM\INC\"     /
//                    -Ohs                                                    /
//    List file    =  E:\Mini-DS\DS203\APP_V2.51\IAR_V5_Prpject\List\stm32f10 /
//                    x_flash.s                                               /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_flash

        PUBLIC FLASH_ClearFlag
        PUBLIC FLASH_EnableWriteProtection
        PUBLIC FLASH_EraseAllPages
        PUBLIC FLASH_EraseOptionBytes
        PUBLIC FLASH_ErasePage
        PUBLIC FLASH_GetFlagStatus
        PUBLIC FLASH_GetPrefetchBufferStatus
        PUBLIC FLASH_GetReadOutProtectionStatus
        PUBLIC FLASH_GetStatus
        PUBLIC FLASH_GetUserOptionByte
        PUBLIC FLASH_GetWriteProtectionOptionByte
        PUBLIC FLASH_HalfCycleAccessCmd
        PUBLIC FLASH_ITConfig
        PUBLIC FLASH_Lock
        PUBLIC FLASH_PrefetchBufferCmd
        PUBLIC FLASH_ProgramHalfWord
        PUBLIC FLASH_ProgramOptionByteData
        PUBLIC FLASH_ProgramWord
        PUBLIC FLASH_ReadOutProtection
        PUBLIC FLASH_SetLatency
        PUBLIC FLASH_Unlock
        PUBLIC FLASH_UserOptionByteConfig
        PUBLIC FLASH_WaitForLastOperation
        
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
        
// E:\Mini-DS\DS203\FWLib\src\stm32f10x_flash.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_flash.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.3
//    5 * Date               : 09/22/2008
//    6 * Description        : This file provides all the FLASH firmware functions.
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
//   17 #include "stm32f10x_flash.h"
//   18 
//   19 /* Private typedef -----------------------------------------------------------*/
//   20 /* Private define ------------------------------------------------------------*/
//   21 /* Flash Access Control Register bits */
//   22 #define ACR_LATENCY_Mask         ((u32)0x00000038)
//   23 #define ACR_HLFCYA_Mask          ((u32)0xFFFFFFF7)
//   24 #define ACR_PRFTBE_Mask          ((u32)0xFFFFFFEF)
//   25 
//   26 #ifdef _FLASH_PROG
//   27 /* Flash Access Control Register bits */
//   28 #define ACR_PRFTBS_Mask          ((u32)0x00000020) 
//   29 
//   30 /* Flash Control Register bits */
//   31 #define CR_PG_Set                ((u32)0x00000001)
//   32 #define CR_PG_Reset              ((u32)0x00001FFE) 
//   33 
//   34 #define CR_PER_Set               ((u32)0x00000002)
//   35 #define CR_PER_Reset             ((u32)0x00001FFD)
//   36 
//   37 #define CR_MER_Set               ((u32)0x00000004)
//   38 #define CR_MER_Reset             ((u32)0x00001FFB)
//   39 
//   40 #define CR_OPTPG_Set             ((u32)0x00000010)
//   41 #define CR_OPTPG_Reset           ((u32)0x00001FEF)
//   42 
//   43 #define CR_OPTER_Set             ((u32)0x00000020)
//   44 #define CR_OPTER_Reset           ((u32)0x00001FDF)
//   45 
//   46 #define CR_STRT_Set              ((u32)0x00000040)
//   47 							 
//   48 #define CR_LOCK_Set              ((u32)0x00000080)
//   49 
//   50 /* FLASH Mask */
//   51 #define RDPRT_Mask               ((u32)0x00000002)
//   52 #define WRP0_Mask                ((u32)0x000000FF)
//   53 #define WRP1_Mask                ((u32)0x0000FF00)
//   54 #define WRP2_Mask                ((u32)0x00FF0000)
//   55 #define WRP3_Mask                ((u32)0xFF000000)
//   56 
//   57 /* FLASH Keys */
//   58 #define RDP_Key                  ((u16)0x00A5)
//   59 #define FLASH_KEY1               ((u32)0x45670123)
//   60 #define FLASH_KEY2               ((u32)0xCDEF89AB)
//   61 
//   62 /* Delay definition */   
//   63 #define EraseTimeout             ((u32)0x00000FFF)
//   64 #define ProgramTimeout           ((u32)0x0000000F)
//   65 #endif
//   66 
//   67 /* Private macro -------------------------------------------------------------*/
//   68 /* Private variables ---------------------------------------------------------*/
//   69 /* Private function prototypes -----------------------------------------------*/
//   70 #ifdef _FLASH_PROG
//   71 static void delay(void);
//   72 #endif
//   73 
//   74 /* Private functions ---------------------------------------------------------*/
//   75 /*******************************************************************************
//   76 * Function Name  : FLASH_SetLatency
//   77 * Description    : Sets the code latency value.
//   78 * Input          : - FLASH_Latency: specifies the FLASH Latency value.
//   79 *                    This parameter can be one of the following values:
//   80 *                       - FLASH_Latency_0: FLASH Zero Latency cycle
//   81 *                       - FLASH_Latency_1: FLASH One Latency cycle
//   82 *                       - FLASH_Latency_2: FLASH Two Latency cycles
//   83 * Output         : None
//   84 * Return         : None
//   85 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function FLASH_SetLatency
        THUMB
//   86 void FLASH_SetLatency(u32 FLASH_Latency)
//   87 {
//   88   /* Check the parameters */
//   89   assert_param(IS_FLASH_LATENCY(FLASH_Latency));
//   90   
//   91   /* Sets the Latency value */
//   92   FLASH->ACR &= ACR_LATENCY_Mask;
FLASH_SetLatency:
        LDR.N    R1,??DataTable2  ;; 0x40022000
        LDR      R2,[R1, #+0]
        AND      R2,R2,#0x38
        STR      R2,[R1, #+0]
//   93   FLASH->ACR |= FLASH_Latency;
        LDR      R2,[R1, #+0]
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//   94 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock0
//   95 
//   96 /*******************************************************************************
//   97 * Function Name  : FLASH_HalfCycleAccessCmd
//   98 * Description    : Enables or disables the Half cycle flash access.
//   99 * Input          : - FLASH_HalfCycle: specifies the FLASH Half cycle Access mode.
//  100 *                    This parameter can be one of the following values:
//  101 *                       - FLASH_HalfCycleAccess_Enable: FLASH Half Cycle Enable
//  102 *                       - FLASH_HalfCycleAccess_Disable: FLASH Half Cycle Disable
//  103 * Output         : None
//  104 * Return         : None
//  105 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function FLASH_HalfCycleAccessCmd
        THUMB
//  106 void FLASH_HalfCycleAccessCmd(u32 FLASH_HalfCycleAccess)
//  107 {
//  108   /* Check the parameters */
//  109   assert_param(IS_FLASH_HALFCYCLEACCESS_STATE(FLASH_HalfCycleAccess));
//  110   
//  111   /* Enable or disable the Half cycle access */
//  112   FLASH->ACR &= ACR_HLFCYA_Mask;
FLASH_HalfCycleAccessCmd:
        LDR.N    R1,??DataTable2  ;; 0x40022000
        LDR      R2,[R1, #+0]
        MOVS     R3,#+8
        BICS     R2,R2,R3
        STR      R2,[R1, #+0]
//  113   FLASH->ACR |= FLASH_HalfCycleAccess;
        LDR      R2,[R1, #+0]
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  114 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  115 
//  116 /*******************************************************************************
//  117 * Function Name  : FLASH_PrefetchBufferCmd
//  118 * Description    : Enables or disables the Prefetch Buffer.
//  119 * Input          : - FLASH_PrefetchBuffer: specifies the Prefetch buffer status.
//  120 *                    This parameter can be one of the following values:
//  121 *                       - FLASH_PrefetchBuffer_Enable: FLASH Prefetch Buffer Enable
//  122 *                       - FLASH_PrefetchBuffer_Disable: FLASH Prefetch Buffer Disable
//  123 * Output         : None
//  124 * Return         : None
//  125 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function FLASH_PrefetchBufferCmd
        THUMB
//  126 void FLASH_PrefetchBufferCmd(u32 FLASH_PrefetchBuffer)
//  127 {
//  128   /* Check the parameters */
//  129   assert_param(IS_FLASH_PREFETCHBUFFER_STATE(FLASH_PrefetchBuffer));
//  130   
//  131   /* Enable or disable the Prefetch Buffer */
//  132   FLASH->ACR &= ACR_PRFTBE_Mask;
FLASH_PrefetchBufferCmd:
        LDR.N    R1,??DataTable2  ;; 0x40022000
        LDR      R2,[R1, #+0]
        MOVS     R3,#+16
        BICS     R2,R2,R3
        STR      R2,[R1, #+0]
//  133   FLASH->ACR |= FLASH_PrefetchBuffer;
        LDR      R2,[R1, #+0]
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  134 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock2

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable2:
        DC32     0x40022000
//  135 
//  136 #ifdef _FLASH_PROG
//  137 /*******************************************************************************
//  138 * Function Name  : FLASH_Unlock
//  139 * Description    : Unlocks the FLASH Program Erase Controller.
//  140 * Input          : None
//  141 * Output         : None
//  142 * Return         : None
//  143 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function FLASH_Unlock
        THUMB
//  144 void FLASH_Unlock(void)
//  145 {
//  146   /* Authorize the FPEC Access */
//  147   FLASH->KEYR = FLASH_KEY1;
FLASH_Unlock:
        LDR.N    R0,??FLASH_Unlock_0  ;; 0x40022004
        LDR.W    R1,??DataTable51  ;; 0x45670123
        STR      R1,[R0, #+0]
//  148   FLASH->KEYR = FLASH_KEY2;
        LDR.W    R1,??DataTable52  ;; 0xcdef89ab
        STR      R1,[R0, #+0]
//  149 }
        BX       LR               ;; return
        DATA
??FLASH_Unlock_0:
        DC32     0x40022004
        CFI EndBlock cfiBlock3
//  150 
//  151 /*******************************************************************************
//  152 * Function Name  : FLASH_Lock
//  153 * Description    : Locks the FLASH Program Erase Controller.
//  154 * Input          : None
//  155 * Output         : None
//  156 * Return         : None
//  157 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function FLASH_Lock
        THUMB
//  158 void FLASH_Lock(void)
//  159 {
//  160   /* Set the Lock Bit to lock the FPEC and the FCR */
//  161   FLASH->CR |= CR_LOCK_Set;
FLASH_Lock:
        LDR.N    R0,??DataTable5  ;; 0x40022010
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x80
        STR      R1,[R0, #+0]
//  162 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock4

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable5:
        DC32     0x40022010
//  163 
//  164 /*******************************************************************************
//  165 * Function Name  : FLASH_ErasePage
//  166 * Description    : Erases a specified FLASH page.
//  167 * Input          : - Page_Address: The page address to be erased.
//  168 * Output         : None
//  169 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  170 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  171 *                  FLASH_TIMEOUT.
//  172 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function FLASH_ErasePage
        THUMB
//  173 FLASH_Status FLASH_ErasePage(u32 Page_Address)
//  174 {
FLASH_ErasePage:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
        MOVS     R1,R0
//  175   FLASH_Status status = FLASH_COMPLETE;
//  176 
//  177   /* Check the parameters */
//  178   assert_param(IS_FLASH_ADDRESS(Page_Address));
//  179 
//  180   /* Wait for last operation to be completed */
//  181   status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R3,#+4095
        LDR.W    R2,??DataTable40  ;; 0x4002200c
        LDR      R0,[R2, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ErasePage_0
        MOVS     R0,#+1
??FLASH_ErasePage_1:
        MOV      LR,#+0
        STR      LR,[SP, #+0]
        MOV      LR,#+255
        STR      LR,[SP, #+0]
        B.N      ??FLASH_ErasePage_2
??FLASH_ErasePage_0:
        LDR      R0,[R2, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ErasePage_3
        MOVS     R0,#+2
        B.N      ??FLASH_ErasePage_4
??FLASH_ErasePage_3:
        LDR      R0,[R2, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ErasePage_5
        MOVS     R0,#+3
        B.N      ??FLASH_ErasePage_4
??FLASH_ErasePage_5:
        MOVS     R0,#+4
        B.N      ??FLASH_ErasePage_4
??FLASH_ErasePage_6:
        LDR      R12,[SP, #+0]
        SUB      LR,R12,#+1
        STR      LR,[SP, #+0]
??FLASH_ErasePage_2:
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_ErasePage_6
        LDR      R12,[R2, #+0]
        TST      R12,#0x1
        BNE.N    ??FLASH_ErasePage_7
        LDR      R0,[R2, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ErasePage_8
        MOVS     R0,#+2
        B.N      ??FLASH_ErasePage_7
??FLASH_ErasePage_8:
        LDR      R0,[R2, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ErasePage_9
        MOVS     R0,#+3
        B.N      ??FLASH_ErasePage_7
??FLASH_ErasePage_9:
        MOVS     R0,#+4
??FLASH_ErasePage_7:
        SUBS     R3,R3,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ErasePage_10
        CMP      R3,#+0
        BNE.N    ??FLASH_ErasePage_1
        B.N      ??FLASH_ErasePage_11
??FLASH_ErasePage_10:
        CBNZ     R3,??FLASH_ErasePage_4
??FLASH_ErasePage_11:
        MOVS     R0,#+5
//  182   
//  183   if(status == FLASH_COMPLETE)
??FLASH_ErasePage_4:
        CMP      R0,#+4
        BNE.N    ??FLASH_ErasePage_12
//  184   { 
//  185     /* if the previous operation is completed, proceed to erase the page */
//  186     FLASH->CR|= CR_PER_Set;
        LDR      R0,[R2, #+4]
        ORR      R0,R0,#0x2
        STR      R0,[R2, #+4]
//  187     FLASH->AR = Page_Address; 
        STR      R1,[R2, #+8]
//  188     FLASH->CR|= CR_STRT_Set;
        LDR      R0,[R2, #+4]
        ORR      R0,R0,#0x40
        STR      R0,[R2, #+4]
//  189     
//  190     /* Wait for last operation to be completed */
//  191     status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R1,#+4095
        LDR      R0,[R2, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ErasePage_13
        MOVS     R0,#+1
??FLASH_ErasePage_14:
        MOVS     R3,#+0
        STR      R3,[SP, #+0]
        MOVS     R3,#+255
        B.N      ??FLASH_ErasePage_15
??FLASH_ErasePage_13:
        LDR      R0,[R2, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ErasePage_16
        MOVS     R0,#+2
        B.N      ??FLASH_ErasePage_17
??FLASH_ErasePage_16:
        LDR      R0,[R2, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ErasePage_18
        MOVS     R0,#+3
        B.N      ??FLASH_ErasePage_17
??FLASH_ErasePage_18:
        MOVS     R0,#+4
        B.N      ??FLASH_ErasePage_17
??FLASH_ErasePage_19:
        LDR      R3,[SP, #+0]
        SUBS     R3,R3,#+1
??FLASH_ErasePage_15:
        STR      R3,[SP, #+0]
        LDR      R3,[SP, #+0]
        CMP      R3,#+0
        BNE.N    ??FLASH_ErasePage_19
        LDR      R3,[R2, #+0]
        TST      R3,#0x1
        BNE.N    ??FLASH_ErasePage_20
        LDR      R0,[R2, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ErasePage_21
        MOVS     R0,#+2
        B.N      ??FLASH_ErasePage_20
??FLASH_ErasePage_21:
        LDR      R0,[R2, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ErasePage_22
        MOVS     R0,#+3
        B.N      ??FLASH_ErasePage_20
??FLASH_ErasePage_22:
        MOVS     R0,#+4
??FLASH_ErasePage_20:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ErasePage_23
        CMP      R1,#+0
        BNE.N    ??FLASH_ErasePage_14
        B.N      ??FLASH_ErasePage_24
??FLASH_ErasePage_23:
        CBNZ     R1,??FLASH_ErasePage_17
??FLASH_ErasePage_24:
        MOVS     R0,#+5
//  192 
//  193     if(status != FLASH_BUSY)
??FLASH_ErasePage_17:
        CMP      R0,#+1
        BEQ.N    ??FLASH_ErasePage_12
//  194     {
//  195       /* if the erase operation is completed, disable the PER Bit */
//  196       FLASH->CR &= CR_PER_Reset;
        LDR      R1,[R2, #+4]
        MOVW     R2,#+8189
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable40  ;; 0x4002200c
        STR      R1,[R2, #+4]
//  197     }
//  198   }
//  199   /* Return the Erase Status */
//  200   return status;
??FLASH_ErasePage_12:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock5
//  201 }
//  202 
//  203 /*******************************************************************************
//  204 * Function Name  : FLASH_EraseAllPages
//  205 * Description    : Erases all FLASH pages.
//  206 * Input          : None
//  207 * Output         : None
//  208 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  209 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  210 *                  FLASH_TIMEOUT.
//  211 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function FLASH_EraseAllPages
        THUMB
//  212 FLASH_Status FLASH_EraseAllPages(void)
//  213 {
FLASH_EraseAllPages:
        SUB      SP,SP,#+8
        CFI CFA R13+8
//  214   FLASH_Status status = FLASH_COMPLETE;
//  215 
//  216   /* Wait for last operation to be completed */
//  217   status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R2,#+4095
        LDR.W    R1,??DataTable40  ;; 0x4002200c
        LDR      R0,[R1, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EraseAllPages_0
        MOVS     R0,#+1
??FLASH_EraseAllPages_1:
        MOVS     R3,#+0
        STR      R3,[SP, #+0]
        MOVS     R3,#+255
        B.N      ??FLASH_EraseAllPages_2
??FLASH_EraseAllPages_0:
        LDR      R0,[R1, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseAllPages_3
        MOVS     R0,#+2
        B.N      ??FLASH_EraseAllPages_4
??FLASH_EraseAllPages_3:
        LDR      R0,[R1, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseAllPages_5
        MOVS     R0,#+3
        B.N      ??FLASH_EraseAllPages_4
??FLASH_EraseAllPages_5:
        MOVS     R0,#+4
        B.N      ??FLASH_EraseAllPages_4
??FLASH_EraseAllPages_6:
        LDR      R3,[SP, #+0]
        SUBS     R3,R3,#+1
??FLASH_EraseAllPages_2:
        STR      R3,[SP, #+0]
        LDR      R3,[SP, #+0]
        CMP      R3,#+0
        BNE.N    ??FLASH_EraseAllPages_6
        LDR      R3,[R1, #+0]
        TST      R3,#0x1
        BNE.N    ??FLASH_EraseAllPages_7
        LDR      R0,[R1, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseAllPages_8
        MOVS     R0,#+2
        B.N      ??FLASH_EraseAllPages_7
??FLASH_EraseAllPages_8:
        LDR      R0,[R1, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseAllPages_9
        MOVS     R0,#+3
        B.N      ??FLASH_EraseAllPages_7
??FLASH_EraseAllPages_9:
        MOVS     R0,#+4
??FLASH_EraseAllPages_7:
        SUBS     R2,R2,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EraseAllPages_10
        CMP      R2,#+0
        BNE.N    ??FLASH_EraseAllPages_1
        B.N      ??FLASH_EraseAllPages_11
??FLASH_EraseAllPages_10:
        CBNZ     R2,??FLASH_EraseAllPages_4
??FLASH_EraseAllPages_11:
        MOVS     R0,#+5
//  218   
//  219   if(status == FLASH_COMPLETE)
??FLASH_EraseAllPages_4:
        CMP      R0,#+4
        BNE.N    ??FLASH_EraseAllPages_12
//  220   {
//  221     /* if the previous operation is completed, proceed to erase all pages */
//  222      FLASH->CR |= CR_MER_Set;
        LDR      R0,[R1, #+4]
        ORR      R0,R0,#0x4
        STR      R0,[R1, #+4]
//  223      FLASH->CR |= CR_STRT_Set;
        LDR      R0,[R1, #+4]
        ORR      R0,R0,#0x40
        STR      R0,[R1, #+4]
//  224     
//  225     /* Wait for last operation to be completed */
//  226     status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R2,#+4095
        LDR      R0,[R1, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EraseAllPages_13
        MOVS     R0,#+1
??FLASH_EraseAllPages_14:
        MOVS     R3,#+0
        STR      R3,[SP, #+0]
        MOVS     R3,#+255
        B.N      ??FLASH_EraseAllPages_15
??FLASH_EraseAllPages_13:
        LDR      R0,[R1, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseAllPages_16
        MOVS     R0,#+2
        B.N      ??FLASH_EraseAllPages_17
??FLASH_EraseAllPages_16:
        LDR      R0,[R1, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseAllPages_18
        MOVS     R0,#+3
        B.N      ??FLASH_EraseAllPages_17
??FLASH_EraseAllPages_18:
        MOVS     R0,#+4
        B.N      ??FLASH_EraseAllPages_17
??FLASH_EraseAllPages_19:
        LDR      R3,[SP, #+0]
        SUBS     R3,R3,#+1
??FLASH_EraseAllPages_15:
        STR      R3,[SP, #+0]
        LDR      R3,[SP, #+0]
        CMP      R3,#+0
        BNE.N    ??FLASH_EraseAllPages_19
        LDR      R3,[R1, #+0]
        TST      R3,#0x1
        BNE.N    ??FLASH_EraseAllPages_20
        LDR      R0,[R1, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseAllPages_21
        MOVS     R0,#+2
        B.N      ??FLASH_EraseAllPages_20
??FLASH_EraseAllPages_21:
        LDR      R0,[R1, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseAllPages_22
        MOVS     R0,#+3
        B.N      ??FLASH_EraseAllPages_20
??FLASH_EraseAllPages_22:
        MOVS     R0,#+4
??FLASH_EraseAllPages_20:
        SUBS     R2,R2,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EraseAllPages_23
        CMP      R2,#+0
        BNE.N    ??FLASH_EraseAllPages_14
        B.N      ??FLASH_EraseAllPages_24
??FLASH_EraseAllPages_23:
        CBNZ     R2,??FLASH_EraseAllPages_17
??FLASH_EraseAllPages_24:
        MOVS     R0,#+5
//  227 
//  228     if(status != FLASH_BUSY)
??FLASH_EraseAllPages_17:
        CMP      R0,#+1
        BEQ.N    ??FLASH_EraseAllPages_12
//  229     {
//  230       /* if the erase operation is completed, disable the MER Bit */
//  231       FLASH->CR &= CR_MER_Reset;
        LDR      R1,[R1, #+4]
        MOVW     R2,#+8187
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable40  ;; 0x4002200c
        STR      R1,[R2, #+4]
//  232     }
//  233   }	   
//  234   /* Return the Erase Status */
//  235   return status;
??FLASH_EraseAllPages_12:
        ADD      SP,SP,#+8
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock6
//  236 }
//  237 
//  238 /*******************************************************************************
//  239 * Function Name  : FLASH_EraseOptionBytes
//  240 * Description    : Erases the FLASH option bytes.
//  241 * Input          : None
//  242 * Output         : None
//  243 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  244 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  245 *                  FLASH_TIMEOUT.
//  246 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function FLASH_EraseOptionBytes
        THUMB
//  247 FLASH_Status FLASH_EraseOptionBytes(void)
//  248 {
FLASH_EraseOptionBytes:
        SUB      SP,SP,#+8
        CFI CFA R13+8
//  249   FLASH_Status status = FLASH_COMPLETE;
//  250   
//  251   /* Wait for last operation to be completed */
//  252   status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R1,#+4095
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EraseOptionBytes_0
        MOVS     R0,#+1
??FLASH_EraseOptionBytes_1:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_EraseOptionBytes_2
??FLASH_EraseOptionBytes_0:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseOptionBytes_3
        MOVS     R0,#+2
        B.N      ??FLASH_EraseOptionBytes_4
??FLASH_EraseOptionBytes_3:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseOptionBytes_5
        MOVS     R0,#+3
        B.N      ??FLASH_EraseOptionBytes_4
??FLASH_EraseOptionBytes_5:
        MOVS     R0,#+4
        B.N      ??FLASH_EraseOptionBytes_4
??FLASH_EraseOptionBytes_6:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_EraseOptionBytes_2:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_EraseOptionBytes_6
        LDR.W    R2,??DataTable50  ;; 0x40022008
        LDR      R2,[R2, #+4]
        TST      R2,#0x1
        BNE.N    ??FLASH_EraseOptionBytes_7
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseOptionBytes_8
        MOVS     R0,#+2
        B.N      ??FLASH_EraseOptionBytes_7
??FLASH_EraseOptionBytes_8:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseOptionBytes_9
        MOVS     R0,#+3
        B.N      ??FLASH_EraseOptionBytes_7
??FLASH_EraseOptionBytes_9:
        MOVS     R0,#+4
??FLASH_EraseOptionBytes_7:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EraseOptionBytes_10
        CMP      R1,#+0
        BNE.N    ??FLASH_EraseOptionBytes_1
        B.N      ??FLASH_EraseOptionBytes_11
??FLASH_EraseOptionBytes_10:
        CBNZ     R1,??FLASH_EraseOptionBytes_4
??FLASH_EraseOptionBytes_11:
        MOVS     R0,#+5
//  253 
//  254   if(status == FLASH_COMPLETE)
??FLASH_EraseOptionBytes_4:
        CMP      R0,#+4
        BNE.W    ??FLASH_EraseOptionBytes_12
//  255   {
//  256     /* Authorize the small information block programming */
//  257     FLASH->OPTKEYR = FLASH_KEY1;
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR.W    R1,??DataTable51  ;; 0x45670123
        STR      R1,[R0, #+0]
//  258     FLASH->OPTKEYR = FLASH_KEY2;
        LDR.W    R1,??DataTable52  ;; 0xcdef89ab
        STR      R1,[R0, #+0]
//  259     
//  260     /* if the previous operation is completed, proceed to erase the option bytes */
//  261     FLASH->CR |= CR_OPTER_Set;
        LDR      R0,[R0, #+8]
        ORR      R0,R0,#0x20
        LDR.W    R1,??DataTable50  ;; 0x40022008
        STR      R0,[R1, #+8]
//  262     FLASH->CR |= CR_STRT_Set;
        LDR      R0,[R1, #+8]
        ORR      R0,R0,#0x40
        STR      R0,[R1, #+8]
//  263 
//  264     /* Wait for last operation to be completed */
//  265     status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R1,#+4095
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EraseOptionBytes_13
        MOVS     R0,#+1
??FLASH_EraseOptionBytes_14:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_EraseOptionBytes_15
??FLASH_EraseOptionBytes_13:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseOptionBytes_16
        MOVS     R0,#+2
        B.N      ??FLASH_EraseOptionBytes_17
??FLASH_EraseOptionBytes_16:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseOptionBytes_18
        MOVS     R0,#+3
        B.N      ??FLASH_EraseOptionBytes_17
??FLASH_EraseOptionBytes_18:
        MOVS     R0,#+4
        B.N      ??FLASH_EraseOptionBytes_17
??FLASH_EraseOptionBytes_19:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_EraseOptionBytes_15:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_EraseOptionBytes_19
        LDR.W    R2,??DataTable50  ;; 0x40022008
        LDR      R2,[R2, #+4]
        TST      R2,#0x1
        BNE.N    ??FLASH_EraseOptionBytes_20
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseOptionBytes_21
        MOVS     R0,#+2
        B.N      ??FLASH_EraseOptionBytes_20
??FLASH_EraseOptionBytes_21:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseOptionBytes_22
        MOVS     R0,#+3
        B.N      ??FLASH_EraseOptionBytes_20
??FLASH_EraseOptionBytes_22:
        MOVS     R0,#+4
??FLASH_EraseOptionBytes_20:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EraseOptionBytes_23
        CMP      R1,#+0
        BNE.N    ??FLASH_EraseOptionBytes_14
        B.N      ??FLASH_EraseOptionBytes_24
??FLASH_EraseOptionBytes_23:
        CBNZ     R1,??FLASH_EraseOptionBytes_17
??FLASH_EraseOptionBytes_24:
        MOVS     R0,#+5
//  266     
//  267     if(status == FLASH_COMPLETE)
??FLASH_EraseOptionBytes_17:
        CMP      R0,#+4
        BNE.N    ??FLASH_EraseOptionBytes_25
//  268     {
//  269       /* if the erase operation is completed, disable the OPTER Bit */
//  270       FLASH->CR &= CR_OPTER_Reset;
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+8]
        MOVW     R1,#+8159
        ANDS     R0,R1,R0
        LDR.W    R1,??DataTable50  ;; 0x40022008
        STR      R0,[R1, #+8]
//  271        
//  272       /* Enable the Option Bytes Programming operation */
//  273       FLASH->CR |= CR_OPTPG_Set;
        LDR      R0,[R1, #+8]
        ORR      R0,R0,#0x10
        STR      R0,[R1, #+8]
//  274 
//  275       /* Enable the readout access */
//  276       OB->RDP= RDP_Key; 
        LDR.N    R0,??DataTable28  ;; 0x1ffff800
        MOVS     R1,#+165
        STRH     R1,[R0, #+0]
//  277 
//  278       /* Wait for last operation to be completed */
//  279       status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R1,#+15
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EraseOptionBytes_26
        MOVS     R0,#+1
??FLASH_EraseOptionBytes_27:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_EraseOptionBytes_28
??FLASH_EraseOptionBytes_26:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseOptionBytes_29
        MOVS     R0,#+2
        B.N      ??FLASH_EraseOptionBytes_30
??FLASH_EraseOptionBytes_29:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseOptionBytes_31
        MOVS     R0,#+3
        B.N      ??FLASH_EraseOptionBytes_30
??FLASH_EraseOptionBytes_31:
        MOVS     R0,#+4
        B.N      ??FLASH_EraseOptionBytes_30
??FLASH_EraseOptionBytes_32:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_EraseOptionBytes_28:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_EraseOptionBytes_32
        LDR.W    R2,??DataTable50  ;; 0x40022008
        LDR      R2,[R2, #+4]
        TST      R2,#0x1
        BNE.N    ??FLASH_EraseOptionBytes_33
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EraseOptionBytes_34
        MOVS     R0,#+2
        B.N      ??FLASH_EraseOptionBytes_33
??FLASH_EraseOptionBytes_34:
        LDR.W    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EraseOptionBytes_35
        MOVS     R0,#+3
        B.N      ??FLASH_EraseOptionBytes_33
??FLASH_EraseOptionBytes_35:
        MOVS     R0,#+4
??FLASH_EraseOptionBytes_33:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EraseOptionBytes_36
        CMP      R1,#+0
        BNE.N    ??FLASH_EraseOptionBytes_27
        B.N      ??FLASH_EraseOptionBytes_37
??FLASH_EraseOptionBytes_36:
        CBNZ     R1,??FLASH_EraseOptionBytes_30
??FLASH_EraseOptionBytes_37:
        MOVS     R0,#+5
//  280  
//  281       if(status != FLASH_BUSY)
??FLASH_EraseOptionBytes_30:
        CMP      R0,#+1
        BEQ.N    ??FLASH_EraseOptionBytes_12
//  282       {
//  283         /* if the program operation is completed, disable the OPTPG Bit */
//  284         FLASH->CR &= CR_OPTPG_Reset;
        LDR.W    R1,??DataTable50  ;; 0x40022008
        LDR      R1,[R1, #+8]
        MOVW     R2,#+8175
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable50  ;; 0x40022008
        B.N      ??FLASH_EraseOptionBytes_38
//  285       }
//  286     }
//  287     else
//  288     {
//  289       if (status != FLASH_BUSY)
??FLASH_EraseOptionBytes_25:
        CMP      R0,#+1
        BEQ.N    ??FLASH_EraseOptionBytes_12
//  290       {
//  291         /* Disable the OPTPG Bit */
//  292         FLASH->CR &= CR_OPTPG_Reset;
        LDR.W    R1,??DataTable50  ;; 0x40022008
        LDR      R1,[R1, #+8]
        MOVW     R2,#+8175
        ANDS     R1,R2,R1
        LDR.W    R2,??DataTable50  ;; 0x40022008
??FLASH_EraseOptionBytes_38:
        STR      R1,[R2, #+8]
//  293       }
//  294     }  
//  295   }
//  296   /* Return the erase status */
//  297   return status;
??FLASH_EraseOptionBytes_12:
        ADD      SP,SP,#+8
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  298 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable28:
        DC32     0x1ffff800
//  299 
//  300 /*******************************************************************************
//  301 * Function Name  : FLASH_ProgramWord
//  302 * Description    : Programs a word at a specified address.
//  303 * Input          : - Address: specifies the address to be programmed.
//  304 *                  - Data: specifies the data to be programmed.
//  305 * Output         : None
//  306 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  307 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  308 *                  FLASH_TIMEOUT. 
//  309 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function FLASH_ProgramWord
        THUMB
//  310 FLASH_Status FLASH_ProgramWord(u32 Address, u32 Data)
//  311 {
FLASH_ProgramWord:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
        MOVS     R2,R0
//  312   FLASH_Status status = FLASH_COMPLETE;
//  313 
//  314   /* Check the parameters */
//  315   assert_param(IS_FLASH_ADDRESS(Address));
//  316 
//  317   /* Wait for last operation to be completed */
//  318   status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOV      LR,#+15
        LDR.N    R3,??DataTable40  ;; 0x4002200c
        LDR      R0,[R3, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ProgramWord_0
        MOVS     R0,#+1
??FLASH_ProgramWord_1:
        MOVS     R4,#+0
        STR      R4,[SP, #+0]
        MOVS     R4,#+255
        B.N      ??FLASH_ProgramWord_2
??FLASH_ProgramWord_0:
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramWord_3
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramWord_4
??FLASH_ProgramWord_3:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramWord_5
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramWord_4
??FLASH_ProgramWord_5:
        MOVS     R0,#+4
        B.N      ??FLASH_ProgramWord_4
??FLASH_ProgramWord_6:
        LDR      R12,[SP, #+0]
        SUB      R4,R12,#+1
??FLASH_ProgramWord_2:
        STR      R4,[SP, #+0]
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_ProgramWord_6
        LDR      R12,[R3, #+0]
        TST      R12,#0x1
        BNE.N    ??FLASH_ProgramWord_7
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramWord_8
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramWord_7
??FLASH_ProgramWord_8:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramWord_9
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramWord_7
??FLASH_ProgramWord_9:
        MOVS     R0,#+4
??FLASH_ProgramWord_7:
        SUB      LR,LR,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ProgramWord_10
        CMP      LR,#+0
        BNE.N    ??FLASH_ProgramWord_1
        B.N      ??FLASH_ProgramWord_11
??FLASH_ProgramWord_10:
        CMP      LR,#+0
        BNE.N    ??FLASH_ProgramWord_4
??FLASH_ProgramWord_11:
        MOVS     R0,#+5
//  319   
//  320   if(status == FLASH_COMPLETE)
??FLASH_ProgramWord_4:
        CMP      R0,#+4
        BNE.W    ??FLASH_ProgramWord_12
//  321   {
//  322     /* if the previous operation is completed, proceed to program the new first 
//  323     half word */
//  324     FLASH->CR |= CR_PG_Set;
        LDR      R0,[R3, #+4]
        ORR      R0,R0,#0x1
        STR      R0,[R3, #+4]
//  325   
//  326     *(vu16*)Address = (u16)Data;
        STRH     R1,[R2, #+0]
//  327 
//  328     /* Wait for last operation to be completed */
//  329     status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOV      LR,#+15
        LDR      R0,[R3, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ProgramWord_13
        MOVS     R0,#+1
??FLASH_ProgramWord_14:
        MOVS     R4,#+0
        STR      R4,[SP, #+0]
        MOVS     R4,#+255
        B.N      ??FLASH_ProgramWord_15
??FLASH_ProgramWord_13:
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramWord_16
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramWord_17
??FLASH_ProgramWord_16:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramWord_18
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramWord_17
??FLASH_ProgramWord_18:
        MOVS     R0,#+4
        B.N      ??FLASH_ProgramWord_17
??FLASH_ProgramWord_19:
        LDR      R12,[SP, #+0]
        SUB      R4,R12,#+1
??FLASH_ProgramWord_15:
        STR      R4,[SP, #+0]
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_ProgramWord_19
        LDR      R12,[R3, #+0]
        TST      R12,#0x1
        BNE.N    ??FLASH_ProgramWord_20
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramWord_21
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramWord_20
??FLASH_ProgramWord_21:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramWord_22
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramWord_20
??FLASH_ProgramWord_22:
        MOVS     R0,#+4
??FLASH_ProgramWord_20:
        SUB      LR,LR,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ProgramWord_23
        CMP      LR,#+0
        BNE.N    ??FLASH_ProgramWord_14
        B.N      ??FLASH_ProgramWord_24
??FLASH_ProgramWord_23:
        CMP      LR,#+0
        BNE.N    ??FLASH_ProgramWord_17
??FLASH_ProgramWord_24:
        MOVS     R0,#+5
//  330  
//  331     if(status == FLASH_COMPLETE)
??FLASH_ProgramWord_17:
        CMP      R0,#+4
        BNE.N    ??FLASH_ProgramWord_25
//  332     {
//  333       /* if the previous operation is completed, proceed to program the new second 
//  334       half word */
//  335       *(vu16*)(Address + 2) = Data >> 16;
        LSRS     R0,R1,#+16
        STRH     R0,[R2, #+2]
//  336     
//  337       /* Wait for last operation to be completed */
//  338       status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R1,#+15
        LDR      R0,[R3, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ProgramWord_26
        MOVS     R0,#+1
??FLASH_ProgramWord_27:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_ProgramWord_28
??FLASH_ProgramWord_26:
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramWord_29
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramWord_30
??FLASH_ProgramWord_29:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramWord_31
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramWord_30
??FLASH_ProgramWord_31:
        MOVS     R0,#+4
        B.N      ??FLASH_ProgramWord_30
??FLASH_ProgramWord_32:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_ProgramWord_28:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_ProgramWord_32
        LDR      R2,[R3, #+0]
        TST      R2,#0x1
        BNE.N    ??FLASH_ProgramWord_33
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramWord_34
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramWord_33
??FLASH_ProgramWord_34:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramWord_35
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramWord_33
??FLASH_ProgramWord_35:
        MOVS     R0,#+4
??FLASH_ProgramWord_33:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ProgramWord_36
        CMP      R1,#+0
        BNE.N    ??FLASH_ProgramWord_27
        B.N      ??FLASH_ProgramWord_37
??FLASH_ProgramWord_36:
        CBNZ     R1,??FLASH_ProgramWord_30
??FLASH_ProgramWord_37:
        MOVS     R0,#+5
//  339         
//  340       if(status != FLASH_BUSY)
??FLASH_ProgramWord_30:
        CMP      R0,#+1
        BEQ.N    ??FLASH_ProgramWord_12
//  341       {
//  342         /* Disable the PG Bit */
//  343         FLASH->CR &= CR_PG_Reset;
        LDR      R1,[R3, #+4]
        MOVW     R2,#+8190
        B.N      ??FLASH_ProgramWord_38
//  344       }
//  345     }
//  346     else
//  347     {
//  348       if (status != FLASH_BUSY)
??FLASH_ProgramWord_25:
        CMP      R0,#+1
        BEQ.N    ??FLASH_ProgramWord_12
//  349       {
//  350         /* Disable the PG Bit */
//  351         FLASH->CR &= CR_PG_Reset;
        LDR      R1,[R3, #+4]
        MOVW     R2,#+8190
??FLASH_ProgramWord_38:
        ANDS     R1,R2,R1
        STR      R1,[R3, #+4]
//  352       }
//  353      }
//  354   }
//  355   /* Return the Program Status */
//  356   return status;
??FLASH_ProgramWord_12:
        ADD      SP,SP,#+8
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock8
//  357 }
//  358 
//  359 /*******************************************************************************
//  360 * Function Name  : FLASH_ProgramHalfWord
//  361 * Description    : Programs a half word at a specified address.
//  362 * Input          : - Address: specifies the address to be programmed.
//  363 *                  - Data: specifies the data to be programmed.
//  364 * Output         : None
//  365 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  366 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  367 *                  FLASH_TIMEOUT. 
//  368 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function FLASH_ProgramHalfWord
        THUMB
//  369 FLASH_Status FLASH_ProgramHalfWord(u32 Address, u16 Data)
//  370 {
FLASH_ProgramHalfWord:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
        MOVS     R2,R0
//  371   FLASH_Status status = FLASH_COMPLETE;
//  372 
//  373   /* Check the parameters */
//  374   assert_param(IS_FLASH_ADDRESS(Address));
//  375 
//  376   /* Wait for last operation to be completed */
//  377   status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOV      LR,#+15
        LDR.N    R3,??DataTable40  ;; 0x4002200c
        LDR      R0,[R3, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ProgramHalfWord_0
        MOVS     R0,#+1
??FLASH_ProgramHalfWord_1:
        MOVS     R4,#+0
        STR      R4,[SP, #+0]
        MOVS     R4,#+255
        B.N      ??FLASH_ProgramHalfWord_2
??FLASH_ProgramHalfWord_0:
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramHalfWord_3
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramHalfWord_4
??FLASH_ProgramHalfWord_3:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramHalfWord_5
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramHalfWord_4
??FLASH_ProgramHalfWord_5:
        MOVS     R0,#+4
        B.N      ??FLASH_ProgramHalfWord_4
??FLASH_ProgramHalfWord_6:
        LDR      R12,[SP, #+0]
        SUB      R4,R12,#+1
??FLASH_ProgramHalfWord_2:
        STR      R4,[SP, #+0]
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_ProgramHalfWord_6
        LDR      R12,[R3, #+0]
        TST      R12,#0x1
        BNE.N    ??FLASH_ProgramHalfWord_7
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramHalfWord_8
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramHalfWord_7
??FLASH_ProgramHalfWord_8:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramHalfWord_9
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramHalfWord_7
??FLASH_ProgramHalfWord_9:
        MOVS     R0,#+4
??FLASH_ProgramHalfWord_7:
        SUB      LR,LR,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ProgramHalfWord_10
        CMP      LR,#+0
        BNE.N    ??FLASH_ProgramHalfWord_1
        B.N      ??FLASH_ProgramHalfWord_11
??FLASH_ProgramHalfWord_10:
        CMP      LR,#+0
        BNE.N    ??FLASH_ProgramHalfWord_4
??FLASH_ProgramHalfWord_11:
        MOVS     R0,#+5
//  378   
//  379   if(status == FLASH_COMPLETE)
??FLASH_ProgramHalfWord_4:
        CMP      R0,#+4
        BNE.N    ??FLASH_ProgramHalfWord_12
//  380   {
//  381     /* if the previous operation is completed, proceed to program the new data */
//  382     FLASH->CR |= CR_PG_Set;
        LDR      R0,[R3, #+4]
        ORR      R0,R0,#0x1
        STR      R0,[R3, #+4]
//  383   
//  384     *(vu16*)Address = Data;
        STRH     R1,[R2, #+0]
//  385     /* Wait for last operation to be completed */
//  386     status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R1,#+15
        LDR      R0,[R3, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ProgramHalfWord_13
        MOVS     R0,#+1
??FLASH_ProgramHalfWord_14:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_ProgramHalfWord_15
??FLASH_ProgramHalfWord_13:
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramHalfWord_16
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramHalfWord_17
??FLASH_ProgramHalfWord_16:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramHalfWord_18
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramHalfWord_17
??FLASH_ProgramHalfWord_18:
        MOVS     R0,#+4
        B.N      ??FLASH_ProgramHalfWord_17
??FLASH_ProgramHalfWord_19:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_ProgramHalfWord_15:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_ProgramHalfWord_19
        LDR      R2,[R3, #+0]
        TST      R2,#0x1
        BNE.N    ??FLASH_ProgramHalfWord_20
        LDR      R0,[R3, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramHalfWord_21
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramHalfWord_20
??FLASH_ProgramHalfWord_21:
        LDR      R0,[R3, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramHalfWord_22
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramHalfWord_20
??FLASH_ProgramHalfWord_22:
        MOVS     R0,#+4
??FLASH_ProgramHalfWord_20:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ProgramHalfWord_23
        CMP      R1,#+0
        BNE.N    ??FLASH_ProgramHalfWord_14
        B.N      ??FLASH_ProgramHalfWord_24
??FLASH_ProgramHalfWord_23:
        CBNZ     R1,??FLASH_ProgramHalfWord_17
??FLASH_ProgramHalfWord_24:
        MOVS     R0,#+5
//  387 
//  388     if(status != FLASH_BUSY)
??FLASH_ProgramHalfWord_17:
        CMP      R0,#+1
        BEQ.N    ??FLASH_ProgramHalfWord_12
//  389     {
//  390       /* if the program operation is completed, disable the PG Bit */
//  391       FLASH->CR &= CR_PG_Reset;
        LDR      R1,[R3, #+4]
        MOVW     R2,#+8190
        ANDS     R1,R2,R1
        STR      R1,[R3, #+4]
//  392     }
//  393   } 
//  394   /* Return the Program Status */
//  395   return status;
??FLASH_ProgramHalfWord_12:
        ADD      SP,SP,#+8
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        CFI EndBlock cfiBlock9
//  396 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable40:
        DC32     0x4002200c
//  397 
//  398 /*******************************************************************************
//  399 * Function Name  : FLASH_ProgramOptionByteData
//  400 * Description    : Programs a half word at a specified Option Byte Data address.
//  401 * Input          : - Address: specifies the address to be programmed.
//  402 *                    This parameter can be 0x1FFFF804 or 0x1FFFF806. 
//  403 *                  - Data: specifies the data to be programmed.
//  404 * Output         : None
//  405 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  406 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  407 *                  FLASH_TIMEOUT. 
//  408 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function FLASH_ProgramOptionByteData
        THUMB
//  409 FLASH_Status FLASH_ProgramOptionByteData(u32 Address, u8 Data)
//  410 {
FLASH_ProgramOptionByteData:
        PUSH     {LR}
        CFI R14 Frame(CFA, -4)
        CFI CFA R13+4
        SUB      SP,SP,#+4
        CFI CFA R13+8
        MOVS     R2,R0
//  411   FLASH_Status status = FLASH_COMPLETE;
//  412 
//  413   /* Check the parameters */
//  414   assert_param(IS_OB_DATA_ADDRESS(Address));
//  415 
//  416   status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R3,#+15
        LDR.N    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ProgramOptionByteData_0
        MOVS     R0,#+1
??FLASH_ProgramOptionByteData_1:
        MOV      LR,#+0
        STR      LR,[SP, #+0]
        MOV      LR,#+255
        STR      LR,[SP, #+0]
        B.N      ??FLASH_ProgramOptionByteData_2
??FLASH_ProgramOptionByteData_0:
        LDR.N    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramOptionByteData_3
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramOptionByteData_4
??FLASH_ProgramOptionByteData_3:
        LDR.N    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramOptionByteData_5
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramOptionByteData_4
??FLASH_ProgramOptionByteData_5:
        MOVS     R0,#+4
        B.N      ??FLASH_ProgramOptionByteData_4
??FLASH_ProgramOptionByteData_6:
        LDR      R12,[SP, #+0]
        SUB      LR,R12,#+1
        STR      LR,[SP, #+0]
??FLASH_ProgramOptionByteData_2:
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_ProgramOptionByteData_6
        LDR.W    R12,??DataTable50  ;; 0x40022008
        LDR      R12,[R12, #+4]
        TST      R12,#0x1
        BNE.N    ??FLASH_ProgramOptionByteData_7
        LDR.N    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramOptionByteData_8
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramOptionByteData_7
??FLASH_ProgramOptionByteData_8:
        LDR.N    R0,??DataTable50  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramOptionByteData_9
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramOptionByteData_7
??FLASH_ProgramOptionByteData_9:
        MOVS     R0,#+4
??FLASH_ProgramOptionByteData_7:
        SUBS     R3,R3,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ProgramOptionByteData_10
        CMP      R3,#+0
        BNE.N    ??FLASH_ProgramOptionByteData_1
        B.N      ??FLASH_ProgramOptionByteData_11
??FLASH_ProgramOptionByteData_10:
        CBNZ     R3,??FLASH_ProgramOptionByteData_4
??FLASH_ProgramOptionByteData_11:
        MOVS     R0,#+5
//  417 
//  418   if(status == FLASH_COMPLETE)
??FLASH_ProgramOptionByteData_4:
        CMP      R0,#+4
        BNE.N    ??FLASH_ProgramOptionByteData_12
//  419   {
//  420     /* Authorize the small information block programming */
//  421     FLASH->OPTKEYR = FLASH_KEY1;
        LDR.N    R0,??DataTable50  ;; 0x40022008
        LDR.W    R3,??DataTable51  ;; 0x45670123
        STR      R3,[R0, #+0]
//  422     FLASH->OPTKEYR = FLASH_KEY2;
        LDR.W    R3,??DataTable52  ;; 0xcdef89ab
        STR      R3,[R0, #+0]
//  423 
//  424     /* Enables the Option Bytes Programming operation */
//  425     FLASH->CR |= CR_OPTPG_Set; 
        LDR      R0,[R0, #+8]
        ORR      R0,R0,#0x10
        LDR.N    R3,??DataTable50  ;; 0x40022008
        STR      R0,[R3, #+8]
//  426     *(vu16*)Address = Data;
        STRH     R1,[R2, #+0]
//  427     
//  428     /* Wait for last operation to be completed */
//  429     status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R1,#+15
        LDR      R0,[R3, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ProgramOptionByteData_13
        MOVS     R0,#+1
??FLASH_ProgramOptionByteData_14:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_ProgramOptionByteData_15
??FLASH_ProgramOptionByteData_13:
        LDR      R0,[R3, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramOptionByteData_16
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramOptionByteData_17
??FLASH_ProgramOptionByteData_16:
        LDR      R0,[R3, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramOptionByteData_18
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramOptionByteData_17
??FLASH_ProgramOptionByteData_18:
        MOVS     R0,#+4
        B.N      ??FLASH_ProgramOptionByteData_17
??FLASH_ProgramOptionByteData_19:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_ProgramOptionByteData_15:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_ProgramOptionByteData_19
        LDR      R2,[R3, #+4]
        TST      R2,#0x1
        BNE.N    ??FLASH_ProgramOptionByteData_20
        LDR      R0,[R3, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ProgramOptionByteData_21
        MOVS     R0,#+2
        B.N      ??FLASH_ProgramOptionByteData_20
??FLASH_ProgramOptionByteData_21:
        LDR      R0,[R3, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ProgramOptionByteData_22
        MOVS     R0,#+3
        B.N      ??FLASH_ProgramOptionByteData_20
??FLASH_ProgramOptionByteData_22:
        MOVS     R0,#+4
??FLASH_ProgramOptionByteData_20:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ProgramOptionByteData_23
        CMP      R1,#+0
        BNE.N    ??FLASH_ProgramOptionByteData_14
        B.N      ??FLASH_ProgramOptionByteData_24
??FLASH_ProgramOptionByteData_23:
        CBNZ     R1,??FLASH_ProgramOptionByteData_17
??FLASH_ProgramOptionByteData_24:
        MOVS     R0,#+5
//  430 
//  431     if(status != FLASH_BUSY)
??FLASH_ProgramOptionByteData_17:
        CMP      R0,#+1
        BEQ.N    ??FLASH_ProgramOptionByteData_12
//  432     {
//  433       /* if the program operation is completed, disable the OPTPG Bit */
//  434       FLASH->CR &= CR_OPTPG_Reset;
        LDR      R1,[R3, #+8]
        MOVW     R2,#+8175
        ANDS     R1,R2,R1
        STR      R1,[R3, #+8]
//  435     }
//  436   }    
//  437   /* Return the Option Byte Data Program Status */
//  438   return status;      
??FLASH_ProgramOptionByteData_12:
        ADD      SP,SP,#+4
        CFI CFA R13+4
        POP      {PC}             ;; return
        CFI EndBlock cfiBlock10
//  439 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable50:
        DC32     0x40022008
//  440 
//  441 /*******************************************************************************
//  442 * Function Name  : FLASH_EnableWriteProtection
//  443 * Description    : Write protects the desired pages
//  444 * Input          : - FLASH_Pages: specifies the address of the pages to be 
//  445 *                    write protected. This parameter can be:
//  446 *                    - For STM32F10Xxx Medium-density devices (FLASH page size equal to 1 KB)
//  447 *                       - A value between FLASH_WRProt_Pages0to3 and 
//  448 *                         FLASH_WRProt_Pages124to127
//  449 *                    - For STM32F10Xxx High-density devices (FLASH page size equal to 2 KB) 
//  450 *                       - A value between FLASH_WRProt_Pages0to1 and
//  451 *                         FLASH_WRProt_Pages60to61 or FLASH_WRProt_Pages62to255 
//  452 *                       - FLASH_WRProt_AllPages
//  453 * Output         : None
//  454 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  455 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  456 *                  FLASH_TIMEOUT.
//  457 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function FLASH_EnableWriteProtection
        THUMB
//  458 FLASH_Status FLASH_EnableWriteProtection(u32 FLASH_Pages)
//  459 {
FLASH_EnableWriteProtection:
        PUSH     {R4,R5,LR}
        CFI R14 Frame(CFA, -4)
        CFI R5 Frame(CFA, -8)
        CFI R4 Frame(CFA, -12)
        CFI CFA R13+12
        SUB      SP,SP,#+4
        CFI CFA R13+16
//  460   u16 WRP0_Data = 0xFFFF, WRP1_Data = 0xFFFF, WRP2_Data = 0xFFFF, WRP3_Data = 0xFFFF;
//  461   
//  462   FLASH_Status status = FLASH_COMPLETE;
//  463   
//  464   /* Check the parameters */
//  465   assert_param(IS_FLASH_WRPROT_PAGE(FLASH_Pages));
//  466   
//  467   FLASH_Pages = (u32)(~FLASH_Pages);
        MVNS     R0,R0
//  468   WRP0_Data = (vu16)(FLASH_Pages & WRP0_Mask);
        UXTB     LR,R0
//  469   WRP1_Data = (vu16)((FLASH_Pages & WRP1_Mask) >> 8);
        AND      R1,R0,#0xFF00
        LSRS     R3,R1,#+8
//  470   WRP2_Data = (vu16)((FLASH_Pages & WRP2_Mask) >> 16);
        AND      R1,R0,#0xFF0000
        LSRS     R2,R1,#+16
//  471   WRP3_Data = (vu16)((FLASH_Pages & WRP3_Mask) >> 24);
        LSRS     R1,R0,#+24
//  472   
//  473   /* Wait for last operation to be completed */
//  474   status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R4,#+15
        LDR.W    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EnableWriteProtection_1
        MOVS     R0,#+1
??FLASH_EnableWriteProtection_2:
        MOVS     R5,#+0
        STR      R5,[SP, #+0]
        MOVS     R5,#+255
        B.N      ??FLASH_EnableWriteProtection_3
??FLASH_EnableWriteProtection_1:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_4
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_5
??FLASH_EnableWriteProtection_4:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_6
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_5
??FLASH_EnableWriteProtection_6:
        MOVS     R0,#+4
        B.N      ??FLASH_EnableWriteProtection_5
??FLASH_EnableWriteProtection_7:
        LDR      R12,[SP, #+0]
        SUB      R5,R12,#+1
??FLASH_EnableWriteProtection_3:
        STR      R5,[SP, #+0]
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_EnableWriteProtection_7
        LDR.W    R12,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R12,[R12, #+4]
        TST      R12,#0x1
        BNE.N    ??FLASH_EnableWriteProtection_8
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_9
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_8
??FLASH_EnableWriteProtection_9:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_10
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_8
??FLASH_EnableWriteProtection_10:
        MOVS     R0,#+4
??FLASH_EnableWriteProtection_8:
        SUBS     R4,R4,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EnableWriteProtection_11
        CMP      R4,#+0
        BNE.N    ??FLASH_EnableWriteProtection_2
        B.N      ??FLASH_EnableWriteProtection_12
??FLASH_EnableWriteProtection_11:
        CBNZ     R4,??FLASH_EnableWriteProtection_5
??FLASH_EnableWriteProtection_12:
        MOVS     R0,#+5
//  475   
//  476   if(status == FLASH_COMPLETE)
??FLASH_EnableWriteProtection_5:
        CMP      R0,#+4
        BNE.W    ??FLASH_EnableWriteProtection_13
//  477   {
//  478     /* Authorizes the small information block programming */
//  479     FLASH->OPTKEYR = FLASH_KEY1;
        LDR.W    R12,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR.N    R4,??DataTable51  ;; 0x45670123
        STR      R4,[R12, #+0]
//  480     FLASH->OPTKEYR = FLASH_KEY2;
        LDR.N    R4,??DataTable52  ;; 0xcdef89ab
        STR      R4,[R12, #+0]
//  481     FLASH->CR |= CR_OPTPG_Set;
        LDR      R12,[R12, #+8]
        ORR      R12,R12,#0x10
        LDR.N    R4,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        STR      R12,[R4, #+8]
//  482 
//  483     if(WRP0_Data != 0xFF)
        CMP      LR,#+255
        BEQ.N    ??FLASH_EnableWriteProtection_14
//  484     {
//  485       OB->WRP0 = WRP0_Data;
        LDR.N    R0,??FLASH_EnableWriteProtection_0+0x4  ;; 0x1ffff808
        STRH     LR,[R0, #+0]
//  486       
//  487       /* Wait for last operation to be completed */
//  488       status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOV      LR,#+15
        LDR      R0,[R4, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EnableWriteProtection_15
        MOVS     R0,#+1
??FLASH_EnableWriteProtection_16:
        MOVS     R4,#+0
        STR      R4,[SP, #+0]
        MOVS     R4,#+255
        B.N      ??FLASH_EnableWriteProtection_17
??FLASH_EnableWriteProtection_15:
        LDR      R0,[R4, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_18
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_14
??FLASH_EnableWriteProtection_18:
        LDR      R0,[R4, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_19
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_14
??FLASH_EnableWriteProtection_19:
        MOVS     R0,#+4
        B.N      ??FLASH_EnableWriteProtection_14
??FLASH_EnableWriteProtection_20:
        LDR      R12,[SP, #+0]
        SUB      R4,R12,#+1
??FLASH_EnableWriteProtection_17:
        STR      R4,[SP, #+0]
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_EnableWriteProtection_20
        LDR.W    R12,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R12,[R12, #+4]
        TST      R12,#0x1
        BNE.N    ??FLASH_EnableWriteProtection_21
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_22
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_21
??FLASH_EnableWriteProtection_22:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_23
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_21
??FLASH_EnableWriteProtection_23:
        MOVS     R0,#+4
??FLASH_EnableWriteProtection_21:
        SUB      LR,LR,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EnableWriteProtection_24
        CMP      LR,#+0
        BNE.N    ??FLASH_EnableWriteProtection_16
        B.N      ??FLASH_EnableWriteProtection_25
??FLASH_EnableWriteProtection_24:
        CMP      LR,#+0
        BNE.N    ??FLASH_EnableWriteProtection_14
??FLASH_EnableWriteProtection_25:
        MOVS     R0,#+5
//  489     }
//  490     if((status == FLASH_COMPLETE) && (WRP1_Data != 0xFF))
??FLASH_EnableWriteProtection_14:
        CMP      R0,#+4
        BNE.N    ??FLASH_EnableWriteProtection_26
        CMP      R3,#+255
        BEQ.N    ??FLASH_EnableWriteProtection_26
//  491     {
//  492       OB->WRP1 = WRP1_Data;
        LDR.N    R0,??FLASH_EnableWriteProtection_0+0x4  ;; 0x1ffff808
        STRH     R3,[R0, #+2]
//  493       
//  494       /* Wait for last operation to be completed */
//  495       status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R3,#+15
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EnableWriteProtection_27
        MOVS     R0,#+1
??FLASH_EnableWriteProtection_28:
        MOV      LR,#+0
        STR      LR,[SP, #+0]
        MOV      LR,#+255
        STR      LR,[SP, #+0]
        B.N      ??FLASH_EnableWriteProtection_29
??FLASH_EnableWriteProtection_27:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_30
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_26
??FLASH_EnableWriteProtection_30:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_31
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_26
??FLASH_EnableWriteProtection_31:
        MOVS     R0,#+4
        B.N      ??FLASH_EnableWriteProtection_26
??FLASH_EnableWriteProtection_32:
        LDR      R12,[SP, #+0]
        SUB      LR,R12,#+1
        STR      LR,[SP, #+0]
??FLASH_EnableWriteProtection_29:
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_EnableWriteProtection_32
        LDR.W    R12,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R12,[R12, #+4]
        TST      R12,#0x1
        BNE.N    ??FLASH_EnableWriteProtection_33
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_34
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_33
??FLASH_EnableWriteProtection_34:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_35
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_33
??FLASH_EnableWriteProtection_35:
        MOVS     R0,#+4
??FLASH_EnableWriteProtection_33:
        SUBS     R3,R3,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EnableWriteProtection_36
        CMP      R3,#+0
        BNE.N    ??FLASH_EnableWriteProtection_28
        B.N      ??FLASH_EnableWriteProtection_37
??FLASH_EnableWriteProtection_36:
        CBNZ     R3,??FLASH_EnableWriteProtection_26
??FLASH_EnableWriteProtection_37:
        MOVS     R0,#+5
//  496     }
//  497 
//  498     if((status == FLASH_COMPLETE) && (WRP2_Data != 0xFF))
??FLASH_EnableWriteProtection_26:
        CMP      R0,#+4
        BNE.N    ??FLASH_EnableWriteProtection_38
        CMP      R2,#+255
        BEQ.N    ??FLASH_EnableWriteProtection_38
//  499     {
//  500       OB->WRP2 = WRP2_Data;
        LDR.N    R0,??FLASH_EnableWriteProtection_0+0x4  ;; 0x1ffff808
        STRH     R2,[R0, #+4]
//  501       
//  502       /* Wait for last operation to be completed */
//  503       status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R2,#+15
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EnableWriteProtection_39
        MOVS     R0,#+1
??FLASH_EnableWriteProtection_40:
        MOVS     R3,#+0
        STR      R3,[SP, #+0]
        MOVS     R3,#+255
        B.N      ??FLASH_EnableWriteProtection_41
??FLASH_EnableWriteProtection_39:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_42
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_38
??FLASH_EnableWriteProtection_42:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_43
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_38
??FLASH_EnableWriteProtection_43:
        MOVS     R0,#+4
        B.N      ??FLASH_EnableWriteProtection_38
??FLASH_EnableWriteProtection_44:
        LDR      R3,[SP, #+0]
        SUBS     R3,R3,#+1
??FLASH_EnableWriteProtection_41:
        STR      R3,[SP, #+0]
        LDR      R3,[SP, #+0]
        CMP      R3,#+0
        BNE.N    ??FLASH_EnableWriteProtection_44
        LDR.N    R3,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R3,[R3, #+4]
        TST      R3,#0x1
        BNE.N    ??FLASH_EnableWriteProtection_45
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_46
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_45
??FLASH_EnableWriteProtection_46:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_47
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_45
??FLASH_EnableWriteProtection_47:
        MOVS     R0,#+4
??FLASH_EnableWriteProtection_45:
        SUBS     R2,R2,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EnableWriteProtection_48
        CMP      R2,#+0
        BNE.N    ??FLASH_EnableWriteProtection_40
        B.N      ??FLASH_EnableWriteProtection_49
??FLASH_EnableWriteProtection_48:
        CBNZ     R2,??FLASH_EnableWriteProtection_38
??FLASH_EnableWriteProtection_49:
        MOVS     R0,#+5
//  504     }
//  505     
//  506     if((status == FLASH_COMPLETE)&& (WRP3_Data != 0xFF))
??FLASH_EnableWriteProtection_38:
        CMP      R0,#+4
        BNE.N    ??FLASH_EnableWriteProtection_50
        CMP      R1,#+255
        BEQ.N    ??FLASH_EnableWriteProtection_50
//  507     {
//  508       OB->WRP3 = WRP3_Data;
        LDR.N    R0,??FLASH_EnableWriteProtection_0+0x4  ;; 0x1ffff808
        STRH     R1,[R0, #+6]
//  509      
//  510       /* Wait for last operation to be completed */
//  511       status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R1,#+15
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_EnableWriteProtection_51
        MOVS     R0,#+1
??FLASH_EnableWriteProtection_52:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_EnableWriteProtection_53
??FLASH_EnableWriteProtection_51:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_54
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_50
??FLASH_EnableWriteProtection_54:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_55
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_50
??FLASH_EnableWriteProtection_55:
        MOVS     R0,#+4
        B.N      ??FLASH_EnableWriteProtection_50
??FLASH_EnableWriteProtection_56:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_EnableWriteProtection_53:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_EnableWriteProtection_56
        LDR.N    R2,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R2,[R2, #+4]
        TST      R2,#0x1
        BNE.N    ??FLASH_EnableWriteProtection_57
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_EnableWriteProtection_58
        MOVS     R0,#+2
        B.N      ??FLASH_EnableWriteProtection_57
??FLASH_EnableWriteProtection_58:
        LDR.N    R0,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_EnableWriteProtection_59
        MOVS     R0,#+3
        B.N      ??FLASH_EnableWriteProtection_57
??FLASH_EnableWriteProtection_59:
        MOVS     R0,#+4
??FLASH_EnableWriteProtection_57:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_EnableWriteProtection_60
        CMP      R1,#+0
        BNE.N    ??FLASH_EnableWriteProtection_52
        B.N      ??FLASH_EnableWriteProtection_61
??FLASH_EnableWriteProtection_60:
        CBNZ     R1,??FLASH_EnableWriteProtection_50
??FLASH_EnableWriteProtection_61:
        MOVS     R0,#+5
//  512     }
//  513           
//  514     if(status != FLASH_BUSY)
??FLASH_EnableWriteProtection_50:
        CMP      R0,#+1
        BEQ.N    ??FLASH_EnableWriteProtection_13
//  515     {
//  516       /* if the program operation is completed, disable the OPTPG Bit */
//  517       FLASH->CR &= CR_OPTPG_Reset;
        LDR.N    R1,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        LDR      R1,[R1, #+8]
        MOVW     R2,#+8175
        ANDS     R1,R2,R1
        LDR.N    R2,??FLASH_EnableWriteProtection_0  ;; 0x40022008
        STR      R1,[R2, #+8]
//  518     }
//  519   } 
//  520   /* Return the write protection operation Status */
//  521   return status;       
??FLASH_EnableWriteProtection_13:
        ADD      SP,SP,#+4
        CFI CFA R13+12
        POP      {R4,R5,PC}       ;; return
        Nop      
        DATA
??FLASH_EnableWriteProtection_0:
        DC32     0x40022008
        DC32     0x1ffff808
        CFI EndBlock cfiBlock11
//  522 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable51:
        DC32     0x45670123

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable52:
        DC32     0xcdef89ab
//  523 
//  524 /*******************************************************************************
//  525 * Function Name  : FLASH_ReadOutProtection
//  526 * Description    : Enables or disables the read out protection.
//  527 *                  If the user has already programmed the other option bytes before 
//  528 *                  calling this function, he must re-program them since this 
//  529 *                  function erases all option bytes.
//  530 * Input          : - Newstate: new state of the ReadOut Protection.
//  531 *                    This parameter can be: ENABLE or DISABLE.
//  532 * Output         : None
//  533 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  534 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  535 *                  FLASH_TIMEOUT.
//  536 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function FLASH_ReadOutProtection
        THUMB
//  537 FLASH_Status FLASH_ReadOutProtection(FunctionalState NewState)
//  538 {
FLASH_ReadOutProtection:
        SUB      SP,SP,#+8
        CFI CFA R13+8
        MOVS     R1,R0
//  539   FLASH_Status status = FLASH_COMPLETE;
//  540 
//  541   /* Check the parameters */
//  542   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  543 
//  544   status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R2,#+4095
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ReadOutProtection_1
        MOVS     R0,#+1
??FLASH_ReadOutProtection_2:
        MOVS     R3,#+0
        STR      R3,[SP, #+0]
        MOVS     R3,#+255
        B.N      ??FLASH_ReadOutProtection_3
??FLASH_ReadOutProtection_1:
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ReadOutProtection_4
        MOVS     R0,#+2
        B.N      ??FLASH_ReadOutProtection_5
??FLASH_ReadOutProtection_4:
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ReadOutProtection_6
        MOVS     R0,#+3
        B.N      ??FLASH_ReadOutProtection_5
??FLASH_ReadOutProtection_6:
        MOVS     R0,#+4
        B.N      ??FLASH_ReadOutProtection_5
??FLASH_ReadOutProtection_7:
        LDR      R3,[SP, #+0]
        SUBS     R3,R3,#+1
??FLASH_ReadOutProtection_3:
        STR      R3,[SP, #+0]
        LDR      R3,[SP, #+0]
        CMP      R3,#+0
        BNE.N    ??FLASH_ReadOutProtection_7
        LDR.N    R3,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R3,[R3, #+4]
        TST      R3,#0x1
        BNE.N    ??FLASH_ReadOutProtection_8
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ReadOutProtection_9
        MOVS     R0,#+2
        B.N      ??FLASH_ReadOutProtection_8
??FLASH_ReadOutProtection_9:
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ReadOutProtection_10
        MOVS     R0,#+3
        B.N      ??FLASH_ReadOutProtection_8
??FLASH_ReadOutProtection_10:
        MOVS     R0,#+4
??FLASH_ReadOutProtection_8:
        SUBS     R2,R2,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ReadOutProtection_11
        CMP      R2,#+0
        BNE.N    ??FLASH_ReadOutProtection_2
        B.N      ??FLASH_ReadOutProtection_12
??FLASH_ReadOutProtection_11:
        CBNZ     R2,??FLASH_ReadOutProtection_5
??FLASH_ReadOutProtection_12:
        MOVS     R0,#+5
//  545 
//  546   if(status == FLASH_COMPLETE)
??FLASH_ReadOutProtection_5:
        CMP      R0,#+4
        BNE.W    ??FLASH_ReadOutProtection_13
//  547   {
//  548     /* Authorizes the small information block programming */
//  549     FLASH->OPTKEYR = FLASH_KEY1;
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR.N    R2,??FLASH_ReadOutProtection_0+0x4  ;; 0x45670123
        STR      R2,[R0, #+0]
//  550     FLASH->OPTKEYR = FLASH_KEY2;
        LDR.N    R2,??FLASH_ReadOutProtection_0+0x8  ;; 0xcdef89ab
        STR      R2,[R0, #+0]
//  551 
//  552     FLASH->CR |= CR_OPTER_Set;
        LDR      R0,[R0, #+8]
        ORR      R0,R0,#0x20
        LDR.N    R2,??FLASH_ReadOutProtection_0  ;; 0x40022008
        STR      R0,[R2, #+8]
//  553     FLASH->CR |= CR_STRT_Set;
        LDR      R0,[R2, #+8]
        ORR      R0,R0,#0x40
        STR      R0,[R2, #+8]
//  554 
//  555     /* Wait for last operation to be completed */
//  556     status = FLASH_WaitForLastOperation(EraseTimeout);
        MOVW     R2,#+4095
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ReadOutProtection_14
        MOVS     R0,#+1
??FLASH_ReadOutProtection_15:
        MOVS     R3,#+0
        STR      R3,[SP, #+0]
        MOVS     R3,#+255
        B.N      ??FLASH_ReadOutProtection_16
??FLASH_ReadOutProtection_14:
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ReadOutProtection_17
        MOVS     R0,#+2
        B.N      ??FLASH_ReadOutProtection_18
??FLASH_ReadOutProtection_17:
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ReadOutProtection_19
        MOVS     R0,#+3
        B.N      ??FLASH_ReadOutProtection_18
??FLASH_ReadOutProtection_19:
        MOVS     R0,#+4
        B.N      ??FLASH_ReadOutProtection_18
??FLASH_ReadOutProtection_20:
        LDR      R3,[SP, #+0]
        SUBS     R3,R3,#+1
??FLASH_ReadOutProtection_16:
        STR      R3,[SP, #+0]
        LDR      R3,[SP, #+0]
        CMP      R3,#+0
        BNE.N    ??FLASH_ReadOutProtection_20
        LDR.N    R3,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R3,[R3, #+4]
        TST      R3,#0x1
        BNE.N    ??FLASH_ReadOutProtection_21
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ReadOutProtection_22
        MOVS     R0,#+2
        B.N      ??FLASH_ReadOutProtection_21
??FLASH_ReadOutProtection_22:
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ReadOutProtection_23
        MOVS     R0,#+3
        B.N      ??FLASH_ReadOutProtection_21
??FLASH_ReadOutProtection_23:
        MOVS     R0,#+4
??FLASH_ReadOutProtection_21:
        SUBS     R2,R2,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ReadOutProtection_24
        CMP      R2,#+0
        BNE.N    ??FLASH_ReadOutProtection_15
        B.N      ??FLASH_ReadOutProtection_25
??FLASH_ReadOutProtection_24:
        CBNZ     R2,??FLASH_ReadOutProtection_18
??FLASH_ReadOutProtection_25:
        MOVS     R0,#+5
//  557 
//  558     if(status == FLASH_COMPLETE)
??FLASH_ReadOutProtection_18:
        CMP      R0,#+4
        BNE.N    ??FLASH_ReadOutProtection_26
//  559     {
//  560       /* if the erase operation is completed, disable the OPTER Bit */
//  561       FLASH->CR &= CR_OPTER_Reset;
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+8]
        MOVW     R2,#+8159
        ANDS     R0,R2,R0
        LDR.N    R2,??FLASH_ReadOutProtection_0  ;; 0x40022008
        STR      R0,[R2, #+8]
//  562 
//  563       /* Enable the Option Bytes Programming operation */
//  564       FLASH->CR |= CR_OPTPG_Set; 
        LDR      R0,[R2, #+8]
        ORR      R0,R0,#0x10
        STR      R0,[R2, #+8]
//  565 
//  566       if(NewState != DISABLE)
        LDR.N    R0,??FLASH_ReadOutProtection_0+0xC  ;; 0x1ffff800
        CBZ      R1,??FLASH_ReadOutProtection_27
//  567       {
//  568         OB->RDP = 0x00;
        MOVS     R1,#+0
        B.N      ??FLASH_ReadOutProtection_28
//  569       }
//  570       else
//  571       {
//  572         OB->RDP = RDP_Key;  
??FLASH_ReadOutProtection_27:
        MOVS     R1,#+165
??FLASH_ReadOutProtection_28:
        STRH     R1,[R0, #+0]
//  573       }
//  574 
//  575       /* Wait for last operation to be completed */
//  576       status = FLASH_WaitForLastOperation(EraseTimeout); 
        MOVW     R1,#+4095
        LDR      R0,[R2, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_ReadOutProtection_29
        MOVS     R0,#+1
??FLASH_ReadOutProtection_30:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_ReadOutProtection_31
??FLASH_ReadOutProtection_29:
        LDR      R0,[R2, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ReadOutProtection_32
        MOVS     R0,#+2
        B.N      ??FLASH_ReadOutProtection_33
??FLASH_ReadOutProtection_32:
        LDR      R0,[R2, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ReadOutProtection_34
        MOVS     R0,#+3
        B.N      ??FLASH_ReadOutProtection_33
??FLASH_ReadOutProtection_34:
        MOVS     R0,#+4
        B.N      ??FLASH_ReadOutProtection_33
??FLASH_ReadOutProtection_35:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_ReadOutProtection_31:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_ReadOutProtection_35
        LDR.N    R2,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R2,[R2, #+4]
        TST      R2,#0x1
        BNE.N    ??FLASH_ReadOutProtection_36
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_ReadOutProtection_37
        MOVS     R0,#+2
        B.N      ??FLASH_ReadOutProtection_36
??FLASH_ReadOutProtection_37:
        LDR.N    R0,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_ReadOutProtection_38
        MOVS     R0,#+3
        B.N      ??FLASH_ReadOutProtection_36
??FLASH_ReadOutProtection_38:
        MOVS     R0,#+4
??FLASH_ReadOutProtection_36:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_ReadOutProtection_39
        CMP      R1,#+0
        BNE.N    ??FLASH_ReadOutProtection_30
        B.N      ??FLASH_ReadOutProtection_40
??FLASH_ReadOutProtection_39:
        CBNZ     R1,??FLASH_ReadOutProtection_33
??FLASH_ReadOutProtection_40:
        MOVS     R0,#+5
//  577     
//  578       if(status != FLASH_BUSY)
??FLASH_ReadOutProtection_33:
        CMP      R0,#+1
        BEQ.N    ??FLASH_ReadOutProtection_13
//  579       {
//  580         /* if the program operation is completed, disable the OPTPG Bit */
//  581         FLASH->CR &= CR_OPTPG_Reset;
        LDR.N    R1,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R1,[R1, #+8]
        MOVW     R2,#+8175
        ANDS     R1,R2,R1
        LDR.N    R2,??FLASH_ReadOutProtection_0  ;; 0x40022008
        B.N      ??FLASH_ReadOutProtection_41
//  582       }
//  583     }
//  584     else 
//  585     {
//  586       if(status != FLASH_BUSY)
??FLASH_ReadOutProtection_26:
        CMP      R0,#+1
        BEQ.N    ??FLASH_ReadOutProtection_13
//  587       {
//  588         /* Disable the OPTER Bit */
//  589         FLASH->CR &= CR_OPTER_Reset;
        LDR.N    R1,??FLASH_ReadOutProtection_0  ;; 0x40022008
        LDR      R1,[R1, #+8]
        MOVW     R2,#+8159
        ANDS     R1,R2,R1
        LDR.N    R2,??FLASH_ReadOutProtection_0  ;; 0x40022008
??FLASH_ReadOutProtection_41:
        STR      R1,[R2, #+8]
//  590       }
//  591     }
//  592   }
//  593   /* Return the protection operation Status */
//  594   return status;      
??FLASH_ReadOutProtection_13:
        ADD      SP,SP,#+8
        CFI CFA R13+0
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_ReadOutProtection_0:
        DC32     0x40022008
        DC32     0x45670123
        DC32     0xcdef89ab
        DC32     0x1ffff800
        CFI EndBlock cfiBlock12
//  595 }
//  596   	
//  597 /*******************************************************************************
//  598 * Function Name  : FLASH_UserOptionByteConfig
//  599 * Description    : Programs the FLASH User Option Byte: IWDG_SW / RST_STOP /
//  600 *                  RST_STDBY.
//  601 * Input          : - OB_IWDG: Selects the IWDG mode
//  602 *                     This parameter can be one of the following values:
//  603 *                     - OB_IWDG_SW: Software IWDG selected
//  604 *                     - OB_IWDG_HW: Hardware IWDG selected
//  605 *                  - OB_STOP: Reset event when entering STOP mode.
//  606 *                     This parameter can be one of the following values:
//  607 *                     - OB_STOP_NoRST: No reset generated when entering in STOP
//  608 *                     - OB_STOP_RST: Reset generated when entering in STOP
//  609 *                  - OB_STDBY: Reset event when entering Standby mode.
//  610 *                    This parameter can be one of the following values:
//  611 *                     - OB_STDBY_NoRST: No reset generated when entering in STANDBY
//  612 *                     - OB_STDBY_RST: Reset generated when entering in STANDBY
//  613 * Output         : None
//  614 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  615 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  616 *                  FLASH_TIMEOUT.
//  617 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function FLASH_UserOptionByteConfig
        THUMB
//  618 FLASH_Status FLASH_UserOptionByteConfig(u16 OB_IWDG, u16 OB_STOP, u16 OB_STDBY)
//  619 {
FLASH_UserOptionByteConfig:
        PUSH     {R4,LR}
        CFI R14 Frame(CFA, -4)
        CFI R4 Frame(CFA, -8)
        CFI CFA R13+8
        SUB      SP,SP,#+8
        CFI CFA R13+16
        MOVS     R3,R0
//  620   FLASH_Status status = FLASH_COMPLETE; 
//  621 
//  622   /* Check the parameters */
//  623   assert_param(IS_OB_IWDG_SOURCE(OB_IWDG));
//  624   assert_param(IS_OB_STOP_SOURCE(OB_STOP));
//  625   assert_param(IS_OB_STDBY_SOURCE(OB_STDBY));
//  626 
//  627   /* Authorize the small information block programming */
//  628   FLASH->OPTKEYR = FLASH_KEY1;
        LDR.N    R0,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        LDR.W    R12,??FLASH_UserOptionByteConfig_0+0x4  ;; 0x45670123
        STR      R12,[R0, #+0]
//  629   FLASH->OPTKEYR = FLASH_KEY2;
        LDR.W    R12,??FLASH_UserOptionByteConfig_0+0x8  ;; 0xcdef89ab
        STR      R12,[R0, #+0]
//  630   
//  631   /* Wait for last operation to be completed */
//  632   status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOV      LR,#+15
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_UserOptionByteConfig_1
        MOVS     R0,#+1
??FLASH_UserOptionByteConfig_2:
        MOVS     R4,#+0
        STR      R4,[SP, #+0]
        MOVS     R4,#+255
        B.N      ??FLASH_UserOptionByteConfig_3
??FLASH_UserOptionByteConfig_1:
        LDR.N    R0,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_UserOptionByteConfig_4
        MOVS     R0,#+2
        B.N      ??FLASH_UserOptionByteConfig_5
??FLASH_UserOptionByteConfig_4:
        LDR.N    R0,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_UserOptionByteConfig_6
        MOVS     R0,#+3
        B.N      ??FLASH_UserOptionByteConfig_5
??FLASH_UserOptionByteConfig_6:
        MOVS     R0,#+4
        B.N      ??FLASH_UserOptionByteConfig_5
??FLASH_UserOptionByteConfig_7:
        LDR      R12,[SP, #+0]
        SUB      R4,R12,#+1
??FLASH_UserOptionByteConfig_3:
        STR      R4,[SP, #+0]
        LDR      R12,[SP, #+0]
        CMP      R12,#+0
        BNE.N    ??FLASH_UserOptionByteConfig_7
        LDR.W    R12,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        LDR      R12,[R12, #+4]
        TST      R12,#0x1
        BNE.N    ??FLASH_UserOptionByteConfig_8
        LDR.N    R0,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_UserOptionByteConfig_9
        MOVS     R0,#+2
        B.N      ??FLASH_UserOptionByteConfig_8
??FLASH_UserOptionByteConfig_9:
        LDR.N    R0,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_UserOptionByteConfig_10
        MOVS     R0,#+3
        B.N      ??FLASH_UserOptionByteConfig_8
??FLASH_UserOptionByteConfig_10:
        MOVS     R0,#+4
??FLASH_UserOptionByteConfig_8:
        SUB      LR,LR,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_UserOptionByteConfig_11
        CMP      LR,#+0
        BNE.N    ??FLASH_UserOptionByteConfig_2
        B.N      ??FLASH_UserOptionByteConfig_12
??FLASH_UserOptionByteConfig_11:
        CMP      LR,#+0
        BNE.N    ??FLASH_UserOptionByteConfig_5
??FLASH_UserOptionByteConfig_12:
        MOVS     R0,#+5
//  633   
//  634   if(status == FLASH_COMPLETE)
??FLASH_UserOptionByteConfig_5:
        CMP      R0,#+4
        BNE.N    ??FLASH_UserOptionByteConfig_13
//  635   {  
//  636     /* Enable the Option Bytes Programming operation */
//  637     FLASH->CR |= CR_OPTPG_Set; 
        LDR.N    R0,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        LDR      R0,[R0, #+8]
        ORR      R0,R0,#0x10
        LDR.W    R12,??FLASH_UserOptionByteConfig_0  ;; 0x40022008
        STR      R0,[R12, #+8]
//  638            
//  639     OB->USER = ( OB_IWDG | OB_STOP |OB_STDBY) | (u16)0xF8; 
        ORR      R0,R1,R3
        ORRS     R0,R2,R0
        ORR      R0,R0,#0xF8
        LDR.N    R1,??FLASH_UserOptionByteConfig_0+0xC  ;; 0x1ffff802
        STRH     R0,[R1, #+0]
//  640   
//  641     /* Wait for last operation to be completed */
//  642     status = FLASH_WaitForLastOperation(ProgramTimeout);
        MOVS     R1,#+15
        MOV      R0,R12
        LDR      R0,[R0, #+4]
        TST      R0,#0x1
        BEQ.N    ??FLASH_UserOptionByteConfig_14
        MOVS     R0,#+1
??FLASH_UserOptionByteConfig_15:
        MOVS     R2,#+0
        STR      R2,[SP, #+0]
        MOVS     R2,#+255
        B.N      ??FLASH_UserOptionByteConfig_16
??FLASH_UserOptionByteConfig_14:
        MOV      R0,R12
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_UserOptionByteConfig_17
        MOVS     R0,#+2
        B.N      ??FLASH_UserOptionByteConfig_18
??FLASH_UserOptionByteConfig_17:
        MOV      R0,R12
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_UserOptionByteConfig_19
        MOVS     R0,#+3
        B.N      ??FLASH_UserOptionByteConfig_18
??FLASH_UserOptionByteConfig_19:
        MOVS     R0,#+4
        B.N      ??FLASH_UserOptionByteConfig_18
??FLASH_UserOptionByteConfig_20:
        LDR      R2,[SP, #+0]
        SUBS     R2,R2,#+1
??FLASH_UserOptionByteConfig_16:
        STR      R2,[SP, #+0]
        LDR      R2,[SP, #+0]
        CMP      R2,#+0
        BNE.N    ??FLASH_UserOptionByteConfig_20
        MOV      R2,R12
        LDR      R2,[R2, #+4]
        TST      R2,#0x1
        BNE.N    ??FLASH_UserOptionByteConfig_21
        MOV      R0,R12
        LDR      R0,[R0, #+4]
        TST      R0,#0x4
        BEQ.N    ??FLASH_UserOptionByteConfig_22
        MOVS     R0,#+2
        B.N      ??FLASH_UserOptionByteConfig_21
??FLASH_UserOptionByteConfig_22:
        MOV      R0,R12
        LDR      R0,[R0, #+4]
        TST      R0,#0x10
        BEQ.N    ??FLASH_UserOptionByteConfig_23
        MOVS     R0,#+3
        B.N      ??FLASH_UserOptionByteConfig_21
??FLASH_UserOptionByteConfig_23:
        MOVS     R0,#+4
??FLASH_UserOptionByteConfig_21:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BNE.N    ??FLASH_UserOptionByteConfig_24
        CMP      R1,#+0
        BNE.N    ??FLASH_UserOptionByteConfig_15
        B.N      ??FLASH_UserOptionByteConfig_25
??FLASH_UserOptionByteConfig_24:
        CBNZ     R1,??FLASH_UserOptionByteConfig_18
??FLASH_UserOptionByteConfig_25:
        MOVS     R0,#+5
//  643 
//  644     if(status != FLASH_BUSY)
??FLASH_UserOptionByteConfig_18:
        CMP      R0,#+1
        BEQ.N    ??FLASH_UserOptionByteConfig_13
//  645     {
//  646       /* if the program operation is completed, disable the OPTPG Bit */
//  647       FLASH->CR &= CR_OPTPG_Reset;
        MOV      R1,R12
        LDR      R1,[R1, #+8]
        MOVW     R2,#+8175
        ANDS     R1,R2,R1
        MOV      R2,R12
        STR      R1,[R2, #+8]
//  648     }
//  649   }    
//  650   /* Return the Option Byte program Status */
//  651   return status;
??FLASH_UserOptionByteConfig_13:
        ADD      SP,SP,#+8
        CFI CFA R13+8
        POP      {R4,PC}          ;; return
        DATA
??FLASH_UserOptionByteConfig_0:
        DC32     0x40022008
        DC32     0x45670123
        DC32     0xcdef89ab
        DC32     0x1ffff802
        CFI EndBlock cfiBlock13
//  652 }
//  653 
//  654 /*******************************************************************************
//  655 * Function Name  : FLASH_GetUserOptionByte
//  656 * Description    : Returns the FLASH User Option Bytes values.
//  657 * Input          : None
//  658 * Output         : None
//  659 * Return         : The FLASH User Option Bytes values:IWDG_SW(Bit0), RST_STOP(Bit1)
//  660 *                  and RST_STDBY(Bit2).
//  661 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function FLASH_GetUserOptionByte
        THUMB
//  662 u32 FLASH_GetUserOptionByte(void)
//  663 {
//  664   /* Return the User Option Byte */
//  665   return (u32)(FLASH->OBR >> 2);
FLASH_GetUserOptionByte:
        LDR.N    R0,??FLASH_GetUserOptionByte_0  ;; 0x4002201c
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+2
        BX       LR               ;; return
        DATA
??FLASH_GetUserOptionByte_0:
        DC32     0x4002201c
        CFI EndBlock cfiBlock14
//  666 }
//  667 
//  668 /*******************************************************************************
//  669 * Function Name  : FLASH_GetWriteProtectionOptionByte
//  670 * Description    : Returns the FLASH Write Protection Option Bytes Register value.
//  671 * Input          : None
//  672 * Output         : None
//  673 * Return         : The FLASH Write Protection  Option Bytes Register value
//  674 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function FLASH_GetWriteProtectionOptionByte
        THUMB
//  675 u32 FLASH_GetWriteProtectionOptionByte(void)
//  676 {
//  677   /* Return the Falsh write protection Register value */
//  678   return (u32)(FLASH->WRPR);
FLASH_GetWriteProtectionOptionByte:
        LDR.N    R0,??FLASH_GetWriteProtectionOptionByte_0  ;; 0x40022020
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_GetWriteProtectionOptionByte_0:
        DC32     0x40022020
        CFI EndBlock cfiBlock15
//  679 }
//  680 
//  681 /*******************************************************************************
//  682 * Function Name  : FLASH_GetReadOutProtectionStatus
//  683 * Description    : Checks whether the FLASH Read Out Protection Status is set 
//  684 *                  or not.
//  685 * Input          : None
//  686 * Output         : None
//  687 * Return         : FLASH ReadOut Protection Status(SET or RESET)
//  688 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function FLASH_GetReadOutProtectionStatus
        THUMB
//  689 FlagStatus FLASH_GetReadOutProtectionStatus(void)
//  690 {
//  691   FlagStatus readoutstatus = RESET;
//  692 
//  693   if ((FLASH->OBR & RDPRT_Mask) != (u32)RESET)
FLASH_GetReadOutProtectionStatus:
        LDR.N    R0,??FLASH_GetReadOutProtectionStatus_0  ;; 0x4002201c
        LDR      R0,[R0, #+0]
//  694   {
//  695     readoutstatus = SET;
//  696   }
//  697   else
//  698   {
//  699     readoutstatus = RESET;
        AND      R1,R0,#0x2
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  700   }
//  701   return readoutstatus;
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_GetReadOutProtectionStatus_0:
        DC32     0x4002201c
        CFI EndBlock cfiBlock16
//  702 }
//  703 
//  704 /*******************************************************************************
//  705 * Function Name  : FLASH_GetPrefetchBufferStatus
//  706 * Description    : Checks whether the FLASH Prefetch Buffer status is set or not.
//  707 * Input          : None
//  708 * Output         : None
//  709 * Return         : FLASH Prefetch Buffer Status (SET or RESET).
//  710 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function FLASH_GetPrefetchBufferStatus
        THUMB
//  711 FlagStatus FLASH_GetPrefetchBufferStatus(void)
//  712 {
//  713   FlagStatus bitstatus = RESET;
//  714   
//  715   if ((FLASH->ACR & ACR_PRFTBS_Mask) != (u32)RESET)
FLASH_GetPrefetchBufferStatus:
        LDR.N    R0,??FLASH_GetPrefetchBufferStatus_0  ;; 0x40022000
        LDR      R0,[R0, #+0]
//  716   {
//  717     bitstatus = SET;
//  718   }
//  719   else
//  720   {
//  721     bitstatus = RESET;
        AND      R1,R0,#0x20
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  722   }
//  723   /* Return the new state of FLASH Prefetch Buffer Status (SET or RESET) */
//  724   return bitstatus; 
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_GetPrefetchBufferStatus_0:
        DC32     0x40022000
        CFI EndBlock cfiBlock17
//  725 }
//  726 
//  727 /*******************************************************************************
//  728 * Function Name  : FLASH_ITConfig
//  729 * Description    : Enables or disables the specified FLASH interrupts.
//  730 * Input          : - FLASH_IT: specifies the FLASH interrupt sources to be 
//  731 *                    enabled or disabled.
//  732 *                    This parameter can be any combination of the following values:
//  733 *                       - FLASH_IT_ERROR: FLASH Error Interrupt
//  734 *                       - FLASH_IT_EOP: FLASH end of operation Interrupt
//  735 * Output         : None
//  736 * Return         : None 
//  737 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function FLASH_ITConfig
        THUMB
//  738 void FLASH_ITConfig(u16 FLASH_IT, FunctionalState NewState)
//  739 {
//  740   /* Check the parameters */
//  741   assert_param(IS_FLASH_IT(FLASH_IT)); 
//  742   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  743 
//  744   if(NewState != DISABLE)
FLASH_ITConfig:
        LDR.N    R2,??FLASH_ITConfig_0  ;; 0x40022010
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??FLASH_ITConfig_1
//  745   {
//  746     /* Enable the interrupt sources */
//  747     FLASH->CR |= FLASH_IT;
        ORRS     R0,R0,R1
        B.N      ??FLASH_ITConfig_2
//  748   }
//  749   else
//  750   {
//  751     /* Disable the interrupt sources */
//  752     FLASH->CR &= ~(u32)FLASH_IT;
??FLASH_ITConfig_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??FLASH_ITConfig_2:
        STR      R0,[R2, #+0]
//  753   }
//  754 }
        BX       LR               ;; return
        DATA
??FLASH_ITConfig_0:
        DC32     0x40022010
        CFI EndBlock cfiBlock18
//  755 
//  756 /*******************************************************************************
//  757 * Function Name  : FLASH_GetFlagStatus
//  758 * Description    : Checks whether the specified FLASH flag is set or not.
//  759 * Input          : - FLASH_FLAG: specifies the FLASH flag to check.
//  760 *                     This parameter can be one of the following values:
//  761 *                    - FLASH_FLAG_BSY: FLASH Busy flag           
//  762 *                    - FLASH_FLAG_PGERR: FLASH Program error flag       
//  763 *                    - FLASH_FLAG_WRPRTERR: FLASH Write protected error flag      
//  764 *                    - FLASH_FLAG_EOP: FLASH End of Operation flag           
//  765 *                    - FLASH_FLAG_OPTERR:  FLASH Option Byte error flag     
//  766 * Output         : None
//  767 * Return         : The new state of FLASH_FLAG (SET or RESET).
//  768 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function FLASH_GetFlagStatus
        THUMB
//  769 FlagStatus FLASH_GetFlagStatus(u16 FLASH_FLAG)
//  770 {
//  771   FlagStatus bitstatus = RESET;
//  772 
//  773   /* Check the parameters */
//  774   assert_param(IS_FLASH_GET_FLAG(FLASH_FLAG)) ;
//  775 
//  776   if(FLASH_FLAG == FLASH_FLAG_OPTERR) 
FLASH_GetFlagStatus:
        CMP      R0,#+1
        BNE.N    ??FLASH_GetFlagStatus_0
//  777   {
//  778     if((FLASH->OBR & FLASH_FLAG_OPTERR) != (u32)RESET)
        LDR.N    R0,??FLASH_GetFlagStatus_1  ;; 0x4002200c
        LDR      R0,[R0, #+16]
//  779     {
//  780       bitstatus = SET;
//  781     }
//  782     else
//  783     {
//  784       bitstatus = RESET;
        AND      R0,R0,#0x1
        BX       LR
//  785     }
//  786   }
//  787   else
//  788   {
//  789    if((FLASH->SR & FLASH_FLAG) != (u32)RESET)
??FLASH_GetFlagStatus_0:
        LDR.N    R1,??FLASH_GetFlagStatus_1  ;; 0x4002200c
        LDR      R1,[R1, #+0]
        ANDS     R1,R0,R1
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  790     {
//  791       bitstatus = SET;
//  792     }
//  793     else
//  794     {
//  795       bitstatus = RESET;
//  796     }
//  797   }
//  798   /* Return the new state of FLASH_FLAG (SET or RESET) */
//  799   return bitstatus;
??FLASH_GetFlagStatus_2:
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_GetFlagStatus_1:
        DC32     0x4002200c
        CFI EndBlock cfiBlock19
//  800 }
//  801 
//  802 /*******************************************************************************
//  803 * Function Name  : FLASH_ClearFlag
//  804 * Description    : Clears the FLASH�s pending flags.
//  805 * Input          : - FLASH_FLAG: specifies the FLASH flags to clear.
//  806 *                    This parameter can be any combination of the following values:
//  807 *                    - FLASH_FLAG_BSY: FLASH Busy flag           
//  808 *                    - FLASH_FLAG_PGERR: FLASH Program error flag       
//  809 *                    - FLASH_FLAG_WRPRTERR: FLASH Write protected error flag      
//  810 *                    - FLASH_FLAG_EOP: FLASH End of Operation flag           
//  811 * Output         : None
//  812 * Return         : None
//  813 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function FLASH_ClearFlag
        THUMB
//  814 void FLASH_ClearFlag(u16 FLASH_FLAG)
//  815 {
//  816   /* Check the parameters */
//  817   assert_param(IS_FLASH_CLEAR_FLAG(FLASH_FLAG)) ;
//  818   
//  819   /* Clear the flags */
//  820   FLASH->SR = FLASH_FLAG;
FLASH_ClearFlag:
        LDR.N    R1,??FLASH_ClearFlag_0  ;; 0x4002200c
        STR      R0,[R1, #+0]
//  821 }
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_ClearFlag_0:
        DC32     0x4002200c
        CFI EndBlock cfiBlock20
//  822 
//  823 /*******************************************************************************
//  824 * Function Name  : FLASH_GetStatus
//  825 * Description    : Returns the FLASH Status.
//  826 * Input          : None
//  827 * Output         : None
//  828 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  829 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP or FLASH_COMPLETE
//  830 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function FLASH_GetStatus
        THUMB
//  831 FLASH_Status FLASH_GetStatus(void)
//  832 {
//  833   FLASH_Status flashstatus = FLASH_COMPLETE;
//  834   
//  835   if((FLASH->SR & FLASH_FLAG_BSY) == FLASH_FLAG_BSY) 
FLASH_GetStatus:
        LDR.N    R0,??FLASH_GetStatus_0  ;; 0x4002200c
        LDR      R1,[R0, #+0]
        TST      R1,#0x1
        BEQ.N    ??FLASH_GetStatus_1
//  836   {
//  837     flashstatus = FLASH_BUSY;
        MOVS     R0,#+1
        BX       LR
//  838   }
//  839   else 
//  840   {  
//  841     if(FLASH->SR & FLASH_FLAG_PGERR)
??FLASH_GetStatus_1:
        LDR      R1,[R0, #+0]
        TST      R1,#0x4
        BEQ.N    ??FLASH_GetStatus_2
//  842     { 
//  843       flashstatus = FLASH_ERROR_PG;
        MOVS     R0,#+2
        BX       LR
//  844     }
//  845     else 
//  846     {
//  847       if(FLASH->SR & FLASH_FLAG_WRPRTERR)
??FLASH_GetStatus_2:
        LDR      R0,[R0, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_GetStatus_3
//  848       {
//  849         flashstatus = FLASH_ERROR_WRP;
        MOVS     R0,#+3
        BX       LR
//  850       }
//  851       else
//  852       {
//  853         flashstatus = FLASH_COMPLETE;
??FLASH_GetStatus_3:
        MOVS     R0,#+4
//  854       }
//  855     }
//  856   }
//  857   /* Return the Flash Status */
//  858   return flashstatus;
??FLASH_GetStatus_4:
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_GetStatus_0:
        DC32     0x4002200c
        CFI EndBlock cfiBlock21
//  859 }
//  860 
//  861 /*******************************************************************************
//  862 * Function Name  : FLASH_WaitForLastOperation
//  863 * Description    : Waits for a Flash operation to complete or a TIMEOUT to occur.
//  864 * Input          : - Timeout: FLASH progamming Timeout
//  865 * Output         : None
//  866 * Return         : FLASH Status: The returned value can be: FLASH_BUSY, 
//  867 *                  FLASH_ERROR_PG, FLASH_ERROR_WRP, FLASH_COMPLETE or 
//  868 *                  FLASH_TIMEOUT.
//  869 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function FLASH_WaitForLastOperation
        THUMB
//  870 FLASH_Status FLASH_WaitForLastOperation(u32 Timeout)
//  871 { 
FLASH_WaitForLastOperation:
        SUB      SP,SP,#+8
        CFI CFA R13+8
        MOVS     R1,R0
//  872   FLASH_Status status = FLASH_COMPLETE;
//  873    
//  874   /* Check for the Flash Status */
//  875   status = FLASH_GetStatus();
        LDR.N    R2,??FLASH_WaitForLastOperation_0  ;; 0x4002200c
        LDR      R0,[R2, #+0]
        TST      R0,#0x1
        BEQ.N    ??FLASH_WaitForLastOperation_1
        MOVS     R0,#+1
??FLASH_WaitForLastOperation_2:
        CBZ      R1,??FLASH_WaitForLastOperation_3
//  876 
//  877   /* Wait for a Flash operation to complete or a TIMEOUT to occur */
//  878   while((status == FLASH_BUSY) && (Timeout != 0x00))
//  879   {
//  880     delay();
        MOVS     R3,#+0
        STR      R3,[SP, #+0]
        MOVS     R3,#+255
        B.N      ??FLASH_WaitForLastOperation_4
??FLASH_WaitForLastOperation_1:
        LDR      R0,[R2, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_WaitForLastOperation_5
        MOVS     R0,#+2
        B.N      ??FLASH_WaitForLastOperation_6
??FLASH_WaitForLastOperation_5:
        LDR      R0,[R2, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_WaitForLastOperation_7
        MOVS     R0,#+3
        B.N      ??FLASH_WaitForLastOperation_6
??FLASH_WaitForLastOperation_7:
        MOVS     R0,#+4
        B.N      ??FLASH_WaitForLastOperation_6
??FLASH_WaitForLastOperation_8:
        LDR      R3,[SP, #+0]
        SUBS     R3,R3,#+1
??FLASH_WaitForLastOperation_4:
        STR      R3,[SP, #+0]
        LDR      R3,[SP, #+0]
        CMP      R3,#+0
        BNE.N    ??FLASH_WaitForLastOperation_8
//  881     status = FLASH_GetStatus();
        LDR      R3,[R2, #+0]
        TST      R3,#0x1
        BNE.N    ??FLASH_WaitForLastOperation_9
        LDR      R0,[R2, #+0]
        TST      R0,#0x4
        BEQ.N    ??FLASH_WaitForLastOperation_10
        MOVS     R0,#+2
        B.N      ??FLASH_WaitForLastOperation_9
??FLASH_WaitForLastOperation_10:
        LDR      R0,[R2, #+0]
        TST      R0,#0x10
        BEQ.N    ??FLASH_WaitForLastOperation_11
        MOVS     R0,#+3
        B.N      ??FLASH_WaitForLastOperation_9
??FLASH_WaitForLastOperation_11:
        MOVS     R0,#+4
//  882     Timeout--;
??FLASH_WaitForLastOperation_9:
        SUBS     R1,R1,#+1
        CMP      R0,#+1
        BEQ.N    ??FLASH_WaitForLastOperation_2
//  883   }
//  884 
//  885   if(Timeout == 0x00 )
??FLASH_WaitForLastOperation_6:
        CBNZ     R1,??FLASH_WaitForLastOperation_12
//  886   {
//  887     status = FLASH_TIMEOUT;
??FLASH_WaitForLastOperation_3:
        MOVS     R0,#+5
//  888   }
//  889 
//  890   /* Return the operation status */
//  891   return status;
??FLASH_WaitForLastOperation_12:
        ADD      SP,SP,#+8
        CFI CFA R13+0
        BX       LR               ;; return
        Nop      
        DATA
??FLASH_WaitForLastOperation_0:
        DC32     0x4002200c
        CFI EndBlock cfiBlock22
//  892 }

        END
//  893 
//  894 /*******************************************************************************
//  895 * Function Name  : delay
//  896 * Description    : Inserts a time delay.
//  897 * Input          : None
//  898 * Output         : None
//  899 * Return         : None
//  900 *******************************************************************************/
//  901 static void delay(void)
//  902 {
//  903   vu32 i = 0;
//  904 
//  905   for(i = 0xFF; i != 0; i--)
//  906   {
//  907   }
//  908 }
//  909 #endif
//  910 
//  911 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
// 4 218 bytes in section .text
// 
// 4 218 bytes of CODE memory
//
//Errors: none
//Warnings: none
