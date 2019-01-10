docker build -t drinuxsac/tomcat:8.5.37-jdk8-oracle .
docker build -t drinuxsac/tomcat:tmp1 .
docker build -t drinuxsac/tomcat:tmp2 .
docker build -t drinuxsac/tomcat:tmp3 .

docker run --name srv-tomcat -dit -p 8181:8080 drinuxsac/tomcat:8.5.37-jdk8-oracle

apt-get install oracle-java8-installer
wget https://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz