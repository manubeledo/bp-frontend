# Usar la imagen específica de Node.js
FROM node:20.11.1

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos package.json y package-lock.json para instalar dependencias
COPY package.json package-lock.json ./

# Limpiar caché y archivos temporales
RUN npm cache clean --force \
    && npm prune \
    && rm -rf /root/.npm /root/.node-gyp \
    && npm install --only=prod

# Copiar todos los archivos del proyecto al directorio de trabajo en el contenedor
COPY . .

# Eliminar la carpeta "dist" si existe
RUN rm -rf ./dist

# Construir la aplicación Vite para producción
RUN npm run build

# Copia el script de inicio
COPY docker-entrypoint.sh /usr/src/app/docker-entrypoint.sh
# (Opcional) Si necesitas herramientas adicionales, descomenta estas líneas
# RUN apt-get update && apt-get install -y build-essential

# Expone el puerto en el que se ejecuta la aplicación
EXPOSE 3000

# Establece el script de inicio como ejecutable
RUN chmod +x /usr/src/app/docker-entrypoint.sh

# Comando para ejecutar la aplicación
CMD ["/usr/src/app/docker-entrypoint.sh"]
# CMD ["node", "dist/index.js"] # Ajusta esto según tu script de inicio