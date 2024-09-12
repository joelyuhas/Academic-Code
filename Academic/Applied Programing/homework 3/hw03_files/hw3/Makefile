# Joel Yuhas
# Homework 1
# MakeFile


.SILENT:

# Output files
MEM = mem.txt
SOURCE = hw3t.cpp hw3t.c hw3opt.c
PROG = hw3t_c hw3t_cpp hw3opt
RESULTS = out.txt ls1.txt size1.txt ls2.txt size2.txt
INPUTFILE = ./data.txt

# Compiler and Directives
CC      = gcc
CCPP     = g++
CFLAGS  = -Wall -std=c99 -O0 -pedantic
CPPFLAGS = -Wall -pedantic 
LFLAGS  = -DEN_TIME
LSOUT = ls2.txt
SIZEOUT = size2.txt

# Build list of OBJ files
OBJS = $(patsubst %.c, %.o, $(SOURCE))



.c.o: echo "compile $<"
	$(CC) $(CFLAGS) -c $<



all: hwcpp hwc hwopt
	echo "Compiling Files"

hwcpp: hw3t.cpp
	$(CCPP) $(CPPFLAGS) $(LFLAGS) hw3t.cpp -o hw3t_cpp

hwc: hw3t.c
	$(CC) $(CFLAGS) $(LFLAGS) hw3t.c -o hw3t_c

hwopt: hw3opt.c
	$(CC) $(CFLAGS) $(LFLAGS) hw3opt.c -o hw3opt

test: hwcpp hwc hwopt	
	echo "Testing hw3t_c"
	echo " " >> out.txt
	echo " " >> out.txt
	echo "------------------------TEST RUN---------------------------" >> out.txt
	echo "**Results for hw3t_c**" >> out.txt
	./hw3t_c $(INPUTFILE) &>> out.txt
	
	
	echo "Testing hw3t_cpp"
	echo " " >> out.txt
	echo "**Results for hw3t_cpp**" >> out.txt
	./hw3t_cpp $(INPUTFILE) &>> out.txt	
	
	echo "Testing hw3opt"
	echo " " >> out.txt
	echo "***Testing hw3opt Final***" >> out.txt
	./hw3opt $(INPUTFILE) &>> out.txt
	echo " " >> out.txt
	echo " " >> out.txt	
	
	echo "Results are:"
	echo "----------------------------------------------------------" >> out.txt
	@cat out.txt
	
	ls -l > $(LSOUT)
	
	echo "hw3t_c size -A: " >> $(SIZEOUT)
	size -A hw3t_c >> $(SIZEOUT)
	echo " " >> $(SIZEOUT)
	
	echo "hw3t_cpp size -A: " >> $(SIZEOUT)
	size -A hw3t_cpp >> $(SIZEOUT)
	echo " " >> $(SIZEOUT)
	
	echo "hw3opt size -A: " >> $(SIZEOUT)
	size -A hw3opt >> $(SIZEOUT)
	echo " " >> $(SIZEOUT)

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
	-rm -f $(RESULTS);
	-rm -f *.o
