# Stage 1: Build the React app
FROM node:alpine as build-stage
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the app with a lightweight HTTP server
FROM node:alpine as production-stage
EXPOSE 80

# Update OpenSSL to the fixed version
RUN apk update && apk upgrade openssl

WORKDIR '/app'
COPY --from=build-stage /app/build .

RUN npm install -g http-server

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD wget --quiet --tries=1 --spider http://localhost:80 || exit 1

CMD ["http-server", "-p", "80"]
