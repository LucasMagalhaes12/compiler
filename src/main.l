START "START"
END "END"

IGNORE [ \n\t]
COMENT \~.*

INT [0-9]+
STR "[A-Za-z]+"
FLOAT [0-9]+\.[0-9]+
BOOL true|false

IF if
ELSE else
FOR for
WHILE while

OPE [-+*/=]
OPE2 [";.:;(){}<>=]

TYPE int|float|str|bool
VAR [a-zA-Z_][a-zA-Z0-9_]*
FUNC {TYPE}" "{VAR}\(\)

INP	input 


%%
{START} {{printf("\n[START]\n\n");}}
{END} {printf("\n[END]\n\n");}

{IGNORE} {}
{COMENT} {printf("COMENT: %s\n\n", yytext);}

{TYPE} {printf("TYPE: %s\n", yytext);}
{FUNC} {printf("FUNC: %s\n", yytext);}

{STR} {printf("STR: %s\n", yytext);}
{INT} {printf("INT: %s\n", yytext);}
{FLOAT} {printf("FLOAT: %s\n", yytext);}
{BOOL} {printf("BOOL: %s\n", yytext);}

{IF} {printf("IF: %s\n", yytext);}
{ELSE} {printf("ELSE: %s\n", yytext);}
{FOR} {printf("FOR: %s\n", yytext);}
{WHILE} {printf("WHILE: %s\n", yytext);}

{VAR} {printf("VAR: %s\n", yytext);}

{OPE} {printf("OPE: %s\n", yytext);}
{OPE2} {printf("OPE2: %s\n", yytext);}
%%


int main(int numargs, char *arg[]) {
	printf("\n\n\n");
	yyin = fopen(arg[1], "r");
	yylex();
	fclose(yyin);
	return 0;
}
