FROM ubuntu:16.04


RUN apt-get update && apt-get install -y vim nmap sudo python-software-properties software-properties-common tar gzip maven \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:webupd8team/java \
    && apt-get update \
    && yes | apt-get install -y oracle-java8-installer

ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# INSTALACION DE TOMCAT
RUN groupadd tomcat \
    && mkdir /opt/tomcat \
    && useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat \
    && cd /tmp \
    && wget https://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz \
    && tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1 \
    && cd /opt/tomcat \
    && chgrp -R tomcat /opt/tomcat \
    && chmod -R g+r conf \
    && chmod g+x conf \
    && chown -R tomcat webapps/ work/ temp/ logs/

ENV CATALINA_PID /opt/tomcat/temp/tomcat.pid
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat

EXPOSE 8080

VOLUME "/opt/tomcat/webapps"

WORKDIR /opt/tomcat

COPY tomcat-users.xml /opt/tomcat/conf
COPY context.xml /opt/tomcat/webapps/host-manager/META-INF/
COPY context.xml /opt/tomcat/webapps/manager/META-INF/

# INSTALAR DRIVE ORACLE
COPY ojdbc8.jar /
RUN mvn install:install-file -Dfile=/ojdbc8.jar -DgroupId=com.oracle -DartifactId=ojdbc8 -Dversion=12.2.0.1 -Dpackaging=jarexi

#Lanzar Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]


