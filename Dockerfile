# Usar la imagen específica de Node.js
FROM node:20.11.1

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos package.json y package-lock.json para instalar dependencias
COPY package.json package-lock.json ./

# Instalar las dependencias
RUN npm install

# Copiar todos los archivos del proyecto al directorio de trabajo en el contenedor
COPY . .

# Eliminar la carpeta "dist" si existe
RUN rm -rf ./dist

# Construir la aplicación Vite para producción
RUN npm run build

# Exponer el puerto en el que se ejecutará la aplicación (debe coincidir con el puerto configurado en Vite)
EXPOSE 3000

# Comando para ejecutar la aplicación cuando el contenedor se inicie
CMD ["npm", "start"]