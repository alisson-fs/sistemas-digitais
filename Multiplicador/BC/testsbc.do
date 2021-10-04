restart;

force /clk 0 0ns, 1 10ns -r 20ns;
force /Reset 0 0ns, 1 180ns;
force /inicio 0 0ns, 1 20ns;
force /Az 0 0ns, 1 125ns;
force /Bz 0 0ns, 1 125ns;

run 200ns;