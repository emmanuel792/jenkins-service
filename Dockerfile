FROM jenkins/jenkins:lts

USER root
# 1. Instalar Docker y herramientas
RUN apt-get update && apt-get install -y \
    docker.io \
    docker-compose \
    git \
    # Limpieza de caché
    && rm -rf /var/lib/apt/lists/*

# 2. Asignar Permisos de Grupo al usuario 'jenkins'
RUN usermod -a -G docker jenkins

# 3. 🚨 PASO CLAVE: Crear enlaces simbólicos para asegurar que los binarios estén en el PATH
# Esto es para asegurar que el usuario 'jenkins' encuentre el binario 'docker'
RUN ln -s /usr/bin/docker /usr/local/bin/docker
# Esto es para asegurar que el usuario 'jenkins' encuentre el binario 'docker-compose'
RUN ln -s /usr/bin/docker-compose /usr/local/bin/docker-compose


USER jenkins

# 4. Instalar plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
