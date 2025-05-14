%{
#include <stdio.h>
#include <math.h>

float var[26];

int yylex();
void yyerror (char *s) {
	printf("%s\n", s);
}


%}

%union {
	float flo;
	int inte;
	char *str;
}

%token <str> STR
%token <flo>NUM
%token <inte>VAR
%token START
%token END
%token OUT
%token INP
%left '+' '-'
%left '*' '/'
%right '^'
%right NEG

%type <flo> exp
%type <flo> valor


%%

prog: START cod END
	;

cod: cod cmdos
	|
	;

cmdos: OUT '(' args ')' {
						printf ("\n");
						}
    | INP '(' VAR ')' {
                        scanf("%f", &var[$3]);
    }
	| VAR '=' exp {
					var[$1] = $3;
					}
	;

args: args ',' arg { } | arg { };

arg: STR  { printf("%s", $1); free($1); }
    | exp { printf("%.2f", $1); }
    ;


exp: exp '+' exp {$$ = $1 + $3;}
	|exp '-' exp {$$ = $1 - $3;}
	|exp '*' exp {$$ = $1 * $3;}
	|exp '/' exp {$$ = $1 / $3;}
	|'(' exp ')' {$$ = $2;}
	|exp '^' exp {$$ = pow($1,$3);}
	|'-' exp %prec NEG {$$ = -$2;}
	|valor {$$ = $1;}
	|VAR {$$ = var[$1];}
	;

valor: NUM {$$ = $1;}
	;

%%


#include "lex.yy.c"

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


    yyparse();
	// yylex();
	fclose(yyin);
	return 0;
}
