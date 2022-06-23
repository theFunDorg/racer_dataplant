/ USAGE::
/ q eodProc.q -log logfile -dir /home/sean/TEST -tbls sym

/ Take inputs to proc
inp:.Q.opt .z.x;
dir:hsym `$inp.dir 0;
logfile:hsym `$inp.log 0;
tbls:first inp.tbls;

/ Load table schemas
system "l tick/",tbls,".q";

upd:{if[x=t;x insert y];};

/ Define writedown function to replay logfiles and set down as partitioned tables
writedown:{[tbl;dbdir]
  t::tbl;
  -11!logfile;
  tblDir:` sv dbdir,(`$string .z.d),tbl,`;
  colCompr:``sym`time!((17;2;6);(12;0;0);(12;0;0));
  (tblDir;colCompr) set .Q.en[dbdir] get tbl;
  delete from tbl;
  };

/ Run writedown for each table that was loaded from sym file
writedown[;dir] each tables[];

/ Exit script
// exit 0