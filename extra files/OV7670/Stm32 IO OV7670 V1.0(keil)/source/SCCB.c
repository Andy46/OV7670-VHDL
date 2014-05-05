#include "SCCB.h"
#include "delay.h"
#include "stm32f10x_lib.h"
/*
-----------------------------------------------
   ����: ��ʼ��ģ��SCCB�ӿ�
   ����: ��
 ����ֵ: ��
-----------------------------------------------
*/
void SCCB_GPIO_Config(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
   /* Enable GPIOA  clock */
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
  GPIO_InitStructure.GPIO_Pin =  SCCB_SIC_BIT|SCCB_SID_BIT;	//SCCB_SIC_BIT=GPIO_Pin_7; SCCB_SID_BIT=GPIO_Pin_6
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;		  //GPIO_Mode_AIN = 0x0,     //ģ������
  GPIO_InitStructure.GPIO_Speed =GPIO_Speed_10MHz;		  //GPIO_Mode_IN_FLOATING = 0x04, //��������
  GPIO_Init(GPIOA, &GPIO_InitStructure);				  //GPIO_Mode_IPD = 0x28,    //��������
														  //GPIO_Mode_IPU = 0x48,    //��������
														  //GPIO_Mode_Out_OD = 0x14, //��©���
														  //GPIO_Mode_Out_PP = 0x10,  //�������
														  //GPIO_Mode_AF_OD = 0x1C,   //��©����
														  //GPIO_Mode_AF_PP = 0x18    //���츴�� 
}
void SCCB_SID_GPIO_OUTPUT(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
   /* Enable GPIOA  clock */
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
  GPIO_InitStructure.GPIO_Pin =  SCCB_SID_BIT;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz;
  GPIO_Init(GPIOA, &GPIO_InitStructure);
}
void SCCB_SID_GPIO_INPUT(void)
{
  GPIO_InitTypeDef GPIO_InitStructure;
   /* Enable GPIOA  clock */
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
  GPIO_InitStructure.GPIO_Pin =  SCCB_SID_BIT;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
 // GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_Init(GPIOA, &GPIO_InitStructure);
}

/*
-----------------------------------------------
   ����: start����,SCCB����ʼ�ź�
   ����: ��
 ����ֵ: ��
-----------------------------------------------
*/
void startSCCB(void)
{
    SCCB_SID_H();     //�����߸ߵ�ƽ
    delay_us(500);

    SCCB_SIC_H();	   //��ʱ���߸ߵ�ʱ���������ɸ�����
    delay_us(500);
 
    SCCB_SID_L();
    delay_us(500);

    SCCB_SIC_L();	 //�����߻ָ��͵�ƽ��������������Ҫ
    delay_us(500);


}
/*
-----------------------------------------------
   ����: stop����,SCCB��ֹͣ�ź�
   ����: ��
 ����ֵ: ��
-----------------------------------------------
*/
void stopSCCB(void)
{
    SCCB_SID_L();
    delay_us(500);
 
    SCCB_SIC_H();	
    delay_us(500);
  

    SCCB_SID_H();	
    delay_us(500);
   
}

/*
-----------------------------------------------
   ����: noAck,����������ȡ�е����һ����������
   ����: ��
 ����ֵ: ��
-----------------------------------------------
*/
void noAck(void)
{
	
	SCCB_SID_H();	
	delay_us(500);
	
	SCCB_SIC_H();	
	delay_us(500);
	
	SCCB_SIC_L();	
	delay_us(500);
	
	SCCB_SID_L();	
	delay_us(500);

}

/*
-----------------------------------------------
   ����: д��һ���ֽڵ����ݵ�SCCB
   ����: д������
 ����ֵ: ���ͳɹ�����1������ʧ�ܷ���0
-----------------------------------------------
*/
unsigned char SCCBwriteByte(unsigned char m_data)
{
	unsigned char j,tem;

	for(j=0;j<8;j++) //ѭ��8�η�������
	{
		if((m_data<<j)&0x80)
		{
			SCCB_SID_H();	
		}
		else
		{
			SCCB_SID_L();	
		}
		delay_us(500);
		SCCB_SIC_H();	
		delay_us(500);
		SCCB_SIC_L();	
		delay_us(500);

	}
	delay_us(100);
	SCCB_SID_IN;/*����SDAΪ����*/
	delay_us(500);
	SCCB_SIC_H();	
	delay_us(100);
	if(SCCB_SID_STATE){tem=0;}   //SDA=1����ʧ�ܣ�����0}
	else {tem=1;}   //SDA=0���ͳɹ�������1
	SCCB_SIC_L();	
	delay_us(500);	
        SCCB_SID_OUT;/*����SDAΪ���*/

	return (tem);  
}

/*
-----------------------------------------------
   ����: һ���ֽ����ݶ�ȡ���ҷ���
   ����: ��
 ����ֵ: ��ȡ��������
-----------------------------------------------
*/
unsigned char SCCBreadByte(void)
{
	unsigned char read,j;
	read=0x00;
	
	SCCB_SID_IN;/*����SDAΪ����*/
	delay_us(500);
	for(j=8;j>0;j--) //ѭ��8�ν�������
	{		     
		delay_us(500);
		SCCB_SIC_H();
		delay_us(500);
		read=read<<1;
		if(SCCB_SID_STATE) 
		{
			read=read+1;
		}
		SCCB_SIC_L();
		delay_us(500);
	}	
	return(read);
}
