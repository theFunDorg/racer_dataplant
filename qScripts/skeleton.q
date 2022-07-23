// USAGE:: q skeleton.q -procName engine

/ Set console size
\c 1000 1000

/ Setting codebase directory
.cfg.codeDir:getenv[`QDIR];

/ Load common files
system"l ",.cfg.codeDir,"utils.q";
system"l ",.cfg.codeDir,"log.q";
system"l ",.cfg.codeDir,"cron.q";
system"l ",.cfg.codeDir,"ipc.q";
.lg.info"Finished loading common files";

/ Parse process inputs
.lg.info"Parsing command line variables";
.cfg,:`$.Q.opt .z.x;

/ Load config
.lg.info"Loading dataplant config";
.ut.loadConfig[];

/ Save process config to .proc namespace for easy access
.proc:.cfg.config[.cfg.procName];
.proc.packages:.proc.packages except `;

/ Set Port
system "p ",string .proc.port;

/ Start process type and load packages
.lg.info"Starting process type = ",string[.proc.procType];
.ut.loadScript each except[.proc.procType,.proc.packages;`];

/ Initialise each module
{[x]
    ns:` sv `,x;
    if[`init in key ns;
      ns[`init][]
    ];
  } each key `;