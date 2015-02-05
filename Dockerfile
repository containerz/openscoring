# pull base image.
FROM dockerfile/java:oracle-java7

# maintainer details
MAINTAINER Brian Ketelsen <brian@xor.exchange>

# update packages and install maven
RUN  \
  export DEBIAN_FRONTEND=noninteractive && \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y vim wget curl git maven

# attach volumes
VOLUME /volume/git

# create working directory
RUN mkdir -p /local/git
ADD . /local/git/openscoring
WORKDIR /local/git/openscoring
RUN mvn clean install
WORKDIR /local/git/openscoring/openscoring-server
CMD java -Dconfig.file=application.conf -jar target/server-executable-1.2-SNAPSHOT.jar
