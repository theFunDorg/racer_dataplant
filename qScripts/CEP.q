/ Parsing inputs to process
inp:.Q.opt .z.x;
tbls:inp.tbls 0;
tpPort:get inp.pTP 0;
 

/ Aggregation function for individual row
aggFn:{[tbl;data]
 if[tbl~`trade;
   $[not (data`sym) in key aggTQ;
     `aggTQ upsert (data`sym;data`price;data`price;data`size;0Nf;0Nf);
     update
       maxP:(max maxP, (data`price)),
       minP:(min minP, (data`price)),
       Vol:(Vol+data`size)
       from `aggTQ where sym=data`sym]];
 if[tbl~`quote;
   $[not (data`sym) in key aggTQ;
     `aggTQ upsert (data`sym;0Nf;0Nf;0;data`bid;data`ask);
     update
       maxBid:(max maxBid,(data`bid)),
       minAsk:(min minAsk,(data`ask))
       from `aggTQ where sym=data`sym]];
 (neg tp)(`.u.upd;`aggTQ;get first 0!select from aggTQ where sym=data`sym);
 };
/ Applying aggregation to each row
upd:{[tbl;data]
 aggFn[tbl;] each data;
 };

/ Opening connection to TP
tp:hopen tpPort;

/ Loading Table schemas
system "l tick/",tbls,".q";

/ Keying schema and removing time column
aggTQ:1!delete time from aggTQ;

/ Removing unused tables
![  `.;  ();  0b;  tables[] except `aggTQ];

/ Adding .z.po and .z.pc function handlers
.z.po:{[hndl]{x[y]}[;hndl] each get each .ipc.zpo};
.z.pc:{[hndl]{x[y]}[;hndl] each get each .ipc.zpc};

/ initialising .z.po, .z.pc function lists
.ipc.zpc:();
.ipc.zpo:();

/ Loading logging script
\l logger.q

/ Subscribing to trade and quote tables
{tp(`.u.sub;x;`)} each `trade`quote;
