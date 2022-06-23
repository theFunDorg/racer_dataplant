/ USAGE::
/ q csvLoader.q -tbl trade -csv trade.csv -types SFJBCC -pTP 5678

/ Take inputs to proc
inp:.Q.opt .z.x
file:hsym `$inp.csv 0;
tbl:`$inp.tbl 0;
types:first inp.types;
tpPort:get inp.pTP 0;

/ Open handle to tickerplant
h:hopen tpPort;

/ Load in the scv in chunks, sending each to the tickerplant
.Q.fs[{{h(`.u.upd;tbl;x)} each flip (types;",") 0:x}] file;

/ Exit script
exit 0;