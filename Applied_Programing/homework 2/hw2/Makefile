# Joel Yuhas
# Homework 1
# MakeFile


.SILENT:

# Output files
MEM = mem.txt
SOURCE = TestDarray.c
PROG = TestD
RESULTS = out.txt
INPUTFILE = ./us-eng-words.txt

# Compiler and Directives
CC     = gcc
CFLAGS = -Wall -std=c99 -O1 -pedantic -g
LFLAGS = -lm

# Build list of OBJ files
OBJS = $(patsubst %.c, %.o, $(SOURCE))



.c.o: echo "compile $<"
	$(CC) $(CFLAGS) -c $<



all: TestD
	echo "Compiling Files"

TestD: TestDarray_hw.c
	$(CC) $(CFLAGS) $(LFLAGS) TestDarray_hw.c DynamicArrays.c -o TestD



test: TestD
	echo "Testing TestD"
	./TestD $(INPUTFILE) > $(RESULTS)
	echo "Results are:"
	@cat $(RESULTS)

mem: TestD
	echo "Running Valgrind test on TestD"
	valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./TestD $(INPUTFILE) &> mem.txt
	echo "Results are:"
	@cat mem.txt

help:
	echo ""
	echo "Help Menu:"
	echo ""
	echo "	all   - compiles DynamicArrays.c and TestDarray_hw.c into TestD"
	echo "	test  - runs the test program with a pre-set input file specified in the Makefile"
	echo "	mem1  - runs valgrind on qs and saves output into mem.txt (overwrites old mem.txt)"
	echo "	help  - displays this help window"
	echo "	clean - cleans all .o files, executable files"
	echo ""

clean:
	echo "Cleaning"
	-rm -f $(PROG)
	-rm -f *.o
