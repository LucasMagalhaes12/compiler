Linguagem mag
Introdução
Mag é uma linguagem de programação personalizada desenvolvida usando Flex para análise lexical e Bison para análise sintática. Este repositório contém o código-fonte do compilador da linguagem mag, permitindo compilar e executar programas mag.

Funcionalidades
A linguagem mag suporta as seguintes funcionalidades, como demonstrado em 

test.mag:

Comentários:

Comentários de linha única começando com 

@.

Comentários de várias linhas entre 

/* ... */.


Saída: A função out() para imprimir valores no console.


Declaração de Variáveis: Declaração de variáveis usando a palavra-chave var.


Atribuição de Variáveis: Atribuição de valores a variáveis.


Entrada: A função in() para ler a entrada do usuário em variáveis.


Vetores: Declaração e manipulação de vetores, por exemplo, var vetor[20].

Declarações Condicionais:


when (condição) { ... }: Equivalente a uma declaração if.


otherwise { ... }: Equivalente a uma declaração else.

Laços de Repetição:


repeate_while (condição) { ... }: Equivalente a um laço while.

Estrutura do Projeto
O projeto está organizado da seguinte forma:

src/: Contém o código-fonte para os componentes do compilador:


lex.l: O arquivo fonte do Flex (analisador lexical).


bison.y: O arquivo fonte do Bison (gerador de parser).


ast.c: Implementação da Árvore de Sintaxe Abstrata (AST) (mencionado em makefile.txt como um arquivo fonte).


lex.c: Analisador lexical gerado (após executar o Flex).


bison.c: Parser gerado (após executar o Bison).


bin/: Conterá o executável compilado para a linguagem mag.


code.mag: Um arquivo de programa mag padrão usado pelo comando run no makefile.


test.mag: Um exemplo de programa mag demonstrando as funcionalidades da linguagem.


makefile: Contém regras para construir, limpar e executar o compilador.

Construindo o Compilador
O projeto usa um makefile para automatizar o processo de construção. Para compilar o compilador da linguagem mag, navegue até o diretório raiz do projeto e execute:

Bash

make compile
Este comando executará os seguintes passos:

Gerará 

src/lex.c a partir de src/lex.l usando Flex.

Gerará 

src/bison.c a partir de src/bison.y usando Bison.

Compilará 

src/bison.c, src/ast.c (e potencialmente outras fontes se adicionadas a SOURCES no makefile) usando GCC, linkando com as bibliotecas fl (biblioteca Flex) e m (biblioteca matemática).

Criará o executável 

main no diretório bin/.

Passos de Construção Individuais
Você também pode executar passos de construção individuais, se necessário:

Flex (Geração do Analisador Lexical):

Bash

make flex
Isso gerará 

src/lex.c a partir de src/lex.l.

Bison (Geração do Parser):

Bash

make bison
Isso gerará 

src/bison.c a partir de src/bison.y.

GCC (Compilação):

Bash

make gcc
Isso compilará 

src/bison.c (e src/ast.c se SOURCES for definido) no executável bin/main, linkando com as bibliotecas necessárias.

Executando um Programa mag
Para compilar e executar o programa code.mag padrão (ou qualquer outro programa especificado pela variável CODE no makefile), use:

Bash

make run
Este comando primeiro chama 

make compile para garantir que o compilador esteja construído e, em seguida, executa o programa main compilado com code.mag como argumento.

Para executar um arquivo .mag diferente, você normalmente executaria o binário compilado diretamente, por exemplo:

Bash

./bin/main test.mag
Limpando o Projeto
Para remover arquivos objeto e executáveis gerados, execute:

Bash

make clean
Este comando apagará os arquivos 

lex.c e bison.c (referidos como OBJFLEX e OBJBISON no makefile) do diretório src/.
