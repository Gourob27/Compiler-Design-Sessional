%option noyywrap

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int lineno = 1; // initialized number of line with 1
    int words = 0;  // number of lexemes
    void ret_print(char *token_type, char *token_value);
    void yyerror();
%}

%x ML_COMMENT
alpha       [a-zA-Z]
digit       [0-9]
alnum       {alpha}|{digit}
print       [ -~]

preprocessor_directives #.*
ARRAY       ({alpha}+{alnum}*"[".+"]")|({alpha}+{alnum}*"["+"]")
POINTER     "*"+{alpha}+{alnum}*
ID          {alpha}+{alnum}*
ICONST      "0"|[0-9]{digit}*
FCONST      "0"|{digit}*"."{digit}+
CCONST      (\'{print}\')|(\'\\[nftrbv]\')
STRING      \"{print}*\"

%%

"//".*                  { printf("Eat up comment at line %d\n", lineno); } 

"/*"                    { printf("Eat up comment from line %d ", lineno); BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/"        { printf("to line %d\n", lineno); BEGIN(INITIAL); }
<ML_COMMENT>[^*\n]+     
<ML_COMMENT>"*"         
<ML_COMMENT>"\n"        { lineno += 1; }


"char"|"CHAR"           { ret_print("KEYWORD_CHAR", yytext); }
"int"|"INT"             { ret_print("KEYWORD_INT", yytext); }
"float"|"FLOAT"         { ret_print("KEYWORD_FLOAT", yytext); }
"double"|"DOUBLE"       { ret_print("KEYWORD_DOUBLE", yytext); }
"if"|"IF"               { ret_print("KEYWORD_IF", yytext); }
"else"|"ELSE"           { ret_print("KEYWORD_ELSE", yytext); }
"while"|"WHILE"         { ret_print("KEYWORD_WHILE", yytext); }
"for"|"FOR"             { ret_print("KEYWORD_FOR", yytext); }
"continue"|"CONTINUE"   { ret_print("KEYWORD_CONTINUE", yytext); }
"break"|"BREAK"         { ret_print("KEYWORD_BREAK", yytext); }
"void"|"VOID"           { ret_print("KEYWORD_VOID", yytext); }
"return"|"RETURN"       { ret_print("KEYWORD_RETURN", yytext); }


"+"|"-"                 { ret_print("ADDOP", yytext); }
"*"                     { ret_print("MULOP", yytext); }
"/"                     { ret_print("DIVOP", yytext); }
"++"|"--"               { ret_print("INCR", yytext); }
"||"                    { ret_print("OROP", yytext); }
"&&"                    { ret_print("ANDOP", yytext); }
"!"                     { ret_print("NOTOP", yytext); }
"=="|"!="               { ret_print("EQUOP", yytext); }
">"|"<"|">="|"<="       { ret_print("RELOP", yytext); }


"("             { ret_print("LPAREN", yytext); }
")"             { ret_print("RPAREN", yytext); }
"["             { ret_print("LBRACK", yytext); }
"]"             { ret_print("RBRACK", yytext); }
"{"             { ret_print("LBRACE", yytext); }
"}"             { ret_print("RBRACE", yytext); }
";"             { ret_print("SEMI", yytext); }
"."             { ret_print("DOT", yytext); }
","             { ret_print("COMMA", yytext); }
"="             { ret_print("ASSIGN", yytext); }
"&"             { ret_print("REFER", yytext); }

{preprocessor_directives} { ret_print("PREPROCESSOR DIRECTIVES", yytext); }
{POINTER}       { ret_print("POINTER", yytext); }
{ARRAY}         { ret_print("ARRAY", yytext); }
{ID}            { ret_print("ID", yytext); }
{ICONST}        { ret_print("ICONST", yytext); }
{FCONST}        { ret_print("FCONST", yytext); }
{CCONST}        { ret_print("CCONST", yytext); }
{STRING}        { ret_print("STRING", yytext); }

"\n"*           { lineno += 1; }
[ \t\r\f]+          /* eat up whitespace */

.               { yyerror("Unrecognized character"); }

%%

void ret_print(char *token_type, char *token_value){
    words++;
    printf("[%s]", token_value);
}

void yyerror(char *message){
    printf("Error: \"%s\" in line %d. Token = %s\n", message, lineno, yytext);
    exit(1);
}

int main(int argc, char *argv[]){
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
    printf("\n");
    return 0;
}
