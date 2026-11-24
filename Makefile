# Makefile - binary_search
CXX      ?= g++
CXXFLAGS ?= -std=c++17 -Wall -Wextra -pedantic -O2

SRC    := src/binary_search.cpp
TARGET := bin/binary_search

.PHONY: all run test clean

all: $(TARGET)

$(TARGET): $(SRC) | bin
	$(CXX) $(CXXFLAGS) -o $@ $<

bin:
	mkdir -p bin

run: $(TARGET)
	./$(TARGET)

test: $(TARGET)
	bash tests/run_tests.sh $(TARGET)

clean:
	rm -rf bin
