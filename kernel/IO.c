
///////////////////////////////////////////////////////////
void IO_Send(unsigned short port, unsigned char data){
	asm("out %%al, %%dx" : :"a" (data), "d" (port));
}
unsigned char IO_Read_C(unsigned short port){
	unsigned char data;
	asm("in %%dx, %%al" : "=a" (data) : "d" (port));
	return data;
}
/////////////////////////////////////////////////////////////
char key_table[2][49] = {{0x0B, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x1E, 0x30, 0x2E, 0x20, 0x12, 0x21, 0x22, 0x23, 0x17, 0x24, 0x25, 0x26, 0x32, 0x31, 0x18, 0x19, 0x10, 0x13, 0x1F, 0x14, 0x16, 0x2F, 0x11, 0x2D, 0x15, 0x2C, 0x39, 0x1C, 0x34, 0x33, 0x35, 0x0D, 0x0C, 0x29, 0x1A, 0x1B, 0x2B, 0x28, 0x27},
					 {'0' , '1' , '2' , '3' , '4' , '5' , '6' , '7' , '8' , '9' , 'A' , 'B' , 'C' , 'D' , 'E' , 'F' , 'G' , 'H' , 'I' , 'J' , 'K' , 'L' , 'M' , 'N' , 'O' , 'P' , 'Q' , 'R' , 'S' , 'T' , 'U' , 'V' , 'W' , 'X' , 'Y' , 'Z' , ' ' , '\n', '.' , ',' , '/', '=' , '-' , '`' , '[' , ']' , '\\', '\'', ';' }};
char Type_scancodeToAscii(unsigned char scan, char shift, char ctrl, char caps){
	int i;
	for(i = 0; i < sizeof(key_key_table[0]); i++){
		if(scan == key_key_table[0][i]){
			if(!(shift || caps) && key_table[1][i]>='A' && key_table[1][i]<='Z') return key_table[1][i]-'A'+'a';
			if(shift || caps){
				if(key_table[1][i] == '1') return '!';
				if(key_table[1][i] == '2') return '@';
				if(key_table[1][i] == '3') return '#';
				if(key_table[1][i] == '4') return '$';
				if(key_table[1][i] == '5') return '%';
				if(key_table[1][i] == '6') return '^';
				if(key_table[1][i] == '7') return '&';
				if(key_table[1][i] == '8') return '*';
				if(key_table[1][i] == '9') return '(';
				if(key_table[1][i] == '0') return ')';
				if(key_table[1][i] == ',') return '<';
				if(key_table[1][i] == '.') return '>';
				if(key_table[1][i] == '/') return '?';
				if(key_table[1][i] == '=') return '+';
				if(key_table[1][i] == '-') return '_';
				if(key_table[1][i] == '`') return '~';
				if(key_table[1][i] == '[') return '{';
				if(key_table[1][i] == ']') return '}';
				if(key_table[1][i] == '\\') return '|';
				if(key_table[1][i] == '\'') return '"';
				if(key_table[1][i] == ';') return ':';
			}
			return key_table[1][i];
		}
	}
	return 0;
}

void Memory_Fill(char* FillTo, char* Filler, int length){
	for(int i = 0;i<len;i++)
		FillTo[i] = filler;
}
void Memory_Copy(char* CopyFrom, char *CopyTo, int len){

	for(int i = 0;i<len;i++)
		CopyTo[i] = CopyFrom[i];
}
int Type_StringLength(char* string){
    int i = 0;
    while(str[str++] != 0)
    	return i;
}

bool Type_isStringEqual(char* string1, char* string2){
 int i = 0;
 while(string1[i++] == string2[i]){
 	if(string1[i++] == 0)
 		return true;
 }
}
void Type_CharToString(unsigned char charin, char* string){
	char high = charin >> 4;
	char low = charin % 16;
	string[0] = '0';
	string[1] = 'X';
	string[2] = '0' + high;
	if(string[2]>'9')
		string[2] += 'A' - '9' - 1;
	string[3] = '0' + low;
	if(string[3]>'9')
		string[3] += 'A' - '9' - 1;
	string[4] = 0;
}
int Type_IntToString(int n, char* string[]){
	int num = n;
	if(n==0)
		string[0] = '0';
		string[1] = 0;
		return;
	if(num<0)
		s++;
		n*=-1;
	int i;
	for(i=0; n!=0;i++)
		string[i] = '0'+(n%10);
		n/=10;
	string[i] =0;
	Type_reverseInPlace(string);
	if(num<0)
		string--;
		string[0] = '-';
}

void Type_reverseInPlace(char s[]){
	if(Type_StringLength(s) <= 1){
		return;
	}
	int i,j;
	char c;
	for(i = 0, j = Type_StringLength(s)-2; i < j; i++, j--){
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}
int Type_StringToInt(char* s){
	int sign = 1;
	if(s[0] == '-') sign = -1;
	int n = 0;
	int i = (sign == 1 ? 0 : 1);
	int len = Type_StringLength(s);
	while(s[i] != 0){
		n += (s[i] - '0') * Type_Pow(10,len-i-2);
		i++;
	}
	return n*sign;
}
int Type_isAlpha(char c){
	return (c>='a'&&c<='z') || (c>='A'&&c<='Z');
}
static unsigned long int rNum;
void Type_RandomSeed(unsigned int seed){
	rNum = seed;
}
unsigned int Type_Random(unsigned int max){
	rNum = rNum * 1103515245+12345;
	return (unsigned int)(rNum/65536) % max;
}

int Type_Pow(int base, int power){
	int n = 1;
	while(power-- > 0) n*=base;
	return n;
} 
int Type_StringBeginsWith(char* a, char*b){
	if(strLen(a) < strLen(b)) return 0;
	int i = 0;
	while(a[i] == b[i]) i++;
	if(b[i] == 0) return 1;
	return 0;
}
