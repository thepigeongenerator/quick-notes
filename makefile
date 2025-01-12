NAME := quick-notes

# compiler settings
CC := clang
CFLAGS = $(shell pkg-config --cflags gtk+-3.0) -Wall -g
LDFLAGS = $(shell pkg-config --libs gtk+-3.0) -lm

# file locations
DIR_BIN := bin
DIR_OBJ := obj
SRC = $(wildcard src/*.c) $(wildcard src/**/*.c) $(wildcard src/**/**/*.c) $(wildcard src/**/**/**/*.c) $(wildcard src/**/**/**/**/*.c)
OBJ = $(patsubst src/%,$(DIR_OBJ)/%,$(SRC:.c=.o))
TARGET = $(DIR_BIN)/$(NAME)

all: clean dirs build

clean:
	rm -rf $(DIR_BIN) $(DIR_OBJ)

# creates the binary
build: $(OBJ)
	$(CC) -o $(TARGET) $^ $(CFLAGS) $(LDFLAGS)

# creates the object files, include a flag for no unused command line arguments, because in this context it's unneeded
$(DIR_OBJ)/%.o: src/%.c
	mkdir -p $(dir $@)
	$(CC) -o $@ -c $< $(CFLAGS) $(LDFLAGS) -Wno-unused-command-line-argument

dirs:
	mkdir -p $(DIR_BIN)
	mkdir -p $(DIR_OBJ)
