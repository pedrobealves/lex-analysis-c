%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

#define	S_IP		100
#define S_TELEFONE 200
#define S_CPF 300

int linha=1;
%}

END [0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]
IP	({END}"."){3}{END}
CPF ([0-9]{3}.){2}[0-9]{3}-[0-9]{2}
DDD		"("[0-9]?[1-9]{2}")" 
PRINCIPAL	[1-9][0-9]{3}"-"[0-9]{4}|9[0-9]{4}"-"[0-9]{4} 
TELEFONE	{DDD}?{PRINCIPAL}


%%
{IP}	{return S_IP;}
{TELEFONE} {return S_TELEFONE;}
{CPF} {return S_CPF;}

[ \t]		/* faz nada. ignora. */
\n 		{linha++;}
<<EOF>>		{return 0;}

%%
int main(){
	int t;
	t = yylex();
	while (t != 0){
		if(t == S_IP){
			printf("IP[%s]\tLinha:%d\n",yytext,linha);
		} 
    else if (t == S_TELEFONE){
      printf("Telefone[%s]\tLinha:%d\n",yytext,linha);
    }
    else if (t == S_CPF){
      printf("CPF[%s]\tLinha:%d\n",yytext,linha);
    }
		t = yylex();
	}
}