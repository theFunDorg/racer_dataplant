\l ml/ml.q
.ml.loadfile`:init.q
\l /home/fund/GitHub/KDB-Assignment/pyScripts/redditFeed.p

.fh.connReddit:{[pwd]
  .p.get[`initConn;pwd]
  };

.fh.dlThreads:{[subrdt;rdt;nthreads]
  `sym`timestamp xcols t:update `$sym from 
    .ml.df2tab .p.get[`getThreads;subrdt;rdt;nthreads]
  };

.fh.dlComments:{[threadID;rdt]
  `sym`timestamp xcols c:update `$sym from 
    .ml.df2tab .p.get[`getComments;threadID;rdt]
  };

  
.fh.threadList:();
reddit:.fh.connReddit["London99"];

h:hopen 5678



.z.ts:{
  show "Start time: ",(string .z.P);
  threads:select from .fh.dlThreads["ireland";reddit;50] where not id in .fh.threadList;
  .fh.threadList,::exec id from threads except .fh.threadList;
  show "Gotten threads";
  cmnts:raze .fh.dlComments[;reddit] each .fh.threadList;
  show "Gotten comments";
  h(`.u.upd;`tt;get flip threads);
  h(`.u.upd;`cc;get flip cmnts);
  show "End time: ",(string .z.P);
  };