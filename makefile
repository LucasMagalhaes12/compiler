all:
	flex main.l
	gcc lex.yy.c -o main -l fl

run: all
	./main

clean:
	rm -f lex.yy.c
