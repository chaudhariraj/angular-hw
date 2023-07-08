# Stage 1: Build the Angular application
FROM node:16.15.0-alpine as build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm cache clean --force
RUN npm install 
COPY . .
RUN npm run build --prod

# Stage 2: Serve the application with NGINX
FROM nginx:latest
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d/
COPY --from=build /usr/src/app/dist/angular-hw /usr/share/nginx/html
EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
