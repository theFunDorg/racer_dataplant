#!/bin/bash

cd /racer_dataplant/qScripts/

while [[ $finish != "1" ]];
  do 
    echo "Looping Daemon";
    echo "";
    echo "";
    if [[ `ps  -ef | grep "q /racer_dataplant/qScripts/skeleton.q" | grep -v "grep" | grep tickerplant |wc -l` == "0" ]]; then
      echo "tickerplant not running, starting now"
      nohup q /racer_dataplant/qScripts/skeleton.q -procName tickerplant > /racer_dataplant/logOuts/tickerplant_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "q /racer_dataplant/qScripts/skeleton.q" | grep -v "grep" | grep rdb |wc -l` == "0" ]]; then
      echo "rdb not running, starting now"
      nohup q /racer_dataplant/qScripts/skeleton.q -procName rdb >> /racer_dataplant/logOuts/rdb_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 & 
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "q /racer_dataplant/qScripts/skeleton.q" | grep -v "grep" | grep engine |wc -l` == "0" ]]; then
      echo "engine not running, starting now"
      nohup q /racer_dataplant/qScripts/skeleton.q -procName engine >> /racer_dataplant/logOuts/engine_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "q /racer_dataplant/qScripts/skeleton.q" | grep -v "grep" | grep subROS |wc -l` == "0" ]]; then
      echo "subROS not running, starting now"
      nohup q /racer_dataplant/qScripts/skeleton.q -procName subROS >> /racer_dataplant/logOuts/subROS_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "q /racer_dataplant/qScripts/skeleton.q" | grep -v "grep" | grep pubROS |wc -l` == "0" ]]; then
      echo "pubROS not running, starting now"
      nohup q /racer_dataplant/qScripts/skeleton.q -procName pubROS >> /racer_dataplant/logOuts/pubROS_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  
    if [[ `ps  -ef | grep "q /racer_dataplant/qScripts/skeleton.q" | grep -v "grep" | grep logger |wc -l` == "0" ]]; then
      echo "logger not running, starting now"
      nohup q /racer_dataplant/qScripts/skeleton.q -procName logger >> /racer_dataplant/logOuts/logger_`date +%Y.%m.%d_%H:%M:%S`.log 2>&1 &
      sleep 3
    fi;
  sleep 5
done;