if[not "w"=first string .z.o;system "sleep 1"];

/ function for connection to ticker plant for (schema;(logcount;log))
.rdb.tpConn:{
  h:(hopen .cfg.config[`tickerplant][`port]);
  schema:{y(`.u.sub;x;`)}[;h] each .cfg.config[.cfg.procName][`subscribe];
  lg:h"(`.u `i`L)";
  .rdb.rep .(schema;lg)
 }

/ init schema and sync up from log file;cd to hdb(so client save can run)
.rdb.rep:{(.[;();:;].)each x;if[null first y;:()];-11!y;system "cd ",1_-10_string first reverse y};


/ Adding .z.po and .z.pc function handlers
.z.po:{[hndl]{x[y]}[;hndl] each get each .ipc.zpo};
.z.pc:{[hndl]{x[y]}[;hndl] each get each .ipc.zpc};

 / connect to ticker plant for (schema;(logcount;log))
.rdb.tpConn[]
 
/ Setting upd to insert after log replay
upd:insert;
