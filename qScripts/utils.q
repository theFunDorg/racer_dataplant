.ut.tbls:{([]tbl:tables[];cnt:count each get each tables[])};

.ut.loadConfig:{
  rawConfig:("SSJSSS";enlist csv) 0: hsym `$.cfg.codeDir,"config.csv";
  .cfg.config:1!update 
    packages:{`$";" vs string x} each packages,
    subscribe:{`$";" vs string x} each subscribe,
    publish:{`$";" vs string x} each publish
      from rawConfig;
  };

.ut.loadScript:{[script]
  script:string script;
  .lg.info"Starting loading ",script;
  system"l ",.cfg.codeDir,script,".q";
  .lg.info"Finished loading ",script;
  };
