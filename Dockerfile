# Etapa 1: Compilar la aplicación Flutter Web
FROM debian:latest AS build-env

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Descargar e instalar Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Ejecutar el doctor de flutter para asegurar que todo esté en orden
RUN flutter doctor -v

# Copiar el código del proyecto al contenedor
RUN mkdir /app
WORKDIR /app
COPY . .

# Compilar Flutter para entorno Web en modo release
RUN flutter build web --release

# Etapa 2: Servir los archivos con Nginx
FROM nginx:alpine

# Copiar los archivos compilados de la etapa anterior al directorio de Nginx
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Exponer el puerto estándar de HTTP
EXPOSE 80

# Arrancar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
