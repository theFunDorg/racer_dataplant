#!/bin/bash
# A simple entrypoint script - it:
# 1 - prints a welcome message
# 2 - prints the length of args
# 3 - executes the arguments passed in. 
# Naturally it can be customised...to perform checks, start various services, etc.,
# One good use case for the entrypoint would be to pass in a specific script and port to run. in this case a 'master' script like master.q could start on e.g. port 5000 and a set of worker scripts worker-1.q, worker-2.q etc., could run on 5001, 5002...
echo "Welcome to KDB+ on Docker"
alias q="rlwrap q"

while [[ $finish != "1" ]];
  do 
    echo "Looping Daemon";
    echo "";
    echo "";
    if [[ `ps  -ef | grep "/home/sean/q/l64/q skeleton.q" | grep -v "grep" | grep tickerplant |wc -l` == "0" ]]; then
      echo "tickerplant not running, starting now"
      nohup /home/sean/q/l64/q skeleton.q -procName tickerplant > ./logOuts/tickerplant_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "/home/sean/q/l64/q skeleton.q" | grep-v "grep" | grep rdb |wc -l` == "0" ]]; then
      echo "rdb not running, starting now"
      nohup /home/sean/q/l64/q skeleton.q -procName rdb >> ./logOuts/rdb_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 & 
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "/home/sean/q/l64/q skeleton.q" | grep -v "grep" | grep engine |wc -l` == "0" ]]; then
      echo "engine not running, starting now"
      nohup /home/sean/q/l64/q skeleton.q -procName engine >> ./logOuts/engine_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "/home/sean/q/l64/q skeleton.q" | grep -v "grep" | grep subROS |wc -l` == "0" ]]; then
      echo "subROS not running, starting now"
      nohup /home/sean/q/l64/q skeleton.q -procName subROS >> ./logOuts/subROS_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "/home/sean/q/l64/q skeleton.q" | grep -v "grep" | grep pubROS |wc -l` == "0" ]]; then
      echo "pubROS not running, starting now"
      nohup /home/sean/q/l64/q skeleton.q -procName pubROS >> ./logOuts/pubROS_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "/home/sean/q/l64/q skeleton.q" | grep -v "grep" | grep logger |wc -l` == "0" ]]; then
      echo "logger not running, starting now"
      nohup /home/sean/q/l64/q skeleton.q -procName logger >> ./logOuts/logger_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  sleep 5
done;