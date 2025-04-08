START "START"
END "END"

IGNORE [ \n\t]
COMENT \~.*

INT [0-9]+
STR [A-Za-z]+
FLOAT [0-9]+\.[0-9]+

OPE [-+*/=]






%%
{START} {{printf("\n[START]\n\n");}}
{END} {printf("\n[END]\n\n");}
{IGNORE} {}
{COMENT} {printf("COMENT: %s\n\n", yytext);}

{STR} {printf("STR: %s\n", yytext);}
{INT} {printf("INT: %s\n", yytext);}
{FLOAT} {printf("FLOAT: %s\n", yytext);}

{OPE} {printf("OPE: %s\n", yytext);}

%%

int main(int numargs, char *arg[]) {
	yyin = fopen(arg[1], "r");
	yylex();
	fclose(yyin);
	// printf("\n");
	return 0;
}
