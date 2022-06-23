/ USAGE::
/ q tick/r.q  -p 5060 -pTP [TPhost:]TPport -sub [comma separated list of tables]

/2008.09.09 .k ->.q
.lg.info:{show "[",(string .z.P),"] - ",x};

/ Take inputs to proc
.inp:.Q.opt .z.x
.inp.tpPort:`$.inp.pTP 0;
.inp.subs: $[count .inp.sub;`$/:"," vs .inp.sub 0;`];
.inp.qDir:getenv `QDIR;
.lg.info"Loaded input vars";

if[not "w"=first string .z.o;system "sleep 1"];

/ conditional insert for log replay
upd:{if[(x in .inp.subs) or .inp.subs~`;x insert y]};

/ end of day: save, clear, hdb reload
.u.end:{t:tables`.;t@:where `g=attr each t@\:`sym;.Q.hdpf[0;`:.;x;`sym];@[;`sym;`g#] each t;};

/ init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{(.[;();:;].)each x;if[null first y;:()];-11!y;system "cd ",1_-10_string first reverse y};

/ function for connection to ticker plant for (schema;(logcount;log))
.u.tpConn:{
  h:(hopen .inp.tpPort);
  schema:{y(`.u.sub;x;`)}[;h] each .inp.subs;
  lg:h"(`.u `i`L)";
  .u.rep .(schema;lg)
 }

/ Adding .z.po and .z.pc function handlers
.z.po:{[hndl]{x[y]}[;hndl] each get each .ipc.zpo};
.z.pc:{[hndl]{x[y]}[;hndl] each get each .ipc.zpc};

/ initialising .z.po, .z.pc function lists
.ipc.zpc:();
.ipc.zpo:();
.lg.info"Loaded input r script functions";

/ Loading logging script
system"l ",.inp.qDir,"logger.q";
.lg.info"Loaded logger.q";

/ Loading functions script
system"l ",.inp.qDir,"functions.q";
.lg.info"Loaded functions.q";

/ Define .z.ws to allow websocket access
.z.ws:{neg[.z.w].Q.s value x};

/ Setting console dimensions
\c 200 2000

/ Show hostname
.lg.info string .z.h;

 / connect to ticker plant for (schema;(logcount;log))
.u.tpConn[]
 
/ Setting upd to insert after log replay
upd:insert;
