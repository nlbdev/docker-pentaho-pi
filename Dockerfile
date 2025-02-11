FROM ubuntu:24.04
LABEL MAINTAINER Jostein Austvik Jacobsen <jostein@nlb.no> <http://www.nlb.no/>

# Set working directory to /opt, which is where we will install things
WORKDIR /opt/

# Set locales
RUN apt-get clean && apt-get update && apt-get install -y locales && locale-gen en_GB en_GB.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL C.UTF-8

# Install Java 17
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Install Pentaho Data Integration CE
RUN apt-get update && apt-get install -y curl unzip
RUN curl -L "https://hitachiedge1.jfrog.io/artifactory/pntpub-maven-release-cache/org/pentaho/di/pdi-ce/9.4.0.0-343/pdi-ce-9.4.0.0-343.zip" \
         --output /tmp/pentaho.zip \
    && unzip /tmp/pentaho.zip -d /opt/pentaho \
    && rm /tmp/pentaho.zip
RUN curl "https://downloads.mariadb.com/Connectors/java/connector-java-3.5.1/mariadb-java-client-3.5.1.jar" \
         --output "/opt/pentaho/data-integration/lib/mariadb-java-client.jar"
RUN curl "https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar" \
         --output "/opt/pentaho/data-integration/lib/mysql-connector-java.jar"
ENV PENTAHO_HOME "/opt/pentaho/data-integration"
