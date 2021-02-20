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
all: testList1 testSearch1 testTime1
	echo "Compiling Files"

testList1: TestList.c
	$(CC) $(CFLAGS)  TestList.c LinkedLists.c -o TestList

testSearch1: TestSearch.c
	$(CC) $(CFLAGS) $(LFLAGS) TestSearch.c LinkedLists.c -o TestSearch

testTime1: TestTime.c
	$(CC) $(CFLAGS) $(LFLAGS) TestTime.c DynamicArrays.c LinkedLists.c -o TestTime

test: testList1	
	echo "Testing TestList"
	./TestList $(INPUTFILE) &> out.txt
	cat ./out.txt	

search: testSearch1
	echo "Testing TestSearch"
	./TestSearch $(INPUTFILE) $(SEARCHWORD) &> search.txt
	cat ./search.txt	

time: testTime1
	echo "Testing TestTime"
	./TestTime $(INPUTFILE) $(SEARCHWORD) &> time.txt
	cat ./time.txt	

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
