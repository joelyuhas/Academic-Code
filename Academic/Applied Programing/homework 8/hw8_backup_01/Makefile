# Joel Yuhas
# Homework 7
# MakeFile


.SILENT:

# Output files
MEM = mem.txt
SOURCE = hw7.txt apmatrix.c gsl_test.c
PROG = myplot correction hw8
RESULTS = data.txt alldata.txt correction.txt realdevice.txt mem.txt
#INPUTFILE = ./polynomials.txt
#SEARCHWORD = "space"
VERBOSE = 

# Compiler and Directives
CC      = gcc
#CCPP     = g++
#CFLAGS  = -Wall -std=c99 -pedantic -lm
CFLAGS  = -ansi -g -lgsl -lgslcblas
PFLAGS  = -g -lgsl -lgslcblas
#CPPFLAGS = -Wall -pedantic 
LFLAGS  = -DEN_TIME
DFLAGS = -DHW8
#MFLAGS  = -DMDEBUG



# Build list of OBJ files
OBJS = $(patsubst %.c, %.o, $(SOURCE))



.c.o: echo "compile $<"
	$(CC) $(CFLAGS) -c $<


#testList testTime
all: homework_8 correction_c myplot_c
	echo "Compiling Files"

homework_8: hw8.c
	$(CC) $(CFLAGS) $(DFLAGS) hw8.c DynamicArrays.c -o hw8

correction_c: correction.c
	$(CC) $(CFLAGS) correction.c -o correction

myplot_c: myplot.c
	$(CC) $(PFLAGS) myplot.c -o myplot



base: realDevice detError homework_8
	./realDevice | ./detError


correct: correction_c detError homework_8
	./realDevice | ./correction | ./detError
	

test: homework_8 realDevice diffVal
	./realDevice | ./diffVal > data.txt
	./hw8 -ge -o 8 -p data.txt $(VERBOSE)


plot: realDevice homework_8 correction_c myplot_c
	./realDevice > realdevice.txt
	./realDevice | ./correction > correction.txt
	paste realdevice.txt correction.txt > alldata.txt
	
	./myplot -i alldata.txt -o alldata.png
	
	#./realDevice | ./diffVal > data.txt
	#./hw8 -ge -o 8 -p data.txt $(VERBOSE)



mem: homework_8
	echo "running Valgrind on Homework 8"

	./realDevice | ./diffVal > data.txt
	valgrind --tool=memcheck --leak-check=yes --track-origins=yes ./hw8 -ge -o 3 -p data.txt &> mem.txt
	
	echo "Results are:"
	@cat mem.txt

help:
	echo ""
	echo "Help Menu:"
	echo ""
	echo "	all     - compiles all files"
	echo "	base    - calculates error with realDevice"
	echo "	correct - calculates error with correction"
	echo "	plot    - performs plot"
	echo "	test    - runs hw8 driver"
	echo "	mem     - perfoms valgrind operation with hw8 driver"
	echo "	help    - displays this help window"
	echo "	clean   - cleans all .o files, executable files and output files"
	echo ""

clean:
	echo "Cleaning"
	-rm -f $(PROG)
	-rm -f $(RESULTS);
	-rm -f *.o
