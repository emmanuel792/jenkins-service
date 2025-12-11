FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y \
    docker.io \
    docker-compose \
    git \
    && rm -rf /var/lib/apt/lists/*

USER jenkins


# Instalar plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
