START "START"
END "END"

IGNORE [ #\n\t]
COMENT \~.*

INT [0-9]+
STR \"[A-Za-z ]+\"
FLOAT [0-9]+\.[0-9]+
BOOL (true|false)

IF if
ELSE else
FOR for
WHILE while

OP_ARI [-+*/=]
OP_2 ["%&|]

AND and
OR or
NOT not
DOT \.
COLON \:
SEMI_COLON \;
COMMA \,
EQUAL =
EXCLAMETION \!
PARENTHESES [\(\)]
BRACKETS [\[\]]
BRACES [\{\}]
SLASH \\
LESS_THAN <
GREATER_THAN >

TYPE int|float|str|bool
VAR [a-zA-Z_][a-zA-Z0-9_]*
FUNC func

INP	input 
OUT output
IMPORT add

PASS pass

%%
{DOT}           { printf("%-20s | %s\n", "DOT", yytext); }
{AND}           { printf("%-20s | %s\n", "AND", yytext); }
{OR}            { printf("%-20s | %s\n", "OR", yytext); }
{NOT}           { printf("%-20s | %s\n", "NOT", yytext); }
{COLON}         { printf("%-20s | %s\n", "COLON", yytext); }
{SEMI_COLON}    { printf("%-20s | %s\n", "SEMI_COLON", yytext); }
{COMMA}         { printf("%-20s | %s\n", "COMMA", yytext); }
{EQUAL}         { printf("%-20s | %s\n", "EQUAL", yytext); }
{EXCLAMETION}   { printf("%-20s | %s\n", "EXCLAMETION", yytext); }
{PARENTHESES}   { printf("%-20s | %s\n", "PARENTHESES", yytext); }
{BRACKETS}      { printf("%-20s | %s\n", "BRACKETS", yytext); }
{BRACES}        { printf("%-20s | %s\n", "BRACES", yytext); }
{SLASH}         { printf("%-20s | %s\n", "SLASH", yytext); }
{GREATER_THAN}  { printf("%-20s | %s\n", "GREATER_THAN", yytext); }
{LESS_THAN}     { printf("%-20s | %s\n", "LESS_THAN", yytext); }

{IMPORT}        { printf("%-20s | %s\n", "IMPORT", yytext); }

{START}         { printf("\n%-20s | %s\n\n", "[START]", yytext); }
{END}           { printf("\n%-20s | %s\n\n", "[END]", yytext); }

{IGNORE}        {}
{COMENT}        { printf("\n%-5s %s\n\n", "COMENT", yytext); }

{TYPE}          { printf("%-20s | %s\n", "TYPE", yytext); }
{FUNC}          { printf("%-20s | %s\n", "FUNC", yytext); }
{PASS}          { printf("%-20s | %s\n", "PASS", yytext); }

{STR}           { printf("%-20s | %s\n", "STR", yytext); }
{INT}           { printf("%-20s | %s\n", "INT", yytext); }
{FLOAT}         { printf("%-20s | %s\n", "FLOAT", yytext); }
{BOOL}          { printf("%-20s | %s\n", "BOOL", yytext); }

{IF}            { printf("%-20s | %s\n", "IF", yytext); }
{ELSE}          { printf("%-20s | %s\n", "ELSE", yytext); }
{FOR}           { printf("%-20s | %s\n", "FOR", yytext); }
{WHILE}         { printf("%-20s | %s\n", "WHILE", yytext); }

{INP}           { printf("%-20s | %s\n", "INP", yytext); }
{OUT}           { printf("%-20s | %s\n", "OUT", yytext); }

{VAR}           { printf("%-20s | %s\n", "VAR", yytext); }

{OP_ARI}        { printf("%-20s | %s\n", "OPE", yytext); }
{OP_2}          { printf("%-20s | %s\n", "OPE2", yytext); }

.               { printf("%-20s | %s\n", "UNKNOWN", yytext); }
%%


int main(int argc, char *argv[]) {
	if (argc < 2) {
		printf("ERROR: Please provide the filename as a command-line argument.\n");
		return 1;
	}
	
	yyin = fopen(argv[1], "r");
	if (!yyin) {
        fprintf(stderr, "ERROR: Could not open file '%s'.\n", argv[1]);
        return 1;
    }

	printf("\"%s\"", argv[1]);
	printf("\n%-20s | %s\n", "TOKEN", "VALOR");
	printf("---------------------|-------------------------\n\n");

	yylex();
	fclose(yyin);
	return 0;
}
