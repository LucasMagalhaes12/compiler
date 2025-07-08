#ifndef AST_H
#define AST_H

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

// Estrutura de uma variável
typedef struct vars {
    int nodetype;
    char name[50];
    double valor;
    char valors[50];
    double *vet;
    struct vars * prox;
} VARI;

// Estrutura de um nó da AST
typedef struct ast {
    int nodetype;
    struct ast *l;
    struct ast *r;
} Ast;

// Estrutura de um número
typedef struct numval {
    int nodetype;
    double number;
} Numval;

// Estrutura de um nome de variável
typedef struct varval {
    int nodetype;
    char var[50];
    int size;
} Varval;

// Estrutura de um texto
typedef struct texto {
    int nodetype;
    char txt[50];
} TXT;

// Estrutura de um desvio (if/else/while)
typedef struct flow {
    int nodetype;
    Ast *cond;
    Ast *tl;
    Ast *el;
} Flow;


 typedef struct flowfor{ 
    int nodetype;
    Ast* v1;
    Ast* v2;
    Ast* v3;
}Flowfor;

// Estrutura de uma string
typedef struct strval {
    int nodetype; // Q
    char *s;
} Strval;

// Estrutura para um nó de atribuição
typedef struct symasgn {
    int nodetype;
    char s[50];
    Ast *v;
    int pos;
} Symasgn;

// Declaração da lista de variáveis global
extern VARI *l1;

// Protótipos das Funções
VARI *ins(VARI*l,char n[]);
VARI *ins_a(VARI*l,char n[], int tamanho);
VARI *srch(VARI*l,char n[]);
Ast * newast(int nodetype, Ast *l, Ast *r);
Ast * newvari(int nodetype, char nome[50]);
Ast * newarray(int nodetype, char nome[50], int tam);
Ast * newtext(int nodetype, char txt[500]);
Ast * newnum(double d);
Ast * newflow(int nodetype, Ast *cond, Ast *tl, Ast *el);
Ast * newflowfor(int nodetype, Ast *b1, Ast *b2, Ast *b3, Ast *tl, Ast *el);
Ast * newstring(char *s);
Ast * newcmp(int cmptype, Ast *l, Ast *r);
Ast * newasgn(char s[50], Ast *v);
Ast * newasgn_a(char s[50], Ast *v, int indice);
Ast * newValorVal(char s[]);
Ast * newValorVal_a(char s[], int indice);
Ast * newValorValS(char s[50]);
char * eval2(Ast *a);
double eval(Ast *a);

#endif //AST_H