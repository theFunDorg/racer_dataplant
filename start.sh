#!/bin/bash
#USE CASE:
#start.sh START all


declare -A port;
declare -A proc;

##===Modify variables below to change ports=======
port[tp]=5678;
port[rdb1]=9010;
port[rdb2]=9020;
port[feed]=9030;
port[CEP]=9040;


##===============Set logs directory===============
logdir="logs/";


##================ Add/remove processes below=====


proc[tp]=" tick.q -tbls sym -lgdir lgdir -p ${port[tp]}";
proc[rdb1]=" tick/r.q -p ${port[rdb1]} -pTP ${port[tp]} -sub trade,quote";
proc[rdb2]=" tick/r.q -p ${port[rdb2]} -pTP ${port[tp]} -sub aggTQ,tt,cc";
#proc[feed]=" feed.q -p ${port[feed]} -pTP ${port[tp]}";
proc[CEP]=" CEP.q -p ${port[CEP]} -pTP ${port[tp]} -tbls sym";


##================ Business end

echo Function used: $1
echo Options used: $2
if [[ $2 == all ]];then
  procs=tp,rdb1,rdb2,feed,CEP
else
  procs=$2
fi
procs=`echo $procs | sed 's/,/\t/g'`
case $1 in 
	START)
	  for i in $procs;
	    do nohup q ${proc[${i}]} > ${logdir}${i} 2>&1 &
	    ##do nohup q ${proc[${i}]} > ${logdir}${i}_`date '+%Y%m%d_%H%M%S'` 2>&1 &
	  done
	  
	  ;;
	STOP)
	  for i in $procs; 
	    do PID=`ps -eo pid,command| grep -v 'grep'|grep "${proc[$i]}"| awk '{print $1}'`;
		if [ ! -z "$PID" ]
		then
		 kill $PID
		fi
		done
	  ;;

	TEST)
	  top -bcn 1 | head -7
	  for i in $procs; 
	    do PID=`ps -eo pid,command| grep -v 'grep'|grep "${proc[$i]}"| awk '{print $1}'`;
		if [ -z "$PID" ]
		then
		  echo "$i is not running"
		else
		  top -bcn 1 -p $PID| tail -1;
		fi
		done
	  ;;
	
	*)
	  echo -e "Please use one of the three formats:\n start.sh \n start.sh \n start.sh"
	  ;;
esac

ps -f