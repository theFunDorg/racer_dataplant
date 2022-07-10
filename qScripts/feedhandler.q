
.fh.init:{[]
  .lg.info"Connecting to tickerplant";
  .fh.tpHandle:.ipc.hopen .cfg.config[`tickerplant][`port];
  .lg.info"Tickerplant connection opened";
  };