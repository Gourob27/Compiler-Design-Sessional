%{
#include<stdio.h>
#include<string.h>
char line[100];

%}
DIGIT    [0-9]
ID       [a-z][a-z0-9]*


%%

{DIGIT}+    {
            fprintf( yyout,"[%s] ", yytext );
            }

{DIGIT}+"."{DIGIT}*        {
            fprintf( yyout,"[%s] ", yytext);
            }

if|then|begin|end|procedure|function|else        {
            fprintf( yyout,"[%s] ", yytext );
            }

{ID}        fprintf( yyout,"[%s] ", yytext );

"+"|"-"|"*"|"/"|"<"|">"|"=>"|"<="   fprintf( yyout,"[%s] ", yytext );

"{"[^}\n]*"}"     /* eat up one-line comments */

[ \t\n]+          /* eat up whitespace */
<<EOF>> { fprintf(yyout,"\n"); return 0;}
%%


int yywrap()
{
	return 1;
}

/* code section */
int main()
{
		extern FILE *yyin, *yyout;
		/* open the source file
		in read mode */
	yyin=fopen("input.txt","r");

		
		/* open the output file
		in write mode */
	yyout=fopen("output.txt","w");
	yylex();
}

