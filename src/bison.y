%{
#include "ast.h"

int yylex();
void yyerror (char *s){
	printf("%s\n", s);
}
%}

%union{
	float flo;
	int fn;
	int inter;
	char str[50];
	Ast *ast;
	}


%token <flo>number
%token <str>variable
%token <str>text
%token <str>string

%token endfile when otherwise repeate_while repeate_for out var in outln inln
%token <fn> CMP

%right '='
%left '+' '-'
%left '*' '/'
%left CMP

%type <ast> exp list stmt prog exp1 var

%nonassoc IFX VARPREC DECLPREC NEG VET 

%%

val: prog endfile
	;

prog: stmt 		{eval($1);}  /*Inicia e execução da árvore de derivação*/
	| prog stmt {eval($2);}	 /*Inicia e execução da árvore de derivação*/
	;
	
/*Funções para análise sintática e criação dos nós na AST*/	
/*Verifique q nenhuma operação é realizada na ação semântica, apenas são criados nós na árvore de derivação com suas respectivas operações*/
	
stmt: when '(' exp ')' '{' list '}' %prec IFX {$$ = newflow('I', $3, $6, NULL);}
	| when '(' exp ')' '{' list '}' otherwise '{' list '}' {$$ = newflow('I', $3, $6, $10);}
	| repeate_while '(' exp ')' '{' list '}' {$$ = newflow('W', $3, $6, NULL);}
    | repeate_for '(' var ';' exp ';' stmt ')' '{' list '}' { $$ = newflowfor('F', $3, $5, $7, $10, NULL);}

	| variable '=' exp %prec VARPREC { $$ = newasgn($1,$3);}
	| variable '['number']' '=' exp {$$ = newasgn_a($1,$6,$3);}

	| var variable	 %prec DECLPREC { $$ = newvari('V',$2);}
	| var variable '['number']'	{ $$ = newarray('a',$2,$4);}
	
	| out '(' exp ')' 	{$$ = newast('P',$3,NULL);}
	| outln '(' exp1 ')' 	{$$ = newast('Y',$3,NULL);}
	| in '('variable')'		{$$ = newvari('S',$3);}
	| inln '('variable')'		{$$ = newvari('T',$3);}
	;

list: stmt {$$ = $1;}
		| list stmt { $$ = newast('L', $1, $2);	}
		;
	
exp: 
	 exp '+' exp {$$ = newast('+',$1,$3);}		/*Expressões matemáticas*/
	|exp '-' exp {$$ = newast('-',$1,$3);}
	|exp '*' exp {$$ = newast('*',$1,$3);}
	|exp '/' exp {$$ = newast('/',$1,$3);}
	|exp CMP exp {$$ = newcmp($2,$1,$3);}		/*Testes condicionais*/
	|'(' exp ')' {$$ = $2;}
	|'-' exp %prec NEG {$$ = newast('M',$2,NULL);}
	|number 	{$$ = newnum($1);}						/*token de um número*/
	
	|variable 	%prec VET {$$ = newValorVal($1);}		/*token de uma variável*/
	|variable '['number']' {$$ = newValorVal_a($1,$3);}				/*token de uma variável*/
    |string { $$ = newstring($1); }
    ;

exp1: 
	variable {$$ = newValorValS($1);}				
	;
%%

#include "lex.c"


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
	yylex();
	fclose(yyin);
	return 0;
}

