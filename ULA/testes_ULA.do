restart
force -freeze A 0001 0 ns, 0100 60 ns;
force -freeze B 1111 0 ns, 0101 60 ns;
force -freeze ULAop 00 0 ns, 01 20 ns, 10 40 ns;
run 80 ns
