#!/bin/bash

## USAGE
# ./startContainers.sh tpStart
# ./startContainers.sh tpStop
# ./startContainers.sh rdbAdd
# ./startContainers.sh rdbStop
# ./startContainers.sh rdbAdd
# ./startContainers.sh gatewayStart
# ./startContainers.sh gatewayStop

## TODO
# Add another rdb
#    add one to port number
#    if port is free
#    start new container with next rdb port
#    else return to start of function
#    start/stop all processes
#    docker stop gateway first, then gateway, then tickerplant. 
#    docker container ls
#    take command to start/stop tp/gateway
#    start container with either tp or gateway
#    for gateway, use list of Up rdbs and their port numbers as option to enter
#    for tickerplant, attach a storage location for the logfiles 


##===Modify variables below to change ports=======
#port number for tickerplant
portTP=5678;

#port number for Gateway
portGateway=5679;

#base port for rdbs
basePort=5680;

##===============Set logs directory===============
#logfile location
logdir="logs/";
lgdir="lgdir";
imageName="fund/docker-kdb";
USR="sean";

echo Function used: $1
case $1 in 
	tpStart)
        echo -e "Starting TP";
        docker run -d --name "tickerplant" -p ${portTP}:${portTP} -it docker-kdb q tick.q -p ${portTP} -tbls sym -lgdir ${lgdir};
        echo -e "TP started";
	  ;;
	tpStop)
	  ;;
	rdbAdd)
        number=`docker container ls| grep "RDB"|wc -l`;
        ((nextPort=basePort+number));
        echo "hello "$nextPort;
        docker run -d --name `echo "RDB"$number` \
        -p ${nextPort}:${nextPort} \
        -e ${portTP}:${portTP} \
        -p ${portGateway}:${portGateway} \
        -it docker-kdb \
        q tick/r.q -p ${nextPort} -pTP ${portTP} -sub tt,cc
	  ;;
	rdbStop)
	  ;;
	gatewayStart)
        echo -e "Starting Gateway";
        docker run -d -p ${portGateway}:${portGateway} -it docker-kdb q gateway.q-p 5001;
        echo -e "Gateway started";
	  ;;
	gatewayStop)
	  ;;
	*)
	  echo -e "Please use one of the three formats:\n start.sh \n start.sh \n start.sh";
	  ;;
esac

docker container ls