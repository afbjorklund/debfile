prefix = /usr

CFLAGS ?= -O2 -g -Wall
LIBS += -lgdbm

CLANG_FORMAT = clang-format

.PHONY: all
all: debfile

debfile: debfile.o
	$(CC) $^ $(LIBS) -o $@

.PHONY: install
install: debfile
	install -d $(DESTDIR)$(prefix)/bin
	install $< $(DESTDIR)$(prefix)/bin
	install -d $(DESTDIR)$(prefix)/share/dlocate
	install convertdb.pl $(DESTDIR)$(prefix)/share/dlocate/convertdb

.PHONY: clean
clean:
	$(RM) debfile *.o

.PHONY: format
format: debfile.c
	$(CLANG_FORMAT) -i $<
