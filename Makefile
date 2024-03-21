
CFLAGS ?= -O2 -g -Wall
LIBS += -lgdbm

CLANG_FORMAT = clang-format

.PHONY: all
all: debfile

debfile: debfile.o
	$(CC) $^ $(LIBS) -o $@

.PHONY: clean
clean:
	$(RM) debfile *.o

.PHONY: format
format: debfile.c
	$(CLANG_FORMAT) -i $<
