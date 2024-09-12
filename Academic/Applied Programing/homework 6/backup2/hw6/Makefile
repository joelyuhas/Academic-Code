# Joel Yuhas
# Homework 1
# MakeFile


.SILENT:

# Output files
MEM = mem.txt
SOURCE = poly.c hw6.c
PROG = hw6
RESULTS = out.txt mem.txt
INPUTFILE = ./simple.txt
SEARCHWORD = "space"
VERBOSE = ""

# Compiler and Directives
CC      = gcc
CCPP     = g++
CFLAGS  = -Wall -std=c99 -pedantic -lm
CPPFLAGS = -Wall -pedantic 
LFLAGS  = -DEN_TIME
MFLAGS  = -DMDEBUG
LSOUT = ls2.txt
SIZEOUT = size2.txt


# Build list of OBJ files
OBJS = $(patsubst %.c, %.o, $(SOURCE))



.c.o: echo "compile $<"
	$(CC) $(CFLAGS) -c $<


#testList testTime
all: homework_6
	echo "Compiling Files"

homework_6: hw6.c poly
	$(CC) $(CFLAGS)  hw6.c poly.o -o hw6

poly: poly.c
	$(CC) $(CFLAGS) -c poly.c

roots: homework_6
	echo "Testing Roots"
	./hw6 -input $(INPUTFILE)  &> out.txt
	cat ./out.txt

mem: homework_6
	echo "running Valgrind on TestList, TestSearch"
	
	valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./hw6 -input $(INPUTFILE) &> mem.txt
	
	echo "Results are:"
	@cat mem.txt

help:
	echo ""
	echo "Help Menu:"
	echo ""
	echo "	all    - compiles the c file, cpp file and the optomized file"
	echo "	root   - runs the test program with a pre-set input file specified in the Makefile"
	echo "	mem    - perfoms valgrind operation"
	echo "	help   - displays this help window"
	echo "	clean  - cleans all .o files, executable files and output files"
	echo ""

clean:
	echo "Cleaning"
	-rm -f $(PROG)
	-rm -f $(RESULTS);
	-rm -f *.o
