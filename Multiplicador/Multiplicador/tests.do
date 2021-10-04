restart;

force /clk 0 0ns, 1 4ns -r 8ns;
force /inicio 1 0ns;
force /reset 0 0ns;
force /entA 0011 0ns;
force /entB 0010 0ns;

run 110ns