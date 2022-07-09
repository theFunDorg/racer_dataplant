// Define connection log table
.ipc.userlog:([]
 timeOpen:`timestamp$();
 timeClose:`timestamp$();
 username:`symbol$();
 handle:`int$();
 host:`symbol$();
 action:`symbol$();
 memOpen:();
 memClose:()
 );

// Define .z.po function
.ipc.logUserConn:{
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
.ipc.logUserDisconn:{ 
  update 
    timeClose:.z.P,
    memClose:(enlist 2_raze "  ",/:string each get .Q.w[])
    from `.lg.userlog where
      i=(max;i) fby handle,
      handle=x; 
  usr: last exec username from .lg.userlog where handle=x;
  .lg.out "The user ",(string usr)," on handle ",(string x)," has disconnected";
 };

// Adding .z.po and .z.pc function lists
.ipc.zpoFuncs,:`.ipc.logUserConn;
.ipc.zpcFuncs,:`.ipc.logUserDisconn;

// Define open and close handle functions
.z.po:{[hndl]get each (;hndl)'[.ipc.zpoFuncs]};
.z.pc:{[hndl]get each (;hndl)'[.ipc.zpcFuncs]};

.ipc.hopen:{[connString]
  hopen connString
  };

// TODO: Adding the whole file.This file will do the following:
// * create open/close functions that are added to the above tables. 
// * Define the hopen function to add handle to a table, with open time