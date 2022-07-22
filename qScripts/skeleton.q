// USAGE:: q skeleton.q -procName engine

/ Set console size
\c 1000 1000

/ Setting codebase directory
.cfg.codeDir:("/" sv -1_ "/" vs .z.X[1]),"/";

/ Load common files
system"l ",.cfg.codeDir,"utils.q";
system"l ",.cfg.codeDir,"log.q";
system"l ",.cfg.codeDir,"cron.q";
system"l ",.cfg.codeDir,"ipc.q";

/ Parse process inputs
.cfg,:`$.Q.opt .z.x;

/ Load config
.ut.loadConfig[];

/ Save process config to .proc namespace for easy access
.proc:.cfg.config[.cfg.procName];

/ Set Port
system "p ",string .proc.port;

/ Start process type
.ut.loadScript[.proc.procType];

/ Load each module
{system "l ",.cfg.codeDir,string[x]} each .proc.packages

/ Initialise each module
{[x]
    ns:` sv `,x;
    if[`init in key ns;
      ns[`init][]
    ];
  } each key `;

