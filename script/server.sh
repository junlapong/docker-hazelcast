#!/bin/sh

PRG="$0"
PRGDIR=`dirname "$PRG"`
HAZELCAST_HOME=`cd "$PRGDIR/.." >/dev/null; pwd`/hazelcast
PID_FILE=$HAZELCAST_HOME/hazelcast_instance.pid

if [ $JAVA_HOME ]
then
	echo "JAVA_HOME found at $JAVA_HOME"
	RUN_JAVA=$JAVA_HOME/bin/java
else
	echo "JAVA_HOME environment variable not available."
    RUN_JAVA=`which java 2>/dev/null`
fi

if [ "x$MIN_HEAP_SIZE" != "x" ]; then
	JAVA_OPTS="$JAVA_OPTS -Xms${MIN_HEAP_SIZE}"
fi

if [ "x$MAX_HEAP_SIZE" != "x" ]; then
	JAVA_OPTS="$JAVA_OPTS -Xmx${MAX_HEAP_SIZE}"
fi

export CLASSPATH=$HAZELCAST_HOME/hazelcast-all-$HZ_VERSION.jar:$CLASSPATH/*

echo "########################################"
$RUN_JAVA -version
echo "# JAVA_OPTS=$JAVA_OPTS"
echo "# starting now...."
echo "########################################"

echo "Process id for hazelcast instance is written to location: " $PID_FILE
java -server $JAVA_OPTS com.hazelcast.core.server.StartServer &
echo $! > ${PID_FILE}

#sleep infinity
tail -f /dev/null
