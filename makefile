CC = gcc
FL = flex
BS = bison

CFLAGS = -Wall -g
SOURCES = ast.c

SRCFLEX = lex.l
SRCBISON = bison.y

OBJFLEX = lex.c
OBJBISON = bison.c

OUT = main
CODE = code.mag


compile:
	$(FL) -o src/$(OBJFLEX) src/$(SRCFLEX)
	$(BS) -o src/$(OBJBISON) src/$(SRCBISON)
	$(CC) src/$(OBJBISON) src/$(SOURCES) -o bin/$(OUT) -l fl -l m

clean:
	rm -f src/$(OBJFLEX) src/$(OBJBISON)


run: compile
	./bin/$(OUT) $(CODE)


flex:
	$(FL) -o src/$(OBJFLEX) src/$(SRCFLEX)

bison:
	$(BS) -o src/$(OBJBISON) src/$(SRCBISON)

gcc:
	$(CC) src/$(OBJBISON) -o bin/$(OUT) -l fl -l m