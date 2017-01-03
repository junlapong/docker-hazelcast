FROM anapsix/alpine-java:8_server-jre_unlimited
ENV HZ_VERSION 3.7.4
ENV HZ_HOME /opt/hazelcast/
RUN mkdir -p $HZ_HOME
WORKDIR $HZ_HOME
# Download hazelcast jars from maven repo.
ADD https://repo1.maven.org/maven2/com/hazelcast/hazelcast-all/$HZ_VERSION/hazelcast-all-$HZ_VERSION.jar $HZ_HOME
ADD script/server.sh /$HZ_HOME/server.sh
ADD script/stop.sh /$HZ_HOME/stop.sh
RUN chmod +x /$HZ_HOME/server.sh
RUN chmod +x /$HZ_HOME/stop.sh
# Start hazelcast standalone server.
CMD ./server.sh
EXPOSE 5701
