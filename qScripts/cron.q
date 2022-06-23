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
  jobToRun[`function] . jobToRun[`params];
  .cron.tbl:$[jobToRun[`repeat];
    update nextRun:.z.P+interval*`long$1e9 from .cron.tbl;
    delete from .cron.tbl where id=i
    ];
  };

.cron.addJob:{[args]
  id:1+count .cron.tbl;
  `.cron.tbl upsert(id;`funcName;5 9;.z.P;5;1b)
  };

.z.ts:{[]
  ids:exec id from .cron.tbl where nextRun<.z.P;
  .cron.runJob each ids;
  };

  funcName:{show x+y}