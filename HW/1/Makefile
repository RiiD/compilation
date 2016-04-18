all: flex bison
	gcc *.c -o hw

flex:
	flex *.lex

bison:
	bison -d *.y

clean:
	@rm *.c -rf
	@rm *.h -rf
