INT [0-9]+
STR [A-Za-z]+
OPE [-+*/=]
COMENT /#.*


%%
"FIM" {printf("Fim/n");}
{INT} {printf("INT: %s\n", yytext);}
{STR} {printf("STR: %s\n", yytext);}
{OPE} {printf("OPE: %s\n", yytext);}

%%

int main() {
	yyin = fopen("codigo.d", "r");
	yylex();
	fclose(yyin);
	return 0;
}
