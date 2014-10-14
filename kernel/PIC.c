#include "include/include.h"

void PIC_init(){
	IO_Send(PIC0, 0xff); //disable master int
	IO_Send(PIC1, 0xff); //disable salve int
	
	IO_Send(PIC0_W1, 0x11);
	IO_Send(PIC0_W2, 0x20);
	IO_Send(PIC0_W3, 1 << 2);
	IO_Send(PIC0_w4, 0x01);
	
	IO_Send(PIC1_W1, 0x11);
	IO_Send(PIC1_W2, 0x28);
	IO_Send(PIC1_W3, 2);
	IO_Send(PIC1_w4, 0x01);
	
	IO_Send(PIC0, 0xfb);
	IO_Send(PIC1, 0xff);
	return;
}
void PIC_done(int to){
	IO_Send(PIC0_OCW, to);
}
