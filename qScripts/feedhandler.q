

.fh.init:{[]
  .lg.info"Connecting to tickerplant";
  .fh.tpHandle:hopen .cfg.config[`tickerplant][`port];
  .lg.info"Tickerplant connection opened";
  };
  
//.z.ts:{
//  show "Start time: ",(string .z.P);
//  threads:select from .fh.dlThreads["ireland";reddit;50] where not id in .fh.threadList;
//  .fh.threadList,::exec id from threads except .fh.threadList;
//  show "Gotten threads";
//  cmnts:raze .fh.dlComments[;reddit] each .fh.threadList;
//  show "Gotten comments";
//  h(`.u.upd;`tt;get flip threads);
//  h(`.u.upd;`cc;get flip cmnts);
//  show "End time: ",(string .z.P);
//  };