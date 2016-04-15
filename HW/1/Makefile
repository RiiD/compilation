all: flex bison
	gcc *.c -o hw

flex:
	flex *.lex

bison:
	bison -d *.y

clear:
	rm *.c
