/*******************************************************************************
*  Copyright (C) 2012 All Rights Reserved
*		
* 软件作者:	骑飞家族
* 版权所有: 骑飞电子	
* 创建日期:	2010年6月10日 
* 软件历史:	2010年11月2日修改
			2012年09月10日修改
* Version:  3.0 
* Demo 淘宝地址：http://qifeidz.taobao.com
**********************************************************************************************************************************************
懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒
懒懒懒懒懒懒懒懒懒懒懒一懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒困一懒懒懒懒懒懒懒懒懒懒懒懒懒懒一一一一一一一懒懒懒懒懒懒懒
懒懒困一一一一懒一一一一一一二懒懒懒懒困一一一一一一一一懒懒懒懒懒懒懒懒懒四厲懒懒一一懒懒懒一懒懒懒懒懒懒懒懒懒一一一一四四一一一懒懒懒懒懒懒
懒懒懒懒懒懒一懒懒懒一二一懒懒懒懒懒懒一一一一四厲二一四懒一一懒懒懒懒懒四一一一一一一一一一一一懒懒懒懒懒懒懒懒四懒懒四一一一一厲懒懒懒懒懒懒
懒懒懒四厲厲一懒懒厲懒懒懒四懒懒懒懒懒懒懒懒懒懒懒困一懒一一懒懒懒懒懒懒懒一一厲厲一一厲厲厲一一懒懒懒懒懒懒厲厲厲厲厲厲一一厲厲厲懒懒懒懒懒懒
懒懒懒一懒二一一一一一一一一一一一懒懒懒懒懒懒懒懒二一一困懒懒懒懒懒懒懒懒一一一一一一一一一一四懒懒懒懒懒一一一一一一一一一一一一一一一懒懒懒
懒懒懒一一一一一厲二一一厲一懒厲懒懒懒懒懒懒懒懒懒一一一一一懒懒懒懒懒懒懒一一懒懒一一懒懒懒一困懒懒懒懒懒一一四懒懒懒懒一一懒懒困一一四懒懒懒
懒懒懒懒懒懒懒一困一懒一厲一懒懒懒懒懒懒懒懒懒懒懒困一懒懒一一懒懒懒懒懒懒一一一一一一一一一一厲懒懒懒懒懒懒懒懒懒懒懒懒一一厲懒懒懒懒懒懒懒懒
懒二一一一懒四困厲一一一厲一懒懒懒懒懒懒懒懒懒懒懒懒一一懒懒懒懒懒懒懒懒懒懒懒懒懒四一厲懒懒懒懒懒懒一懒懒懒懒懒懒懒懒懒一一厲懒懒懒懒懒懒懒懒
懒懒懒懒懒懒一懒懒懒懒懒一一懒懒懒懒懒懒懒懒懒懒懒懒厲一一一一一一困懒懒懒懒懒懒懒懒一一一一一一一一一懒懒懒懒懒困懒懒厲一一懒懒懒懒懒懒懒懒懒
懒懒懒懒一一一懒懒困一一一一懒懒懒懒懒懒懒懒懒懒懒懒懒懒一一一一一懒懒懒懒懒懒懒懒懒懒一一一一一一一懒懒懒懒懒懒懒一一一一四懒懒懒懒懒懒懒懒懒
懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒懒
**********************************************************************************************************************************************/

#include "OV7670.h"
#include "delay.h"
#include "stm32f10x_lib.h"

// GND         PIN1
// HREF  PC8   PIN2
// VSYNC       PIN3
// PWDN  GND   PIN4
// PCLK  PC9   PIN5 没有用到
// AVDD  2.8V  PIN6
// DVDD  2.8V  PIN7
// SIOD  PA6   PIN8
// XCLK1 PA8   PIN9
// SIOC  PA7   PIN10
// D0    PC0   PIN11
// D1    PC1   PIN12
// D2    PC2   PIN13
// D3    PC3   PIN14
// GND         PIN15
// D4    PC4   PIN16
// D5    PC5   PIN17
// D6    PC6   PIN18
// D7    PC7   PIN19
// RST   GND   PIN20

//extern const char change_reg[CHANGE_REG_NUM][2];
////////////////////////////
//功能：提供7670时钟
//返回：无

void CLK_init_ON(void)
{
  
    GPIO_InitTypeDef GPIO_InitStructure;
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8; 
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz; 
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP ; 
    GPIO_Init(GPIOA, &GPIO_InitStructure);
    RCC_MCOConfig(RCC_MCO_HSE  );//hsi
}
void CLK_init_OFF(void)
{
  
    GPIO_InitTypeDef GPIO_InitStructure;
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8; 
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz; 
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(GPIOA, &GPIO_InitStructure);
}
void OV7670_GPIO_Init(void)
{
  
  GPIO_InitTypeDef GPIO_InitStructure;
   /* Enable GPIOC  clock */
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);
  GPIO_InitStructure.GPIO_Pin =  0X0BFF;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPD;//GPIO_Mode_AF_OD  GPIO_Mode_AF_PP GPIO_Mode_IPU	GPIO_Mode_IN_FLOATING   
  //GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_Init(GPIOC, &GPIO_InitStructure);
}
void OV7670_GPIO_CONTRL_CONFIG(void)
{
  
    GPIO_InitTypeDef GPIO_InitStructure;
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
    GPIO_InitStructure.GPIO_Pin = LCD_HREF_BIT|LCD_VSYNC_BIT|LCD_PCLK_BIT;
    //GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; 
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
    GPIO_Init(GPIOC, &GPIO_InitStructure);
    RCC_MCOConfig(RCC_MCO_HSE  );//hsi
}
////////////////////////////
//功能：写OV7670寄存器
//返回：1-成功	0-失败
unsigned char wrOV7670Reg(unsigned char regID, unsigned char regDat)
{
	startSCCB();
	if(0==SCCBwriteByte(0x42))
	{
		stopSCCB();
		return(0);
	}
	delay_us(100);
  	if(0==SCCBwriteByte(regID))
	{
		stopSCCB();
		return(0);
	}
	delay_us(100);
  	if(0==SCCBwriteByte(regDat))
	{
		stopSCCB();
		return(0);
	}
  	stopSCCB();
	
  	return(1);
}
////////////////////////////
//功能：读OV7670寄存器
//返回：1-成功	0-失败
unsigned char rdOV7670Reg(unsigned char regID, unsigned char *regDat)
{
	//通过写操作设置寄存器地址
	startSCCB();
	if(0==SCCBwriteByte(0x42))
	{
		stopSCCB();
		return(0);
	}
	delay_us(100);
  	if(0==SCCBwriteByte(regID))
	{
		stopSCCB();
		return(0);
	}
	stopSCCB();
	
	delay_us(100);
	
	//设置寄存器地址后，才是读
	startSCCB();
	if(0==SCCBwriteByte(0x43))
	{
		stopSCCB();
		return(0);
	}
	delay_us(100);
  	*regDat=SCCBreadByte();
  	noAck();
  	stopSCCB();
  	return(1);
}


//(140,16,640,480) is good for VGA
//(272,16,320,240) is good for QVGA
/* config_OV7670_window */
void OV7670_config_window(unsigned int startx,unsigned int starty,unsigned int width, unsigned int height)
{
	unsigned int endx;
	unsigned int endy;// "v*2"必须
	unsigned char temp_reg1, temp_reg2;
	unsigned char temp=0;
	
	endx=(startx+width);
	endy=(starty+height+height);// "v*2"必须
        rdOV7670Reg(0x03, &temp_reg1 );
	temp_reg1 &= 0xf0;
	rdOV7670Reg(0x32, &temp_reg2 );
	temp_reg2 &= 0xc0;
	
	// Horizontal
	temp = temp_reg2|((endx&0x7)<<3)|(startx&0x7);
	wrOV7670Reg(0x32, temp );
	temp = (startx&0x7F8)>>3;
	wrOV7670Reg(0x17, temp );
	temp = (endx&0x7F8)>>3;
	wrOV7670Reg(0x18, temp );
	
	// Vertical
	temp =temp_reg1|((endy&0x3)<<2)|(starty&0x3);
	wrOV7670Reg(0x03, temp );
	temp = starty>>2;
	wrOV7670Reg(0x19, temp );
	temp = endy>>2;
	wrOV7670Reg(0x1A, temp );
}

set_OV7670reg(void)
{
	wrOV7670Reg(0x8c, 0x00);
	wrOV7670Reg(0x3a, 0x04);
	wrOV7670Reg(0x40, 0xd0);  //原来10，通用COM15，设置输出数据范围和输出格式
	wrOV7670Reg(0x8c, 0x00);
	wrOV7670Reg(0x12, 0x14); //输出格式QVGA,原设置为0x14
	wrOV7670Reg(0x32, 0x80);
	wrOV7670Reg(0x17, 0x16);
	wrOV7670Reg(0x18, 0x04);
	wrOV7670Reg(0x19, 0x02);
	wrOV7670Reg(0x1a, 0x7b);//0x7a,  原来0x7b
	wrOV7670Reg(0x03, 0x06);//0x0a,  原来0x06
	wrOV7670Reg(0x0c, 0x04);//原来0x04	   com3,设置缩放，省电，模式等
	wrOV7670Reg(0x3e, 0x00);//	原来0x00   com14，dcw和pclk缩放设置，以及分频等
	wrOV7670Reg(0x70, 0x3a); //原来0x04
	wrOV7670Reg(0x71, 0x35); //原来0x35
	wrOV7670Reg(0x72, 0x11); //原来0x11
	wrOV7670Reg(0x73, 0x00);//原来f0 已改这里改变很重要
	wrOV7670Reg(0xa2, 0x00); //原来0x02
	wrOV7670Reg(0x11, 0xff); //时钟频率，这里改为最大值，原来为0x81  （改变）
	//wrOV7670Reg(0x15 , 0x31);
	wrOV7670Reg(0x7a, 0x20); //原来0x20 寄存器7a--89为伽马曲线设置
	wrOV7670Reg(0x7b, 0x1c); //原来0x1c
	wrOV7670Reg(0x7c, 0x28); //原来0x28
	wrOV7670Reg(0x7d, 0x3c); //原来0x3c
	wrOV7670Reg(0x7e, 0x55); //原来0x55
	wrOV7670Reg(0x7f, 0x68); //原来0x68
	wrOV7670Reg(0x80, 0x76); //原来0x76
	wrOV7670Reg(0x81, 0x80); //原来0x80
	wrOV7670Reg(0x82, 0x88); //原来0x88
	wrOV7670Reg(0x83, 0x8f); //原来0x8f
	wrOV7670Reg(0x84, 0x96); //原来0x96
	wrOV7670Reg(0x85, 0xa3); //原来0xa3
	wrOV7670Reg(0x86, 0xaf); //原来0xaf
	wrOV7670Reg(0x87, 0xc4); //原来0xc4
	wrOV7670Reg(0x88, 0xd7); //原来0xd7
	wrOV7670Reg(0x89, 0xe8); //原来0xe8 
	 
	wrOV7670Reg(0x32,0xb6);
	
	wrOV7670Reg(0x13, 0xff); //原来0xe0 com13 AGC,AWB,AEC使能控制	 （改变）
	wrOV7670Reg(0x00, 0x00);//AGC //原来0x00
	wrOV7670Reg(0x10, 0x00);//原来0x00  曝光值
	wrOV7670Reg(0x0d, 0x00);//原来0x00	 COM4
	wrOV7670Reg(0x14, 0x4e);//原来0x28, limit the max gain	自动增益设置 没变化
	wrOV7670Reg(0xa5, 0x05); //原来0x05 50Hz bangding step limting
	wrOV7670Reg(0xab, 0x07); //原来0x07 60Hz bangding step limting
	wrOV7670Reg(0x24, 0x75); //原来0x75 agc/aec-稳定运行区域上限
	wrOV7670Reg(0x25, 0x63); //原来0x63 agc/aec-稳定运行区域下限
	wrOV7670Reg(0x26, 0xA5); //原来0xa5 agc/aec-快速运行区域
	wrOV7670Reg(0x9f, 0x78); //原来0x78 基于直方图的aec/agc的控制1
	wrOV7670Reg(0xa0, 0x68); //原来0x68 基于直方图的aec/agc的控制2
//	wrOV7670Reg(0xa1, 0x03);//0x0b,
	wrOV7670Reg(0xa6, 0xdf);//0xd8, 原来0xdf 基于直方图的aec/agc的控制3
	wrOV7670Reg(0xa7, 0xdf);//0xd8, 原来0xdf 基于直方图的aec/agc的控制4
	wrOV7670Reg(0xa8, 0xf0); //原来0xf0  基于直方图的aec/agc的控制5
	wrOV7670Reg(0xa9, 0x90);  //原来0x90  基于直方图的aec/agc的控制6
	wrOV7670Reg(0xaa, 0x94);  //原来0x94  基于直方图的aec/agc的控制7
	//wrOV7670Reg(0x13, 0xe5);  //原来0xe5
	wrOV7670Reg(0x0e, 0x61);  //原来0x61 COM5
	wrOV7670Reg(0x0f, 0x43);  //原来0x4b COM6
	wrOV7670Reg(0x16, 0x02);  //原来0x02 保留
	wrOV7670Reg(0x1e, 0x37);//0x07, 原来0x37 水平镜像/竖直翻转使能	 设置为01后发生翻转
	wrOV7670Reg(0x21, 0x02);	//原来0x02  保留
	wrOV7670Reg(0x22, 0x91);	//原来0x91	保留
	wrOV7670Reg(0x29, 0x07);	//原来0x07	保留
	wrOV7670Reg(0x33, 0x0b);	//原来0x0b	href控制，改为初始值80时改变
	wrOV7670Reg(0x35, 0x0b);	//原来0xe0	保留
	wrOV7670Reg(0x37, 0x3f);	//原来0x1d	adc控制
	wrOV7670Reg(0x38, 0x01);	//原来0x71	adc和模拟共模控制
	wrOV7670Reg(0x39, 0x00);	//原来0x2a	adc偏移控制
	wrOV7670Reg(0x3c, 0x78);	//原来0x78	 COM12
	wrOV7670Reg(0x4d, 0x40);	//原来0x40	 保留
	wrOV7670Reg(0x4e, 0x20);	//原来0x20	 保留
	wrOV7670Reg(0x69, 0x00);	//原来0x00	  固定增益控制
	wrOV7670Reg(0x6b, 0x4a);   //PLL原来0x00	  pll控制	重要设置
	wrOV7670Reg(0x74, 0x19);	//原来0x19	手动数字增益
	wrOV7670Reg(0x8d, 0x4f);	//原来0x4f	保留
	wrOV7670Reg(0x8e, 0x00);	//原来0x00	保留
	wrOV7670Reg(0x8f, 0x00);	//原来0x00	保留
	wrOV7670Reg(0x90, 0x00);	//原来0x00	保留
	wrOV7670Reg(0x91, 0x00);	//原来0x00	保留
	wrOV7670Reg(0x92, 0x00);   //0x19,//0x66	 原来0x00 空行低8位
	wrOV7670Reg(0x96, 0x00);	//原来0x00	  保留
	wrOV7670Reg(0x9a, 0x80);	//原来0x80	  保留
	wrOV7670Reg(0xb0, 0x84);	//原来0xe0	  保留
	wrOV7670Reg(0xb1, 0x0c);	//原来0x0c	 ablc设置
	wrOV7670Reg(0xb2, 0x0e);	//原来0x0e	  保留
	wrOV7670Reg(0xb3, 0x82);	//原来0x82	  ablc target
	wrOV7670Reg(0xb8, 0x0a);	//原来0x0a	   保留
	wrOV7670Reg(0x43, 0x14);	//原来0x14	  43-48为保留
	wrOV7670Reg(0x44, 0xf0);	//原来0xf0
	wrOV7670Reg(0x45, 0x34);	//原来0x34
	wrOV7670Reg(0x46, 0x58);	//原来0x58
	wrOV7670Reg(0x47, 0x28);	//原来0x28
	wrOV7670Reg(0x48, 0x3a);	//原来0x3a
	
	wrOV7670Reg(0x59, 0x88);	//原来0x88	 51-5e保留
	wrOV7670Reg(0x5a, 0x88);	//原来0x88
	wrOV7670Reg(0x5b, 0x44);	//原来0x44
	wrOV7670Reg(0x5c, 0x67);	//原来0x67
	wrOV7670Reg(0x5d, 0x49);	//原来0x49
	wrOV7670Reg(0x5e, 0x0e);	//原来0xe0
	
	wrOV7670Reg(0x64, 0x04);	//原来0x04	  64-66镜头补偿
	wrOV7670Reg(0x65, 0x20);	//原来0x20
	wrOV7670Reg(0x66, 0x05);	//原来0x05

	wrOV7670Reg(0x94, 0x04);	//原来0x04	94-95镜头补偿
	wrOV7670Reg(0x95, 0x08);	//原来0x08	 

	wrOV7670Reg(0x6c, 0x0a);	//原来0x0a	6c-6fawb设置
	wrOV7670Reg(0x6d, 0x55);	//原来0x55
	wrOV7670Reg(0x6e, 0x11);	//原来0x11
	wrOV7670Reg(0x6f, 0x9f);   //0x9e for advance AWB	  原来9f

	wrOV7670Reg(0x6a, 0x40);	//原来0x40	g通道awb增益
	wrOV7670Reg(0x01, 0x40);	//原来0x40	b通道awb增益控制
	wrOV7670Reg(0x02, 0x40);	//原来0x40	r通道awb增益控制
	
	//wrOV7670Reg(0x13, 0xe7);	//原来0xe7
	wrOV7670Reg(0x15, 0x00);   //00  cmos10  含有pclk输出选择
	wrOV7670Reg(0x4f, 0x80);	//原来0x80	以下为色彩矩阵系数设置
	wrOV7670Reg(0x50, 0x80);	//原来0x80
	wrOV7670Reg(0x51, 0x00);	//原来0x00
	wrOV7670Reg(0x52, 0x22);	//原来0x22
	wrOV7670Reg(0x53, 0x5e);	//原来0x5e
	wrOV7670Reg(0x54, 0x80);	//原来0x80
	wrOV7670Reg(0x58, 0x9e);	//原来0x9e

	wrOV7670Reg(0x41, 0x08);	//原来0x08	com16 以下为边缘设置
	wrOV7670Reg(0x3f, 0x00);	//原来0x00  边缘增强调整
	wrOV7670Reg(0x75, 0x05);	//原来0x05
	wrOV7670Reg(0x76, 0xe1);	//原来0xe1

	wrOV7670Reg(0x4c, 0x00);	//原来0x00  噪声抑制强度
	wrOV7670Reg(0x77, 0x01);	//原来0x01	噪声去除偏移
	
	wrOV7670Reg(0x3d, 0xc1);	//0xc0,	   com13 输出设置
	wrOV7670Reg(0x4b, 0x09);	//原来0x09 寄存器4b设置
	wrOV7670Reg(0xc9, 0x60);	//原来0x60	 饱和度控制
	//wrOV7670Reg(0x41, 0x38);	//原来0x38	  com16边缘设置设置
	wrOV7670Reg(0x56, 0x40);//0x40,  change according to Jim's request	对比度控制
	wrOV7670Reg(0x34, 0x11);	//原来0x11	  感光阵列参考电压控制
	wrOV7670Reg(0x3b, 0x02);//0x00,//原来0x02,	  com11控制
	wrOV7670Reg(0xa4, 0x89);//0x88, 原来89 nt控制  
	
	wrOV7670Reg(0x96, 0x00);	//原来0x00  以下96-9c保留
	wrOV7670Reg(0x97, 0x30);	//原来0x30
	wrOV7670Reg(0x98, 0x20);	//原来0x20
	wrOV7670Reg(0x99, 0x30);	//原来0x30
	wrOV7670Reg(0x9a, 0x84);	//原来0x84
	wrOV7670Reg(0x9b, 0x29);	//原来0x29
	wrOV7670Reg(0x9c, 0x03);	//原来0x03
	wrOV7670Reg(0x9d, 0x4c);	//原来0x4c	50HZ条纹滤波的值
	wrOV7670Reg(0x9e, 0x3f);	//原来0x3f	60HZ条纹滤波的值

	wrOV7670Reg(0x09, 0x00);	//原来0x00 通用控制器com2
	wrOV7670Reg(0x3b, 0xc2);//0x82,//0xc0,//原来0xc2,	//night mode 原来0xc2

}

/* OV7670_init() */
//返回1成功，返回0失败
unsigned char OV7670_init(void)
{
	unsigned char temp;	
	unsigned int i=0;

	OV7670_GPIO_Init();
	OV7670_GPIO_CONTRL_CONFIG();
	SCCB_GPIO_Config(); // io init..

    CLK_init_ON();
	temp=0x80;
	if(0==wrOV7670Reg(0x12, temp)) //Reset SCCB
	{
        return 0 ;
	}
	delay_ms(100);
  	set_OV7670reg();

	OV7670_config_window(272,12,320,240);// set 240*320
	return 0x01; //ok			  
} 