if[not "w"=first string .z.o;system "sleep 1"];

/ function for connection to ticker plant for (schema;(logcount;log))
.rdb.subscribe:{
  .rdb.schemas:.rdb.tpHandle(`.tick.subscribe;.cfg.config[.cfg.procName][`subscribe];.z.w);
  {x set .rdb.schemas[x]}each key .rdb.schemas;
 }

/ init schema and sync up from log file;cd to hdb(so client save can run)
.rdb.rep:{(.[;();:;].)each x;if[null first y;:()];-11!y;system "cd ",1_-10_string first reverse y};


/ Adding .z.po and .z.pc function handlers
.z.po:{[hndl]{x[y]}[;hndl] each get each .ipc.zpo};
.z.pc:{[hndl]{x[y]}[;hndl] each get each .ipc.zpc};

/ connect to ticker plant for (schema;(logcount;log))
 
/ Setting upd to insert after log replay
upd:insert;


.rdb.init:{[]
  .lg.info"Connecting to tickerplant";
  .rdb.tpHandle:hopen .cfg.config[`tickerplant][`port];
  .lg.info"Tickerplant connection opened";
  .lg.info"Subscribing and getting schemas";
  .rdb.subscribe`;
  .lg.info"Subscription completed";

  };
.rdb.init`