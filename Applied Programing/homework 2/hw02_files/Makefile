# Joel Yuhas
# Homework 1
# MakeFile


.SILENT:

# Output files
MEM = mem.txt
SOURCE = val.c QuadraticSolver.c
PROG = qs val
RESULTS = out.txt

# Compiler and Directives
CC     = gcc
CFLAGS = -Wall -std=c99 -O1 -pedantic -g
LFLAGS = -lm

# Build list of OBJ files
OBJS = $(patsubst %.c, %.o, $(SOURCE))



.c.o: echo "compile $<"
	$(CC) $(CFLAGS) -c $<



all: val qs
	echo "Compiling Files"

val: val.c
	$(CC) $(CFLAGS) $(LFLAGS) val.c -o val

qs: QuadraticSolver.c
	$(CC) $(CFLAGS) $(LFLAGS) QuadraticSolver.c -o qs


test: qs
	echo "Testing QuadraticSolver"
	./qs 2 2392.2 -766267.2 > $(RESULTS)
	./qs 1 -1 1 >> $(RESULTS)
	./qs 0 1 -10 >> $(RESULTS)
	echo "Results are:"
	@cat $(RESULTS)

mem1: qs
	echo "Running Valgrind test on qs"
	valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./qs 1 2 4 &> mem.txt
	echo "Results are:"
	@cat mem.txt

mem2: val
	echo "Running Valgrind test on val"
	valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./val &> mem.txt
	echo "Results are:"
	@cat mem.txt


help:
	echo ""
	echo "Help Menu:"
	echo ""
	echo "	all   - compiles QuadraticSolver.c and val.c"
	echo "	test  - runs the qs program with 3 test cases"
	echo "	mem1  - runs valgrind on qs and saves output into mem.txt (overwrites old mem.txt)"
	echo "	mem2  - runs valgrind on val and saves output into mem.txt (overwites old mem.txt)"
	echo "	help  - displays this help window"
	echo "	clean - cleans all .o files, executable files"
	echo ""

clean:
	echo "Cleaning"
	-rm -f $(PROG)
	-rm -f *.o
