# note: bison and flex think they are  generating C files  but here all files
# are compiled with g++ (the C++ compiler)
build_dir = build
objects = ast.tab.o lex.yy.o gen.o symtab.o ast.o

myprog.exe: $(objects) ${build_dir}
	g++ -o ${build_dir}/myprog.exe $(objects)

ast.tab.o : ast.tab.c ast.h gen.h symtab.h
	g++ -g -c ast.tab.c

${build_dir}:
	mkdir ${build_dir} -p

lex.yy.o : lex.yy.c ast.tab.h ast.h gen.h
	g++ -g -c lex.yy.c

gen.o : gen.cpp ast.h gen.h
	g++ -g -c gen.cpp

symtab.o : symtab.cpp symtab.h gen.h
	g++ -g -c symtab.cpp

ast.o: ast.cpp gen.h symtab.h ast.h
	g++ -g -c ast.cpp

ast.tab.c: ast.y
	bison -d ast.y

ast.tab.h : ast.y
	bison -d ast.y

lex.yy.c : ast.lex
	flex ast.lex

clean :
	rm $(objects) ${build_dir}/* lex.yy.c ast.tab.h ast.tab.c
