///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      12/Apr/2011  13:39:16 /
// IAR ANSI C/C++ Compiler V5.20.0.20892/W32 EVALUATION for ARM               /
// Copyright 1999-2008 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  E:\DS0203\FWLib\src\stm32f10x_rcc.c                     /
//    Command line =  E:\DS0203\FWLib\src\stm32f10x_rcc.c -lA                 /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\ -o             /
//                    E:\DS0203\APP_V2.32\IAR_V5_Prpject\Obj\ --debug         /
//                    --endian=little --cpu=Cortex-M3 --fpu=None              /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 5.0 Evaluation\ARM\INC\DLib_Config_Full.h"    /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\FWLib\inc\  /
//                    -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\..\USBLib\inc\ /
//                     -I E:\DS0203\APP_V2.32\IAR_V5_Prpject\..\include\ -I   /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 5.0    /
//                    Evaluation\ARM\INC\" -Ohs                               /
//    List file    =  E:\DS0203\APP_V2.32\IAR_V5_Prpject\List\stm32f10x_rcc.s /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME stm32f10x_rcc

        PUBLIC RCC_ADCCLKConfig
        PUBLIC RCC_AHBPeriphClockCmd
        PUBLIC RCC_APB1PeriphClockCmd
        PUBLIC RCC_APB1PeriphResetCmd
        PUBLIC RCC_APB2PeriphClockCmd
        PUBLIC RCC_APB2PeriphResetCmd
        PUBLIC RCC_AdjustHSICalibrationValue
        PUBLIC RCC_BackupResetCmd
        PUBLIC RCC_ClearFlag
        PUBLIC RCC_ClearITPendingBit
        PUBLIC RCC_ClockSecuritySystemCmd
        PUBLIC RCC_DeInit
        PUBLIC RCC_GetClocksFreq
        PUBLIC RCC_GetFlagStatus
        PUBLIC RCC_GetITStatus
        PUBLIC RCC_GetSYSCLKSource
        PUBLIC RCC_HCLKConfig
        PUBLIC RCC_HSEConfig
        PUBLIC RCC_HSICmd
        PUBLIC RCC_ITConfig
        PUBLIC RCC_LSEConfig
        PUBLIC RCC_LSICmd
        PUBLIC RCC_MCOConfig
        PUBLIC RCC_PCLK1Config
        PUBLIC RCC_PCLK2Config
        PUBLIC RCC_PLLCmd
        PUBLIC RCC_PLLConfig
        PUBLIC RCC_RTCCLKCmd
        PUBLIC RCC_RTCCLKConfig
        PUBLIC RCC_SYSCLKConfig
        PUBLIC RCC_USBCLKConfig
        PUBLIC RCC_WaitForHSEStartUp
        
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
        
// E:\DS0203\FWLib\src\stm32f10x_rcc.c
//    1 /******************** (C) COPYRIGHT 2008 STMicroelectronics ********************
//    2 * File Name          : stm32f10x_rcc.c
//    3 * Author             : MCD Application Team
//    4 * Version            : V2.0.3
//    5 * Date               : 09/22/2008
//    6 * Description        : This file provides all the RCC firmware functions.
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
//   17 #include "stm32f10x_rcc.h"
//   18 
//   19 /* Private typedef -----------------------------------------------------------*/
//   20 /* Private define ------------------------------------------------------------*/
//   21 /* ------------ RCC registers bit address in the alias region ----------- */
//   22 #define RCC_OFFSET                (RCC_BASE - PERIPH_BASE)
//   23 
//   24 /* --- CR Register ---*/
//   25 /* Alias word address of HSION bit */
//   26 #define CR_OFFSET                 (RCC_OFFSET + 0x00)
//   27 #define HSION_BitNumber           0x00
//   28 #define CR_HSION_BB               (PERIPH_BB_BASE + (CR_OFFSET * 32) + (HSION_BitNumber * 4))
//   29 
//   30 /* Alias word address of PLLON bit */
//   31 #define PLLON_BitNumber           0x18
//   32 #define CR_PLLON_BB               (PERIPH_BB_BASE + (CR_OFFSET * 32) + (PLLON_BitNumber * 4))
//   33 
//   34 /* Alias word address of CSSON bit */
//   35 #define CSSON_BitNumber           0x13
//   36 #define CR_CSSON_BB               (PERIPH_BB_BASE + (CR_OFFSET * 32) + (CSSON_BitNumber * 4))
//   37 
//   38 /* --- CFGR Register ---*/
//   39 /* Alias word address of USBPRE bit */
//   40 #define CFGR_OFFSET               (RCC_OFFSET + 0x04)
//   41 #define USBPRE_BitNumber          0x16
//   42 #define CFGR_USBPRE_BB            (PERIPH_BB_BASE + (CFGR_OFFSET * 32) + (USBPRE_BitNumber * 4))
//   43 
//   44 /* --- BDCR Register ---*/
//   45 /* Alias word address of RTCEN bit */
//   46 #define BDCR_OFFSET               (RCC_OFFSET + 0x20)
//   47 #define RTCEN_BitNumber           0x0F
//   48 #define BDCR_RTCEN_BB             (PERIPH_BB_BASE + (BDCR_OFFSET * 32) + (RTCEN_BitNumber * 4))
//   49 
//   50 /* Alias word address of BDRST bit */
//   51 #define BDRST_BitNumber           0x10
//   52 #define BDCR_BDRST_BB             (PERIPH_BB_BASE + (BDCR_OFFSET * 32) + (BDRST_BitNumber * 4))
//   53 
//   54 /* --- CSR Register ---*/
//   55 /* Alias word address of LSION bit */
//   56 #define CSR_OFFSET                (RCC_OFFSET + 0x24)
//   57 #define LSION_BitNumber           0x00
//   58 #define CSR_LSION_BB              (PERIPH_BB_BASE + (CSR_OFFSET * 32) + (LSION_BitNumber * 4))
//   59 
//   60 /* ---------------------- RCC registers bit mask ------------------------ */
//   61 /* CR register bit mask */
//   62 #define CR_HSEBYP_Reset           ((u32)0xFFFBFFFF)
//   63 #define CR_HSEBYP_Set             ((u32)0x00040000)
//   64 #define CR_HSEON_Reset            ((u32)0xFFFEFFFF)
//   65 #define CR_HSEON_Set              ((u32)0x00010000)
//   66 #define CR_HSITRIM_Mask           ((u32)0xFFFFFF07)
//   67 
//   68 /* CFGR register bit mask */
//   69 #define CFGR_PLL_Mask             ((u32)0xFFC0FFFF)
//   70 #define CFGR_PLLMull_Mask         ((u32)0x003C0000)
//   71 #define CFGR_PLLSRC_Mask          ((u32)0x00010000)
//   72 #define CFGR_PLLXTPRE_Mask        ((u32)0x00020000)
//   73 #define CFGR_SWS_Mask             ((u32)0x0000000C)
//   74 #define CFGR_SW_Mask              ((u32)0xFFFFFFFC)
//   75 #define CFGR_HPRE_Reset_Mask      ((u32)0xFFFFFF0F)
//   76 #define CFGR_HPRE_Set_Mask        ((u32)0x000000F0)
//   77 #define CFGR_PPRE1_Reset_Mask     ((u32)0xFFFFF8FF)
//   78 #define CFGR_PPRE1_Set_Mask       ((u32)0x00000700)
//   79 #define CFGR_PPRE2_Reset_Mask     ((u32)0xFFFFC7FF)
//   80 #define CFGR_PPRE2_Set_Mask       ((u32)0x00003800)
//   81 #define CFGR_ADCPRE_Reset_Mask    ((u32)0xFFFF3FFF)
//   82 #define CFGR_ADCPRE_Set_Mask      ((u32)0x0000C000)
//   83 
//   84 /* CSR register bit mask */
//   85 #define CSR_RMVF_Set              ((u32)0x01000000)
//   86 
//   87 /* RCC Flag Mask */
//   88 #define FLAG_Mask                 ((u8)0x1F)
//   89 
//   90 /* Typical Value of the HSI in Hz */
//   91 #define HSI_Value                 ((u32)8000000)
//   92 
//   93 /* CIR register byte 2 (Bits[15:8]) base address */
//   94 #define CIR_BYTE2_ADDRESS         ((u32)0x40021009)
//   95 /* CIR register byte 3 (Bits[23:16]) base address */
//   96 #define CIR_BYTE3_ADDRESS         ((u32)0x4002100A)
//   97 
//   98 /* CFGR register byte 4 (Bits[31:24]) base address */
//   99 #define CFGR_BYTE4_ADDRESS        ((u32)0x40021007)
//  100 
//  101 /* BDCR register base address */
//  102 #define BDCR_ADDRESS              (PERIPH_BASE + BDCR_OFFSET)
//  103 
//  104 #ifndef HSEStartUp_TimeOut
//  105 /* Time out for HSE start up */
//  106 #define HSEStartUp_TimeOut        ((u16)0x0500)
//  107 #endif
//  108 
//  109 /* Private macro -------------------------------------------------------------*/
//  110 /* Private variables ---------------------------------------------------------*/

        SECTION `.rodata`:CONST:NOROOT(2)
//  111 static uc8 APBAHBPrescTable[16] = {0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9};
APBAHBPrescTable:
        DATA
        DC8 0, 0, 0, 0, 1, 2, 3, 4, 1, 2, 3, 4, 6, 7, 8, 9
        DC8 2, 4, 6, 8
//  112 static uc8 ADCPrescTable[4] = {2, 4, 6, 8};
//  113 
//  114 /* Private function prototypes -----------------------------------------------*/
//  115 /* Private functions ---------------------------------------------------------*/
//  116 
//  117 /*******************************************************************************
//  118 * Function Name  : RCC_DeInit
//  119 * Description    : Resets the RCC clock configuration to the default reset state.
//  120 * Input          : None
//  121 * Output         : None
//  122 * Return         : None
//  123 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock0 Using cfiCommon0
        CFI Function RCC_DeInit
        THUMB
//  124 void RCC_DeInit(void)
//  125 {
//  126   /* Set HSION bit */
//  127   RCC->CR |= (u32)0x00000001;
RCC_DeInit:
        LDR.N    R0,??DataTable17  ;; 0x40021000
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1
        STR      R1,[R0, #+0]
//  128 
//  129   /* Reset SW[1:0], HPRE[3:0], PPRE1[2:0], PPRE2[2:0], ADCPRE[1:0] and MCO[2:0] bits */
//  130   RCC->CFGR &= (u32)0xF8FF0000;
        LDR      R1,[R0, #+4]
        LDR.N    R2,??RCC_DeInit_0  ;; 0xf8ff0000
        ANDS     R1,R2,R1
        STR      R1,[R0, #+4]
//  131   
//  132   /* Reset HSEON, CSSON and PLLON bits */
//  133   RCC->CR &= (u32)0xFEF6FFFF;
        LDR      R1,[R0, #+0]
        LDR.N    R2,??RCC_DeInit_0+0x4  ;; 0xfef6ffff
        ANDS     R1,R2,R1
        STR      R1,[R0, #+0]
//  134 
//  135   /* Reset HSEBYP bit */
//  136   RCC->CR &= (u32)0xFFFBFFFF;
        LDR      R1,[R0, #+0]
        MVN      R2,#+262144
        ANDS     R1,R2,R1
        STR      R1,[R0, #+0]
//  137 
//  138   /* Reset PLLSRC, PLLXTPRE, PLLMUL[3:0] and USBPRE bits */
//  139   RCC->CFGR &= (u32)0xFF80FFFF;
        LDR      R0,[R0, #+4]
        MVN      R1,#+8323072
        ANDS     R0,R1,R0
        LDR.N    R1,??DataTable17  ;; 0x40021000
        STR      R0,[R1, #+4]
//  140 
//  141   /* Disable all interrupts */
//  142   RCC->CIR = 0x00000000;
        MOV      R0,R1
        MOVS     R1,#+0
        STR      R1,[R0, #+8]
//  143 }
        BX       LR               ;; return
        DATA
??RCC_DeInit_0:
        DC32     0xf8ff0000
        DC32     0xfef6ffff
        CFI EndBlock cfiBlock0
//  144 
//  145 /*******************************************************************************
//  146 * Function Name  : RCC_HSEConfig
//  147 * Description    : Configures the External High Speed oscillator (HSE).
//  148 *                  HSE can not be stopped if it is used directly or through the 
//  149 *                  PLL as system clock.
//  150 * Input          : - RCC_HSE: specifies the new state of the HSE.
//  151 *                    This parameter can be one of the following values:
//  152 *                       - RCC_HSE_OFF: HSE oscillator OFF
//  153 *                       - RCC_HSE_ON: HSE oscillator ON
//  154 *                       - RCC_HSE_Bypass: HSE oscillator bypassed with external
//  155 *                         clock
//  156 * Output         : None
//  157 * Return         : None
//  158 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock1 Using cfiCommon0
        CFI Function RCC_HSEConfig
        THUMB
//  159 void RCC_HSEConfig(u32 RCC_HSE)
//  160 {
//  161   /* Check the parameters */
//  162   assert_param(IS_RCC_HSE(RCC_HSE));
//  163 
//  164   /* Reset HSEON and HSEBYP bits before configuring the HSE ------------------*/
//  165   /* Reset HSEON bit */
//  166   RCC->CR &= CR_HSEON_Reset;
RCC_HSEConfig:
        LDR.N    R1,??DataTable17  ;; 0x40021000
        LDR      R2,[R1, #+0]
        MVN      R3,#+65536
        ANDS     R2,R3,R2
        STR      R2,[R1, #+0]
//  167 
//  168   /* Reset HSEBYP bit */
//  169   RCC->CR &= CR_HSEBYP_Reset;
        LDR      R2,[R1, #+0]
        MVN      R3,#+262144
        ANDS     R2,R3,R2
        STR      R2,[R1, #+0]
//  170 
//  171   /* Configure HSE (RCC_HSE_OFF is already covered by the code section above) */
//  172   switch(RCC_HSE)
        MOV      R2,#+65536
        SUBS     R0,R0,R2
        BEQ.N    ??RCC_HSEConfig_0
        MOV      R2,#+196608
        SUBS     R0,R0,R2
        ITTT     EQ 
        LDREQ    R0,[R1, #+0]
        ORREQ    R0,R0,#0x50000
        STREQ    R0,[R1, #+0]
        BX       LR
//  173   {
//  174     case RCC_HSE_ON:
//  175       /* Set HSEON bit */
//  176       RCC->CR |= CR_HSEON_Set;
??RCC_HSEConfig_0:
        LDR      R0,[R1, #+0]
        ORR      R0,R0,#0x10000
        STR      R0,[R1, #+0]
//  177       break;
//  178       
//  179     case RCC_HSE_Bypass:
//  180       /* Set HSEBYP and HSEON bits */
//  181       RCC->CR |= CR_HSEBYP_Set | CR_HSEON_Set;
//  182       break;            
//  183       
//  184     default:
//  185       break;      
//  186   }
//  187 }
??RCC_HSEConfig_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock1
//  188 
//  189 /*******************************************************************************
//  190 * Function Name  : RCC_WaitForHSEStartUp
//  191 * Description    : Waits for HSE start-up.
//  192 * Input          : None
//  193 * Output         : None
//  194 * Return         : An ErrorStatus enumuration value:
//  195 *                         - SUCCESS: HSE oscillator is stable and ready to use
//  196 *                         - ERROR: HSE oscillator not yet ready
//  197 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock2 Using cfiCommon0
        CFI Function RCC_WaitForHSEStartUp
        THUMB
//  198 ErrorStatus RCC_WaitForHSEStartUp(void)
//  199 {
RCC_WaitForHSEStartUp:
        SUB      SP,SP,#+8
        CFI CFA R13+8
//  200   vu32 StartUpCounter = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  201   ErrorStatus status = ERROR;
//  202   FlagStatus HSEStatus = RESET;
        LDR.N    R0,??DataTable17  ;; 0x40021000
//  203   
//  204   /* Wait till HSE is ready and if Time out is reached exit */
//  205   do
//  206   {
//  207     HSEStatus = RCC_GetFlagStatus(RCC_FLAG_HSERDY);
??RCC_WaitForHSEStartUp_0:
        LDR      R1,[R0, #+0]
        AND      R1,R1,#0x20000
        SUBS     R1,R1,#+1
        SBCS     R1,R1,R1
        MVNS     R1,R1
        LSRS     R1,R1,#+31
//  208     StartUpCounter++;  
        LDR      R2,[SP, #+0]
        ADDS     R2,R2,#+1
        STR      R2,[SP, #+0]
//  209   } while((HSEStatus == RESET) && (StartUpCounter != HSEStartUp_TimeOut));
        CBNZ     R1,??RCC_WaitForHSEStartUp_1
        LDR      R1,[SP, #+0]
        CMP      R1,#+1280
        BNE.N    ??RCC_WaitForHSEStartUp_0
//  210 
//  211 
//  212   if (RCC_GetFlagStatus(RCC_FLAG_HSERDY) != RESET)
??RCC_WaitForHSEStartUp_1:
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0x20000
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
//  213   {
//  214     status = SUCCESS;
//  215   }
//  216   else
//  217   {
//  218     status = ERROR;
//  219   }  
//  220 
//  221   return (status);
        ADD      SP,SP,#+8
        CFI CFA R13+0
        BX       LR               ;; return
        CFI EndBlock cfiBlock2
//  222 }
//  223 
//  224 /*******************************************************************************
//  225 * Function Name  : RCC_AdjustHSICalibrationValue
//  226 * Description    : Adjusts the Internal High Speed oscillator (HSI) calibration
//  227 *                  value.
//  228 * Input          : - HSICalibrationValue: specifies the calibration trimming value.
//  229 *                    This parameter must be a number between 0 and 0x1F.
//  230 * Output         : None
//  231 * Return         : None
//  232 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock3 Using cfiCommon0
        CFI Function RCC_AdjustHSICalibrationValue
        THUMB
//  233 void RCC_AdjustHSICalibrationValue(u8 HSICalibrationValue)
//  234 {
//  235   u32 tmpreg = 0;
//  236 
//  237   /* Check the parameters */
//  238   assert_param(IS_RCC_CALIBRATION_VALUE(HSICalibrationValue));
//  239 
//  240   tmpreg = RCC->CR;
RCC_AdjustHSICalibrationValue:
        LDR.N    R1,??DataTable17  ;; 0x40021000
        LDR      R2,[R1, #+0]
//  241 
//  242   /* Clear HSITRIM[4:0] bits */
//  243   tmpreg &= CR_HSITRIM_Mask;
//  244 
//  245   /* Set the HSITRIM[4:0] bits according to HSICalibrationValue value */
//  246   tmpreg |= (u32)HSICalibrationValue << 3;
//  247 
//  248   /* Store the new value */
//  249   RCC->CR = tmpreg;
        MOVS     R3,#+248
        BICS     R2,R2,R3
        ORR      R0,R2,R0, LSL #+3
        STR      R0,[R1, #+0]
//  250 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock3
//  251 
//  252 /*******************************************************************************
//  253 * Function Name  : RCC_HSICmd
//  254 * Description    : Enables or disables the Internal High Speed oscillator (HSI).
//  255 *                  HSI can not be stopped if it is used directly or through the 
//  256 *                  PLL as system clock.
//  257 * Input          : - NewState: new state of the HSI.
//  258 *                    This parameter can be: ENABLE or DISABLE.
//  259 * Output         : None
//  260 * Return         : None
//  261 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock4 Using cfiCommon0
        CFI Function RCC_HSICmd
        THUMB
//  262 void RCC_HSICmd(FunctionalState NewState)
//  263 {
//  264   /* Check the parameters */
//  265   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  266 
//  267   *(vu32 *) CR_HSION_BB = (u32)NewState;
RCC_HSICmd:
        LDR.N    R1,??RCC_HSICmd_0  ;; 0x42420000
        STR      R0,[R1, #+0]
//  268 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_HSICmd_0:
        DC32     0x42420000
        CFI EndBlock cfiBlock4
//  269 
//  270 /*******************************************************************************
//  271 * Function Name  : RCC_PLLConfig
//  272 * Description    : Configures the PLL clock source and multiplication factor.
//  273 *                  This function must be used only when the PLL is disabled.
//  274 * Input          : - RCC_PLLSource: specifies the PLL entry clock source.
//  275 *                    This parameter can be one of the following values:
//  276 *                       - RCC_PLLSource_HSI_Div2: HSI oscillator clock divided
//  277 *                         by 2 selected as PLL clock entry
//  278 *                       - RCC_PLLSource_HSE_Div1: HSE oscillator clock selected
//  279 *                         as PLL clock entry
//  280 *                       - RCC_PLLSource_HSE_Div2: HSE oscillator clock divided
//  281 *                         by 2 selected as PLL clock entry
//  282 *                  - RCC_PLLMul: specifies the PLL multiplication factor.
//  283 *                    This parameter can be RCC_PLLMul_x where x:[2,16]
//  284 * Output         : None
//  285 * Return         : None
//  286 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock5 Using cfiCommon0
        CFI Function RCC_PLLConfig
        THUMB
//  287 void RCC_PLLConfig(u32 RCC_PLLSource, u32 RCC_PLLMul)
//  288 {
//  289   u32 tmpreg = 0;
//  290 
//  291   /* Check the parameters */
//  292   assert_param(IS_RCC_PLL_SOURCE(RCC_PLLSource));
//  293   assert_param(IS_RCC_PLL_MUL(RCC_PLLMul));
//  294 
//  295   tmpreg = RCC->CFGR;
RCC_PLLConfig:
        LDR.N    R2,??DataTable14  ;; 0x40021004
        LDR      R3,[R2, #+0]
//  296 
//  297   /* Clear PLLSRC, PLLXTPRE and PLLMUL[3:0] bits */
//  298   tmpreg &= CFGR_PLL_Mask;
//  299 
//  300   /* Set the PLL configuration bits */
//  301   tmpreg |= RCC_PLLSource | RCC_PLLMul;
//  302 
//  303   /* Store the new value */
//  304   RCC->CFGR = tmpreg;
        MVN      R12,#+4128768
        AND      R3,R12,R3
        ORRS     R0,R0,R3
        ORRS     R0,R1,R0
        STR      R0,[R2, #+0]
//  305 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock5
//  306 
//  307 /*******************************************************************************
//  308 * Function Name  : RCC_PLLCmd
//  309 * Description    : Enables or disables the PLL.
//  310 *                  The PLL can not be disabled if it is used as system clock.
//  311 * Input          : - NewState: new state of the PLL.
//  312 *                    This parameter can be: ENABLE or DISABLE.
//  313 * Output         : None
//  314 * Return         : None
//  315 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock6 Using cfiCommon0
        CFI Function RCC_PLLCmd
        THUMB
//  316 void RCC_PLLCmd(FunctionalState NewState)
//  317 {
//  318   /* Check the parameters */
//  319   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  320 
//  321   *(vu32 *) CR_PLLON_BB = (u32)NewState;
RCC_PLLCmd:
        LDR.N    R1,??RCC_PLLCmd_0  ;; 0x42420060
        STR      R0,[R1, #+0]
//  322 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_PLLCmd_0:
        DC32     0x42420060
        CFI EndBlock cfiBlock6
//  323 
//  324 /*******************************************************************************
//  325 * Function Name  : RCC_SYSCLKConfig
//  326 * Description    : Configures the system clock (SYSCLK).
//  327 * Input          : - RCC_SYSCLKSource: specifies the clock source used as system
//  328 *                    clock. This parameter can be one of the following values:
//  329 *                       - RCC_SYSCLKSource_HSI: HSI selected as system clock
//  330 *                       - RCC_SYSCLKSource_HSE: HSE selected as system clock
//  331 *                       - RCC_SYSCLKSource_PLLCLK: PLL selected as system clock
//  332 * Output         : None
//  333 * Return         : None
//  334 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock7 Using cfiCommon0
        CFI Function RCC_SYSCLKConfig
        THUMB
//  335 void RCC_SYSCLKConfig(u32 RCC_SYSCLKSource)
//  336 {
//  337   u32 tmpreg = 0;
//  338 
//  339   /* Check the parameters */
//  340   assert_param(IS_RCC_SYSCLK_SOURCE(RCC_SYSCLKSource));
//  341 
//  342   tmpreg = RCC->CFGR;
RCC_SYSCLKConfig:
        LDR.N    R1,??DataTable14  ;; 0x40021004
        LDR      R2,[R1, #+0]
//  343 
//  344   /* Clear SW[1:0] bits */
//  345   tmpreg &= CFGR_SW_Mask;
//  346 
//  347   /* Set SW[1:0] bits according to RCC_SYSCLKSource value */
//  348   tmpreg |= RCC_SYSCLKSource;
//  349 
//  350   /* Store the new value */
//  351   RCC->CFGR = tmpreg;
        MOVS     R3,#+3
        BICS     R2,R2,R3
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  352 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock7
//  353 
//  354 /*******************************************************************************
//  355 * Function Name  : RCC_GetSYSCLKSource
//  356 * Description    : Returns the clock source used as system clock.
//  357 * Input          : None
//  358 * Output         : None
//  359 * Return         : The clock source used as system clock. The returned value can
//  360 *                  be one of the following:
//  361 *                       - 0x00: HSI used as system clock
//  362 *                       - 0x04: HSE used as system clock
//  363 *                       - 0x08: PLL used as system clock
//  364 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock8 Using cfiCommon0
        CFI Function RCC_GetSYSCLKSource
        THUMB
//  365 u8 RCC_GetSYSCLKSource(void)
//  366 {
//  367   return ((u8)(RCC->CFGR & CFGR_SWS_Mask));
RCC_GetSYSCLKSource:
        LDR.N    R0,??DataTable14  ;; 0x40021004
        LDR      R0,[R0, #+0]
        AND      R0,R0,#0xC
        BX       LR               ;; return
        CFI EndBlock cfiBlock8
//  368 }
//  369 
//  370 /*******************************************************************************
//  371 * Function Name  : RCC_HCLKConfig
//  372 * Description    : Configures the AHB clock (HCLK).
//  373 * Input          : - RCC_SYSCLK: defines the AHB clock divider. This clock is
//  374 *                    derived from the system clock (SYSCLK).
//  375 *                    This parameter can be one of the following values:
//  376 *                       - RCC_SYSCLK_Div1: AHB clock = SYSCLK
//  377 *                       - RCC_SYSCLK_Div2: AHB clock = SYSCLK/2
//  378 *                       - RCC_SYSCLK_Div4: AHB clock = SYSCLK/4
//  379 *                       - RCC_SYSCLK_Div8: AHB clock = SYSCLK/8
//  380 *                       - RCC_SYSCLK_Div16: AHB clock = SYSCLK/16
//  381 *                       - RCC_SYSCLK_Div64: AHB clock = SYSCLK/64
//  382 *                       - RCC_SYSCLK_Div128: AHB clock = SYSCLK/128
//  383 *                       - RCC_SYSCLK_Div256: AHB clock = SYSCLK/256
//  384 *                       - RCC_SYSCLK_Div512: AHB clock = SYSCLK/512
//  385 * Output         : None
//  386 * Return         : None
//  387 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock9 Using cfiCommon0
        CFI Function RCC_HCLKConfig
        THUMB
//  388 void RCC_HCLKConfig(u32 RCC_SYSCLK)
//  389 {
//  390   u32 tmpreg = 0;
//  391 
//  392   /* Check the parameters */
//  393   assert_param(IS_RCC_HCLK(RCC_SYSCLK));
//  394 
//  395   tmpreg = RCC->CFGR;
RCC_HCLKConfig:
        LDR.N    R1,??DataTable14  ;; 0x40021004
        LDR      R2,[R1, #+0]
//  396 
//  397   /* Clear HPRE[3:0] bits */
//  398   tmpreg &= CFGR_HPRE_Reset_Mask;
//  399 
//  400   /* Set HPRE[3:0] bits according to RCC_SYSCLK value */
//  401   tmpreg |= RCC_SYSCLK;
//  402 
//  403   /* Store the new value */
//  404   RCC->CFGR = tmpreg;
        MOVS     R3,#+240
        BICS     R2,R2,R3
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  405 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock9
//  406 
//  407 /*******************************************************************************
//  408 * Function Name  : RCC_PCLK1Config
//  409 * Description    : Configures the Low Speed APB clock (PCLK1).
//  410 * Input          : - RCC_HCLK: defines the APB1 clock divider. This clock is
//  411 *                    derived from the AHB clock (HCLK).
//  412 *                    This parameter can be one of the following values:
//  413 *                       - RCC_HCLK_Div1: APB1 clock = HCLK
//  414 *                       - RCC_HCLK_Div2: APB1 clock = HCLK/2
//  415 *                       - RCC_HCLK_Div4: APB1 clock = HCLK/4
//  416 *                       - RCC_HCLK_Div8: APB1 clock = HCLK/8
//  417 *                       - RCC_HCLK_Div16: APB1 clock = HCLK/16
//  418 * Output         : None
//  419 * Return         : None
//  420 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock10 Using cfiCommon0
        CFI Function RCC_PCLK1Config
        THUMB
//  421 void RCC_PCLK1Config(u32 RCC_HCLK)
//  422 {
//  423   u32 tmpreg = 0;
//  424 
//  425   /* Check the parameters */
//  426   assert_param(IS_RCC_PCLK(RCC_HCLK));
//  427 
//  428   tmpreg = RCC->CFGR;
RCC_PCLK1Config:
        LDR.N    R1,??DataTable14  ;; 0x40021004
        LDR      R2,[R1, #+0]
//  429 
//  430   /* Clear PPRE1[2:0] bits */
//  431   tmpreg &= CFGR_PPRE1_Reset_Mask;
//  432 
//  433   /* Set PPRE1[2:0] bits according to RCC_HCLK value */
//  434   tmpreg |= RCC_HCLK;
//  435 
//  436   /* Store the new value */
//  437   RCC->CFGR = tmpreg;
        MVN      R3,#+1792
        ANDS     R2,R3,R2
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  438 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock10
//  439 
//  440 /*******************************************************************************
//  441 * Function Name  : RCC_PCLK2Config
//  442 * Description    : Configures the High Speed APB clock (PCLK2).
//  443 * Input          : - RCC_HCLK: defines the APB2 clock divider. This clock is
//  444 *                    derived from the AHB clock (HCLK).
//  445 *                    This parameter can be one of the following values:
//  446 *                       - RCC_HCLK_Div1: APB2 clock = HCLK
//  447 *                       - RCC_HCLK_Div2: APB2 clock = HCLK/2
//  448 *                       - RCC_HCLK_Div4: APB2 clock = HCLK/4
//  449 *                       - RCC_HCLK_Div8: APB2 clock = HCLK/8
//  450 *                       - RCC_HCLK_Div16: APB2 clock = HCLK/16
//  451 * Output         : None
//  452 * Return         : None
//  453 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock11 Using cfiCommon0
        CFI Function RCC_PCLK2Config
        THUMB
//  454 void RCC_PCLK2Config(u32 RCC_HCLK)
//  455 {
//  456   u32 tmpreg = 0;
//  457 
//  458   /* Check the parameters */
//  459   assert_param(IS_RCC_PCLK(RCC_HCLK));
//  460 
//  461   tmpreg = RCC->CFGR;
RCC_PCLK2Config:
        LDR.N    R1,??DataTable14  ;; 0x40021004
        LDR      R2,[R1, #+0]
//  462 
//  463   /* Clear PPRE2[2:0] bits */
//  464   tmpreg &= CFGR_PPRE2_Reset_Mask;
//  465 
//  466   /* Set PPRE2[2:0] bits according to RCC_HCLK value */
//  467   tmpreg |= RCC_HCLK << 3;
//  468 
//  469   /* Store the new value */
//  470   RCC->CFGR = tmpreg;
        MVN      R3,#+14336
        ANDS     R2,R3,R2
        ORR      R0,R2,R0, LSL #+3
        STR      R0,[R1, #+0]
//  471 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock11
//  472 
//  473 /*******************************************************************************
//  474 * Function Name  : RCC_ITConfig
//  475 * Description    : Enables or disables the specified RCC interrupts.
//  476 * Input          : - RCC_IT: specifies the RCC interrupt sources to be enabled
//  477 *                    or disabled.
//  478 *                    This parameter can be any combination of the following values:
//  479 *                       - RCC_IT_LSIRDY: LSI ready interrupt
//  480 *                       - RCC_IT_LSERDY: LSE ready interrupt
//  481 *                       - RCC_IT_HSIRDY: HSI ready interrupt
//  482 *                       - RCC_IT_HSERDY: HSE ready interrupt
//  483 *                       - RCC_IT_PLLRDY: PLL ready interrupt
//  484 *                  - NewState: new state of the specified RCC interrupts.
//  485 *                    This parameter can be: ENABLE or DISABLE.
//  486 * Output         : None
//  487 * Return         : None
//  488 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock12 Using cfiCommon0
        CFI Function RCC_ITConfig
        THUMB
//  489 void RCC_ITConfig(u8 RCC_IT, FunctionalState NewState)
//  490 {
//  491   /* Check the parameters */
//  492   assert_param(IS_RCC_IT(RCC_IT));
//  493   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  494 
//  495   if (NewState != DISABLE)
RCC_ITConfig:
        LDR.N    R2,??RCC_ITConfig_0  ;; 0x40021009
        CMP      R1,#+0
        LDRB     R1,[R2, #+0]
        BEQ.N    ??RCC_ITConfig_1
//  496   {
//  497     /* Perform Byte access to RCC_CIR[12:8] bits to enable the selected interrupts */
//  498     *(vu8 *) CIR_BYTE2_ADDRESS |= RCC_IT;
        ORRS     R0,R0,R1
        B.N      ??RCC_ITConfig_2
//  499   }
//  500   else
//  501   {
//  502     /* Perform Byte access to RCC_CIR[12:8] bits to disable the selected interrupts */
//  503     *(vu8 *) CIR_BYTE2_ADDRESS &= (u8)~RCC_IT;
??RCC_ITConfig_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??RCC_ITConfig_2:
        STRB     R0,[R2, #+0]
//  504   }
//  505 }
        BX       LR               ;; return
        DATA
??RCC_ITConfig_0:
        DC32     0x40021009
        CFI EndBlock cfiBlock12
//  506 
//  507 /*******************************************************************************
//  508 * Function Name  : RCC_USBCLKConfig
//  509 * Description    : Configures the USB clock (USBCLK).
//  510 * Input          : - RCC_USBCLKSource: specifies the USB clock source. This clock
//  511 *                    is derived from the PLL output.
//  512 *                    This parameter can be one of the following values:
//  513 *                       - RCC_USBCLKSource_PLLCLK_1Div5: PLL clock divided by 1,5
//  514 *                         selected as USB clock source
//  515 *                       - RCC_USBCLKSource_PLLCLK_Div1: PLL clock selected as USB
//  516 *                         clock source
//  517 * Output         : None
//  518 * Return         : None
//  519 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock13 Using cfiCommon0
        CFI Function RCC_USBCLKConfig
        THUMB
//  520 void RCC_USBCLKConfig(u32 RCC_USBCLKSource)
//  521 {
//  522   /* Check the parameters */
//  523   assert_param(IS_RCC_USBCLK_SOURCE(RCC_USBCLKSource));
//  524 
//  525   *(vu32 *) CFGR_USBPRE_BB = RCC_USBCLKSource;
RCC_USBCLKConfig:
        LDR.N    R1,??RCC_USBCLKConfig_0  ;; 0x424200d8
        STR      R0,[R1, #+0]
//  526 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_USBCLKConfig_0:
        DC32     0x424200d8
        CFI EndBlock cfiBlock13
//  527 
//  528 /*******************************************************************************
//  529 * Function Name  : RCC_ADCCLKConfig
//  530 * Description    : Configures the ADC clock (ADCCLK).
//  531 * Input          : - RCC_PCLK2: defines the ADC clock divider. This clock is
//  532 *                    derived from the APB2 clock (PCLK2).
//  533 *                    This parameter can be one of the following values:
//  534 *                       - RCC_PCLK2_Div2: ADC clock = PCLK2/2
//  535 *                       - RCC_PCLK2_Div4: ADC clock = PCLK2/4
//  536 *                       - RCC_PCLK2_Div6: ADC clock = PCLK2/6
//  537 *                       - RCC_PCLK2_Div8: ADC clock = PCLK2/8
//  538 * Output         : None
//  539 * Return         : None
//  540 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock14 Using cfiCommon0
        CFI Function RCC_ADCCLKConfig
        THUMB
//  541 void RCC_ADCCLKConfig(u32 RCC_PCLK2)
//  542 {
//  543   u32 tmpreg = 0;
//  544 
//  545   /* Check the parameters */
//  546   assert_param(IS_RCC_ADCCLK(RCC_PCLK2));
//  547 
//  548   tmpreg = RCC->CFGR;
RCC_ADCCLKConfig:
        LDR.N    R1,??DataTable14  ;; 0x40021004
        LDR      R2,[R1, #+0]
//  549 
//  550   /* Clear ADCPRE[1:0] bits */
//  551   tmpreg &= CFGR_ADCPRE_Reset_Mask;
//  552 
//  553   /* Set ADCPRE[1:0] bits according to RCC_PCLK2 value */
//  554   tmpreg |= RCC_PCLK2;
//  555 
//  556   /* Store the new value */
//  557   RCC->CFGR = tmpreg;
        MVN      R3,#+49152
        ANDS     R2,R3,R2
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  558 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock14
//  559 
//  560 /*******************************************************************************
//  561 * Function Name  : RCC_LSEConfig
//  562 * Description    : Configures the External Low Speed oscillator (LSE).
//  563 * Input          : - RCC_LSE: specifies the new state of the LSE.
//  564 *                    This parameter can be one of the following values:
//  565 *                       - RCC_LSE_OFF: LSE oscillator OFF
//  566 *                       - RCC_LSE_ON: LSE oscillator ON
//  567 *                       - RCC_LSE_Bypass: LSE oscillator bypassed with external
//  568 *                         clock
//  569 * Output         : None
//  570 * Return         : None
//  571 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock15 Using cfiCommon0
        CFI Function RCC_LSEConfig
        THUMB
//  572 void RCC_LSEConfig(u8 RCC_LSE)
//  573 {
//  574   /* Check the parameters */
//  575   assert_param(IS_RCC_LSE(RCC_LSE));
//  576 
//  577   /* Reset LSEON and LSEBYP bits before configuring the LSE ------------------*/
//  578   /* Reset LSEON bit */
//  579   *(vu8 *) BDCR_ADDRESS = RCC_LSE_OFF;
RCC_LSEConfig:
        LDR.N    R1,??DataTable13  ;; 0x40021020
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
//  580 
//  581   /* Reset LSEBYP bit */
//  582   *(vu8 *) BDCR_ADDRESS = RCC_LSE_OFF;
        STRB     R2,[R1, #+0]
//  583 
//  584   /* Configure LSE (RCC_LSE_OFF is already covered by the code section above) */
//  585   switch(RCC_LSE)
        CMP      R0,#+1
        BEQ.N    ??RCC_LSEConfig_0
        CMP      R0,#+4
        BNE.N    ??RCC_LSEConfig_1
//  586   {
//  587     case RCC_LSE_ON:
//  588       /* Set LSEON bit */
//  589       *(vu8 *) BDCR_ADDRESS = RCC_LSE_ON;
//  590       break;
//  591       
//  592     case RCC_LSE_Bypass:
//  593       /* Set LSEBYP and LSEON bits */
//  594       *(vu8 *) BDCR_ADDRESS = RCC_LSE_Bypass | RCC_LSE_ON;
??RCC_LSEConfig_2:
        MOVS     R0,#+5
??RCC_LSEConfig_0:
        STRB     R0,[R1, #+0]
//  595       break;            
//  596       
//  597     default:
//  598       break;      
//  599   }
//  600 }
??RCC_LSEConfig_1:
        BX       LR               ;; return
        CFI EndBlock cfiBlock15
//  601 
//  602 /*******************************************************************************
//  603 * Function Name  : RCC_LSICmd
//  604 * Description    : Enables or disables the Internal Low Speed oscillator (LSI).
//  605 *                  LSI can not be disabled if the IWDG is running.
//  606 * Input          : - NewState: new state of the LSI.
//  607 *                    This parameter can be: ENABLE or DISABLE.
//  608 * Output         : None
//  609 * Return         : None
//  610 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock16 Using cfiCommon0
        CFI Function RCC_LSICmd
        THUMB
//  611 void RCC_LSICmd(FunctionalState NewState)
//  612 {
//  613   /* Check the parameters */
//  614   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  615 
//  616   *(vu32 *) CSR_LSION_BB = (u32)NewState;
RCC_LSICmd:
        LDR.N    R1,??RCC_LSICmd_0  ;; 0x42420480
        STR      R0,[R1, #+0]
//  617 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_LSICmd_0:
        DC32     0x42420480
        CFI EndBlock cfiBlock16
//  618 
//  619 /*******************************************************************************
//  620 * Function Name  : RCC_RTCCLKConfig
//  621 * Description    : Configures the RTC clock (RTCCLK).
//  622 *                  Once the RTC clock is selected it can�t be changed unless the
//  623 *                  Backup domain is reset.
//  624 * Input          : - RCC_RTCCLKSource: specifies the RTC clock source.
//  625 *                    This parameter can be one of the following values:
//  626 *                       - RCC_RTCCLKSource_LSE: LSE selected as RTC clock
//  627 *                       - RCC_RTCCLKSource_LSI: LSI selected as RTC clock
//  628 *                       - RCC_RTCCLKSource_HSE_Div128: HSE clock divided by 128
//  629 *                         selected as RTC clock
//  630 * Output         : None
//  631 * Return         : None
//  632 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock17 Using cfiCommon0
        CFI Function RCC_RTCCLKConfig
        THUMB
//  633 void RCC_RTCCLKConfig(u32 RCC_RTCCLKSource)
//  634 {
//  635   /* Check the parameters */
//  636   assert_param(IS_RCC_RTCCLK_SOURCE(RCC_RTCCLKSource));
//  637 
//  638   /* Select the RTC clock source */
//  639   RCC->BDCR |= RCC_RTCCLKSource;
RCC_RTCCLKConfig:
        LDR.N    R1,??DataTable13  ;; 0x40021020
        LDR      R2,[R1, #+0]
        ORRS     R0,R0,R2
        STR      R0,[R1, #+0]
//  640 }
        BX       LR               ;; return
        CFI EndBlock cfiBlock17

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable13:
        DC32     0x40021020
//  641 
//  642 /*******************************************************************************
//  643 * Function Name  : RCC_RTCCLKCmd
//  644 * Description    : Enables or disables the RTC clock.
//  645 *                  This function must be used only after the RTC clock was
//  646 *                  selected using the RCC_RTCCLKConfig function.
//  647 * Input          : - NewState: new state of the RTC clock.
//  648 *                    This parameter can be: ENABLE or DISABLE.
//  649 * Output         : None
//  650 * Return         : None
//  651 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock18 Using cfiCommon0
        CFI Function RCC_RTCCLKCmd
        THUMB
//  652 void RCC_RTCCLKCmd(FunctionalState NewState)
//  653 {
//  654   /* Check the parameters */
//  655   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  656 
//  657   *(vu32 *) BDCR_RTCEN_BB = (u32)NewState;
RCC_RTCCLKCmd:
        LDR.N    R1,??RCC_RTCCLKCmd_0  ;; 0x4242043c
        STR      R0,[R1, #+0]
//  658 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_RTCCLKCmd_0:
        DC32     0x4242043c
        CFI EndBlock cfiBlock18
//  659 
//  660 /*******************************************************************************
//  661 * Function Name  : RCC_GetClocksFreq
//  662 * Description    : Returns the frequencies of different on chip clocks.
//  663 * Input          : - RCC_Clocks: pointer to a RCC_ClocksTypeDef structure which
//  664 *                    will hold the clocks frequencies.
//  665 * Output         : None
//  666 * Return         : None
//  667 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock19 Using cfiCommon0
        CFI Function RCC_GetClocksFreq
        THUMB
//  668 void RCC_GetClocksFreq(RCC_ClocksTypeDef* RCC_Clocks)
//  669 {
//  670   u32 tmp = 0, pllmull = 0, pllsource = 0, presc = 0;
//  671 
//  672   /* Get SYSCLK source -------------------------------------------------------*/
//  673   tmp = RCC->CFGR & CFGR_SWS_Mask;
RCC_GetClocksFreq:
        LDR.N    R1,??DataTable14  ;; 0x40021004
        LDR      R2,[R1, #+0]
        AND      R2,R2,#0xC
//  674 
//  675   switch (tmp)
        CMP      R2,#+8
        BEQ.N    ??RCC_GetClocksFreq_0
//  676   {
//  677     case 0x00:  /* HSI used as system clock */
//  678       RCC_Clocks->SYSCLK_Frequency = HSI_Value;
        LDR.N    R3,??RCC_GetClocksFreq_1  ;; 0x7a1200
        B.N      ??RCC_GetClocksFreq_2
//  679       break;
//  680 
//  681     case 0x04:  /* HSE used as system clock */
//  682       RCC_Clocks->SYSCLK_Frequency = HSE_Value;
//  683       break;
//  684 
//  685     case 0x08:  /* PLL used as system clock */
//  686       /* Get PLL clock source and multiplication factor ----------------------*/
//  687       pllmull = RCC->CFGR & CFGR_PLLMull_Mask;
??RCC_GetClocksFreq_0:
        LDR      R2,[R1, #+0]
        AND      R2,R2,#0x3C0000
//  688       pllmull = ( pllmull >> 18) + 2;
        LSRS     R2,R2,#+18
        ADDS     R2,R2,#+2
//  689 
//  690       pllsource = RCC->CFGR & CFGR_PLLSRC_Mask;
        LDR      R3,[R1, #+0]
        ANDS     R3,R3,#0x10000
//  691 
//  692       if (pllsource == 0x00)
        BNE.N    ??RCC_GetClocksFreq_3
//  693       {/* HSI oscillator clock divided by 2 selected as PLL clock entry */
//  694         RCC_Clocks->SYSCLK_Frequency = (HSI_Value >> 1) * pllmull;
        LDR.N    R3,??RCC_GetClocksFreq_1+0x4  ;; 0x3d0900
        B.N      ??RCC_GetClocksFreq_4
//  695       }
//  696       else
//  697       {/* HSE selected as PLL clock entry */
//  698 
//  699         if ((RCC->CFGR & CFGR_PLLXTPRE_Mask) != (u32)RESET)
??RCC_GetClocksFreq_3:
        LDR      R3,[R1, #+0]
        TST      R3,#0x20000
        BEQ.N    ??RCC_GetClocksFreq_5
//  700         {/* HSE oscillator clock divided by 2 */
//  701 
//  702           RCC_Clocks->SYSCLK_Frequency = (HSE_Value >> 1) * pllmull;
        LDR.N    R3,??RCC_GetClocksFreq_1+0x4  ;; 0x3d0900
        B.N      ??RCC_GetClocksFreq_4
//  703         }
//  704         else
//  705         {
//  706           RCC_Clocks->SYSCLK_Frequency = HSE_Value * pllmull;
??RCC_GetClocksFreq_5:
        LDR.N    R3,??RCC_GetClocksFreq_1  ;; 0x7a1200
??RCC_GetClocksFreq_4:
        MULS     R3,R2,R3
??RCC_GetClocksFreq_2:
        STR      R3,[R0, #+0]
//  707         }
//  708       }
//  709       break;
//  710 
//  711     default:
//  712       RCC_Clocks->SYSCLK_Frequency = HSI_Value;
//  713       break;
//  714   }
//  715 
//  716   /* Compute HCLK, PCLK1, PCLK2 and ADCCLK clocks frequencies ----------------*/
//  717   /* Get HCLK prescaler */
//  718   tmp = RCC->CFGR & CFGR_HPRE_Set_Mask;
        LDR      R2,[R1, #+0]
        AND      R12,R2,#0xF0
//  719   tmp = tmp >> 4;
//  720   presc = APBAHBPrescTable[tmp];
//  721 
//  722   /* HCLK clock frequency */
//  723   RCC_Clocks->HCLK_Frequency = RCC_Clocks->SYSCLK_Frequency >> presc;
        LDR.N    R2,??RCC_GetClocksFreq_1+0x8  ;; APBAHBPrescTable
        LSR      R12,R12,#+4
        LDRB     R12,[R12, R2]
        LSR      R3,R3,R12
        STR      R3,[R0, #+4]
//  724 
//  725   /* Get PCLK1 prescaler */
//  726   tmp = RCC->CFGR & CFGR_PPRE1_Set_Mask;
        LDR      R12,[R1, #+0]
        AND      R12,R12,#0x700
//  727   tmp = tmp >> 8;
//  728   presc = APBAHBPrescTable[tmp];
//  729 
//  730   /* PCLK1 clock frequency */
//  731   RCC_Clocks->PCLK1_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
        LSR      R12,R12,#+8
        LDRB     R12,[R12, R2]
        LSR      R12,R3,R12
        STR      R12,[R0, #+8]
//  732 
//  733   /* Get PCLK2 prescaler */
//  734   tmp = RCC->CFGR & CFGR_PPRE2_Set_Mask;
        LDR      R12,[R1, #+0]
        AND      R12,R12,#0x3800
//  735   tmp = tmp >> 11;
//  736   presc = APBAHBPrescTable[tmp];
//  737 
//  738   /* PCLK2 clock frequency */
//  739   RCC_Clocks->PCLK2_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
        LSR      R12,R12,#+11
        LDRB     R12,[R12, R2]
        LSR      R3,R3,R12
        STR      R3,[R0, #+12]
//  740 
//  741   /* Get ADCCLK prescaler */
//  742   tmp = RCC->CFGR & CFGR_ADCPRE_Set_Mask;
        LDR      R1,[R1, #+0]
        AND      R1,R1,#0xC000
//  743   tmp = tmp >> 14;
//  744   presc = ADCPrescTable[tmp];
//  745 
//  746   /* ADCCLK clock frequency */
//  747   RCC_Clocks->ADCCLK_Frequency = RCC_Clocks->PCLK2_Frequency / presc;
        ADD      R1,R2,R1, LSR #+14
        LDRB     R1,[R1, #+16]
        UDIV     R1,R3,R1
        STR      R1,[R0, #+16]
//  748 }
        BX       LR               ;; return
        DATA
??RCC_GetClocksFreq_1:
        DC32     0x7a1200
        DC32     0x3d0900
        DC32     APBAHBPrescTable
        CFI EndBlock cfiBlock19

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable14:
        DC32     0x40021004
//  749 
//  750 /*******************************************************************************
//  751 * Function Name  : RCC_AHBPeriphClockCmd
//  752 * Description    : Enables or disables the AHB peripheral clock.
//  753 * Input          : - RCC_AHBPeriph: specifies the AHB peripheral to gates its clock.
//  754 *                    This parameter can be any combination of the following values:
//  755 *                       - RCC_AHBPeriph_DMA1
//  756 *                       - RCC_AHBPeriph_DMA2
//  757 *                       - RCC_AHBPeriph_SRAM
//  758 *                       - RCC_AHBPeriph_FLITF
//  759 *                       - RCC_AHBPeriph_CRC
//  760 *                       - RCC_AHBPeriph_FSMC
//  761 *                       - RCC_AHBPeriph_SDIO
//  762 *                    SRAM and FLITF clock can be disabled only during sleep mode.
//  763 *                  - NewState: new state of the specified peripheral clock.
//  764 *                    This parameter can be: ENABLE or DISABLE.
//  765 * Output         : None
//  766 * Return         : None
//  767 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock20 Using cfiCommon0
        CFI Function RCC_AHBPeriphClockCmd
        THUMB
//  768 void RCC_AHBPeriphClockCmd(u32 RCC_AHBPeriph, FunctionalState NewState)
//  769 {
//  770   /* Check the parameters */
//  771   assert_param(IS_RCC_AHB_PERIPH(RCC_AHBPeriph));
//  772   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  773 
//  774   if (NewState != DISABLE)
RCC_AHBPeriphClockCmd:
        LDR.N    R2,??RCC_AHBPeriphClockCmd_0  ;; 0x40021014
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??RCC_AHBPeriphClockCmd_1
//  775   {
//  776     RCC->AHBENR |= RCC_AHBPeriph;
        ORRS     R0,R0,R1
        B.N      ??RCC_AHBPeriphClockCmd_2
//  777   }
//  778   else
//  779   {
//  780     RCC->AHBENR &= ~RCC_AHBPeriph;
??RCC_AHBPeriphClockCmd_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??RCC_AHBPeriphClockCmd_2:
        STR      R0,[R2, #+0]
//  781   }
//  782 }
        BX       LR               ;; return
        DATA
??RCC_AHBPeriphClockCmd_0:
        DC32     0x40021014
        CFI EndBlock cfiBlock20
//  783 
//  784 /*******************************************************************************
//  785 * Function Name  : RCC_APB2PeriphClockCmd
//  786 * Description    : Enables or disables the High Speed APB (APB2) peripheral clock.
//  787 * Input          : - RCC_APB2Periph: specifies the APB2 peripheral to gates its
//  788 *                    clock.
//  789 *                    This parameter can be any combination of the following values:
//  790 *                       - RCC_APB2Periph_AFIO, RCC_APB2Periph_GPIOA, RCC_APB2Periph_GPIOB,
//  791 *                         RCC_APB2Periph_GPIOC, RCC_APB2Periph_GPIOD, RCC_APB2Periph_GPIOE,
//  792 *                         RCC_APB2Periph_GPIOF, RCC_APB2Periph_GPIOG, RCC_APB2Periph_ADC1,
//  793 *                         RCC_APB2Periph_ADC2, RCC_APB2Periph_TIM1, RCC_APB2Periph_SPI1,
//  794 *                         RCC_APB2Periph_TIM8, RCC_APB2Periph_USART1, RCC_APB2Periph_ADC3,
//  795 *                         RCC_APB2Periph_ALL
//  796 *                  - NewState: new state of the specified peripheral clock.
//  797 *                    This parameter can be: ENABLE or DISABLE.
//  798 * Output         : None
//  799 * Return         : None
//  800 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock21 Using cfiCommon0
        CFI Function RCC_APB2PeriphClockCmd
        THUMB
//  801 void RCC_APB2PeriphClockCmd(u32 RCC_APB2Periph, FunctionalState NewState)
//  802 {
//  803   /* Check the parameters */
//  804   assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
//  805   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  806 
//  807   if (NewState != DISABLE)
RCC_APB2PeriphClockCmd:
        LDR.N    R2,??RCC_APB2PeriphClockCmd_0  ;; 0x40021018
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??RCC_APB2PeriphClockCmd_1
//  808   {
//  809     RCC->APB2ENR |= RCC_APB2Periph;
        ORRS     R0,R0,R1
        B.N      ??RCC_APB2PeriphClockCmd_2
//  810   }
//  811   else
//  812   {
//  813     RCC->APB2ENR &= ~RCC_APB2Periph;
??RCC_APB2PeriphClockCmd_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??RCC_APB2PeriphClockCmd_2:
        STR      R0,[R2, #+0]
//  814   }
//  815 }
        BX       LR               ;; return
        DATA
??RCC_APB2PeriphClockCmd_0:
        DC32     0x40021018
        CFI EndBlock cfiBlock21
//  816 
//  817 /*******************************************************************************
//  818 * Function Name  : RCC_APB1PeriphClockCmd
//  819 * Description    : Enables or disables the Low Speed APB (APB1) peripheral clock.
//  820 * Input          : - RCC_APB1Periph: specifies the APB1 peripheral to gates its
//  821 *                    clock.
//  822 *                    This parameter can be any combination of the following values:
//  823 *                       - RCC_APB1Periph_TIM2, RCC_APB1Periph_TIM3, RCC_APB1Periph_TIM4,
//  824 *                         RCC_APB1Periph_TIM5, RCC_APB1Periph_TIM6, RCC_APB1Periph_TIM7,
//  825 *                         RCC_APB1Periph_WWDG, RCC_APB1Periph_SPI2, RCC_APB1Periph_SPI3,
//  826 *                         RCC_APB1Periph_USART2, RCC_APB1Periph_USART3, RCC_APB1Periph_USART4, 
//  827 *                         RCC_APB1Periph_USART5, RCC_APB1Periph_I2C1, RCC_APB1Periph_I2C2,
//  828 *                         RCC_APB1Periph_USB, RCC_APB1Periph_CAN, RCC_APB1Periph_BKP,
//  829 *                         RCC_APB1Periph_PWR, RCC_APB1Periph_DAC, RCC_APB1Periph_ALL
//  830 *                  - NewState: new state of the specified peripheral clock.
//  831 *                    This parameter can be: ENABLE or DISABLE.
//  832 * Output         : None
//  833 * Return         : None
//  834 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock22 Using cfiCommon0
        CFI Function RCC_APB1PeriphClockCmd
        THUMB
//  835 void RCC_APB1PeriphClockCmd(u32 RCC_APB1Periph, FunctionalState NewState)
//  836 {
//  837   /* Check the parameters */
//  838   assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
//  839   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  840 
//  841   if (NewState != DISABLE)
RCC_APB1PeriphClockCmd:
        LDR.N    R2,??RCC_APB1PeriphClockCmd_0  ;; 0x4002101c
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??RCC_APB1PeriphClockCmd_1
//  842   {
//  843     RCC->APB1ENR |= RCC_APB1Periph;
        ORRS     R0,R0,R1
        B.N      ??RCC_APB1PeriphClockCmd_2
//  844   }
//  845   else
//  846   {
//  847     RCC->APB1ENR &= ~RCC_APB1Periph;
??RCC_APB1PeriphClockCmd_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??RCC_APB1PeriphClockCmd_2:
        STR      R0,[R2, #+0]
//  848   }
//  849 }
        BX       LR               ;; return
        DATA
??RCC_APB1PeriphClockCmd_0:
        DC32     0x4002101c
        CFI EndBlock cfiBlock22
//  850 
//  851 /*******************************************************************************
//  852 * Function Name  : RCC_APB2PeriphResetCmd
//  853 * Description    : Forces or releases High Speed APB (APB2) peripheral reset.
//  854 * Input          : - RCC_APB2Periph: specifies the APB2 peripheral to reset.
//  855 *                    This parameter can be any combination of the following values:
//  856 *                       - RCC_APB2Periph_AFIO, RCC_APB2Periph_GPIOA, RCC_APB2Periph_GPIOB,
//  857 *                         RCC_APB2Periph_GPIOC, RCC_APB2Periph_GPIOD, RCC_APB2Periph_GPIOE,
//  858 *                         RCC_APB2Periph_GPIOF, RCC_APB2Periph_GPIOG, RCC_APB2Periph_ADC1,
//  859 *                         RCC_APB2Periph_ADC2, RCC_APB2Periph_TIM1, RCC_APB2Periph_SPI1,
//  860 *                         RCC_APB2Periph_TIM8, RCC_APB2Periph_USART1, RCC_APB2Periph_ADC3,
//  861 *                         RCC_APB2Periph_ALL
//  862 *                  - NewState: new state of the specified peripheral reset.
//  863 *                    This parameter can be: ENABLE or DISABLE.
//  864 * Output         : None
//  865 * Return         : None
//  866 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock23 Using cfiCommon0
        CFI Function RCC_APB2PeriphResetCmd
        THUMB
//  867 void RCC_APB2PeriphResetCmd(u32 RCC_APB2Periph, FunctionalState NewState)
//  868 {
//  869   /* Check the parameters */
//  870   assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
//  871   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  872 
//  873   if (NewState != DISABLE)
RCC_APB2PeriphResetCmd:
        LDR.N    R2,??RCC_APB2PeriphResetCmd_0  ;; 0x4002100c
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??RCC_APB2PeriphResetCmd_1
//  874   {
//  875     RCC->APB2RSTR |= RCC_APB2Periph;
        ORRS     R0,R0,R1
        B.N      ??RCC_APB2PeriphResetCmd_2
//  876   }
//  877   else
//  878   {
//  879     RCC->APB2RSTR &= ~RCC_APB2Periph;
??RCC_APB2PeriphResetCmd_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??RCC_APB2PeriphResetCmd_2:
        STR      R0,[R2, #+0]
//  880   }
//  881 }
        BX       LR               ;; return
        DATA
??RCC_APB2PeriphResetCmd_0:
        DC32     0x4002100c
        CFI EndBlock cfiBlock23
//  882 
//  883 /*******************************************************************************
//  884 * Function Name  : RCC_APB1PeriphResetCmd
//  885 * Description    : Forces or releases Low Speed APB (APB1) peripheral reset.
//  886 * Input          : - RCC_APB1Periph: specifies the APB1 peripheral to reset.
//  887 *                    This parameter can be any combination of the following values:
//  888 *                       - RCC_APB1Periph_TIM2, RCC_APB1Periph_TIM3, RCC_APB1Periph_TIM4,
//  889 *                         RCC_APB1Periph_TIM5, RCC_APB1Periph_TIM6, RCC_APB1Periph_TIM7,
//  890 *                         RCC_APB1Periph_WWDG, RCC_APB1Periph_SPI2, RCC_APB1Periph_SPI3,
//  891 *                         RCC_APB1Periph_USART2, RCC_APB1Periph_USART3, RCC_APB1Periph_USART4, 
//  892 *                         RCC_APB1Periph_USART5, RCC_APB1Periph_I2C1, RCC_APB1Periph_I2C2,
//  893 *                         RCC_APB1Periph_USB, RCC_APB1Periph_CAN, RCC_APB1Periph_BKP,
//  894 *                         RCC_APB1Periph_PWR, RCC_APB1Periph_DAC, RCC_APB1Periph_ALL
//  895 *                  - NewState: new state of the specified peripheral clock.
//  896 *                    This parameter can be: ENABLE or DISABLE.
//  897 * Output         : None
//  898 * Return         : None
//  899 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock24 Using cfiCommon0
        CFI Function RCC_APB1PeriphResetCmd
        THUMB
//  900 void RCC_APB1PeriphResetCmd(u32 RCC_APB1Periph, FunctionalState NewState)
//  901 {
//  902   /* Check the parameters */
//  903   assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
//  904   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  905 
//  906   if (NewState != DISABLE)
RCC_APB1PeriphResetCmd:
        LDR.N    R2,??RCC_APB1PeriphResetCmd_0  ;; 0x40021010
        CMP      R1,#+0
        LDR      R1,[R2, #+0]
        BEQ.N    ??RCC_APB1PeriphResetCmd_1
//  907   {
//  908     RCC->APB1RSTR |= RCC_APB1Periph;
        ORRS     R0,R0,R1
        B.N      ??RCC_APB1PeriphResetCmd_2
//  909   }
//  910   else
//  911   {
//  912     RCC->APB1RSTR &= ~RCC_APB1Periph;
??RCC_APB1PeriphResetCmd_1:
        MVNS     R0,R0
        ANDS     R0,R0,R1
??RCC_APB1PeriphResetCmd_2:
        STR      R0,[R2, #+0]
//  913   }
//  914 }
        BX       LR               ;; return
        DATA
??RCC_APB1PeriphResetCmd_0:
        DC32     0x40021010
        CFI EndBlock cfiBlock24
//  915 
//  916 /*******************************************************************************
//  917 * Function Name  : RCC_BackupResetCmd
//  918 * Description    : Forces or releases the Backup domain reset.
//  919 * Input          : - NewState: new state of the Backup domain reset.
//  920 *                    This parameter can be: ENABLE or DISABLE.
//  921 * Output         : None
//  922 * Return         : None
//  923 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock25 Using cfiCommon0
        CFI Function RCC_BackupResetCmd
        THUMB
//  924 void RCC_BackupResetCmd(FunctionalState NewState)
//  925 {
//  926   /* Check the parameters */
//  927   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  928 
//  929   *(vu32 *) BDCR_BDRST_BB = (u32)NewState;
RCC_BackupResetCmd:
        LDR.N    R1,??RCC_BackupResetCmd_0  ;; 0x42420440
        STR      R0,[R1, #+0]
//  930 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_BackupResetCmd_0:
        DC32     0x42420440
        CFI EndBlock cfiBlock25
//  931 
//  932 /*******************************************************************************
//  933 * Function Name  : RCC_ClockSecuritySystemCmd
//  934 * Description    : Enables or disables the Clock Security System.
//  935 * Input          : - NewState: new state of the Clock Security System..
//  936 *                    This parameter can be: ENABLE or DISABLE.
//  937 * Output         : None
//  938 * Return         : None
//  939 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock26 Using cfiCommon0
        CFI Function RCC_ClockSecuritySystemCmd
        THUMB
//  940 void RCC_ClockSecuritySystemCmd(FunctionalState NewState)
//  941 {
//  942   /* Check the parameters */
//  943   assert_param(IS_FUNCTIONAL_STATE(NewState));
//  944 
//  945   *(vu32 *) CR_CSSON_BB = (u32)NewState;
RCC_ClockSecuritySystemCmd:
        LDR.N    R1,??RCC_ClockSecuritySystemCmd_0  ;; 0x4242004c
        STR      R0,[R1, #+0]
//  946 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_ClockSecuritySystemCmd_0:
        DC32     0x4242004c
        CFI EndBlock cfiBlock26
//  947 
//  948 /*******************************************************************************
//  949 * Function Name  : RCC_MCOConfig
//  950 * Description    : Selects the clock source to output on MCO pin.
//  951 * Input          : - RCC_MCO: specifies the clock source to output.
//  952 *                    This parameter can be one of the following values:
//  953 *                       - RCC_MCO_NoClock: No clock selected
//  954 *                       - RCC_MCO_SYSCLK: System clock selected
//  955 *                       - RCC_MCO_HSI: HSI oscillator clock selected
//  956 *                       - RCC_MCO_HSE: HSE oscillator clock selected
//  957 *                       - RCC_MCO_PLLCLK_Div2: PLL clock divided by 2 selected
//  958 * Output         : None
//  959 * Return         : None
//  960 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock27 Using cfiCommon0
        CFI Function RCC_MCOConfig
        THUMB
//  961 void RCC_MCOConfig(u8 RCC_MCO)
//  962 {
//  963   /* Check the parameters */
//  964   assert_param(IS_RCC_MCO(RCC_MCO));
//  965 
//  966   /* Perform Byte access to MCO[2:0] bits to select the MCO source */
//  967   *(vu8 *) CFGR_BYTE4_ADDRESS = RCC_MCO;
RCC_MCOConfig:
        LDR.N    R1,??RCC_MCOConfig_0  ;; 0x40021007
        STRB     R0,[R1, #+0]
//  968 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_MCOConfig_0:
        DC32     0x40021007
        CFI EndBlock cfiBlock27
//  969 
//  970 /*******************************************************************************
//  971 * Function Name  : RCC_GetFlagStatus
//  972 * Description    : Checks whether the specified RCC flag is set or not.
//  973 * Input          : - RCC_FLAG: specifies the flag to check.
//  974 *                    This parameter can be one of the following values:
//  975 *                       - RCC_FLAG_HSIRDY: HSI oscillator clock ready
//  976 *                       - RCC_FLAG_HSERDY: HSE oscillator clock ready
//  977 *                       - RCC_FLAG_PLLRDY: PLL clock ready
//  978 *                       - RCC_FLAG_LSERDY: LSE oscillator clock ready
//  979 *                       - RCC_FLAG_LSIRDY: LSI oscillator clock ready
//  980 *                       - RCC_FLAG_PINRST: Pin reset
//  981 *                       - RCC_FLAG_PORRST: POR/PDR reset
//  982 *                       - RCC_FLAG_SFTRST: Software reset
//  983 *                       - RCC_FLAG_IWDGRST: Independent Watchdog reset
//  984 *                       - RCC_FLAG_WWDGRST: Window Watchdog reset
//  985 *                       - RCC_FLAG_LPWRRST: Low Power reset
//  986 * Output         : None
//  987 * Return         : The new state of RCC_FLAG (SET or RESET).
//  988 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock28 Using cfiCommon0
        CFI Function RCC_GetFlagStatus
        THUMB
//  989 FlagStatus RCC_GetFlagStatus(u8 RCC_FLAG)
//  990 {
//  991   u32 tmp = 0;
//  992   u32 statusreg = 0;
//  993   FlagStatus bitstatus = RESET;
//  994 
//  995   /* Check the parameters */
//  996   assert_param(IS_RCC_FLAG(RCC_FLAG));
//  997 
//  998   /* Get the RCC register index */
//  999   tmp = RCC_FLAG >> 5;
RCC_GetFlagStatus:
        LSRS     R1,R0,#+5
// 1000 
// 1001   if (tmp == 1)               /* The flag to check is in CR register */
        CMP      R1,#+1
        BNE.N    ??RCC_GetFlagStatus_0
// 1002   {
// 1003     statusreg = RCC->CR;
        LDR.N    R1,??DataTable17  ;; 0x40021000
        LDR      R1,[R1, #+0]
        B.N      ??RCC_GetFlagStatus_1
// 1004   }
// 1005   else if (tmp == 2)          /* The flag to check is in BDCR register */
??RCC_GetFlagStatus_0:
        CMP      R1,#+2
        ITTEE    NE 
        LDRNE.N  R1,??DataTable17  ;; 0x40021000
        LDRNE    R1,[R1, #+36]
// 1006   {
// 1007     statusreg = RCC->BDCR;
        LDREQ.N  R1,??DataTable17  ;; 0x40021000
        LDREQ    R1,[R1, #+32]
// 1008   }
// 1009   else                       /* The flag to check is in CSR register */
// 1010   {
// 1011     statusreg = RCC->CSR;
// 1012   }
// 1013 
// 1014   /* Get the flag position */
// 1015   tmp = RCC_FLAG & FLAG_Mask;
// 1016 
// 1017   if ((statusreg & ((u32)1 << tmp)) != (u32)RESET)
??RCC_GetFlagStatus_1:
        MOVS     R2,#+1
        AND      R0,R0,#0x1F
        LSL      R0,R2,R0
        ANDS     R0,R0,R1
        SUBS     R0,R0,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
// 1018   {
// 1019     bitstatus = SET;
// 1020   }
// 1021   else
// 1022   {
// 1023     bitstatus = RESET;
// 1024   }
// 1025 
// 1026   /* Return the flag status */
// 1027   return bitstatus;
        BX       LR               ;; return
        CFI EndBlock cfiBlock28
// 1028 }

        SECTION `.text`:CODE:NOROOT(2)
        DATA
??DataTable17:
        DC32     0x40021000
// 1029 
// 1030 /*******************************************************************************
// 1031 * Function Name  : RCC_ClearFlag
// 1032 * Description    : Clears the RCC reset flags.
// 1033 *                  The reset flags are: RCC_FLAG_PINRST, RCC_FLAG_PORRST,
// 1034 *                  RCC_FLAG_SFTRST, RCC_FLAG_IWDGRST, RCC_FLAG_WWDGRST,
// 1035 *                  RCC_FLAG_LPWRRST
// 1036 * Input          : None
// 1037 * Output         : None
// 1038 * Return         : None
// 1039 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock29 Using cfiCommon0
        CFI Function RCC_ClearFlag
        THUMB
// 1040 void RCC_ClearFlag(void)
// 1041 {
// 1042   /* Set RMVF bit to clear the reset flags */
// 1043   RCC->CSR |= CSR_RMVF_Set;
RCC_ClearFlag:
        LDR.N    R0,??RCC_ClearFlag_0  ;; 0x40021024
        LDR      R1,[R0, #+0]
        ORR      R1,R1,#0x1000000
        STR      R1,[R0, #+0]
// 1044 }
        BX       LR               ;; return
        DATA
??RCC_ClearFlag_0:
        DC32     0x40021024
        CFI EndBlock cfiBlock29
// 1045 
// 1046 /*******************************************************************************
// 1047 * Function Name  : RCC_GetITStatus
// 1048 * Description    : Checks whether the specified RCC interrupt has occurred or not.
// 1049 * Input          : - RCC_IT: specifies the RCC interrupt source to check.
// 1050 *                    This parameter can be one of the following values:
// 1051 *                       - RCC_IT_LSIRDY: LSI ready interrupt
// 1052 *                       - RCC_IT_LSERDY: LSE ready interrupt
// 1053 *                       - RCC_IT_HSIRDY: HSI ready interrupt
// 1054 *                       - RCC_IT_HSERDY: HSE ready interrupt
// 1055 *                       - RCC_IT_PLLRDY: PLL ready interrupt
// 1056 *                       - RCC_IT_CSS: Clock Security System interrupt
// 1057 * Output         : None
// 1058 * Return         : The new state of RCC_IT (SET or RESET).
// 1059 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock30 Using cfiCommon0
        CFI Function RCC_GetITStatus
        THUMB
// 1060 ITStatus RCC_GetITStatus(u8 RCC_IT)
// 1061 {
// 1062   ITStatus bitstatus = RESET;
// 1063 
// 1064   /* Check the parameters */
// 1065   assert_param(IS_RCC_GET_IT(RCC_IT));
// 1066 
// 1067   /* Check the status of the specified RCC interrupt */
// 1068   if ((RCC->CIR & RCC_IT) != (u32)RESET)
RCC_GetITStatus:
        LDR.N    R1,??RCC_GetITStatus_0  ;; 0x40021008
        LDR      R1,[R1, #+0]
        ANDS     R1,R0,R1
        SUBS     R0,R1,#+1
        SBCS     R0,R0,R0
        MVNS     R0,R0
        LSRS     R0,R0,#+31
// 1069   {
// 1070     bitstatus = SET;
// 1071   }
// 1072   else
// 1073   {
// 1074     bitstatus = RESET;
// 1075   }
// 1076 
// 1077   /* Return the RCC_IT status */
// 1078   return  bitstatus;
        BX       LR               ;; return
        DATA
??RCC_GetITStatus_0:
        DC32     0x40021008
        CFI EndBlock cfiBlock30
// 1079 }
// 1080 
// 1081 /*******************************************************************************
// 1082 * Function Name  : RCC_ClearITPendingBit
// 1083 * Description    : Clears the RCC�s interrupt pending bits.
// 1084 * Input          : - RCC_IT: specifies the interrupt pending bit to clear.
// 1085 *                    This parameter can be any combination of the following values:
// 1086 *                       - RCC_IT_LSIRDY: LSI ready interrupt
// 1087 *                       - RCC_IT_LSERDY: LSE ready interrupt
// 1088 *                       - RCC_IT_HSIRDY: HSI ready interrupt
// 1089 *                       - RCC_IT_HSERDY: HSE ready interrupt
// 1090 *                       - RCC_IT_PLLRDY: PLL ready interrupt
// 1091 *                       - RCC_IT_CSS: Clock Security System interrupt
// 1092 * Output         : None
// 1093 * Return         : None
// 1094 *******************************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        CFI Block cfiBlock31 Using cfiCommon0
        CFI Function RCC_ClearITPendingBit
        THUMB
// 1095 void RCC_ClearITPendingBit(u8 RCC_IT)
// 1096 {
// 1097   /* Check the parameters */
// 1098   assert_param(IS_RCC_CLEAR_IT(RCC_IT));
// 1099 
// 1100   /* Perform Byte access to RCC_CIR[23:16] bits to clear the selected interrupt
// 1101      pending bits */
// 1102   *(vu8 *) CIR_BYTE3_ADDRESS = RCC_IT;
RCC_ClearITPendingBit:
        LDR.N    R1,??RCC_ClearITPendingBit_0  ;; 0x4002100a
        STRB     R0,[R1, #+0]
// 1103 }
        BX       LR               ;; return
        Nop      
        DATA
??RCC_ClearITPendingBit_0:
        DC32     0x4002100a
        CFI EndBlock cfiBlock31

        END
// 1104 
// 1105 /******************* (C) COPYRIGHT 2008 STMicroelectronics *****END OF FILE****/
// 
//  20 bytes in section .rodata
// 836 bytes in section .text
// 
// 836 bytes of CODE  memory
//  20 bytes of CONST memory
//
//Errors: none
//Warnings: none
