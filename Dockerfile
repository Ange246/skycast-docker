# Etapa 1: Compilar la aplicación Flutter Web
FROM debian:latest AS build-env

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Descargar e instalar Flutter SDK en una ruta global limpia
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Forzar explícitamente a Flutter a permitir la ejecución como root
ENV BOT=true
ENV CHROME_EXECUTABLE=/usr/bin/chromium

# Marcar el directorio de Flutter como seguro para Git
RUN git config --global --add safe.directory /usr/local/flutter

# Desactivar analíticas y arrancar el doctor ignorando las advertencias de root
RUN flutter config --no-analytics
RUN flutter doctor -v --no-pub

# Copiar el código del proyecto al contenedor
RUN mkdir /app
WORKDIR /app
COPY . .

# Compilar Flutter para entorno Web en modo release de forma aislada
RUN flutter build web --release --no-pub

# Etapa 2: Servir los archivos con Nginx
FROM nginx:alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
