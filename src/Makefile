# Generated automatically from Makefile.in by configure.
CC = gcc
CFLAGS = -O2
AIXFLAGS = -bmaxdata:0x80000000
DEBUGS = -DDEBUG_FACILITIES -DDEBUG_PRINTF -DDEBUG_MALLOC -DSTRICT_VCD_ONLY -DDEBUG_MALLOC_LINES

SRCS = vcd.c debug.c main.c misc.c bsearch.c globals.c

OBJS = vcd.o debug.o main.o misc.o bsearch.o globals.o

vcddiff:$(OBJS)
	$(CC) $(CFLAGS) `gtk-config --libs` $(OBJS) -o vcddiff

.c.o:	$(H_FILES)
	$(CC) $(CFLAGS) `gtk-config --cflags` -c -o $@ $<

clean: 
	rm -f core *.core *.o vcddiff
