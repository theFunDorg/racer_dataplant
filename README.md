# racer_dataplant
docker-run KDB dataplant for racer

TP::
q tick.q -tbls sym -lgdir lgdir -p 5678

RDB1::
q tick/r.q -p 9010 -pTP 5678 -sub trade,quote

RDB2::
q tick/r.q -p 9020 -pTP 5678 -sub aggTQ

FEEDHANDLER::
q feed.q -p 9030 -pTP 5678

CEP::
q CEP.q -p 9040 -pTP 5678 -tbls sym

LOGGING::
\l logger.q

STARTUP:
./start.sh START all
./start.sh STOP tp,rdb1,rdb2,feed,CEP
./start.sh TEST all

TPLOG_REWRITE::
q replay.q -inp oldLog -out newLog -sym ibm.n

CSV_TO_TP::
q csvLoader.q -tbl trade -csv trade.csv -types SFJBCC -pTP 5678

EOD::
q eodProc.q -log logfile -dir /home/sean/TEST -tbls sym
