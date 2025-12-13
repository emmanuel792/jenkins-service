FROM jenkins/jenkins:lts

USER root

# Instalar Docker CLI dentro del contenedor (para CI con Docker)
RUN apt-get update && \
    apt-get install -y docker.io docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Agregar al usuario jenkins al grupo docker (ver siguiente paso)
RUN groupadd -g 999 docker || true
RUN usermod -aG docker jenkins

# Volver al usuario jenkins
USER jenkins

# Instalar plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
