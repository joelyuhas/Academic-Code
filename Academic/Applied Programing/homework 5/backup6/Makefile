# Joel Yuhas
# Homework 1
# MakeFile


.SILENT:

# Output files
MEM = mem.txt
SOURCE = hw5.c rootfinding.c
PROG = TestSearch TestTime TestList
RESULTS = out.txt time.txt search.txt
INPUTFILE = ./us-eng-words.txt
SEARCHWORD = "space"
INPUTLINE = "-bisection -tol .000001 -ga -2 -gb -3 -verb"

# Compiler and Directives
CC      = gcc
CCPP     = g++
CFLAGS  = -Wall -std=c99 -pedantic -lm -O1
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
	$(CC) $(CFLAGS)   hw5.c rootfinding.o -o hw5

intTest_c: intTest.c rootfinding
	$(CC) $(CFLAGS) $(LFLAGS) intTest.c rootfinding.o -o intTest

rootfinding: rootfinding.c
	$(CC) $(CFLAGS) -c rootfinding.c

bisection: homework_5
	echo "-------------------------------------------------" > out.txt
	echo "Testing Bisection Method [-2.5, 2.5]" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -b -t 1E-6 -ga-2.5 -gb 2.5 -v &>> out.txt

	cat ./out.txt

secant: homework_5
	echo "-------------------------------------------------" > out.txt
	echo "Testing Secant Method -1.5 and 2.0" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -s -tol 1E-6 -ba -1.5 -bb 2.0  -v&>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Testing Secant Method 1.5 and 5"  >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -s -tol 1E-6 -ba 1.5 -bb 5  -v&>> out.txt

	cat ./out.txt

newton: homework_5
	echo "-------------------------------------------------" > out.txt
	echo "Testing Newton Method -1.5"  >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -n -tol 1E-6 -ba -1.5 &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Testing Newton Method 1.5" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -n -tol 1E-6 -ba 1.5  &>> out.txt

	cat ./out.txt

integer: intTest_c
	echo "-------------------------------------------------" > out.txt
	echo "Testing initTest.c"  >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./intTest &>> out.txt

	cat ./out.txt


test: homework_5
	echo "-------------------------------------------------" > out.txt
	echo "Testing Bisection Method [-2.5, 2.5]" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -b -t 1E-6 -ga -2.5 -gb 2.5 -v &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Testing Secant Method -1.5 and 2.0" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -s -tol 1E-6 -ba -1.5 -bb 2.0 -v &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Testing Secant Method 1.5 and 5"  >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -s -tol 1E-6 -ba 1.5 -bb 5 -v &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Testing Newton Method -1.5"  >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -n -tol 1E-6 -ba -1.5 -v &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Testing Newton Method 1.5" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -n -tol 1E-6 -ba 1.5 -v &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Testing initTest.c"  >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./intTest &>> out.txt

	cat ./out.txt	
	

opts: homework_5
	echo "-------------------------------------------------" > out.txt
	echo "Running: -b -tol 1E-6 -ga -2.5 -gb 3 -verb" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -b -tol 1E-6 -ga -2.5 -gb 3 -verb &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Running: -b -t 1E-6 -g -2.5 -u 3 -verb" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -b -t 1E-6 -g -2.5 -u 3 -verb &>> out.txt
	echo "-------------------------------------------------" >> out.txt
	echo "Running: -b -t 1E-6 -ba -2.5 -bb 3 -verb" >> out.txt
	echo "-------------------------------------------------" >> out.txt
	./hw5 -b -t 1E-6 -ba -2.5 -bb 3 -verb &>> out.txt

	cat ./out.txt	

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
