.lg.info"TickerPlant Starting";

system"l schemas.q";
.lg.info"Finished loading schemas";

.z.pc:{.tick.deleteSub[x]};

.tick.init:{
  .tick.tblCounts:tables[]!count each get each tables[];
  .tick.subscribers::t!(count t::tables`.)#();
  };

.tick.deleteSub:{[handle]
  {.tick.subscribers[x]:distinct .tick.subscribers[x] except y}[;handle] each key .tick.subscribers;
  };

.tick.shutdown:{
  exit 0
  };

.tick.subscribe:{[tbls;handle]
  if[tbls[0]~`;tbls:except[key .tick.subscribers;`]];
  {.tick.subscribers[x]:distinct .tick.subscribers[x],y}[;handle] each tbls;
  :tbls!get each tbls
  };

.tick.publish:{[tbl;data]
  if[not -12h=type first data;
    data:.z.P,data
  ];
  {[hndl;tbl;data]hndl(`upd;tbl;data)}[;tbl;data] each .tick.subscribers[tbl];
  };

.tick.init[];