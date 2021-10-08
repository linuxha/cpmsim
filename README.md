# cpmsim
Originally referenced as http://home.earthlink.net/~schultdw/cpm68/simulator.html (now 404)

This simple CP/M-68K simulator, is built around the famous Musashi MC68000 simulator core.  So it’s a little more well debugged than the SIMH CP/M-68k. Namely that COM works!

## Required files to run cpmsim

- cpmsim
- cpm400.bin
- simbios.bin

I'm assuming that it is in the immediate directory where it is run. I may fix that up later.

## Command line options

```
sta:b:c:d:e:f:g:h:i:j:k:l:n:o:p:
-s
-t
-a thru -p (CPM drives) <filename> # Where filename is the CPM disk and -n is the drive letter <n> (a thru p)

diskc.cpm.fs is drive C but contains files in User 0 - 15
```

```
# Start cpmsim with diskc.cpm.fs as drive C: (0-15 User dirs)
./cpmsim -c diskc.cpm.fs -s

;
; To exit back to Linux, type bbye
;
```

## Notes

This cpmsim has the the following added to cpmsim.c (line before m68k_pulse_reset();)
```
m68k_init()
m68k_set_cpu_type(M68K_CPU_TYPE_68000)
```
So this version no longer fails with SIGSEGV.
