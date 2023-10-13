%{
#include <ctype.h>
#include <stdio.h>
int yylex();
void yyerror();
int tmp=0;
%}

%token num
%left '+' '-'
%left '*' '/'
%left '(' ')'

%%

line :exp  {printf("=%d\n",$$); return 0;};

exp  :exp '+' exp {$$ =$1+$3;}
     | exp '-' exp {$$ =$1-$3;}
     | exp '*' exp {$$ =$1*$3;}
     | exp '/' exp {$$ =$1/$3;}
     | '(' exp ')' {$$=$2;}
     | num {$$=$1;};
     
%%

void yyerror(){
	printf("The arithmetic expression is incorrect\n");
	tmp=1;
}
int main(){
	printf("Enter an arithmetic expression(can contain +,-,*,/ or parenthesis):\n");
	yyparse();
}
