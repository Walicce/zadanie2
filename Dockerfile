# Stage 1: Budowanie aplikacji React
FROM node:alpine as build-stage
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Tworzenie obrazu produkcyjnego
FROM nginx:alpine as production-stage
COPY --from=build-stage /app/build /usr/share/nginx/html

# Stage 3: Tworzenie obrazu dla architektury arm64
FROM --platform=linux/arm64 nginx:alpine as arm64-stage
COPY --from=build-stage /app/build /usr/share/nginx/html

# HEALTHCHECK
HEALTHCHECK --interval=30s --timeout=3s CMD wget -q --spider http://localhost || exit 1
