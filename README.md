# racer_dataplant
docker-run KDB dataplant for racer

to build and run the dataplant:

    cd racer_dataplant
    docker build -t racer-kdb . ;docker-compose up


    q /home/sean/racer_dataplant/qScripts/skeleton.q -procName tickerplant
    q /home/sean/racer_dataplant/qScripts/skeleton.q -procName rdb
    q /home/sean/racer_dataplant/qScripts/skeleton.q -procName engine
    q /home/sean/racer_dataplant/qScripts/skeleton.q -procName subROS
    q /home/sean/racer_dataplant/qScripts/skeleton.q -procName pubROS
    q /home/sean/racer_dataplant/qScripts/skeleton.q -procName logger


Define env Variables first though:

    export ROS2KDB_DIR=~/cloud/ros_ws/src/ros2kdb/
    export CONFIG_DIR=~/cloud/ros_ws/src/ros2kdb/config/
    export INTERFACES_DIR=~/cloud/ros_ws/src/racer_interfaces/
    export QROS_DIR=~/cloud/ros_ws/src/ros2kdb/q
    export QDIR=/home/sean/racer_dataplant/qScripts/