#!/bin/bash -x
# start a drawingboard microservice, based on coherence
#

jarfile=$(ls /pipeline/source/target/*with-dependencies.jar)
options="-Dcoherence.cacheconfig=drawingboard-coherence-cache-config.xml -Dcoherence.cluster=drawingboard"
wka_options="-Dcoherence.wka=drawingboard-cache"

echo wait a little so cache service gets its ip
sleep 5

ping -c 1 -W 1 drawingboard-cache
if [ $? -ne 0 ]
then
        echo "exiting since no cache service available..."
        exit 1
fi

java $options $wka_options -jar $jarfile
