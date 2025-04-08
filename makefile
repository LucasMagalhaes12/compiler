# code = code.mag

# all:
# 	flex main.l
# 	gcc lex.yy.c -o main -l fl

# run: all
# 	./main $(code)

# clean:
# 	rm -f lex.yy.c

# Definições de variáveis
CC = gcc
FL = flex
CFLAGS = -Wall -g
SRC = main.l
OBJ = lex.yy.c
OUT = main
CODE = code.mag


all:
	$(FL) $(SRC)
	$(CC) $(OBJ) -o $(OUT) -l fl

clean:
	rm -f $(OBJ) $(OUT)


run: all
	./$(OUT) $(CODE)
