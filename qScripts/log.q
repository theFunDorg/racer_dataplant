// USAGE::
//q)\l LOGGING.q

// Define connection log table
.lg.userlog:([]
 timeOpen:`timestamp$();
 timeClose:`timestamp$();
 username:`symbol$();
 handle:`int$();
 host:`symbol$();
 action:`symbol$();
 memOpen:();
 memClose:()
 );
 
// log-err and log-out messaging functions defined
.lg.info:{show "[",(string .z.P),"] - ",x};
.lg.out:{-1 "[",$:[.z.d]," - ",$:[.z.n]," - stdout] : ",x;};
.lg.err:{-2 "[",$:[.z.p]," - ",2_$:[.z.n]," - stderr ] : ",x;};

// Define .z.po function
.lg.zpo:{
  `.lg.userlog insert (
    .z.P,
    0Np,
    .z.u,
    x,
    .z.h,
    `open,
    (enlist  2_raze "  ",/:string each get .Q.w[]),
    (enlist ""));
  .lg.out "The user ",(string .z.u)," has connected on handle ",string x;
 };


// Define .z.pc function
.lg.zpc:{ 
  update 
    timeClose:.z.P,
    memClose:(enlist 2_raze "  ",/:string each get .Q.w[])
    from `.lg.userlog where
      i=(max;i) fby handle,
      handle=x; 
  usr: last exec username from .lg.userlog where handle=x;
  .lg.out "The user ",(string usr)," on handle ",(string x)," has disconnected";
 };
 


// Adding .z.po and .z.pc functions to process
.ipc.zpo,:`.lg.zpo;
.ipc.zpc,:`.lg.zpc;