// USAGE:: q skeleton.q -procName engine

/ Set console size
\c 1000 1000

/ Load common files
\l utils.q
\l log.q
\l cron.q

/ Load config
.ut.loadConfig[];

/ Parse process inputs
.cfg,:`$.Q.opt .z.x;

/ Set Port
system "p ",string .cfg.config[.cfg.procName][`port];

/ Start process type
.ut.loadScript[.cfg.config[.cfg.procName][`procType]];
/ Load each module

/ Initialise each module
