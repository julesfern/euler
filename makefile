# Give the problem you want to run as an integer argument
# e.g. make run PROBLEM=35

CC=g++
CFLAGS=-c -Wall

LIBDIR=cpplib
BINDIR=bin

PROBLEM_SOURCE=problem-$(PROBLEM).cpp
LIB_SOURCES=primes.cpp
LIB_SOURCEPATHS=$(addprefix cpplib/,$(LIB_SOURCES))
OBJECTS=$(LIB_SOURCES:.cpp=.o)
EXECUTABLE=$(BINDIR)/problem-$(PROBLEM)

all: executable

executable: problem.o
	$(CC) helpers.o problem.o -o $(EXECUTABLE)

problem.o: helpers.o
	$(CC) $(CFLAGS) $(PROBLEM_SOURCE) -o problem.o

helpers.o:
	$(CC) $(CFLAGS) $(LIB_SOURCEPATHS) -o helpers.o

run: executable
	$(EXECUTABLE)

clean:
	rm -f *.o