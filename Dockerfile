FROM ubuntu:18.04
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
RUN curl -L "https://sourceforge.net/projects/pentaho/files/Data%20Integration/7.1/pdi-ce-7.1.0.0-12.zip/download" \
         --output /tmp/pentaho.zip \
    && unzip /tmp/pentaho.zip -d /opt/pentaho \
    && rm /tmp/pentaho.zip
RUN curl "https://downloads.mariadb.com/Connectors/java/connector-java-2.3.0/mariadb-java-client-2.3.0.jar" \
         --output "/opt/pentaho/data-integration/lib/mariadb-java-client.jar"
RUN curl "http://central.maven.org/maven2/mysql/mysql-connector-java/8.0.13/mysql-connector-java-8.0.13.jar" \
         --output "/opt/pentaho/data-integration/lib/mysql-connector-java.jar"
ENV PENTAHO_HOME "/opt/pentaho/data-integration"
