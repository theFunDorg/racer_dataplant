// Define connection log table
.ipc.userlog:([]
 timeOpen:`timestamp$();
 username:`symbol$();
 handle:`int$();
 host:`symbol$();
 action:`symbol$()
 );

// Define .z.po function
.ipc.logUserConn:{
  `.ipc.userlog insert (
    .z.P, .z.u, x, .z.h, `open
    );
  .lg.info "The user ",string[.z.u]," has connected on handle ",string[x];
 };

// Define .z.pc function
.ipc.logUserDisconn:{ 
  `.ipc.userlog insert (
    .z.P, .z.u, x, .z.h, `close
    );
  .lg.info "The user ",string[.z.u]," on handle ",string[x]," has disconnected";
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