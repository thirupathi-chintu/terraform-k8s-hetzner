FROM jenkins/jenkins

ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial setup
# ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-slaves

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer
RUN /usr/local/bin/install-plugins.sh slack

# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher

# UI
RUN /usr/local/bin/install-plugins.sh greenballs
RUN /usr/local/bin/install-plugins.sh simple-theme-plugin

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes

# COPY plugins.txt /usr/share/jenkins/plugins.txt
# RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
USER root
RUN  apt update &&  apt install -y python3 &&  apt install -y python3-pip &&  pip3 install ansible &&  pip3 install openshift

RUN wget https://storage.googleapis.com/kubernetes-helm//var/lib/jenkins/ansible/sayarapp-deploy/deploy.yml-v2.8.1-linux-amd64.tar.gz
RUN tar -xzvf helm-v2.8.1-linux-amd64.tar.gz
RUN sudo mv linux-amd64/helm /usr/local/bin

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#RUN apt-get -qq update && apt-get -qq install -y kubelet

RUN apt-get update \
  && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"
RUN apt-get update  -qq \
  && apt-get install docker-ce -y
RUN usermod -aG docker jenkins
RUN apt-get clean
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN apt-get update && apt-get install -y maven
USER jenkins

# # install Maven
# USER root
# USER jenkins
