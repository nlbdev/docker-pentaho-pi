FROM ubuntu:19.10
LABEL MAINTAINER Jostein Austvik Jacobsen <jostein@nlb.no> <http://www.nlb.no/>

# Set working directory to /opt, which is where we will install things
WORKDIR /opt/

# Set locales
RUN apt-get clean && apt-get update && apt-get install -y locales && locale-gen en_GB en_GB.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL C.UTF-8

# Install Java 8
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Install Pentaho Data Integration CE
RUN apt-get update && apt-get install -y curl unzip
RUN curl -L "https://sourceforge.net/projects/pentaho/files/Pentaho%208.3/client-tools/pdi-ce-8.3.0.0-371.zip/download" \
         --output /tmp/pentaho.zip \
    && unzip /tmp/pentaho.zip -d /opt/pentaho \
    && rm /tmp/pentaho.zip
RUN curl "https://downloads.mariadb.com/Connectors/java/connector-java-2.5.2/mariadb-java-client-2.5.2.jar" \
         --output "/opt/pentaho/data-integration/lib/mariadb-java-client.jar"
RUN curl "http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.48/mysql-connector-java-5.1.48.jar" \
         --output "/opt/pentaho/data-integration/lib/mysql-connector-java.jar"
ENV PENTAHO_HOME "/opt/pentaho/data-integration"
