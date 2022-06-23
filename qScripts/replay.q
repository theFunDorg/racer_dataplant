/ USAGE::
/ q replay.q -inp oldLog -out newLog -sym MS

/ Take inputs to proc
inp:.Q.opt .z.x
oldLog:hsym `$inp.inp 0
newLog:hsym `$inp.out 0
sym:`$inp.sym 0

/ Create and open handle to new logfile
newLog set ();
h:hopen newLog;

/ Define upd function to be run by -11!
upd:{[tbl;data]
  {[t;d]
    if[(`trade=t) & (sym=first d 1);
    h enlist (`upd;`trade;d)];
  }[tbl;] each $[-1+count first data; flip data; enlist data];
 };

/ Run -11!, close handle to new logfile, exit process
-11!oldLog
hclose h
exit 0
