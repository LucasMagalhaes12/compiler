CC = gcc
FL = flex
CFLAGS = -Wall -g
SRC = main.l
OBJ = lex.c
OUT = main
CODE = code.mag


compile:
	$(FL) -o src/$(OBJ) src/$(SRC)
	$(CC) src/$(OBJ) -o bin/$(OUT) -l fl

clean:
	rm -f src/$(OBJ)


run: compile
	./bin/$(OUT) $(CODE)
