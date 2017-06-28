FROM ubuntu

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y build-essential software-properties-common byobu curl git htop man unzip vim wget

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y zip oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

RUN wget --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" -O /opt/wso2esb.zip http://dist.wso2.org/products/enterprise-service-bus/5.0.0/wso2esb-5.0.0.zip 

RUN unzip /opt/wso2esb.zip -d /opt && rm /opt/wso2esb.zip

RUN mv /opt/wso2esb-5.0.0 /opt/wso2esb

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

EXPOSE 9443 9763 8243 8280

WORKDIR /opt/wso2esb

ENTRYPOINT ["/opt/wso2esb/bin/wso2server.sh"]