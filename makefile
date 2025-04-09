# code = code.mag

# all:
# 	flex main.l
# 	gcc lex.yy.c -o main -l fl

# run: all
# 	./main $(code)

# clean:
# 	rm -f src/lex.c

# Definições de variáveis
CC = gcc
FL = flex
CFLAGS = -Wall -g
SRC = main.l
OBJ = lex.c
OUT = main
CODE = code.mag


all:
	$(FL) -o src/$(OBJ) src/$(SRC)
	$(CC) src/$(OBJ) -o bin/$(OUT) -l fl

clean:
	rm -f src/$(OBJ)


run: all
	./bin/$(OUT) $(CODE)
