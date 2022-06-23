/ USAGE::
/ q gateway.q  -p 5060 -rdbs rdb1:5680,rdb2:5681

/2008.09.09 .k ->.q
.lg.info:{show "[",(string .z.P),"] - ",x};

/ Take inputs to proc
.inp:.Q.opt .z.x;
hndls:hsym each `$'csv vs .inp.rdbs 0;

.lg.info"Loaded input vars";


workerHandles:hopen each hndls / open handles to worker processes

pending:()!() / keep track of received results for each clientHandle

/ this example fn joins the results when all are received from the workers
reduceFunction:raze

/ each worker calls this with (0b;result) or (1b;errorString) 
callback:{[clientHandle;result] 
 pending[clientHandle],:enlist result; / store the received result
 / check whether we have all expected results for this client
 if[count[workerHandles]=count pending clientHandle; 
   / test whether any response (0|1b;...) included an error
   isError:0<sum pending[clientHandle][;0]; 
   result:pending[clientHandle][;1]; / grab the error strings or results
   / send the first error or the reduced result
   r:$[isError;{first x where 10h=type each x};reduceFunction]result; 
   -30!(clientHandle;isError;r); 
   pending[clientHandle]:(); / clear the temp results
 ]
 }

 
.z.pg:{[query]
  remoteFunction:{[clntHandle;query]
    neg[.z.w](`callback;clntHandle;@[(0b;)value@;query;{[errorString](1b;errorString)}])
  };
  neg[workerHandles]@\:(remoteFunction;.z.w;query); / send the query to each worker
  -30!(::); / defer sending a response message i.e. return value of .z.pg is ignored
 }