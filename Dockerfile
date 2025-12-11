FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y \
    docker-compose \
    git \
    curl \
    && groupadd docker || true \
    && rm -rf /var/lib/apt/lists/*


RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.24.tgz \
    | tar zxf - -C /tmp/ \
    && mv /tmp/docker/docker /usr/local/bin/docker \
    && rm -rf /tmp/docker


RUN usermod -a -G docker jenkins

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
