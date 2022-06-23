/ q tick.q sym . -p 5001 </dev/null >foo 2>&1 &
/2014.03.12 remove license check
/2013.09.05 warn on corrupt log
/2013.08.14 allow <endofday> when -u is set
/2012.11.09 use timestamp type rather than time. -19h/"t"/.z.Z -> -16h/"n"/.z.P
/2011.02.10 i->i,j to avoid duplicate data if subscription whilst data in buffer
/2009.07.30 ts day (and "d"$a instead of floor a)
/2008.09.09 .k -> .q, 2.4
/2008.02.03 tick/r.k allow no log
/2007.09.03 check one day flip
/2006.10.18 check type?
/2006.07.24 pub then log
/2006.02.09 fix(2005.11.28) .z.ts end-of-day
/2006.01.05 @[;`sym;`g#] in tick.k load
/2005.12.21 tick/r.k reset `g#sym
/2005.12.11 feed can send .u.endofday
/2005.11.28 zero-end-of-day
/2005.10.28 allow`time on incoming
/2005.10.10 zero latency
"kdb+tick 2.8 2014.03.12"

/q tick.q SRC [DST] [-p 5010] [-o h]

.lg.info:{show "[",(string .z.P),"] - ",x};

/ Take inputs to proc
.inp:.Q.opt .z.x;
.inp.tbls:first .inp.tbls;
.inp.lgdir:first .inp.lgdir;
.inp.qDir:getenv `QDIR;
.lg.info"Loaded input vars";

system"l ",.inp.qDir,"tick/",.inp.tbls,".q";
system"l ",.inp.qDir,"tick/u.q";
.lg.info"Finished loading  support scripts";

\d .u
ld:{
  if[not type key L::`$(-10_string L),string x;
    .[L;();:;()]];
  i::j::-11!(-2;L);
  if[0<=type i;-2 (string L)," is a corrupt log. Truncate to length ",(string last i)," and restart";exit 1];
  hopen L};

tick:{
    init[];
    if[not min(`time`sym~2#key flip value@)each t;'`timesym];
    @[;`sym;`g#]each t;
    d::.z.D;
    if[l::count y;
       L::`$":",y,"/",x,10#".";
       l::ld d]
    };

endofday:{end d;d+:1;if[l;hclose l;l::0(`.u.ld;d)]};

ts:{
   if[d<x;
     if[d<x-1;
        system"t 0";
        '"more than one day?"];
   endofday[]]};

.z.ts:{
  ts .z.D;
  if[.z.p>=t60;
    `.u.T60 insert ( .z.p,(get w),(get T) );
	t60:: .z.p+`minute$1];
 };

t60:.z.p;
system"t 1000";

upd:{[t;x]
  ts"d"$a:.z.P;
  if[not -16=type first first x;
    a:"n"$a;
    x:$[0>type first x;a,x;(enlist(count first x)#a),x]];
    T[t]+::count first x;
  f:key flip value t;
  pub[t;$[0>type first x;enlist f!x;flip f!x]];
  if[l;l enlist (`upd;t;x);i+:1];};


\d .
.lg.info"Finished in .u namespace";

/ Adding .z.po and .z.pc function handlers
 .z.po:{[hndl]{x[y]}[;hndl] each get each .ipc.zpo};
 .z.pc:{[hndl]{x[y]}[;hndl] each get each .ipc.zpc};

/ initialising .z.po, .z.pc function lists
.ipc.zpc:();
.ipc.zpo:();

.ipc.zpc,:`.u.zpc;
/ Loading logging script
.lg.info"Finished setting zpc/zpo, po/pc";
system"l ",.inp.qDir,"logger.q";
.lg.info"Loaded logger.q";
.u.tick[.inp.tbls;.inp.lgdir];
.lg.info"initialised .u.tick";

\
 globals used
 .u.w - dictionary of tables->(handle;syms)
 .u.i - msg count in log file
 .u.j - total msg count (log file plus those held in buffer)
 .u.t - table names
 .u.L - tp log filename, e.g. `:./sym2008.09.11
 .u.l - handle to tp log file
 .u.d - date
/test
>q tick.q
>q tick/ssl.q
/run
>q tick.q sym  .  -p 5010	/tick
>q tick/r.q :5010 -p 5011	/rdb
>q sym            -p 5012	/hdb
>q tick/ssl.q sym :5010		/feed