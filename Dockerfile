FROM ghcr.io/cirruslabs/flutter:stable

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Instala las dependencias
RUN flutter pub get

# Construye la aplicación web
RUN flutter build web

# Configura un servidor web simple para servir la aplicación
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expone el puerto 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
