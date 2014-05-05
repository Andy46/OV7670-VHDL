#ifndef _SCCB_H
#define _SCCB_H

#define SCCB_SIC_BIT     GPIO_Pin_4	//�˿ڵ�7λ
#define SCCB_SID_BIT     GPIO_Pin_5	 //�˿ڵ�8λ

#define SCCB_SIC_H()     GPIOA->BSRR = SCCB_SIC_BIT;  //�Զ˿�A�ض�λ������	,�������ø�
#define SCCB_SIC_L()     GPIOA->BRR =  SCCB_SIC_BIT;  //�������õ�

#define SCCB_SID_H()     GPIOA->BSRR = SCCB_SID_BIT;  //ͬ��
#define SCCB_SID_L()     GPIOA->BRR =  SCCB_SID_BIT;
/**/
#define SCCB_SID_IN      SCCB_SID_GPIO_INPUT();
#define SCCB_SID_OUT     SCCB_SID_GPIO_OUTPUT();


#define SCCB_SID_STATE	 GPIOA->IDR&0x40

///////////////////////////////////////////	 
void SCCB_GPIO_Config(void);
void SCCB_SID_GPIO_OUTPUT(void);
void SCCB_SID_GPIO_INPUT(void);
void startSCCB(void);
void stopSCCB(void);
void noAck(void);
unsigned char SCCBwriteByte(unsigned char m_data);
unsigned char SCCBreadByte(void);


#endif /* _SCCB_H */


