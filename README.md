# Linguagem mag

## Introdução

Este projeto apresenta a linguagem de programação "mag", um compilador desenvolvido utilizando **Flex** para a análise lexical (`lex.l`) e **Bison** para a análise sintática (`bison.y`). O objetivo deste README é guiá-lo através do processo de compilação e execução de programas `mag` utilizando o `makefile` fornecido.

## Funcionalidades da Linguagem mag

A linguagem `mag` suporta as seguintes funcionalidades principais:

* **Comentários**: Suporte a comentários de linha única (iniciados com `@`) e de múltiplas linhas (entre `/* ... */`).
* **Entrada e Saída**: Funções `out()` para exibir dados e `in()` para ler entrada do usuário.
* **Variáveis**: Declaração (`var`) e atribuição de valores a variáveis.
* **Vetores**: Suporte para declaração e acesso a elementos de vetores (ex: `var vetor[20]`).
<<<<<<< HEAD
=======
* **Operadores Aritméticos**: Suporte para operações matemáticas básicas:
    * Adição (`+`)
    * Subtração (`-`)
    * Multiplicação (`*`)
    * Divisão (`/`)
    * Potenciação (`^`)
>>>>>>> 929b6cc075114ef6e8ea86671eceae7caa8ef5b4
* **Controle de Fluxo**:
    * Condicionais: `when (condição) { ... }` (equivalente a `if`) e `otherwise { ... }` (equivalente a `else`).
    * Laços de Repetição: `repeate_while (condição) { ... }` (equivalente a `while`).

Um exemplo de uso dessas funcionalidades pode ser encontrado no arquivo `test.mag`.

## Estrutura do Projeto

O projeto é organizado da seguinte forma:

* `src/`: Contém os arquivos fonte do compilador:
    * `lex.l`: Definições do analisador lexical (Flex).
    * `bison.y`: Definições do analisador sintático (Bison).
    * `ast.c`: Implementação da Árvore de Sintaxe Abstrata (AST).
    * `lex.c`: Arquivo C gerado pelo Flex a partir de `lex.l`.
    * `bison.c`: Arquivo C gerado pelo Bison a partir de `bison.y`.
* `bin/`: Diretório onde o executável compilado (`main`) será colocado.
* `code.mag`: Um arquivo de exemplo de programa `mag`.
* `test.mag`: Um arquivo de teste da linguagem `mag` com diversas funcionalidades.
* `makefile`: O arquivo principal para automatizar a compilação e execução.

## Compilação e Execução com o `makefile`

O `makefile` é o método preferencial e mais fácil para construir e executar o compilador da linguagem `mag`.

### Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas em seu sistema:

* **GCC**: O compilador C (`gcc`).
* **Flex**: Gerador de analisadores lexicais (`flex`).
* **Bison**: Gerador de analisadores sintáticos (`bison`).

### Comandos do `makefile`

Navegue até o diretório raiz do projeto no seu terminal.

1.  **Compilar o Projeto Completo**:
    Para compilar todo o projeto, gerando os arquivos de código-fonte (`lex.c`, `bison.c`) e o executável final, use:
    ```bash
    make compile
    ```
    Este comando executa as seguintes etapas na ordem correta:
    * Gera `src/lex.c` a partir de `src/lex.l` usando Flex.
    * Gera `src/bison.c` a partir de `src/bison.y` usando Bison.
    * Compila `src/bison.c` e `src/ast.c` (se `ast.c` for o único `SOURCES` definido) usando `gcc`, linkando com as bibliotecas `flex` (`-lfl`) e `math` (`-lm`).
    * Cria o executável `main` no diretório `bin/`.

2.  **Executar um Programa `mag`**:
    Para compilar o projeto (se ainda não estiver compilado) e, em seguida, executar o arquivo `code.mag`, utilize:
    ```bash
    make run
    ```
    Isso executará o comando `./bin/main code.mag`.

    Para executar um arquivo `mag` específico (por exemplo, `test.mag`), você pode fazer isso manualmente após a compilação:
    ```bash
    ./bin/main test.mag
    ```

3.  **Compilação Individual de Componentes**:
    O `makefile` também permite compilar partes específicas do projeto:
    * **Apenas Flex (Analisador Lexical)**:
        ```bash
        make flex
        ```
        Gera `src/lex.c` a partir de `src/lex.l`.
    * **Apenas Bison (Analisador Sintático)**:
        ```bash
        make bison
        ```
        Gera `src/bison.c` a partir de `src/bison.y`.
    * **Apenas GCC (Compilação do Código C)**:
        ```bash
        make gcc
        ```
        Compila `src/bison.c` e outros fontes C para criar o executável `main`. Note que este comando assume que `lex.c` e `bison.c` já foram gerados.

4.  **Limpar o Projeto**:
    Para remover os arquivos gerados durante a compilação (como `lex.c` e `bison.c`), use:
    ```bash
    make clean
    ```

---
