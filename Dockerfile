# Etapa 1: Compilar la aplicación Flutter Web
FROM debian:latest AS build-env

# Instalar dependencias necesarias como root
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa sudo

# Crear un usuario no-root llamado 'developer' con acceso a sudo
RUN useradd -m -s /bin/bash developer && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Descargar e instalar Flutter SDK en el directorio del usuario home
USER developer
WORKDIR /home/developer
RUN git clone https://github.com/flutter/flutter.git /home/developer/flutter

# Configurar variables de entorno para el nuevo usuario
ENV PATH="/home/developer/flutter/bin:/home/developer/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Marcar el directorio como seguro para Git
RUN git config --global --add safe.directory /home/developer/flutter

# Desactivar analíticas y ejecutar el doctor (ahora pasará sin problemas ya que no es root)
RUN flutter config --no-analytics
RUN flutter doctor -v

# Configurar el directorio de trabajo para la app
WORKDIR /home/developer/app
COPY --chown=developer:developer . .

# Compilar Flutter para entorno Web en modo release
RUN flutter build web --release

# Etapa 2: Servir los archivos con Nginx
FROM nginx:alpine
# Copiar desde la ruta del usuario developer
COPY --from=build-env /home/developer/app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
