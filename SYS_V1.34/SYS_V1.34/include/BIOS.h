/********************* (C) COPYRIGHT 2010 e-Design Co.,Ltd. ********************
 File Name : BIOS.h  
 Version   : DS203_SYS Ver 1.3x                                 Author : bure
*******************************************************************************/
#ifndef __BIOS_H
#define __BIOS_H

#include "stm32f10x_lib.h"

//=================== ��Ӳ���汾��ض��� ===================
//===================Definition of software and hardware version======

  #define HDW_VERSION       "Hardware Ver 2.6  "
  #define SYS_VERSION       "     DS203 Mini DSO SYS Ver 1.34       "

//==================== Flash �ռ���� ====================
//====================Flash Address=======================

#define BIN_BASE                ((u32)(0x0802C000)) // Size < 68KB  
#define PRM_BASE                BIN_BASE + 68*1024  // Size =  2KB   
#define INF_BASE                BIN_BASE + 70*1024  // Size < 10KB   
#define APP4_BASE               ((u32)(0x08024000)) // Size = 32KB  
#define APP3_BASE               ((u32)(0x0801C000)) // Size = 32KB  
#define APP2_BASE               ((u32)(0x08014000)) // Size = 32KB  
#define APP1_BASE               ((u32)(0x0800C000)) // Size = 32KB  
#define SYS_BASE                ((u32)(0x08004000)) // Size = 32KB   
#define DFU_BASE                ((u32)(0x08000000)) // Size = 16KB 

//====================== ���� Set �� Object �� Value ���� ======================
//======================Definition of object and value in function :Set========

#define CH_A_OFFSET       0     // Aͨ����ֱλ��//Vertical offset of CHA   Value = 0~200
#define CH_B_OFFSET       1     // Bͨ����ֱλ��//Vertical offset of CHB  Value = 0~200
#define BACKLIGHT         2     // ��������   // Backlight      Value = 0~100
#define BEEP_VOLUME       3     // ���������� // Beep volume    Value = 0~100
#define BETTERY_DT        4     // ��ص�ѹ���//Battry check    Value = 1: ����//Enable
#define ADC_MODE          5     // ADC����ģʽ //Mode of ADC    Value = 1/0
#define FIFO_CLR          6     // FIFOָ�븴λ//Reset the FIFO pointer   Value = 1/0: W_PTR/R_PTR
#define T_BASE_PSC        7     
#define T_BASE_ARR        8     
#define CH_A_COUPLE       9     //                Value = 1/0: AC/DC
#define CH_A_RANGE       10     //                Value = 0~5
#define CH_B_COUPLE      11     //                Value = 1/0: AC/DC
#define CH_B_RANGE       12     //                Value = 0~5
#define ANALOG_ARR       13     // ģ�������Ƶϵ��//Frequency-divide factor for analog output
#define ANALOG_PTR       14     // ģ�����������ָ��//Pointer to analog output buffer
#define ANALOG_CNT       15     // ģ�����ÿ���ڵ���//NO.of dots each period for analog output 
#define DIGTAL_PSC       16     // �������Ԥ��Ƶϵ��//Pre-devide factor for digital output
#define DIGTAL_ARR       17     // ���������Ƶϵ��  //Devide factor for digital output
#define DIGTAL_CCR       18     // �������ռ�ձ�ϵ��//Duty for digital output
#define KEY_IF_RST       19     // ��ʱ�жϱ�־��λ  //Time IRQ reset
#define STANDBY          20     // ���뽵���ĵȴ�״̬//Enter Standby mode
#define FPGA_RST         31     // FPGA ��λ         //Reset FPGA 

#define TRIGG_MODE       32+0  // ����ģʽ			//Trigger Mode 
#define V_THRESHOLD      32+1  // ��ѹ��������      //Trigger threshold
#define T_THRESHOLD      32+2  // �����ȴ���ʱ������//Min of time to trigger
#define ADC_CTRL         32+4  // ADC ����״̬����    //ADC work state 
#define A_POSITION       32+5  // ��ǰCH_A�����λ��  //Base setting for CHA
#define B_POSITION       32+6  // ��ǰCH_B�����λ��  //Base setting for CHB
#define REG_ADDR         32+7  // �õ�ַ������FPGA����һ��Ĵ��������ݱ�MCU����//Which set of register in FPGA  is  readed into MCU

//==================== ���� Set �� TRIGG_MODE �� Value ����=====================
//=====================Definition of TRIGG_MODE in function: SET================

/*
CH_A Trigger source & kind select => 
0x00: by Negedge;   0x01: by Posedge;   0x02: by low level; 0x03: by high level
0x04: TL < Delta_T; 0x05: TL > Delta_T; 0x06: TH < Delta_T; 0x07: TH > Delta_T;

CH_B Trigger source & kind select =>
0x08: by Negedge;   0x09: by Posedge;   0x0A: by low level; 0x0B: by high level
0x0C: TL < Delta_T; 0x0D: TL > Delta_T; 0x0E: TH < Delta_T; 0x0F: TH > Delta_T;

CH_C Trigger source & kind select =>
0x10: by Negedge;   0x11: by Posedge;   0x12: by low level; 0x13: by high level
0x04: TL < Delta_T; 0x05: TL > Delta_T; 0x06: TH < Delta_T; 0x07: TH > Delta_T;

CH_D Trigger source & kind select =>
0x18: by Negedge;   0x19: by Posedge;   0x1A: by low level; 0x1B: by high level
0x1C: TL < Delta_T; 0x1D: TL > Delta_T; 0x1E: TH < Delta_T; 0x1F: TH > Delta_T;

0x20~0xFF  =>  Unconditional trigger
*/
#define UNCONDITION       0x20        // ��������������  // Sample with no condition        

//===================== ���� Set �� ADC_CTRL �� Value ���� =====================
//================Definition of ADC_CTRL & STANDBY Value in fuction:Set=========


#define ADC_DN            0        // ADC����//Sample independently
#define ADC_EN            1        // ADC����//Sample interlacly

//===================== ���� Set �� ADC_MODE �� Value ���� =====================
//=====================Definiton of ADC_MODE Value in fuction: Set===============

#define SEPARATE          0        // ADC��������ģʽ//Sample independently
#define INTERLACE         1        // ADC�������ģʽ//Sample interlacly

//======================== FPGA���ݶ�д�����ź�H_L���� =========================
//========================Definition of H_L in W/R Control of FPGA===============

#define LOW               0
#define HIGH              1

//===================== ���� Set �� FIFO_CLR �� Value ���� =====================
//=====================Definition of FIFO_CLR in function: Set=================

#define R_PTR             0        // FIFO����ַָ��//Pointer to read FIFO
#define W_PTR             1        // FIFOд��ַָ��//Pointer to write FIFO

//==================== ���� Set_ �� CH_X_COUPLE �� Value ���� ==================
//=====================Definition of CH_X_COUPLE in function :Set===============

#define DC                0
#define AC                1

//======================== ���� Get �е� Object ���� ===========================
//========================Definition of Object of function:Get=================

#define FIFO_DIGIT     0        // 16bits FIFO digital data
#define FIFO_EMPTY     1        // FIFO empty flag: 1 = empty
#define FIFO_START     2        // FIFO start flag: 1 = start
#define FIFO_FULL      3        // FIFO full flag: 1 = Full
#define KEY_STATUS     4        // Current keys status
#define USB_POWER      5        // USB power status: 1 = Power ON
#define V_BATTERY      6        // Battery voltage (mV)
#define VERTICAL       7        // ��ֱͨ������ָ��//Pointer to vertical attribution
#define HORIZONTAL     8        // ˮƽͨ������ָ��//Pointer to horizontal attribution
#define GLOBAL         9        // ��������ָ��//Pointer to global attribution of HW
#define TRIGGER        10       // ����ͨ������ָ��//Pointer to trigg attribution
#define FPGA_OK        11       // FPGA ���óɹ�// 1 = FPGA config ok
#define CHARGE         12       // ��س��״̬//State of charging

#define ADC_DATA       32+0     // 0~7:ADC_CH_A 8~15:ADC_CH_B 16~17:CH_C&CH_D 
#define PRE_SAMPLING   32+1     // 0~15:Pre-sampling depth
#define ALL_SAMPLING   32+2     // 0~15:Total sampling depth
#define CH_A_MIN_MAX   32+3     // 0~7:VMIN 8~15:VMAX 
#define CH_A_V_SUM     32+4     // 0~15:CH_A voltage sum
#define CH_A_V_SSQ     32+5     // 0~15:CH_A voltage sum of squares
#define CH_A_NEDGE     32+6     // 0~15:CH_A number of edge
#define CH_A_FREQ      32+7     // 0~15:CH_A frequence
#define CH_A_PHW_MAX   32+8     // 0~15:CH_A pulse high width MAX
#define CH_A_PHW_MIN   32+9     // 0~15:CH_A pulse high width MIN
#define CH_A_PLW_MAX   32+10    // 0~15:CH_A pulse low width MAX
#define CH_A_PLW_MIN   32+11    // 0~15:CH_A pulse low width MIN

//======================= ģ��ͨ��(˥��/����)��λ�����ź� ======================
//======================= Analog channel (gain)gears============================

  #define _50MV             0
  #define _100MV            1
  #define _200MV            2
  #define _500MV            3
  #define _1V               4
  #define _2V               5
  #define _5V               6
  #define _10V              7
  #define CH_A              8
  #define CH_B              8

//============================= ϵͳ������IO�Ŷ��� =============================
//==========================Definition of IO for system control=================
#define LCD_nRST_LOW()    GPIOD_BRR  = GPIO_Pin_11
#define LCD_nRST_HIGH()   GPIOD_BSRR = GPIO_Pin_11
#define LCD_RS_LOW()      GPIOD_BRR  = GPIO_Pin_12
#define LCD_RS_HIGH()     GPIOD_BSRR = GPIO_Pin_12

#define FIFO_SCK_LOW()    GPIOA_BRR  = GPIO_Pin_6
#define FIFO_SCK_HIGH()   GPIOA_BSRR = GPIO_Pin_6
#define FIFO_SDA_LOW()    GPIOA_BRR  = GPIO_Pin_7
#define FIFO_SDA_HIGH()   GPIOA_BSRR = GPIO_Pin_7

#define FIFO_CLRW_LOW()   GPIOB_BRR  = GPIO_Pin_1
#define FIFO_CLRW_HIGH()  GPIOB_BSRR = GPIO_Pin_1
#define FIFO_MODE_LOW()   GPIOC_BRR  = GPIO_Pin_3
#define FIFO_MODE_HIGH()  GPIOC_BSRR = GPIO_Pin_3
#define FIFO_CLRR_LOW()   GPIOC_BRR  = GPIO_Pin_4
#define FIFO_CLRR_HIGH()  GPIOC_BSRR = GPIO_Pin_4
#define FIFO_H_L_LOW()    GPIOC_BRR  = GPIO_Pin_5
#define FIFO_H_L_HIGH()   GPIOC_BSRR = GPIO_Pin_5

#define SPI_SS_LOW()      GPIOB_BRR  = GPIO_Pin_10
#define SPI_SS_HIGH()     GPIOB_BSRR = GPIO_Pin_10
#define SPI_CLK_LOW()     GPIOB_BRR  = GPIO_Pin_11
#define SPI_CLK_HIGH()    GPIOB_BSRR = GPIO_Pin_11
#define SPI_MOSI_LOW()    GPIOB_BRR  = GPIO_Pin_12
#define SPI_MOSI_HIGH()   GPIOB_BSRR = GPIO_Pin_12
#define SPI_CRST_LOW()    GPIOB_BRR  = GPIO_Pin_14
#define SPI_CRST_HIGH()   GPIOB_BSRR = GPIO_Pin_14

#define CHRG_ST          !((GPIOB_IDR & 0x0100)>>8)
#define USB_PWR_ON        ((GPIOD_IDR & 0x0004)>>2)
#define FPGA_CFG_OK       (GPIOB_IDR >>15)

#define KEY1_OFF          ((GPIOA_IDR & 0x4000)!=0)
#define KEY2_OFF          ((GPIOC_IDR & 0x0400)!=0)
#define KEY3_OFF          ((GPIOC_IDR & 0x0200)!=0)
#define KEY4_OFF          ((GPIOC_IDR & 0x0100)!=0)
#define KEY1_ON           ((GPIOA_IDR & 0x4000)==0)
#define KEY2_ON           ((GPIOC_IDR & 0x0400)==0)
#define KEY3_ON           ((GPIOC_IDR & 0x0200)==0)
#define KEY4_ON           ((GPIOC_IDR & 0x0100)==0)

#define USB_EN()          GPIOA_CRH = 0x888BBBBB

#define STB_DN()    GPIOD_BSRR = GPIO_Pin_13; TIM1_CR1 = 0x0085 
#define STB_EN()    GPIOD_BRR  = GPIO_Pin_13; TIM1_CR1 = 0x0084 

//================= ģ��ͨ�������źŶ��� =================
//================Definition of analog channel signal=====
  #define DC_1()        GPIOE_BSRR = GPIO_Pin_0
  #define AC_1()        GPIOE_BRR  = GPIO_Pin_0
  #define DC_2()        GPIOE_BSRR = GPIO_Pin_5
  #define AC_2()        GPIOE_BRR  = GPIO_Pin_5
  #define Ax0_OFF()     GPIOE_BRR  = GPIO_Pin_4
  #define Ax0_ON()      GPIOE_BSRR = GPIO_Pin_4
  #define Ax1_OFF()     GPIOB_BRR  = GPIO_Pin_9
  #define Ax1_ON()      GPIOB_BSRR = GPIO_Pin_9
  #define Ax2_LOW()     GPIOE_BRR  = GPIO_Pin_2
  #define Ax2_HIGH()    GPIOE_BSRR = GPIO_Pin_2
  #define Ax5_LOW()     GPIOE_BRR  = GPIO_Pin_3
  #define Ax5_HIGH()    GPIOE_BSRR = GPIO_Pin_3
//#define Ax10_OFF()    GPIOB_BSRR = GPIO_Pin_8
//#define Ax10_ON()     GPIOB_BRR  = GPIO_Pin_8
  #define Bx0_OFF()     GPIOC_BRR  = GPIO_Pin_13
  #define Bx0_ON()      GPIOC_BSRR = GPIO_Pin_13
  #define Bx1_OFF()     GPIOE_BRR  = GPIO_Pin_6
  #define Bx1_ON()      GPIOE_BSRR = GPIO_Pin_6
  #define Bx2_LOW()     GPIOC_BRR  = GPIO_Pin_14
  #define Bx2_HIGH()    GPIOC_BSRR = GPIO_Pin_14
  #define Bx5_LOW()     GPIOC_BRR  = GPIO_Pin_15
  #define Bx5_HIGH()    GPIOC_BSRR = GPIO_Pin_15

// =======================================================��

typedef struct  // Ӳ���ۺ����� //Hardware attribution 
{
  u16 LCD_X;    // ��Ļˮƽ��ʾ����//Resolution X
  u16 LCD_Y;    // ��Ļ��ֱ��ʾ����//Resolution Y
  u16 Yp_Max;   // ��ֱ��λ���ֵ   //Max of vertical gears  
  u16 Xp_Max;   // ˮƽ��λ���ֵ    //Max of horizontal gears 
  u16 Tg_Num;   // ������λ���ֵ	//Max of trigger gears
  u16 Yv_Max;   // ��ֱλ�����ֵ  //Max of offset in vertical
  u16 Xt_Max;   // ˮƽλ�����ֵ //Max of offset in horizontal 
  u16 Co_Max;   // ��Ϸ�ʽ���ֵ  //Couple mode
  u8  Ya_Num;   // ģ��ͨ����Ŀ 	//NO.of analog channel
  u8  Yd_Num;   // ����ͨ����Ŀ		//NO.of digital channel
  u8  INSERT;   // ��ʼӦ�ò�ֵ�ĵ�λ	//Gears to start interpolation
  u16 KpA1;     // Aͨ��λ�Ʋ���ϵ��1	//Offset Compensation factor_1 for CHA
  u16 KpA2;     // Aͨ��λ�Ʋ���ϵ��2	//Offset Compensation factor_2 for CHA
  u16 KpB1;     // Bͨ��λ�Ʋ���ϵ��1	//Offset Compensation factor_1 for CHB
  u16 KpB2;     // Bͨ��λ�Ʋ���ϵ��2	//Offset Compensation factor_2 for CHB
} G_attr ;

typedef struct  // ��ֱͨ������ //Vertical attribution  
{
  u8  STR[8];   // ��λ��ʶ�ַ���//Gears String
  s16 KA1;      // Aͨ��λ�����У��ϵ��1//Offset calibration factor for CHA
  u16 KA2;      // Aͨ��б�����У��ϵ��2//Slope  calibration factor for CHA
  s16 KB1;      // Bͨ��λ�����У��ϵ��1//Offset calibration factor for CHB
  u16 KB2;      // Bͨ��б�����У��ϵ��2//Slope  calibration factor for CHB
  u32 SCALE;    // ��ֱͨ������ϵ��		//Vertical proportional factor
} Y_attr ;

typedef struct  // ˮƽͨ������ //Horizontal attribution
{
  u8  STR[8];   // ��λ��ʶ�ַ���//Gears String
  s16 PSC;      // Ԥ��Ƶϵ��	//Frequency pre-divide factor
  u16 ARR;      // ��Ƶϵ��		//Frequency divide factor
  u16 CCR;      // ռ�ձ�ϵ��	//Duty
  u16 KP;       // ��ֵϵ��		//Interpolate factor
  u32 SCALE;    // ˮƽͨ������ϵ��//Horizontal proportional factor
} X_attr ; 

typedef struct  // ����ͨ������//Attribution of triggering 
{
  u8  STR[8];   // ������ʽ��ʶ�ַ���//Identify String 
  u8  CHx;      // ����ͨ�����//Trigger channel
  u8  CMD;      // ������ʽ������//Trigger mode
} T_attr ; 

extern const G_attr G_ATTR[1];
extern const Y_attr Y_ATTR[9];
extern const X_attr X_ATTR[27];
extern const T_attr T_ATTR[32];

extern Y_attr *Y_Attr; 
extern X_attr *X_Attr; 
extern G_attr *G_Attr; 
extern T_attr *T_Attr; 

void SendByte(u8 Data); 
void Set_Param(u8 RegAddr, u8 Parameter); 

u32  Get(u8 Object, u32 Value);
u32  Set(u8 Object, u32 Value);

#endif  

/*******************************  END OF FILE  ********************************/
