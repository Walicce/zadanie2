# Stage 1: Build the React app
FROM node:alpine as build-stage
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx as production-stage
EXPOSE 80

# Fix incorrect permission assignment
RUN chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx

COPY --from=build-stage /app/build /usr/share/nginx/html
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1
CMD ["nginx", "-g", "daemon off;"]
