
/* ASM function*/
void write_memory(int address, int data);
void IO_STI();
void IO_CLI();
void IO_HALT();
void IO_LOADEFLAG();
void IO_SAVEEFLAG(int EfFag);
void PIC_int();
/*c FUNCTION*/
void PIC_done(int to);
void Memory_Fill(char*, char, int);
void Memory_Copy(char*, char*, int);
int Type_StringLength(char*);
int Type_IntToString(int, char*);
int Type_StringToInt(char*);
void Type_CharToString(unsigned char, char*);
bool Type_isStringEqual(char*, char*);
void Type_reverseInPlace(char*);
int Type_Pow(int, int);
int Type_isAlpha(char);
void Type_RandomSeed(unsigned int);
unsigned int Type_Random(unsigned int);
char Type_scancodeToAscii(unsigned char, char, char, char);
int Type_StringBeginsWith(char*, char*);
void IO_Send(unsigned short, unsigned char);
void IO_Read_C(unsigned short);
/*DEFINE*/
#define PIC0	0x0021
#define PIC1	0x00A1
#define PIC0_W1	0x0020
#define PIC1_W1	0x00A0
#define PIC0_W2	0x0021
#define PIC1_W2	0x00A1
#define PIC0_W3	0x0021
#define PIC1_w3	0x00A1
#define PIC0_w4	0x0021
#define PIC1_w4	0x00A1
#define PIC0_OCW	0x0020
#define PIC1_OCW	0x00A0
