#include "ast.h"

// Variáveis globais
VARI *l1;
VARI *aux;

// Insere uma nova variável na lista de variáveis
VARI *ins(VARI*l,char n[]){
    VARI*new =(VARI*)malloc(sizeof(VARI));
    strcpy(new->name,n);
    new->prox = l;
    new->nodetype = 1;
    return new;
}

VARI *ins_a(VARI*l,char n[], int tamanho){
    VARI*new =(VARI*)malloc(sizeof(VARI));
    strcpy(new->name,n);
    new->vet = (double*)malloc(tamanho * sizeof(double));
    new->prox = l;
    new->nodetype = 3;
    return new;
}

// Busca uma variável na lista de variáveis
VARI *srch(VARI*l,char n[]){
    VARI*aux = l;
    while(aux != NULL){
        if(strcmp(n,aux->name)==0)
            return aux;
        aux = aux->prox;
    }
    return aux;
}

// Função para criar um nó
Ast * newast(int nodetype, Ast *l, Ast *r){
    Ast *a = (Ast*) malloc(sizeof(Ast));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = nodetype;
    a->l = l;
    a->r = r;
    return a;
}

// Função de que cria uma nova variável
Ast * newvari(int nodetype, char nome[50]) {
    Varval *a = (Varval*) malloc(sizeof(Varval));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = nodetype;
    strcpy(a->var,nome);
    return (Ast*)a;
}

// Função de que cria uma nova variável (vetor)
Ast * newarray(int nodetype, char nome[50], int tam) {
    Varval *a = (Varval*) malloc(sizeof(Varval));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = nodetype;
    strcpy(a->var,nome);
    a->size = tam;
    return (Ast*)a;
}

// Função de que cria um novo texto
Ast * newtext(int nodetype, char txt[500]) {
    TXT *a = (TXT*) malloc(sizeof(TXT));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = nodetype;
    strcpy(a->txt,txt);
    return (Ast*)a;
}

// Função de que cria um novo número
Ast * newnum(double d) {
    Numval *a = (Numval*) malloc(sizeof(Numval));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = 'K';
    a->number = d;
    return (Ast*)a;
}

// Função que cria um nó de if/else/while
Ast * newflow(int nodetype, Ast *cond, Ast *tl, Ast *el){
    Flow *a = (Flow*)malloc(sizeof(Flow));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = nodetype;
    a->cond = cond;
    a->tl = tl;
    a->el = el;
    return (Ast *)a;
}



Ast * newflowfor(int nodetype, Ast *b1, Ast *b2, Ast *b3, Ast *tl, Ast *el){ 
    Flow *a = (Flow*)malloc(sizeof(Flow));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    Flowfor *b = (Flowfor*)malloc(sizeof(Flowfor));
    if(!b) {
        printf("out of space");
        exit(0);
    }
    b->nodetype = 'F';
    b->v1 = b1;
    b->v2 = b2;
    b->v3 = b3;
    a->nodetype = nodetype;
    a->cond = (Ast*)b;
    a->tl = tl;
    a->el = el;
    return (Ast *)a;
}

Ast * newstring(char *s) { /*Função de que cria uma string literal*/
    Strval *a = malloc(sizeof(Strval));
    if (!a) { perror("out of space"); exit(1); }
    a->nodetype = 'Q';
    a->s = strdup(s);
    return (Ast*)a;
}

// Função que cria um nó para testes
Ast * newcmp(int cmptype, Ast *l, Ast *r){
    Ast *a = (Ast*)malloc(sizeof(Ast));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = '0' + cmptype;
    a->l = l;
    a->r = r;
    return a;
}

// Função para um nó de atribuição
Ast * newasgn(char s[50], Ast *v) {
    Symasgn *a = (Symasgn*)malloc(sizeof(Symasgn));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = '=';
    strcpy(a->s,s);
    a->v = v;
    return (Ast *)a;
}

// Função para um nó de atribuição em vetor
Ast * newasgn_a(char s[50], Ast *v, int indice) {
    Symasgn *a = (Symasgn*)malloc(sizeof(Symasgn));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = '=';
    strcpy(a->s,s);
    a->v = v;
    a->pos = indice;
    return (Ast *)a;
}

// Função que recupera o nome/referência de uma variável
Ast * newValorVal(char s[]) {
    Varval *a = (Varval*) malloc(sizeof(Varval));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = 'N';
    strcpy(a->var,s);
    return (Ast*)a;
}

// Função que recupera o nome/referência de uma variável (vetor)
Ast * newValorVal_a(char s[], int indice) {
    Varval *a = (Varval*) malloc(sizeof(Varval));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = 'n';
    strcpy(a->var,s);
    a->size = indice;
    return (Ast*)a;
}

// Função que recupera o nome/referência de uma variável (string)
Ast * newValorValS(char s[50]) {
    Varval *a = (Varval*) malloc(sizeof(Varval));
    if(!a) {
        printf("out of space");
        exit(0);
    }
    a->nodetype = 'Q';
    strcpy(a->var,s);
    return (Ast*)a;
}

// Função que executa operações a partir de um nó (para string)
char * eval2(Ast *a) {
    VARI *aux1;
    char *v2;
    switch(a->nodetype) {
        case 'Q':
            aux1 = srch(l1,((Varval *)a)->var);
            return aux1->valors;
            break;
        default: printf("internal error: bad node %c\n", a->nodetype);
                break;
    }
    return v2;
}

// Função que executa operações a partir de um nó
double eval(Ast *a) {
    double v;
    char v1[50];
    char *v2;
    VARI *aux1;

    if (!a) {
        printf("internal error, null eval");
        return 0.0;
    }

    switch (a->nodetype) {
        case 'K': /* Recupera um número */
            v = ((Numval *)a)->number;
            break;

        case 'N':
            aux1 = srch(l1, ((Varval *)a)->var);
            v = aux1->valor;
            break;

        case 'n':
            aux1 = srch(l1, ((Varval *)a)->var);
            v = aux1->vet[((Varval *)a)->size];
            break;

        case '+': /* Operações "árv esq + árv dir" */
            v = eval(a->l) + eval(a->r);
            break;
        case '-': /* Operações */
            v = eval(a->l) - eval(a->r);
            break;
        case '*': /* Operações */
            v = eval(a->l) * eval(a->r);
            break;
        case '/': /* Operações */
            v = eval(a->l) / eval(a->r);
            break;
        case '^':
            v = pow(eval(a->l), eval(a->r));
            break;
        case 'M': /* Operações, número negativo */
            v = -eval(a->l);
            break;

        case '1': /* Operações lógicas. "árv esq > árv dir" Se verdade 1, falso 0 */
            v = (eval(a->l) > eval(a->r)) ? 1 : 0;
            break;
        case '2':
            v = (eval(a->l) < eval(a->r)) ? 1 : 0;
            break;
        case '3':
            v = (eval(a->l) != eval(a->r)) ? 1 : 0;
            break;
        case '4':
            v = (eval(a->l) == eval(a->r)) ? 1 : 0;
            break;
        case '5':
            v = (eval(a->l) >= eval(a->r)) ? 1 : 0;
            break;
        case '6':
            v = (eval(a->l) <= eval(a->r)) ? 1 : 0;
            break;

        case '=':
            v = eval(((Symasgn *)a)->v); /* Recupera o valor */
            aux = srch(l1, ((Symasgn *)a)->s);

            //printf ("AQUI %d\n",((Varval *)aux)->nodetype);

            if (aux->nodetype == 1) { //lembrar de verificar os demais tipos
                aux->valor = v;
                //printf ("%lf\n",v);
            } else {
                aux->vet[((Symasgn *)a)->pos] = v; //inserção no vetor
            }
            break;

        case 'I': /* CASO IF */
            if (eval(((Flow *)a)->cond) != 0) { /* executa a condição / teste */
                if (((Flow *)a)->tl) /* Se existir árvore */
                    v = eval(((Flow *)a)->tl); /* Verdade */
                else
                    v = 0.0;
            } else {
                if (((Flow *)a)->el) {
                    v = eval(((Flow *)a)->el); /* Falso */
                } else {
                    v = 0.0;
                }
            }
            break;

        case 'W':
            //printf ("WHILE\n");
            v = 0.0;
            if (((Flow *)a)->tl) {
                while (eval(((Flow *)a)->cond) != 0) {
                    v = eval(((Flow *)a)->tl);
                }
            }
            break;

        // case 'F': /* CASO FOR */
        //     v = 0.0; // Valor de retorno padrão
        //     // O nó 'a' é do tipo Flow. Seu campo 'cond' armazena a estrutura Flowfor.
        //     Flow *for_loop = (Flow *)a;
        //     Flowfor *for_parts = (Flowfor *)for_loop->cond;

        //     // 1. Executa a inicialização uma vez
        //     eval(for_parts->v1);

        //     // 2. Loop enquanto a condição (v2) for verdadeira
        //     while (eval(for_parts->v2) != 0) {
        //         // Executa o corpo do laço
        //         v = eval(for_loop->tl);
        //         // 3. Executa o incremento ao final de cada iteração
        //         eval(for_parts->v3);
        //     }
        //     break;
        case 'F':
            v = 0.0;
            if( ((Flow *)a)->tl ) {
                for(eval(((Flowfor*)((Flow *)a)->cond)->v1); 
                    eval(((Flowfor*)((Flow *)a)->cond)->v2); 
                    eval(((Flowfor*)((Flow *)a)->cond)->v3)
                    ){
                        v =  eval(((Flow *)a)->tl);
                }
            }
            break;


        case 'L': /* Lista de operções em um bloco IF/ELSE/WHILE. Assim o analisador não se perde entre os blocos */
            eval(a->l);
            v = eval(a->r);
            break;

// case 'L': ...

        case 'P': /* Função que imprime um valor (numérico ou string) */
            // Verifica o tipo do nó filho (a->l) antes de avaliar
            if (a->l->nodetype == 'Q') { // Se for uma string literal
                // O nó 'a->l' é do tipo Strval, criado pela função newstring
                printf("%s\n", ((Strval *)a->l)->s);
                v = 0.0; // Retorno padrão
            } else { // Senão, assume que é uma expressão numérica
                v = eval(a->l); /* Recupera um valor numérico */
                printf("%.2f\n", v);
            }
            break;

        case 'S':
            scanf("%lf", &v);
            aux1 = srch(l1, ((Varval *)a)->var);
            aux1->valor = v;
            break;

        case 'T':
            scanf("%s", v1);
            aux1 = srch(l1, ((Varval *)a)->var);
            strcpy(aux1->valors, v1);
            break;

        case 'Y':
            v2 = eval2(a->l); /* Recupera um valor STR */
            printf("%s\n", v2); /* Função que imprime um valor (string) */
            break;

        case 'V':
            l1 = ins(l1, ((Varval*)a)->var);
            break;
        case 'a':
            l1 = ins_a(l1, ((Varval*)a)->var, ((Varval*)a)->size);
            break;

        default:
            printf("internal error: bad node %c\n", a->nodetype);
            break;
    }
    return v;
}