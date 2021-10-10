#
# cpmsim - emulates a Motorola 68K and Runs CP/M68K
#
# http://home.earthlink.net/~schultdw/cpm68/simulator.html
#
CC =     gcc
WARNINGS = -Wall
CFLAGS = $(WARNINGS) -g -O0 -c -Iobj -I.
#FLAGS = $(WARNINGS) -g -O2 -c -Iobj -I.
LFLAGS = $(WARNINGS)
FILES  = cpmsim.c sim.h m68k.h m68kconf.h obj/m68kops.h m68k.h m68kconf.h obj/m68kops.c  obj/m68kopac.c  obj/m68kopdm.c obj/m68kopnz.c
CHECK := for i in $(FILES); do ./check.sh $$i; done

all: obj cpmsim

clean:
	rm -f *.o *~ cpmsim
	rm -rf obj

obj:
	mkdir obj

check:
	@echo check for the missing
	@$(CHECK)

cpmsim: obj/cpmsim.o obj/m68kcpu.o obj/m68kops.o obj/m68kopac.o obj/m68kopdm.o obj/m68kopnz.o m68kdasm.o softfloat.o
	$(CC) $(LFLAGS) obj/sim.o obj/m68kcpu.o obj/m68kops.o obj/m68kopac.o obj/m68kopdm.o obj/m68kopnz.o m68kdasm.o softfloat.o -o cpmsim

softfloat.o: softfloat/softfloat.c softfloat/softfloat.h
	$(CC) $(CFLAGS) softfloat/softfloat.c -o softfloat.o

obj/cpmsim.o: cpmsim.c sim.h m68k.h m68kconf.h
	$(CC) $(CFLAGS) cpmsim.c -o obj/sim.o

obj/m68kcpu.o: sim.h obj/m68kops.h sim.h m68k.h m68kconf.h
	$(CC) $(CFLAGS) m68kcpu.c -o obj/m68kcpu.o

###
###
###
obj/m68kops.o: obj/m68kmake obj/m68kops.h obj/m68kops.c sim.h m68k.h m68kconf.h
	$(CC) $(CFLAGS) obj/m68kops.c -o obj/m68kops.o

obj/m68kopac.o: obj/m68kmake obj/m68kops.h obj/m68kopac.c sim.h m68k.h m68kconf.h
	$(CC) $(CFLAGS) obj/m68kopac.c -o obj/m68kopac.o

obj/m68kopdm.o: obj/m68kmake obj/m68kops.h obj/m68kopdm.c sim.h m68k.h m68kconf.h
	$(CC) $(CFLAGS) obj/m68kopdm.c -o obj/m68kopdm.o

obj/m68kopnz.o: obj/m68kmake obj/m68kops.h obj/m68kopnz.c sim.h m68k.h m68kconf.h
	$(CC) $(CFLAGS) obj/m68kopnz.c -o obj/m68kopnz.o

###
### m68make creates m68k_in.c, m68kops.h, & m68kops.c"
###
obj/m68kops.h: obj/m68kmake
	obj/m68kmake obj m68k_in.c

obj/m68kmake: m68kmake.c m68k_in.c
	$(CC) $(WARNINGS) m68kmake.c -o obj/m68kmake

m68kdasm.o: m68kdasm.c
	$(CC) $(CFLAGS) m68kdasm.c -o m68kdasm.o

###
### Not sure where these come from
###
obj/m68kopac.c:
	cp examples/m68kopac.c obj/

obj/m68kopdm.c:
	cp examples/m68kopdm.c obj/

obj/m68kopnz.c:
	cp examples/m68kopnz.c obj/
