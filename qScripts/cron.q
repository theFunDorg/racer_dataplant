// Create cron table
.cron.tbl:(
    [id:`long$()]
    function:`$();
    params:();
    nextRun:`timestamp$();
    interval:`long$();
    repeat:`boolean$()
  );

.cron.deleteJobByFunc:{[func]
    .lg.info"deleting function ",string[func]," from timer";
    .cron.tbl:delete from .cron.tbl where function=func;
  };

.cron.deleteJobByID:{[ID]
    .lg.info"deleting timer ID ",string[ID]," from timer";
    .cron.tbl:delete from .cron.tbl where id=ID;
  };

.cron.runJob:{[i]
    jobToRun:.cron.tbl[i];
    
    $[1=count jobToRun[`params];
        @[jobToRun[`function];jobToRun[`params];{.lg.err"JobID: ",string[i],"failed to run with error",string x} ];
        .[jobToRun[`function];jobToRun[`params];{.lg.err"JobID: ",string[i],"failed to run with error",string x} ]
    ];
    .cron.tbl:$[jobToRun[`repeat];
      update nextRun:.z.P+interval*`long$1e9 from .cron.tbl;
      delete from .cron.tbl where id=i
    ];
  };

.cron.addJob:{[args]
  .lg.info "Adding job with details:";
  show args;
  `.cron.tbl upsert(
    1+count .cron.tbl;
    args`funcName; 
    args`inputs;
    args`nextRun;
    args`interval;
    args`repeat
  );
  };

.z.ts:{[]
    ids:exec id from .cron.tbl where nextRun<.z.P;
    .cron.runJob each ids;
  };

funcName:{show x+y};

.cron.init:{system "t 50"};