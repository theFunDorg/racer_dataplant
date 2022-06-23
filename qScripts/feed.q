/ USAGE:
/ q feed.q -p 9030 -pTP 5678

/ Take inputs to proc
.inp:.Q.opt .z.x
.inp.tpPort:get .inp.pTP 0;

/ Setting list of syms to send to TP
syms:`MSFT`GOOG`AAPL`MS`JPM`FDP`IBM

/ Function to generate random data and send to TP
.z.ts:{
  Ntrade:first 1+1?2;
  Nquote:first 1+1?2;
    h(`.u.upd;
      `trade;(
        Ntrade?syms;
        70+Ntrade?30f;
        Ntrade?100000;
        Ntrade?1b;
        upper Ntrade?" ";
        upper Ntrade?" "));
    h(`.u.upd;
      `quote;(
  	    Nquote?syms;
        70+Nquote?30f;
        70+Nquote?30f;
        Nquote?100000;
        Nquote?100000;
        upper Nquote?" ";
        upper Nquote?" "));
  };

/ Adding .z.po and .z.pc function handlers
.z.po:{[hndl]{x[y]}[;hndl] each get each .ipc.zpo};
.z.pc:{[hndl]{x[y]}[;hndl] each get each .ipc.zpc};

/ initialising .z.po, .z.pc function lists
.ipc.zpc:();
.ipc.zpo:();

/ Loading logging script
\l logger.q

/ Opening handle to TP
h:neg hopen .inp.tpPort;

/ Running timer function
\t 500
