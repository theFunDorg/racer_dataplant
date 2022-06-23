/2008.09.09 .k -> .q
/2006.05.08 add
.lg.info"Starting u.q";

\d .u
init:{
  w::t!(count t::tables`.)#();
  T::t!(count t)#0;
  T60::0#enlist (`time,t,{` sv `cnt,x} each t)!(1+2*count t)#();}


del:{w[x]_:w[x;;0]?y};

//.z.pc:{del[;x]each t};

zpc:{del[;x]each t};

sel:{$[`~y;x;select from x where sym in y]}

pub:{[t;x]{[t;x;w]if[count x:sel[x]w 1;(neg first w)(`upd;t;x)]}[t;x]each w t}

add:{$[(count w x)>i:w[x;;0]?.z.w;.[`.u.w;(x;i;1);union;y];w[x],:enlist(.z.w;y)];(x;$[99=type v:value x;sel[v]y;0#v])}

sub:{if[x~`;:sub[;y]each t];if[not x in t;'x];del[x].z.w;add[x;y]}

end:{(neg union/[w[;;0]])@\:(`.u.end;x)}

\d .

.lg.info"finished u.q";