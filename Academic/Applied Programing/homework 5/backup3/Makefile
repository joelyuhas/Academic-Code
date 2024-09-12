# Joel Yuhas
# Homework 1
# MakeFile


.SILENT:

# Output files
MEM = mem.txt
SOURCE = TestList.c TestSearch.c TestTime.c
PROG = TestSearch TestTime TestList
RESULTS = out.txt time.txt search.txt
INPUTFILE = ./us-eng-words.txt
SEARCHWORD = "space"
INPUTLINE = "-bisection -tol .000001 -ga -2 -gb -3 -verb"

# Compiler and Directives
CC      = gcc
CCPP     = g++
CFLAGS  = -Wall -std=c99 -pedantic
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
all: homework_5
	echo "Compiling Files"

homework_5: hw5.c rootfinding
	$(CC) $(CFLAGS)  hw5.c rootfinding.o -o hw5

rootfinding: rootfinding.c
	$(CC) $(CFLAGS) -c rootfinding.c

test: homework_5
	echo "Testing hw5.c"
	./hw5 -newton -tol 1E-6 -ba -1.5 #&> out.txt
	#cat ./out.txt		

mem: testList1 testSearch1
	echo "running Valgrind on TestList, TestSearch"
	
	valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./TestList $(INPUTFILE) &> mem.txt
	valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./TestSearch $(INPUTFILE) $(SEARCHWORD) &>> mem.txt
	#valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./TestTime $(INPUTFILE) $(WORD) &>> mem.txt

	
	
	echo "Results are:"
	@cat mem.txt


help:
	echo ""
	echo "Help Menu:"
	echo ""
	echo "	all    - compiles the c file, cpp file and the optomized file"
	echo "	test   - runs the test program with a pre-set input file specified in the Makefile"
	echo "	search - runs the test program with a pre-set input and searches for selected word"
	echo "	time   - same as search but records time and evaluates performance"
	echo "	mem    - perfoms valgrind operation"
	echo "	help   - displays this help window"
	echo "	clean  - cleans all .o files, executable files and output files"
	echo ""

clean:
	echo "Cleaning"
	-rm -f $(PROG)
	-rm -f $(RESULTS);
	-rm -f *.o
