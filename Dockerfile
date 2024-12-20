# Stage 1: Build the Vue.js application
FROM node:18-alpine as build-stage

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the application with nginx
FROM nginx:alpine

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# Run this dockerfile with the following command:
# docker build -t web-interface .
# docker run -p 8080:80 web-interface