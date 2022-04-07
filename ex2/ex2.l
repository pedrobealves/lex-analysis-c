%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

#define	S_PARANA  100
#define	S_SP  200
#define S_MG 300

int linha=1;
%}

DIGITOS [0-9]{3}[1-9]
PARANA [A-B][A-E][A-Z]"-"{DIGITOS}
SP [B-G][F-K][A-I]"-"{DIGITOS}
MG [G-H][K-O][J-K]"-"{DIGITOS}

%%
{PARANA}	{return S_PARANA;}
{SP}	{return S_SP;}
{MG}	{return S_MG;}

[ \t]		/* faz nada. ignora. */
\n 		{linha++;}
<<EOF>>		{return 0;}

%%
int main(){
	int t;
	t = yylex();
	while (t != 0){
		if(t == S_PARANA){
			printf("PARANA[%s]\tLinha:%d\n",yytext,linha);
		} else if (t == S_SP){
      printf("SP[%s]\tLinha:%d\n",yytext,linha);
    } else if (t == S_MG){
      printf("MG[%s]\tLinha:%d\n",yytext,linha);
    }
		t = yylex();
	}
}